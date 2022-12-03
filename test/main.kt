import org.apache.commons.io.FileUtils
import org.junit.jupiter.api.Test
import java.io.File
import java.net.URL

class DownloadTest {
    @Test
    fun shouldCorrectlyInstallIcaro() {
        FileUtils.copyURLToFile(
            URL("https://github.com/icaroland/cli-entrypoint/releases/latest/download/entrypoint.jar"),
            File("$HOME/icaro/cli/entrypoint.jar")
        )
    }
}
