
"""
    text_output(id)

Render the output from the server as raw text.

This is best used with a formatting tag (such as `p()` or heading `h1()` etc)
"""
function text_output(id)
    UIElement("""{{ $id }}""", "$id: 'Loading...'")
end
