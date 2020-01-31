# Input elements

```@docs
slider
text_input
number_input
```

## Selecting among options
```@docs
select
```

### Dynamically setting the options in a `select`

By setting the `item` argument to an `id`, Matte will fetch the items from the server. This
can be used to create dynamic selections, where the options in the list depend on the values
of other inputs. The example `dynamic_select` shows how this works (create it by running
`matte_example("dynamic_select")`).

In the UI, we define a `select`, which has items defined by `dynamic_items`:
```
select("main_select", "Choose a subgroup", "dynamic_items")
```

And we define another `select` called `first_select` that will determine what shows up in
`dynamic_items`, but has static options:
```
select("first_select", "Select First Option:", "['Group #1', 'Group #2']")
```

We then define a function in the `Server` module in the app called `dynamic_items`
```
function dynamic_items(first_select)
  if (first_select == "Group #1")
    ["Subgroup 1.$i" for i in 1:10]
  elseif (first_select == "Group #2")
    ["Subgroup 2.$i" for i in 1:10]
  else
    ["No group selected"]
  end
end
```

Now, when users make a selection of a group in the first `select`, the options in the second
select will reflect that choice.

This pattern can be applied to create complex chains of dependent `select`s.
