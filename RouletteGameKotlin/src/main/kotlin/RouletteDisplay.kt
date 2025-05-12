// Controla o mostrador de pontuacao.
object RouletteDisplay {



    // Inicia a classe, estabelecendo os valores iniciais.
    fun init () {

    }
    // Realiza a animacaoo do sorteio
    fun animation(){
        TODO()
    }

    // Envia comando para atualizar o valor do mostrador da roleta
    fun setValue(value : Int) {
        var y = value shl 3
        SerialEmitter.send(SerialEmitter.Destination.ROULETTE, y, 8)
        SerialEmitter.send(SerialEmitter.Destination.ROULETTE, 0x06, 8)
    }
    // Envia comando para desativar/ativar a visualizacao do mostrador da roleta
    fun off (value : Boolean) {
        val x = if(value) 0xff else 0xf7
        SerialEmitter.send(SerialEmitter.Destination.ROULETTE, x, 8)
    }
}