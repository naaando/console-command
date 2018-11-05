
public static int main(string[] args) {
    var commands = new Console.Commands ();
    commands.add ("hello", new TestCommand ());
    commands["ho"] = new TestCommand ();
    commands["quick"] = new Console.ClosureCommand ("quick", (request) => print (@"Testing closure command\n")).with_description ("Tests a closure based Command");

    commands.execute_with_args (args);

    return 0;
}
