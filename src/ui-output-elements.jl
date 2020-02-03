
"""
    text_output(id)

Render the output from the server as raw text.

This is best used with a formatting tag (such as `p()` or heading `h1()` etc)
"""
function text_output(id)
    (UIElement("""{{ $id }}"""), UIModel(id, "'Loading...'"))
end

"""
    plots_output(id)

Render a plot. Supports plots created by the `Plots` package.

Plots are slow to render, and so should not be directly hooked up to inputs that rapidly
request updates to the server -- like sliders. If you wish to use these input types, add a
button to refresh the plot input and only return the plot when that is `true` (otherwise
return `nothing`).
"""
function plots_output(id)
    UIElement("""<v-container><img v-bind:src = "$id"></v-container>"""), UIModel(id, "null")
end
