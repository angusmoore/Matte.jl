# [Building a UI](@id g03-ui)

UIs in Matte are declared as a function, called `ui`. This function contains a `tuple` of
stuff to create your UI. But what stuff?

Well, there's lots. There are [style elements](@ref r04-ui-style), like HTML headings, bold
text, and horizontal lines. There are [input elements](@ref r02-input-elements) for your
users to interact with -- text fields, tick boxes, sliders, etc. There are
[output elements](@ref r03-output-elements) that let you display the results from server-side
calculations. And there are ways to determine the [layout](@ref r01-layouts) of your app.

## Step 1: Creating a layout

There's a lot of options there, so let's keep things simple and concrete. Start with the
hello world app, delete everything inside the body of the UI function. And then lets create
a new UI that uses the layout common for dashboards -- input controls on the left, main output
on the right (in a larger panel). In Matte, this is called a `sidebar_layout`. We create one
as follows (inside our app module):
```
function ui()
  sidebar_layout(
    side_panel(

    ),
    main_panel(

    )  
  )
end
```

`sidebar_layout` is a function that takes two arguments, the left side panel and the right
side panel. We've added a `side_panel` for the left panel, and a `main_panel` for the right.
But both of those panels are currently blank -- they are also just functions, but we haven't
passed anything to them.

## Step 2: Adding some stuff to the UI

Let's add some content to our left side control panel. Let's add a level 1 heading `h1`,
some text explaining what our app does, and a slider for users to interact with.
```
function ui()
  sidebar_layout(
    side_panel(
      h1("Our First Matte App"),
      p("Hi everyone, this app doesn't do very much, but you can play with the slider below"),
      slider("my_slider", "Choose a number", 0, 100)
    ),
    main_panel(

    )  
  )
end
```

To add these elements, all we need to do is ... add them, with commas in between so that
Julia knows you've started a new element.[^1] Each of the elements is fairly self explanatory:
`h1` takes some text and displays it as a heading; `p` the same, but as a paragraph, and
`slider` creates a new slider with `id` `my_slider` -- we need this `id` so we can access the
value on the server.

Let's add some elements to the `main_panel` too. We haven't created a Server module yet, but,
for argument's sake, let's assume we have a function in our server called `my_output` that
returns the number the user selected times 10 (we'll create this in the next guide).
```
function ui()
  sidebar_layout(
    side_panel(
      h1("Our First Matte App"),
      p("Hi everyone, this app doesn't do very much, but you can play with the slider below"),
      slider("my_slider", "Choose a number", 0, 100)
    ),
    main_panel(
      h1("Some output"),
      p("The number you chose was: ", text_output("my_output"))
    )  
  )
end
```

Again, we've added a level 1 heading and a paragraph. But this time, we've added _two_ things
inside the paragraph, some static text and the `text_output`. `text_ouput` (and it's other
output element friends) are how you display results from the server in your UI. I this case,
`text_output` will renders the response as, well, text. You can also render plots from the
`Plots.jl` package and dataframes (or and `Tables.jl` table) using `plots_output` and
`datatable_output` respectively. See the [reference guide](@ref r03-output-elements) for
examples.

## A quick note on adding elements

Most -- but not all -- UI elements can contain multiple layout elements within them. That's
how we are able to put a heading, paragraph and slider inside a `side_panel`, or a static
string and a `text_output` inside a `p`. But some elements, that need to have multiple arguments
cannot -- for instance a `sidebar_layout` takes exactly two inputs: the left and right panels.

If you find yourself in a situation where you need to provide multiple UI elements to a
multi-argument function, simply wrap the elements in parentheses (to create a tuple).

## Digging deeper

There are _lots_ of UI elements. The Matte reference is the best place to understand what is
available, and how to use them. Key frequently-used elements include: `number_input`,
`text_input`, `button`, `switch`, `selector` and `plots_output`.

In the [next guide](@ref g04-server) we'll look at how to create the server-side logic that
drives the interactivity of a Matte app.

[^1]: Under the hood, `side_panel` takes a vararg tuple.
