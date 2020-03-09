# Matte.jl <a href='https://angusmoore.github.io/Matte.jl/'><img src='docs/src/assets/logo.png' align="right" height="140"/></a>

![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)
![CI](https://github.com/angusmoore/Matte.jl/workflows/CI/badge.svg)
[![codecov.io](http://codecov.io/github/angusmoore/Matte.jl/coverage.svg?branch=master)](http://codecov.io/github/angusmoore/Matte.jl?branch=master)

[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://angusmoore.github.io/Matte.jl/stable)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://angusmoore.github.io/Matte.jl/dev)

Matte is a julia library for julia-powered dashboards, inspired by Google's material design.
Matte makes it easy to convert your existing julia code into a beautiful and powerful dashboard
for end users.

**Please note**: Matte is still highly experimental.

## Examples

* [Create an app for interactive plotting](http://104.154.85.59/mattejl/plotsexample/)

(NB: Examples are temporarily hosted, and may not be available from time-to-time).

## Getting started

### Installation

To install the latest release run the following from the `Pkg` repl (type `]` to get there):
```
pkg> add Matte
```

You can install the latest development version by running:
```
pkg> add https://github.com/angusmoore/Matte.jl.git
```

### Run an example app

Matte comes with some example apps. Let's create and run one of the examples:
```
julia> matte_example("hello_world", "hello_world")
```

Matte will create a new folder and julia project at your chosen path and create all the files
for the example. Matte will change your working directory and activate the project.

### Running your new app

Let's run the app.

But before we do: a note about Revise. I _highly_ recommend using Revise with Matte. This
lets you edit your app and see the changes immediately, without having to restart your app.
Revise is included by default when you create a new Matte app, so all we need to do is:
```
julia> using Revise
```

Back to our app.

To run the app, we need to first load Matte, and then load our module MyApp:
```
julia> using Matte
julia> includet("app.jl")
```
(Note that I use `includet` from Revise, to track changes to the file. If you aren't using
Revise, just use `include`. But you should *definitely* use Revise!)

All we need to do now is run our app. We do this using the Matte function `run_app`, which
takes the module that defines our app as argument:
```
julia> run_app(HelloWorldApp)
```

Matte will take a little while to start. Your app is up and running once you see:
```
Web Server starting at http://127.0.0.1:8000
```
Navigate your favourite web browser to the address listed above and (after a few seconds)
viola! Your app is ready!

## Support, bugs, & planned features

General support for help with usage and troubleshooting is best directed to the
[julialang discourse](https://discourse.julialang.org/).

Please report any bugs you find on the [github issue tracker](https://github.com/angusmoore/Matte.jl/issues).

## Acknowledgements

Matte is made possible by a range of excellent julia and javascript open source libraries.
Of particular note: [Genie.jl](https://genieframework.github.io/Genie.jl/),
[Vuetify](https://vuetifyjs.com/) and [Vue.js](https://vuejs.org/).
