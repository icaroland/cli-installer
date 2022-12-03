import com.google.gson.Gson
import kotlinx.coroutines.joinAll
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import org.apache.commons.io.FileUtils
import java.io.File
import java.net.URI
import java.net.URL
import java.net.http.HttpClient
import java.net.http.HttpRequest
import java.net.http.HttpResponse

val HOME: String = System.getenv("HOME")

fun main() {
    createIcaroFoldersAndFiles()

    println("starting to install Icaro!")

    runBlocking {
        listOf(
            launch {
                downloadLastReleaseDirectly("cli-entrypoint", "cli", "entrypoint.jar")
            },
            launch {
                downloadLastRelease("cli-core", "cli/core")
            },
            launch {
                downloadLastRelease("lang", "lang")
            }
        ).joinAll()
    }

    println("\n\nclose and reopen this terminal or launch source ~/.zshrc to use icaro \n\n")
}

fun createIcaroFoldersAndFiles() {
    File("$HOME/icaro").deleteRecursively()
    File("$HOME/icaro/cli/core").mkdirs()
    File("$HOME/icaro/lang").mkdirs()

    File("$HOME/icaro/env.sh").writeText(
        """
        #!/bin/sh
        export ICARO_HOME="${'$'}HOME/icaro"
        alias icaro="java -jar ~/icaro/cli/entrypoint.jar"
        """.trimIndent()
    )

    if ("\n [ -f ~/icaro/env.sh ] && source ~/icaro/env.sh" !in File("$HOME/.zshrc").readText())
        File("$HOME/.zshrc").appendText("\n [ -f ~/icaro/env.sh ] && source ~/icaro/env.sh")
}

fun downloadLastRelease(repoName: String, targetFolder: String) {
    val response =
        HttpClient.newHttpClient().send(
            HttpRequest.newBuilder()
                .uri(URI("https://api.github.com/repos/icaroland/$repoName/releases/latest"))
                .GET()
                .build(), HttpResponse.BodyHandlers.ofString()
        ).body()

    val lastRelease: String = Gson().fromJson(response, Map::class.java)["tag_name"] as String

    println("$repoName $lastRelease is installing...")

    FileUtils.copyURLToFile(
        URL("https://github.com/icaroland/$repoName/releases/latest/download/$lastRelease.jar"),
        File("$HOME/icaro/$targetFolder/$lastRelease.jar")
    )

    println("$repoName $lastRelease installed")
}

fun downloadLastReleaseDirectly(repoName: String, targetFolder: String, targetFile: String) {
    println("$repoName is installing...")

    FileUtils.copyURLToFile(
        URL("https://github.com/icaroland/$repoName/releases/latest/download/$targetFile.jar"),
        File("$HOME/icaro/$targetFolder/$targetFile")
    )

    println("$repoName installed")
}

