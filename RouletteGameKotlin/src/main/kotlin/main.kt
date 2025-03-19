import isel.leic.UsbPort

fun main() {
    KBD.init()
    while (true) {
        var key = KBD.waitKey(1000)
        HAL.setBits(0b00010000)
        println(key)
        HAL.clrBits(0b00010000)

    }
}