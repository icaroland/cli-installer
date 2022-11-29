import org.apache.commons.io.FileUtils
import java.io.File
import java.net.URI
import java.net.URL
import java.net.http.HttpClient
import java.net.http.HttpRequest
import java.net.http.HttpResponse


fun main() {
    callGithubApi()
}

fun downloadEnvFile() {
    FileUtils.copyURLToFile(
        URL("https://raw.githubusercontent.com/icaroland/cli-installer/main/src/unix/envs.sh"),
        File("envs.sh")
    )
}

fun callGithubApi() {
    val request = HttpRequest.newBuilder()
        .uri(URI("https://api.github.com/repos/icaroland/cli-entrypoint/tags"))
        .GET()
        .build()

    val response =
        HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString()).body()

    print(response)
}
