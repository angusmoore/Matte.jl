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
    </v-slider>""",
    "$id: $default")
end

"""
    text_input(id, label, default = "")

Free text field for string input by users

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

"""
    floating_action_button(id, label, location = "bottom right", color = "red")

Add a floating action button to your UI at `location`
"""
function floating_action_button(id::AbstractString, label::AbstractString, location::AbstractString = "bottom right", color::AbstractString = "red", size::AbstractString = "normal")
    UIElement("""<v-btn absolute fab $location color="$color" @click="fetch_update_$id(true)">$label</v-btn>""",
            "$id: false")
end
