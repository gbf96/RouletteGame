import isel.leic.UsbPort

fun main() {
    KBD.init()
    while (true) {
        val key = KBD.waitKey(1000)
        println(key)
    }
}
