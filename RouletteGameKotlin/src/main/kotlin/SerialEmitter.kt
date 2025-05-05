import isel.leic.simul.module.LCD

// Envia tramas para os diferentes modulos Serial Receiver.
object SerialEmitter {

    private const val SCLK_MASK = 0x02
    private const val SDX_MASK = 0x01
    private const val LCD_SEL = 0x40
    private const val RD_SEL = 0x80

    enum class Destination {LCD, ROULETTE}
    // Inicia a classe
    fun init () {
        HAL.init()
        HAL.setBits(LCD_SEL)
        HAL.setBits(RD_SEL)
    }
    // Envia uma trama para o SerialReceiver
    // identificado o destino em ’addr’,
    // os bits de dados em ’data’
    // e em ’size’ o numero de bits a enviar.
    fun send(addr: Destination , data: Int , size : Int) {

        val destiny = when(addr){
            Destination.LCD -> LCD_SEL
            Destination.ROULETTE -> RD_SEL
        }
        HAL.clrBits(destiny)
        HAL.clrBits(SCLK_MASK)
        HAL.setBits(SCLK_MASK)

        var numOfOnes = 0

        var bit: Int

        for (i in 0..<size){
            bit = 0x1 and (data shr (i))
            if (bit != 0) numOfOnes++
            HAL.writeBits(SDX_MASK, bit)
            HAL.clrBits(SCLK_MASK)
            HAL.setBits(SCLK_MASK)
        }

        if (numOfOnes % 2 != 0) HAL.writeBits(SDX_MASK, 0)
        else HAL.writeBits(SDX_MASK, 1)
        HAL.clrBits(SCLK_MASK)
        HAL.setBits(SCLK_MASK)

        HAL.setBits(destiny)
        HAL.clrBits(SCLK_MASK)
        HAL.setBits(SCLK_MASK)
    }
}