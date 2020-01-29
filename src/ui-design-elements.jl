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


"""
    dialog(id, title, content, width = 500)

Display a dialog box (which pops over the rest of the content, forcing user acknowledgement).
Visibility is controlled by `id`. A common use case is to define this output function to have
sole input from a button, and simply return whether the button has been clicked.

`title` and `content` can be dynamically set.
"""
function dialog(id, title, content, width = 500)
    (UIElement("""
    <v-dialog
      v-model="$id"
      width="$width">

      <v-card>
        <v-card-title
          primary-title>"""),
    title,
    UIElement("""
    </v-card-title>
        <v-card-text>"""),
    content,
    UIElement("""
        </v-card-text>

        <v-divider></v-divider>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="primary"
            text
            @click="$id = false"
          >
            Close
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    """,
    "$id: false"))
end
