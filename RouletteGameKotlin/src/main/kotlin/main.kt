import isel.leic.UsbPort
import isel.leic.utils.Time

fun main() {
   // HAL.init()
   // LCD.init()
   // LCD.cursor(1,2)
   // LCD.write("OLá")
   // Time.sleep(3000)
   // LCD.clear()
   // LCD.write("Logico")

    KBD.init()
    while (true){
        val key = KBD.waitKey(1000)
        println(key)
    }
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          