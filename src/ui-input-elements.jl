"""
    slider(id, label, min, max, default = Int(round((max + min) / 2))

Input element that allows users to select among a set of integers using a slider
"""
function slider(id::AbstractString, label::AbstractString, min::Integer, max::Integer, default::Integer = Int(round((max + min) / 2)))
    UIElement("""
    <v-slider
        v-model = "$id"
        min="$min"
        max="$max"
        thumb-label
        label="$label">
        </v-slider>"""),
    UIModel(id, "$default")
end

"""
    text_input(id, label, default = "")

Free text field for string input by users

Note that a text input always returns a String to the server. If you need users
to be able to freely enter a number, use `number_input`.
"""
function text_input(id::AbstractString, label::AbstractString, default::AbstractString = "")
    UIElement("""
    <v-text-field
        v-model = "$id"
        label="$label"
        filled>
    </v-text-field>
    """),
    UIModel(id, "\"$default\"")
end

"""
    number_input(id, label, default = 0)

Form input that only accepts numbers

Note that `number_input` always returns a float to the server. If you need a string
use `text_input`. If you need integers, you can use a `slider` or round the result.
"""
function number_input(id::AbstractString, label::AbstractString, default::Integer = 0)
    UIElement("""
    <v-text-field
        v-model.number = "$id"
        label="$label"
        type = "number"
        filled>
    </v-text-field>
    """),
    UIModel(id, "$default")
end


"""
    button(id, label, color, size)

Add a button to a UI. Buttons return `true` to the server when clicked, and false otherwise.

size can be one of `x-small`, `small`, `normal`, `large`, `x-large`
color can be any valid color (see docs on colors for a full list) - e.g. `primary`, `error`, `teal` etc
"""
function button(id::AbstractString, label::AbstractString, color::AbstractString = "normal", size::AbstractString = "normal")
    UIElement("""
    <v-btn $size color="$color" v-model="$id" @click="fetch_update_$id(true)">$label</v-btn>
    """),
    UIModel(id, "false")
end

"""
    floating_action_button(id, label, location = "bottom right", color = "red")

Add a floating action button to your UI at `location`
"""
function floating_action_button(id::AbstractString, label::AbstractString, location::AbstractString = "bottom right", color::AbstractString = "red", size::AbstractString = "normal")
    UIElement("""<v-btn absolute fab $location color="$color" @click="fetch_update_$id(true)">$label</v-btn>"""),
    UIModel(id, "false")
end

"""
    date_picker(id::AbstractString, color::AbstractString = "primary")

Add a date picker to your UI. Date is returned as a String in ISO 8601 form (YYYY-MM-DD)
"""
function date_picker(id::AbstractString, color::AbstractString = "primary")
    UIElement("""<v-date-picker v-model="$id" color="$color" header-color="$color"></v-date-picker>"""),
    UIModel(id, "new Date().toISOString().substr(0, 10)")
end

"""
    time_picker(id, color = "primary")

Add a clock time picker to your UI. Time is returned as a String, in HH:MM 24 hour format.
Returns `nothing` if user has not yet picked a time.
"""
function time_picker(id::AbstractString, color::AbstractString = "primary", default::Union{AbstractString, Nothing} = nothing)
    UIElement("""<v-time-picker v-model="$id" color = "$color"></v-time-picker>"""),
    UIModel(id, isnothing(default) ? "null" : "\"$default\"")
end

"""
    function select(id, label, items, multiple = false, autocomplete = false)

Create a selection box in your UI for users to choose among options. Allow multiple selections
with `multiple`. Let users type in the box to filter options by setting `autocomplete` to `true`.
`items` can either be a string for a static (javascript) array of options (i.e. "['a first option',
'the second option']") or an id that corresponds to a function in your Server that returns an
array of options (potentially dynamically).

Returns either an Array (if no or multiple elements are selected) or the type of the individual
element if only one is selected. The type that is returned depends on the types of the elements
in the select list.
"""
function select(id::AbstractString, label::AbstractString, items::AbstractString, multiple::Bool = false, autocomplete::Bool = false)
    if occursin("[", items)
        items_model = ()
    else
        items_model = UIModel(items, "[]")
    end
    tag = autocomplete ? "v-autocomplete" : "v-select"
    UIElement("""
    <$tag
            v-model="$id"
            :items="$items"
            attach
            label="$label"
            filled
            $(multiple ? "multiple" : "")></$tag>"""),
    UIModel(id, "[]"),
    items_model
end

"""
    checkbox(id, label; default = false)
"""
function checkbox(id, label; default = false)
    UIElement("""
    <v-checkbox
      v-model="$id"
      label="$label"></v-checkbox>"""),
    UIModel(id, "$default")
end

quote_wrap_if_string(x::AbstractString) = "'$x'"
quote_wrap_if_string(x) = x

"""
    radio(id, values, labels})

"""
function radio(id::AbstractString, values::Array, labels::Array{<:AbstractString, 1})
    length(values) != length(labels) && error("`values` and `labels` must have the same length")

    buttons = map((value, label) -> UIElement("""<v-radio label="$label" :value="$(quote_wrap_if_string(value))"></v-radio>"""), values, labels)

    UIElement("""<v-radio-group v-model="$id" :mandatory="false">"""),
    buttons...,
    UIElement("</v-radio-group>"),
    UIModel(id, "null")
end

"""
    switch(id, label; default = false)
"""
function switch(id, label; default = false)
    UIElement("""
    <v-switch
      v-model="$id"
      label="$label"
    ></v-switch>
    """),
  UIModel(id, "$default")
end
