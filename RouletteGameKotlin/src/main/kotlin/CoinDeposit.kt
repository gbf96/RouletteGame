class CoinDeposit(private val fileName: String) {
    var games: Int = 0
    var coins: Int = 0

    fun loadFromFile() {
        val lines = fileToArray(fileName)
        if (lines.size >= 2) {
            games = lines[0].toIntOrNull() ?: 0
            coins = lines[1].toIntOrNull() ?: 0
        }
    }

    fun saveToFile() {
        val lines = arrayOf(games.toString(), coins.toString())
        writeFile(lines, fileName)
    }

    fun incrementGames() {
        games++
    }

    fun addCoins(amount: Int) {
        coins += amount
    }

    fun clear(){
        games = 0
        coins = 0
    }
}
