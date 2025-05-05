
    const val NONE = -1

    fun init() {
        KBD.init()
        LCD.init()
    }

    fun printText(text: String, line: Int, column: Int, clear: Boolean = false) {
        LCD.cursor(line, column)
        LCD.write(text)
    }

    fun clearLine(line:Int){
        LCD.cursor (line,0)
        LCD.write("                ")
    }


    fun writeOnLCD() : Char {
        val key = KBD.waitKey(5000)
        if (key != NONE.toChar()) {
            println(key)
            LCD.write(key)
            return key
        }
        return key
    }

    fun clearDisplay(){
        LCD.clear()
    }
