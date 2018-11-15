public class Console.Commands : Object, CommandContainer {
    public Command? default_command { get; set; }
    Gee.HashMap<string, Command> commands = new Gee.HashMap<string, Command> ();

    public new Command get (string name) {
        return commands[name];
    }

    public new void set (string name, Command command) {
        add (name, command);
    }

    public void add (string name, Command command) {
        commands[name] = command;
    }

    public void remove (string name) {
        commands.unset (name);
    }

    public Request parse_request_from_args (string[] args) {
        return new Console.BaseRequest (args);
    }

    public void execute_with_args (string[] args) {
        execute_request (parse_request_from_args (args));
    }

    public void execute_request (Request request) {
        var actions = request.get_actions ();
        string? action = actions.length > 0 ? actions[0] : null;

        Command? cmd = get_command (action);
        if (cmd == null) {
            debug ("No input was given, and no help or default command has been set")
            return;
        }

        inject_request (request, cmd);
        cmd.execute_sync ();
    }

    Command? get_command (string? action) {
        if (action == null) {
            return default_command ?? commands["help"];
        }

        return commands[action] ?? commands["help"] ?? default_command;
    }

    void inject_request (Request request, Command cmd) {
        if (cmd is UseRequest) {
            (cmd as UseRequest).set_request (request);
        }
    }
}
