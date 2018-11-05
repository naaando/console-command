public abstract class Console.BaseCommand : Object, Command, UseRequest {
    protected Request request;

    public void set_request (Request request) {
        this.request = request;
    }

    public abstract string get_name ();
    public abstract async void execute ();

    public virtual void execute_sync () {
        var loop = new MainLoop ();

        execute.begin ((obj, result) => {
            execute.end (result);
            loop.quit ();
        });

        loop.run ();
    }

    public virtual void show_description () { return; }
    public virtual void show_help () { return; }
}
