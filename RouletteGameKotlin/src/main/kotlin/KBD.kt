import isel.leic.UsbPort
import isel.leic.utils.Time

object KBD {
    const val NONE = 0
    val K = arrayOf(0,0,0,0)

    // Inicia a classe
    fun init () {
        HAL.init()
    }

    // Retorna de imediato a tecla premida ou NONE se nao ha tecla premida.
    fun getKey(): Char {


        if (HAL.isBit(0b00010000)){
            val key = HAL.readBits(0b00001111)
            when(key){
                0b0000 -> return '1'
                0b0001 -> return '4'
                0b0010 -> return '7'
                0b0011 -> return '*'
                0b0100 -> return '2'
                0b0101 -> return '5'
                0b0110 -> return '8'
                0b0111 -> return '0'
                0b1000 -> return '3'
                0b1001 -> return '6'
                0b1010 -> return '9'
                0b1011 -> return '#'
                0b1100 -> return 'A'
                0b1101 -> return 'B'
                0b1110 -> return 'C'
                0b1111 -> return 'D'
            }
        }
        return NONE.toChar()
    }

    // Retorna a tecla premida, caso ocorra antes do ’timeout’ (em milissegundos),
    // ou NONE caso contrario.
    fun waitKey(timeout: Long): Char {
        val startTime = Time.getTimeInMillis()
        while (Time.getTimeInMillis() - startTime < timeout) {
            val key = getKey()
            if (key != NONE.toChar()) {
                return key
            }
        }
        return NONE.toChar()
    }
}