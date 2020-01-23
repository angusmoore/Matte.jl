"""
Wrap some text in a paragraph tag. Helps with layout of text.

Inputs:
    contents: The contents to wrap in a paragraph. Can be a string, or a tuple
    of other UI elements (such as text inputs, text output etc)
"""
p(contents) = tag_wrap("p", contents)

"""
Show contents as a level 1 heading

Inputs:
    contents: The contents to show as a heading. Can be a string, or a tuple
    of other UI elements (text output etc)
"""
h1(contents) = tag_wrap("h1", contents)

"""
Show contents as a level 2 heading

Inputs:
    contents: The contents to show as a heading. Can be a string, or a tuple
    of other UI elements (text output etc)
"""
h2(contents) = tag_wrap("h2", contents)

"""
Show contents as a level 3 heading

Inputs:
    contents: The contents to show as a heading. Can be a string, or a tuple
    of other UI elements (text output etc)
"""
h3(contents) = tag_wrap("h3", contents)


"""
Show contents as a level 4 heading

Inputs:
    contents: The contents to show as a heading. Can be a string, or a tuple
    of other UI elements (text output etc)
"""
h4(contents) = tag_wrap("h4", contents)

"""
Insert a line break (html `<br>`) into your UI
"""
br() = UIElement("<br>")
