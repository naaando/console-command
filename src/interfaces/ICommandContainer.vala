public interface Console.CommandContainer : Object {
    public abstract void set (string name, Command command);
    public abstract Command get (string name);
    public abstract void add (string name, Command command);
    public abstract void remove (string name);
}
