public class Console.BaseRequest : Object, Request {
    string[] actions;
    string[] parameters;
    string[] targets;

    public BaseRequest (string[] args) {
        //  Here we start by stripping args[0] and args[1]
        //  because they are the concepts of action and the target
        //  at this point they are
        foreach (string arg in args[1:args.length]) {
            if (is_action (arg)) {
                add_action (arg);
            } else if (is_long_parameter (arg)) {
                add_long_parameters (arg);
            } else if (is_short_parameter (arg)) {
                add_short_parameters (arg);
            } else {
                targets += arg;
            }
        }
    }

    public string[] get_actions () {
        return actions;
    }

    public string[] get_parameters () {
        return parameters;
    }

    public string[] get_targets () {
        return targets;
    }

    public virtual bool is_long_parameter (string arg) {
        return arg.has_prefix ("--") && arg.length > 2;
    }

    public virtual bool is_short_parameter (string arg) {
        return arg.has_prefix ("-") && arg.length > 1;
    }

    public virtual bool is_action (string arg) {
        return (!is_long_parameter (arg) && !is_short_parameter(arg)) &&
                actions.length == 0;
    }

    public virtual void add_long_parameters (string arg) {
        var stripped_arg = arg.contains ("--") ? arg[2:arg.length] : arg;

        parameters += stripped_arg;
    }

    public virtual void add_short_parameters (string arg) {
        var stripped_arg = arg.contains ("-") ? arg[1:arg.length] : arg;

        for (int ch = 0; ch < stripped_arg.length; ch++) {
            if (stripped_arg[ch+1] != '=') {
                parameters += @"$(stripped_arg[ch])";
            } else {
                parameters += stripped_arg[ch:stripped_arg.length];
                break;
            }
        }
    }

    public virtual void add_action (string arg) {
        actions += arg;
    }
}
