object RouletteGame{

    fun init() {
        TUI.init()
        RouletteDisplay.init()
    }

    fun mainMenu(){
        TUI.printTextMiddle("Roulette Game", 0)
    }

    fun sort(time: Int){
        val sec = time *2
        for (i in 0..sec){
            RouletteDisplay.animation()
        }
    }
}

