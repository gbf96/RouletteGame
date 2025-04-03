fun main() {
    KBD.init()
    LCD.init()


    LCD.write("ola")
    while (true){
        val key = KBD.waitKey(1000)
        if (key != 0.toChar()) {
            println(key)
            LCD.write(key)
        }
    }
}