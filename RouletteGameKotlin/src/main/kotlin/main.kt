import isel.leic.UsbPort
import isel.leic.utils.Time

fun main() {
    RouletteGame.init()
    RouletteGame.mainMenu()
    while (true){
        val x = TUI.readKey()
        if (x == '*'){
            TUI.printTextLeft("Creditos:",1)
            RouletteGame.sort(5)
        }
    }
}
