public interface Console.Command : Object {
    public abstract string get_name ();
    public abstract async void execute ();
    public abstract void execute_sync ();
    public abstract void show_description ();
    public abstract void show_help ();
}
