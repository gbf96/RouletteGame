object M {

    private const val M_MASK = 0x80

    fun checkMaintenance(): Boolean {
        return HAL.isBit(M_MASK)
    }

}