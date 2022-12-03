import org.junit.jupiter.api.Test

class CliInstallerTest {
    @Test
    fun shouldCorrectlyInstallIcaro() {
        downloadLastRelease("lang", "lang")
    }
}
