public class Console.Commands : Object, CommandContainer {
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

        if (action == null || !commands.has_key (action)) {
            if (commands.has_key ("help")) {
                commands["help"].execute_sync ();
            }
            return;
        }

        if (commands.has_key (action)) {
            var cmd = commands[action];

            if (cmd is UseRequest) {
                (cmd as UseRequest).set_request (request);
            }

            cmd.execute_sync ();
        }
    }
}
