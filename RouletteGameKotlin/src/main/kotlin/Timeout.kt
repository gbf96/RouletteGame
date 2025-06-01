import isel.leic.utils.Time

class Timeout(private val durationMs: Long) {
    private var startTime: Long = Time.getTimeInMillis()

    fun isExpired(): Boolean {
        return Time.getTimeInMillis() - startTime >= durationMs
    }

    fun reset() {
        startTime = Time.getTimeInMillis()
    }
}