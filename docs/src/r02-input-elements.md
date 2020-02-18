# [Input elements](@id r02-input-elements)

## Text input

```@docs
text_input
```

## Numeric inputs

```@docs
number_input
slider
```

`number_input` provides more flexibility, as sliders can only offer integers.

!!! note
    `number_input` will return an empty string if the user deletes _all_ of the digits in the
    input box. This may cause your server-side functions to fail if they assume a number
    will be returned.

## Selecting among options

```@docs
selector
radio
switch
checkbox
list
list_item
button_group
```

### Dynamically setting the options in a `selector`

By setting the `item` argument to an `id`, Matte will fetch the items from the server. This
can be used to create dynamic selections, where the options in the list depend on the values
of other inputs. The example `dynamic_select` shows how this works (create it by running
`matte_example("dynamic_select")`).

In the UI, we define a `selector`, which has items defined by `dynamic_items`:
```
selector("main_select", "Choose a subgroup", "dynamic_items")
```

And we define another `selector` called `first_select` that will determine what shows up in
`dynamic_items`, but has static options:
```
selector("first_select", "Select First Option:", "['Group #1', 'Group #2']")
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

Now, when users make a selection of a group in the first `selector`, the options in the second
select will reflect that choice.

This pattern can be applied to create complex chains of dependent `selector`s.

## Dates and times

```@docs
date_picker
time_picker
```

## Buttons

```@docs
floating_action_button
button
```
