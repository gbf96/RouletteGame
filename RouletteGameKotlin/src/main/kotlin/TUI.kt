object TUI {
    const val NONE = 0
    private const val MAX_COLUMNS: Int = 16
    fun init() {
        KBD.init()
        LCD.init()
    }

    fun printText(text: String, line: Int, column: Int) {
        LCD.cursor(line, column)
        LCD.write(text)
    }

    fun printTextLeft(text: String, line: Int) {
        LCD.cursor(line, 0)
        LCD.write(text)
    }

    fun printTextMiddle(text: String, line: Int) {
        val column = ((MAX_COLUMNS - (text.length)) / 2)
        LCD.cursor(line, column)
        LCD.write(text)
    }

    fun printTextRight(text: String, line: Int) {
        val column = MAX_COLUMNS - text.length
        LCD.cursor(line, column)
        LCD.write(text)
    }

    fun clearLine(line: Int) {
        LCD.cursor(line, 0)
        LCD.write("                ")
    }



    fun readKey():Char{
        var key = NONE.toChar()
        while(key == NONE.toChar()){
            key = KBD.waitKey(5000)
        }
        return key
    }

    fun clearDisplay() {
        LCD.clear()
    }
}