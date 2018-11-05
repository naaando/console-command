public class Console.ClosureCommand : BaseCommand {
    [CCode (has_target = false)]
    public delegate void CommandFn (Request request);

    CommandFn fn;
    string name;
    string description;

    public ClosureCommand (string name, CommandFn func) {
        fn = func;
        this.name = name;
    }

    public ClosureCommand with_description (string description) {
        this.description = description;
        return this;
    }

    public override string get_name () {
        return name;
    }

    public override async void execute () {
        fn (request);
    }
}
