# console-command

Library to route command-line arguments to a Command pattern object, current implementation covers extension by inheritance or using closures.

## Requests
Console requests parse arguments to
#### Actions
Actions are the intent to do something
Like delete, copy, help, create

#### Modifiers (Parameters)
Parameters act on modifing the behavior of an action
It have a short and a long form    
Short form: -f -s -t ...   
Long form: --force --track --no-git ...

#### Targets
Files.

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
Is an abstract class that handle all the fuzz to create a basic class
basically you should only override execute and get_name methods and your ready to go

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
Commands service is a container that holds a list of commands and execute commands

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
commands.remove ("hello);
```

#### Parsing args and executing

You can parse the args returning a Request by
```cs
public static int main(string[] args) {
    return 0;
    var commands = new Console.Commands ();
    var request = commands.parse_request_from_args ();
}
```
And execute requests with
```cs
commands.execute_request (request);
```
It's also possible to parse and execute in one shot with
```cs
public static int main(string[] args) {
    return 0;
    var commands = new Console.Commands ();
    commands.execute_with_args (args);
    // But in this case nothing will happen because there's no command
}

```
