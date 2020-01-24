# The basics

Matte comes with a number of example apps to demonstrate how it works. Let's start with the
`hello_world` example.

Open Julia. If you haven't already, install Matte -- instructions can be found in the
[Getting started](@ref) part of the manual.

Next create a new Matte app, and populate it with the included `hello_world` app by running:
```
julia> using Matte
julia> matte_example("hello_world", "path/to/example")
```

where `path/to/example` is an empty folder where you want to create the new app. Matte will
create a new project at that location. Change your working directory to that location:
```
julia> cd("path/to/example")
```
and open up the folder in your favourite editor. There are two files that Matte has created:
`app.jl` and a `Project.toml`.  `Project.toml` is a standard project file for Julia's package
manager, for specifying your app's dependencies. `app.jl` (unsurprisingly!) is the app.
It defines the server-side logic, and the UI. Open that file in your favourite editor. It
should look like this:
```@example
read(joinpath(pathof(Matte), "examples", "hello_world", "app.jl")) # hide
```

Before we dig in to what makes a Matte app, let's run the app. First we need to activate the
project, and load `Revise` (so that can make changes to our app without having to restart.
You don't _have_ to use `Revise`. But you should!):
```
pkg> activate .
julia> using Revise
julia> includet("hello_world.app")
julia> run_app(HelloWorldApp)
```
Open your favourite web browser and visit `http://localhost:8000`. After a few seconds you
should see a simple webpage that looks like this:
![Hello world screenshot]("assets/hello-world.png")

You can type some text on the left, and it will appear on the right. Not very exciting, but
it's our first Matte app!

## Key element 1: App module

All Matte apps are defined as modules. The modules must contain three things:

1. A `const` String called `title` that defines the app title.
2. A function called `ui` that defines (and returns!) the ui
3. A sub-module called server

You can structure this module however you like: it can be one file (like the hello_world
example), or split across many. There are no restrictions on the name of the app module.
The module can import packages, these just need to specified as with any julia project.

## Key element 2: Defining the UI



## Key element 3: Server-side logic

Server side logic is contained in a module that must be called `Server`, as a sub-module of
your app module.

Each function in the server module represents an `output` variable that can be rendered in
your UI. These functions take as inputs variables whose names must correspond to input variables
in your UI (i.e. the `id`s of your various input elements.

In our `hello_world` app, we have only one output variable called `my_output`. It takes a
single argument, `my_input`. In our UI, `my_input` is the `id` for the text input. As it
stands, this function is pretty boring. It just returns whatever is in the text input.
Let's make it a bit more exciting, by having it replace any 'a' it finds with a 'b'. Replace
the definition of `my_output` with the following:
```
function my_output(my_input)
  replace(my_input, "a" => "b")
end
```
Go back to your browser, refresh the page, and try out the new text input.

That's it! You've created, customised and run your first Matte app. In the next article
[Building a Matte app](@ref) we'll go into more detail about creating UIs and server-side
logic.
