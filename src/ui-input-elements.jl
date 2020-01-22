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
