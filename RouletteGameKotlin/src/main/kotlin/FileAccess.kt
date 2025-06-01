import java.io.BufferedReader
import java.io.FileReader
import java.io.PrintWriter


fun createReader(fileName: String): BufferedReader {
    return BufferedReader(FileReader(fileName))
}

fun createWriter(fileName: String): PrintWriter {
    return PrintWriter(fileName)
}

fun fileToArray(fileName: String): Array<String> {
    val reader = createReader(fileName)
    var line = reader.readLine()
    var lines = emptyArray<String>()
    while (line != null) {
        lines += line
        line = reader.readLine()
    }
    reader.close()
    return lines
}

fun writeFile(array: Array<String>, fileName: String) {
    val writer = createWriter(fileName)
    array.forEach {
        writer.println(it)
    }
    writer.close()
}
