import isel.leic.utils.Time

// Controla o mostrador de pontuacao.
object RouletteDisplay {
    private const val SIZE = 8
    // Inicia a classe, estabelecendo os valores iniciais.
    fun init () {
        off(false)
    }
    // Realiza a animacaoo do sorteio
    fun animation(){
        setValue(0b10010_10010_10010_10010_10010_10010)
        Time.sleep(120)
        setValue(0b10001_10001_10001_10001_10001_10001)
        Time.sleep(120)
        setValue(0b10101_10101_10101_10101_10101_10101)
        Time.sleep(120)
        setValue(0b10100_10100_10100_10100_10100_10100)
        Time.sleep(120)
    }

    fun toRoulette(str: String, complete: Char = ' ') {
        val map = mapOf(
            '0' to 0x00,
            '1' to 0x01,
            '2' to 0x02,
            '3' to 0x03,
            '4' to 0x04,
            '5' to 0x05,
            '6' to 0x06,
            '7' to 0x07,
            '8' to 0x08,
            '9' to 0x09,
            'A' to 0x0A,
            'B' to 0x0B,
            'C' to 0x0C,
            'D' to 0x0D,
            'E' to 0x0E,
            'F' to 0x0F,
            '-' to 0x10,
            ' ' to 0x1F,
            ',' to 0x12, //Upper-left
            ';' to 0x11, //Upper-right
            '.' to 0x15, //Down-right
            ':' to 0x14, //Down-left
            '_' to 0x18  //maintenance
        )
        val trimmed = str.takeLast(6).padStart(6, complete)
        var word = 0

        for (i in 0..5) {
            val char = trimmed[i].uppercaseChar()
            val valor5Bits = map[char] ?: throw IllegalArgumentException("Comando '$char' não encontrado no mapa.")
            val shiftAmount = (5 - i) * 5
            word = word or (valor5Bits shl shiftAmount)
        }

        setValue(word)
    }

    // Envia comando para atualizar o valor do mostrador da roleta
    fun setValue(value : Int) {
        var v = value
        for (i in 0..<6) {
            val digit = v and 0b11111
            val command = (digit shl 3) or i
            SerialEmitter.send(SerialEmitter.Destination.ROULETTE, command, SIZE)
            v = v shr 5
        }
        SerialEmitter.send(SerialEmitter.Destination.ROULETTE, 0x06, SIZE)
    }
    // Envia comando para desativar/ativar a visualizacao do mostrador da roleta
    fun off (value : Boolean) {
        val x = if(value) 0xff else 0xf7
        SerialEmitter.send(SerialEmitter.Destination.ROULETTE, x, SIZE)
    }
}