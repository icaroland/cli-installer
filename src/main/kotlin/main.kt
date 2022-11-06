import kotlin.system.exitProcess

fun main() {
    try {
        val osCommands = mapOf("win" to windows.commands, "unix" to unix.commands)
    } catch (e: Throwable) {
        exitProcess(1)
    }
}


