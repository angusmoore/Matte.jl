
"""
Render the output from the server as raw text

This is best used with a formatting tag (such as `p()` or heading `h1()` etc)

Input:
    id: The output variable name (a function in the Server module)

See the getting started guide for an explanation of how to structure your app
module.
"""
function text_output(id)
    UIElement("""{{ $id }}""", "$id: 'Loading...'")
end
