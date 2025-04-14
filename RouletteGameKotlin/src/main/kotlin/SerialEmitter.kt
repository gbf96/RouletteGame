// Envia tramas para os diferentes modulos Serial Receiver.
object SerialEmitter {

    private const val SCLK_MASK = 0x02
    private const val SDX_MASK = 0x01
    private const val LCDsel = 0x40
    private const val ROULETTE_DESTINY = 0
    private const val LCD_DESTINY = 1

    enum class Destination {LCD, ROULETTE}
    // Inicia a classe
    fun init () {
        HAL.init()

    }
    // Envia uma trama para o SerialReceiver
    // identificado o destino em ’addr’,
    // os bits de dados em ’data’
    // e em ’size’ o numero de bits a enviar.
    fun send(addr: Destination , data: Int , size : Int) {



        var numOfOnes = 0
        var i = 0
        var bit = 0

        while (i < size) {
            bit = 0x01 and (data shr (i))
            if (bit != 0) numOfOnes++
            HAL.writeBits(SDX_MASK, bit)
            HAL.clrBits(SCLK_MASK)
            HAL.setBits(SCLK_MASK)
            i++
        }

        if (numOfOnes % 2 != 0) HAL.writeBits(SDX_MASK, 0)
        else HAL.writeBits(SDX_MASK, 1)
        HAL.clrBits(SCLK_MASK)
        HAL.setBits(SCLK_MASK)

    }
}