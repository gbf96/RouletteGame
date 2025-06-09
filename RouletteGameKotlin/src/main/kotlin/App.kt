import isel.leic.utils.Time
import kotlin.system.exitProcess

object App {

    private const val NONE = 0.toChar()

    private var credits = 0
    private var stats = Statistics("Statistics.txt")
    private var count = CoinDeposit("Count.txt")

    fun runApp() {
        init()
        if (M.checkMaintenance()) {
            maintenanceMode()
        }else{
            gameMode()
        }
    }

    private fun gameMode() {
        gameMenu()
        val roulette = arrayOf(",",";",".",":")
        var i = 0
        while (true) {
            if (M.checkMaintenance()) maintenanceMode()
            i %= 4
            RouletteDisplay.toRoulette(roulette[i].repeat(6))

            val key = KBD.waitKey(150)

            val addedCredits = CoinAcceptor.checkCoin() ?: 0
            if (addedCredits > 0) {
                credits += addedCredits
                TUI.printTextLeft("Credits: $credits", 1)
                count.addCoins(1)
            }

            if (key == '*' && credits > 0) {
                rouletteGame(true)
                Time.sleep(3000)
                gameMenu()
            }
            i++
        }
    }

    private fun maintenanceMode() {
        maintenanceMenu()
        RouletteDisplay.toRoulette("_".repeat(6))
        var showingFirstScreen = false
        showMaintenanceScreen(showingFirstScreen)
        var key: Char

        while (true) {
            if (!M.checkMaintenance()) {
                gameMode()
            }

            key = KBD.waitKey(3000)

            if (key in listOf('*', 'A', 'D', 'C')) {
                break
            }

            showingFirstScreen = !showingFirstScreen
            showMaintenanceScreen(showingFirstScreen)
        }

        when (key) {
            '*' -> {
                rouletteGame(false)
                maintenanceMode()
            }
            'A' -> {
                TUI.clearDisplay()
                TUI.printTextLeft("Games:${count.games}", 0)
                TUI.printTextLeft("Coins:${count.coins}", 1)

                if (KBD.waitKey(5000) == '*'){
                    showClearCountScreen()
                    val nextK = TUI.readKey()
                    if (nextK == '5') {
                        count.clear()
                    }
                    maintenanceMode()
                }
                maintenanceMode()
            }

            'C' -> {
                for (i in 0 ..6) {
                    showStatisticsScreen(i)
                    val k = KBD.waitKey(3000)
                    when (k) {
                        '*' -> {
                            showClearStatisticsScreen()
                            val nextK = TUI.readKey()
                            if (nextK == '5') {
                                stats.clear()
                            }
                            maintenanceMode()
                        }
                        NONE -> {}
                        else -> maintenanceMode()
                    }
                }
                maintenanceMode()
            }

            'D' -> {
                TUI.clearDisplay()
                TUI.printTextMiddle("Shutdown", 0)
                TUI.printTextMiddle("5-Yes  other-No", 1)
                val k = TUI.readKey()
                if (k == '5'){
                    stats.saveToFile()
                    count.saveToFile()
                    TUI.clearDisplay()
                    RouletteDisplay.off(true)
                    exitProcess(0)
                }else{
                    maintenanceMode()
                }
            }
        }
    }

    private fun rouletteGame(recordStats: Boolean) {
        val bets = IntArray(14)
        val random = java.util.Random()
        TUI.clearDisplay()
        TUI.printTextMiddle("0123456789ABCD",1)
        val savedCredits = credits
        var rollTimeout: Timeout? = null
        var animation = false
        val roulette = arrayOf(',',';','.',':')
        var i = 0
        if (!recordStats) {
            credits = 100
        }
        if (recordStats) count.incrementGames()
        RouletteDisplay.toRoulette("$credits")
        while (true) {
            val key = KBD.waitKey(150)

            if (rollTimeout?.isExpired() == true){
                break
            }

            if (key == '#' && bets.sum() != 0) {
                animation = true
                rollTimeout = Timeout(random.nextInt(10000).toLong())
            }

            if(animation){
                i %= 4
                RouletteDisplay.toRoulette("$credits", roulette[i])
                i++
            }
            val idx = keyToIndex(key) ?: continue

            if (bets[idx] < 9 && credits > 0) {
                val currentBet = ++bets[idx]
                credits--
                if (!animation) RouletteDisplay.toRoulette("$credits")
                TUI.printText("$currentBet",0,idx+1 )
            }
        }

        val sortedIdx = random.nextInt(14)
        val sortedKey = indexToKey(sortedIdx)

        val betsOnSorted = bets[sortedIdx]
        showNumber(sortedIdx)
        if (betsOnSorted > 0) {
            val amountWon = betsOnSorted * 2
            if(recordStats) {
                credits += amountWon
                stats.registerDraw(sortedIdx, amountWon)
            }
            val str = fillToSix("$sortedKey","$amountWon", '_')
            RouletteDisplay.toRoulette(str)
        } else {
            if (recordStats) stats.registerDraw(sortedIdx)
            val totalLost = bets.sum()
            val str = fillToSix("$sortedKey","$totalLost", '-')
            RouletteDisplay.toRoulette(str)
        }
        Time.sleep(5000)
        if (!recordStats) {
            credits = savedCredits
        }
    }

    private fun gameMenu(){
        TUI.clearDisplay()
        TUI.printTextMiddle("Roulette Game", 0)
        TUI.printTextLeft("Credits: $credits", 1)
    }

    private fun maintenanceMenu(){
        TUI.clearDisplay()
        TUI.printTextMiddle("On maintenance", 0)
        TUI.printTextLeft("*-Play D-shutD", 1)
    }

    private fun showNumber(number: Int) {
        val delays = listOf(500L, 500L, 500L, 500L, 1000L, 1000L, 1000L)

        for (i in 6 downTo 0) {
            val idx = (number - i + 14) % 14
            RouletteDisplay.toRoulette(indexToKey(idx).toString().repeat(6))
            Time.sleep(delays[6 - i])
        }
    }

    private fun showMaintenanceScreen(showFirstScreen: Boolean) {
        if (showFirstScreen) {
            TUI.clearLine(1)
            TUI.printTextLeft("C-Stats A-Count", 1)
        } else {
            TUI.clearLine(1)
            TUI.printTextLeft("*-Play D-shutD", 1)
        }
    }

    private fun showClearStatisticsScreen(){
        TUI.clearDisplay()
        TUI.printTextMiddle("Clear Statistics",0)
        TUI.printTextLeft("5-Yes  other-No",1)
    }

    private fun showClearCountScreen(){
        TUI.clearDisplay()
        TUI.printTextMiddle("Clear Count",0)
        TUI.printTextLeft("5-Yes  other-No",1)
    }

    private fun init() {
        TUI.init()
        RouletteDisplay.init()
        stats.loadFromFile()
        count.loadFromFile()
    }

    private fun keyToIndex(key: Char): Int? = when (key) {
        in '0'..'9' -> key - '0'
        in 'A'..'D' -> key - 'A' + 10
        else        -> null
    }

    private fun indexToKey(index: Int): Char = if (index < 10) ('0' + index) else ('A' + (index - 10))

    private fun fillToSix(left: String, right: String, filler: Char): String {
        val count = 6 - (left.length + right.length)
        val str = filler.toString().repeat(count)
        return left + str + right
    }


    private fun showStatisticsScreen(screen: Int) {
        val index0 = screen * 2
        val index1 = index0 + 1

        val line0 = "${indexToKey(index0)} -> ${stats.getCount(index0)} $:${stats.getPrizeSum(index0)}"
        val line1 = "${indexToKey(index1)} -> ${stats.getCount(index1)} $:${stats.getPrizeSum(index1)}"

        TUI.clearDisplay()
        TUI.printTextLeft(line0, 0)
        TUI.printTextLeft(line1, 1)
    }
}

fun main() {
    App.runApp()
}
