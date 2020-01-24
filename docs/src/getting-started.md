# Getting started

### Installation

Matte is not yet registered in the julia general repository. To install the latest release run the following from the `Pkg` repl (type `]` to get there):

```
pkg> add https://github.com/angusmoore/Matte.jl.git#v0.1.0
```

You can install the latest development version by removing the `#v0.1.0`.

### Creating your first app

To create the skeleton for a Matte app, start julia, run `using Matte` and then run:
```
julia> new_matte_app("path/to/app")
```

Matte will create a new folder and julia project at your chosen path and create all the files necessary to get started with Matte. Change your directory to where you just created your app and activate the new project:
```
julia> cd("path/to/app")
pkg> activate .
```
(Remember `]` gets you into the `Pkg` repl)

Matte has created a simple app in that directory. The app is defined in the file called `app.jl`. It defines a module called `MyApp`. This is, well, your brand new Matte app.

### Running your new app

Let's run our new app.

But before we do: a note about Revise. I _highly_ recommend using Revise with Matte. This lets you edit your app and see the changes immediately, without having to restart your app. Revise is included by default when you create a new Matte app, so all we need to do is:
```
julia> using Revise
```

Back to our app.

To run the app, we need to first load Matte, and then load our module MyApp:
```
julia> using Matte
julia> includet("app.jl")
```
(Note that I use `includet` from Revise, to track changes to the file. If you aren't using Revise, just use `include`. But you should *definitely* use Revise!)

All we need to do now is run our app. We do this using the Matte function `run_app`, which takes the module that defines our app as argument:
```
julia> run_app(MyApp)
```

Matte will take a little while to start. Your app is up and running once you see:
```
Web Server starting at http://0.0.0.0:8000
```
Navigate your favourite web browser to the address listed above and (after a few seconds) viola! Your app is ready!
