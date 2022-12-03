import org.junit.jupiter.api.Test
import java.io.File

class DownloadTest {
    @Test
    fun shouldCorrectlyInstallIcaro() {
        File("$HOME/.zshrc").createNewFile()

        main()
    }
}
