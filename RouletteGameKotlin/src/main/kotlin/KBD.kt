
import isel.leic.utils.Time

object KBD {
    const val NONE = 0
    // Inicia a classe
    fun init () {
        HAL.init()
    }

    // Retorna de imediato a tecla premida ou NONE se nao ha tecla premida.
    fun getKey(): Char {
        val pad = charArrayOf('1', '4', '7', '*', '2', '5', '8', '0','3','6', '9', '#', 'A', 'B', 'C', 'D')
        val key = HAL.readBits(0b00001111)
        if (HAL.isBit(0b00010000)) {
            HAL.setBits(0b00010000)
            return pad[key]
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
                HAL.clrBits(0b00010000)
                return key
            }
        }
        return NONE.toChar()
    }
}