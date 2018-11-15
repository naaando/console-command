# Console commands

Library to route command-line arguments to a Command pattern object, current implementation covers extension by inheritance or using closures.

**Note**: I wanted to create a reflection based approach to register the commands automatically so we can just trigger the execution from the cli arguments, but Vala register objects derivated classes dynamically(we can't introspect types before them being called with new Object () or Type.class_ref ()), so instantiating the class type would be necessary somewhere.

## Basic usage

Subclass BaseCommand class

```cs
public class MyCommand : Console.BaseCommand {
    public override string get_name () {
        return "My command";
    }

    public override async void execute () {
        print (@"Aha!\n");
    }
}
```

Use Commands service to store your commands and parse arguments on main
```cs
public static int main(string[] args) {
    var commands = new Console.Commands ();
    commands["something"] = new MyCommand ();
    commands.execute_with_args (args);
    return 0;
}
```

## Requests
Console requests parse arguments to *Actions*, *modifiers* and *targets*
#### Actions
Actions are the intent to do something
Like delete, copy, help, create

They are the first argument after program name, the later are targets or modifiers.
If a command should nest an action like *help create* then create would be the target

#### Modifiers (Parameters)
Parameters act modifying the behavior of an action
Short form: -f -s -t ...   
Long form: --force --track --no-git ...

#### Targets
Files usually but could be urls, git addresses, or names too.

## Commands

#### Command Interface
```cs
public interface Console.Command : Object {
    public abstract string get_name ();
    public abstract async void execute ();
    public abstract void execute_sync ();
    public abstract void show_description ();
    public abstract void show_help ();
}
```

#### BaseCommand class
Is an abstract class that handles all the fuzz to create a basic class
you should only override execute and get_name methods and you're ready to go

```cs
public class TestCommand : Console.BaseCommand {
    public override string get_name () {
        return "Test";
    }

    public override async void execute () {
        print (@"Aha!\n");
    }
}

```

#### ClousureCommand
If your command is simple you can use just a closure using ClosureCommand (nameOfCommand, closure) and it's possible to append details with with_description (string dsc) method
```cs
commands["quick"] = new Console.ClosureCommand ("quick",
        (request) => print (@"Testing closure command\n"))
        .with_description ("Tests a closure based Command");
```

### Commands service
Commands service is a container that holds a list of commands and executes commands

#### Adding commands
```cs
var commands = new Console.Commands ();
// You can use add method
commands.add ("hello", new HelloCommand ());
// Or the container accessor
commands["hello"] = new HelloCommand ();
```

#### Removing commands
```cs
commands.remove ("hello");
```

#### Parsing args and executing

You can parse the args returning a Request by
```cs
public static int main(string[] args) {
    var commands = new Console.Commands ();
    var request = commands.parse_request_from_args (args);
    return 0;
}
```
And execute requests with
```cs
commands.execute_request (request);
```
It's also possible to parse and execute in one shot with
```cs
public static int main(string[] args) {
    var commands = new Console.Commands ();
    commands.execute_with_args (args);
    return 0;
}

```
