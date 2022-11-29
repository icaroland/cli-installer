import org.junit.jupiter.api.Test
import java.io.File

class DownloadTest {
    @Test
    fun shouldCorrectlyDownloadFile() {
        downloadEnvFile()

        assert(File("envs.sh").exists())

        File("envs.sh").delete()
    }
}