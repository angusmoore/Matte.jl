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
