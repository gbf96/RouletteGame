import isel.leic.utils.Time

// Escreve no LCD usando a interface a 4 bits.
object LCD {

    private const val RS_MASK = 0x10
    private const val EN_MASK = 0x20
    private const val WRITE_MASK = 0x0F

    private const val INIT_DATA = 0x03
    private const val INIT_4BITS = 0x02
    private const val FONT = 0x28
    private const val DISPLAY_OFF = 0x08
    private const val DISPLAY_CLR = 0x01
    private const val ENTRY_MODE = 0x06
    private const val DISPLAY_CURSOR_ON = 0x0F

    // Dimensao do display.
    private const val LINES = 2
    private const val COLS = 16

    // Define se a interface e Serie ou Paralela
    private const val SERIAL_INTERFACE = true

    // Escreve um byte de comando/dados no LCD em paralelo
    private fun writeNibbleParallel(rs : Boolean , data: Int){
        if (rs) HAL.setBits(RS_MASK) else HAL.clrBits(RS_MASK)
        HAL.setBits(EN_MASK)
        HAL.writeBits(WRITE_MASK, data)
        Time.sleep(1)
        HAL.clrBits(EN_MASK)
    }

    // Escreve um byte de comando/dados no LCD em serie
    private fun writeNibbleSerial(rs : Boolean , data: Int) {
        var d = data shl 1
        val r = if(rs) 1 else 0
        d = d or r
        if (rs) SerialEmitter.send(SerialEmitter.Destination.LCD, d,5)
        else SerialEmitter.send(SerialEmitter.Destination.LCD, d,5)
    }

    // Escreve um nibble de comando/dados no LCD
    private fun writeNibble(rs : Boolean , data: Int) = if (SERIAL_INTERFACE) writeNibbleSerial(rs, data) else writeNibbleParallel(rs, data)

    // Escreve um byte de comando/dados no LCD
    private fun writeByte(rs : Boolean , data: Int) {
        writeNibble(rs, data shr 4)
        writeNibble(rs, data)
    }

    // Escreve um comando no LCD
    private fun writeCMD(data: Int) = writeByte(false, data)

    // Escreve um dado no LCD
    private fun writeDATA(data: Int) = writeByte(true, data)

    // Envia a sequencia de iniciacao para comunicacao a 4 bits.
    fun init () {
        SerialEmitter.init()

        Time.sleep(15)
        writeNibble(false, INIT_DATA)
        Time.sleep(5)
        writeNibble(false, INIT_DATA)
        Time.sleep(1)
        writeNibble(false, INIT_DATA)

        writeNibble(false, INIT_4BITS)

        writeCMD(FONT)
        writeCMD(DISPLAY_OFF)
        writeCMD(DISPLAY_CLR)
        writeCMD(ENTRY_MODE)
        writeCMD(DISPLAY_CURSOR_ON)
    }

    // Escreve um carater na posicao corrente.
    fun write(c: Char) = writeDATA(c.code)


    // Escreve uma string na posicao corrente.
    fun write(text : String) {
        for (c in text) write(c)
    }

    // Envia comando para posicionar cursor (’line ’:0..LINES-1 , ’column ’:0..COLS-1)
    fun cursor( line : Int , column: Int) {
        var cursor = column
        if (line == 1) cursor += 0x40
        cursor = cursor or 0x80
        writeCMD(cursor)
    }

    // Envia comando para limpar o ecra e posicionar o cursor em (0,0)
    fun clear () = writeCMD(DISPLAY_CLR)
}