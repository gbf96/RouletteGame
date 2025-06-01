

object CoinAcceptor {
    private const val COIN_MASK = 0x40
    private const val COIN_ID_MASK = 0x20
    private const val COIN_ACCEPT_MASK = 0x40

    fun checkCoin(): Int? {
        if (HAL.isBit(COIN_MASK)) {
            val id = if (HAL.isBit(COIN_ID_MASK)) 4 else 2
            HAL.setBits(COIN_ACCEPT_MASK)
            while (HAL.isBit(COIN_MASK)){ }
            HAL.clrBits(COIN_ACCEPT_MASK)
            return id
        }
        return null
    }
}