"""
Input element that allows users to select among a set of integers using a slider

Inputs:
    id: Unique id for the input. This id is used as the variable name for the
    value of in your server-side functions
    label: Some text to describe what the slider does
    min: Minimum value of the slider
    max: Maximum value of the slider
    default (optional): The starting value for the slider. Defaults to the mid point
"""
function slider(id::AbstractString, label::AbstractString, min::Integer, max::Integer, default::Integer = Int(round((max + min) / 2)))
UIElement("""
<v-slider
    v-model = "$id"
    min="$min"
    max="$max"
    thumb-label
    label="$label">
    </v-slider>""",
    "$id: $default")
end

"""
Free text field for string input by users

Inputs:
    id: Unique id for the input. This id is used as the variable name for the
    value of in your server-side functions.
    label: Some text to describe what the text input is for
    default: The starting value for the input when the app loads (default empty string)

Note that a text input always returns a String to the server. If you need users
to be able to freely enter a number, use `number_input`.
"""
function text_input(id::AbstractString, label::AbstractString, default::AbstractString = "\"\"")
UIElement("""
<v-text-field
    v-model = "$id"
    label="$label"
    filled>
</v-text-field>
""",
    "$id: $default")
end

"""
Form input that only accepts numbers

Inputs:
    id: Unique id for the input. This id is used as the variable name for the
    value of in your server-side functions.
    label: Some text to describe what the number input is for
    default: The starting value for the input when the app loads (default 0)

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
    """,
        "$id: $default")
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
    """,
    "$id: false")
end
