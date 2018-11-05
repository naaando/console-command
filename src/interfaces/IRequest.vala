public interface Console.Request : Object {
    public abstract string[] get_actions ();

    //  Parameters are information that could modify the output of the input
    //  like --no-git -f
    public abstract string[] get_parameters ();

    //  Targets are the input group that is essencial to work e.g.
    //  Creating a project: init NameOfTheProject
    public abstract string[] get_targets ();
}
