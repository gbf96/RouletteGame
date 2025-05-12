import isel.leic.UsbPort
import isel.leic.utils.Time

fun main() {
    KBD.init()
    LCD.init()
    LCD.write("Roulette Game")
    RouletteDisplay.off(false)
    RouletteDisplay.setValue(3)
    RouletteDisplay.off(true)
    RouletteDisplay.off(false)
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          