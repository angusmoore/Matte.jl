# [Long-running Computations](@id g07-long-running-computations)

This guide combines the previous [two](@ref g06a-server-side-state)
[guides](@ref g06b-side-effects) to provide a design pattern that is helpful for
long-running computations. If you haven't read those guides, do so before continuing here.

## The problem and set up

Suppose we have some long-running computation. It doesn't have to be _super_ long, but long
enough that a user will notice a lag between changing inputs and outputs. Even a second is
noticeable, but let's assume we have something that takes even longer -- say 10 seconds.

The example app `long_running` simulates this just by using a `sleep`. Let's create a copy of
that app and fire it up to get a sense of the problem we're dealing with:

```
matte_example("bad_long_running", "bad_long_running")
includet("app.jl")
run_app(BadLongRunningExample)
```

Change one of the sliders and you'll immediately get a sense of the problem: the UI doesn't
seem to work! It _is_, it's just taking a long time to respond. Worse still, because we're
using a slider, moving the slider generates 10s of updates every time the user interacts with
it -- all the intermediate values that are scrolled through trigger updates too. Each update
takes 10 seconds (the `sleep` we inserted, to simulate some complex calculation). This is
intolerable as a user experience.

## How to improve it?

Ideally, we want to make two changes:

1) Avoid unnecessary intermediate calculations by _only_ running the calculation when the
user is happy with their chosen inputs.
2) _Show_ the user that a calculation is taking place. Have some animation to show that the
result is being calculated.

We'll make these changes to `bad_long_running` in the next two steps. An example app that
implements these changes is available as `better_long_running`.

## Improvement 1: Only calculate when desired

First, we need to add a button to our `ui` so that users can trigger the calculation. Let's
change the `side_panel` of our UI to include such a button:

```

function ui()
    sidebar_layout(
        side_panel(
            h1("Choose two numbers"),
            br(),
            slider("slider1", "Number 1", 0, 100),
            slider("slider2", "Number 2", 0, 100),
            br(),
            button("calculate", "Calculate now!")
        ),
        main_panel(
            ...
        )
    )
end
```

And then we need to hook this button up to our calculation. We want to _only_ run the
calculation when the button is pushed, that is, when `calculate` is `true`

```
function my_sum(slider1, slider2, calculate)
    if calculate
        sleep(10)
        slider1 + slider2
    end
end
```

Importantly, if `calculate` is `false`, this function returns `nothing`. `nothing` has a
special role in Matte. Matte will not change the UI if it receives a `nothing` response. This
means whatever our _last_ calculated result was will continue to be displayed, even if the
user changes the sliders. Jump over to your web browser and try it out for yourself (if you
are using `Revise`, you should only need to refresh your web browser to see the changes).

## Improvement 2: Show a loading animation

Showing users some visual indication that a calculation being informed will greatly improve
the user experience, and discourage users from repeatedly trying to recalculate (think the
app isn't working).

For this, we're going to need two UI elements: `circular_loader` and `show_if`.

The first is just a spinning wheel animation, and the second let's us conditional show that
animation.

Let's add these to the UI in the main panel:
```
sidebar_layout(
      side_panel(
        ...
      ),
      main_panel(
          h1("The sum of your numbers is:"),
          br(),
          text_output("my_sum"),
          show_if("loading",
            circular_loader()
          )
      )
  )
```

Now, our circular loader will show up anytime the server-side function `loading` returns
`true`. But, wait?! What would such a function even look like -- we want it to show the
animation when we start our long running computation and finish when that computation is
finished. We can't do that from a function!

This is where `update_output` from the guide on [side effects](@ref g06b-side-effects)
shines. We will _manually_ set the value of `loading` from _inside_ our long-running
function `my_sum`:

```
function my_sum(slider1, slider2, calculate, session)
    if calculate
        update_output("loading", true, session)
        sleep(10)
        result = slider1 + slider2
        update_output("loading", false, session)
        result
    end
end
```

(NB: Don't forget to add `using Matte` to your server module so that you can access the
`update_output` function from Matte).

The key here is we manually set `loading` to true before we start our long running
computation (proxied here by `sleep(10)`). Once that finishes, we again manually
`update_output` for `loading` to set it to false -- hiding our loading animation. And then
we, finally, return the result of our computation.

Go ahead and try it out in your app. When you push the button, a circular loader pops
indicating that the app is running a calculation. When it's finished, it disappears and the
new sum is shown.

For extra credit you could even _hide_ the previous number while the calculation is happening
using a `hide_if` with the `id` of `loading`.

This is a particularly helpful design pattern for plots, which tend to be slow to update and
can make UIs feel sluggish if allowed to recompute on every change to inputs.
