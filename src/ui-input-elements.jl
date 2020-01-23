struct UIElement
    html::AbstractString
    model::Union{AbstractString, Missing}
end

UIElement(html::AbstractString) = UIElement(html, missing)
UIElement(el::UIElement) = el

tag_wrap(tag, contents) = (UIElement("<$tag>"), UIElement(contents), UIElement("</$tag>"))

p(contents) = tag_wrap("p", contents)
h1(contents) = tag_wrap("h1", contents)
h2(contents) = tag_wrap("h2", contents)
h3(contents) = tag_wrap("h3", contents)
br() = UIElement("<br>")

function slider(id, label, min, max, default = (max + min) / 2)
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

function text_input(id, label, default = "\"\"")
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
