import org.apache.commons.io.FileUtils
import java.io.File
import java.net.URL

interface OsCommands {
    fun icaroHome()
}

val OS_NAME = if ("Windows" in System.getProperty("os.name")) "win" else "unix"

fun downloadRepo(githubRepoName: String, tag: String, targetFolder: String) {
    println(githubRepoName)

    val url = "https://github.com/icaroland/$githubRepoName/releases/download/$tag/$tag.jar"

    FileUtils.copyURLToFile(URL(url), File("$targetFolder/$tag.jar"))
}