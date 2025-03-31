
import isel.leic.utils.Time

object KBD {
    private const val NONE = 0.toChar()
    private const val DVAL_MASK = 0x10
    private const val K_MASK = 0x0F
    private const val ACK_MASK = 0x80

    // Inicia a classe
    fun init () {
        HAL.init()
        HAL.clrBits(ACK_MASK)
    }

    // Retorna de imediato a tecla premida ou NONE se nao ha tecla premida.
    fun getKey(): Char {
        val pad = charArrayOf('1', '4', '7', '*', '2', '5', '8', '0','3','6', '9', '#', 'A', 'B', 'C', 'D')
        if (HAL.isBit(DVAL_MASK)) {
            val key = HAL.readBits(K_MASK)
            HAL.setBits(ACK_MASK)
            val c = pad[key]

            while (true){
                if (!HAL.isBit(DVAL_MASK)){
                    HAL.clrBits(ACK_MASK)
                    return c
                }
            }
        }
        return NONE
    }

    // Retorna a tecla premida, caso ocorra antes do ’timeout’ (em milissegundos),
    // ou NONE caso contrario.
    fun waitKey(timeout: Long): Char {
        val startTime = Time.getTimeInMillis()
        while (Time.getTimeInMillis() - startTime < timeout) {
            val key = getKey()
            if (key != NONE) {
                return key
            }
        }
        return NONE
    }
}