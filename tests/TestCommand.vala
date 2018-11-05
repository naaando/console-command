public class TestCommand : Console.BaseCommand {
    public override string get_name () {
        return "Test";
    }

    public override async void execute () {
        print (@"Aha!\n");
    }
}
