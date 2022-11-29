import org.apache.commons.io.FileUtils
import java.io.File
import java.net.URL


fun main() {
    downloadEnvFile()
}

fun downloadEnvFile() {
    FileUtils.copyURLToFile(
        URL("https://raw.githubusercontent.com/icaroland/cli-installer/main/src/unix/envs.sh"),
        File("envs.sh")
    )
}
