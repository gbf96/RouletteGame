data class DrawStat(
    var count: Int = 0,
    var prizeSum: Int = 0
)

class Statistics(private val fileName: String) {
    private val stats = Array(14) { DrawStat() }

    fun registerDraw(number: Int, prize: Int = 0) {
        if (number in 0..13) {
            stats[number].count++
            stats[number].prizeSum += prize
        }
    }

    fun getCount(number: Int): Int {
        return stats.getOrNull(number)?.count ?: 0
    }

    fun getPrizeSum(number: Int): Int {
        return stats.getOrNull(number)?.prizeSum ?: 0
    }

    fun clear() {
        for (s in stats) {
            s.count = 0
            s.prizeSum = 0
        }
    }

    fun saveToFile() {
        val lines = stats.mapIndexed { index, stat -> "$index;${stat.count};${stat.prizeSum}" }.toTypedArray()
        writeFile(lines, fileName)
    }

    fun loadFromFile() {
        val lines = fileToArray(fileName)
        for (line in lines) {
            val parts = line.split(";")
            if (parts.size == 3) {
                val number = parts[0].toIntOrNull()
                val count = parts[1].toIntOrNull()
                val prize = parts[2].toIntOrNull()
                if (number != null && count != null && prize != null && number in 0..13) {
                    stats[number].count = count
                    stats[number].prizeSum = prize
                }
            }
        }
    }
}

