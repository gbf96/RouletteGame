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