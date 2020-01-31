"""
    p(contents)

Wrap some text in a paragraph tag. Helps with layout of raw text.
"""
p(contents...) = tag_wrap("p", contents...)

"""
    h1(contents...)

Show contents as a level 1 heading
"""
h1(contents...) = tag_wrap("h1", contents...)

"""
    h2(contents...)

Show contents as a level 2 heading
"""
h2(contents...) = tag_wrap("h2", contents...)

"""
    h3(contents...)

Show contents as a level 3 heading
"""
h3(contents...) = tag_wrap("h3", contents...)


"""
    h4(contents...)

Show contents as a level 4 heading
"""
h4(contents...) = tag_wrap("h4", contents...)

"""
    br()

Insert a line break (html `<br>`) into your UI
"""
br() = UIElement("<br>")


"""
    dialog(id, title, content, width = 500)

Display a dialog box (which pops over the rest of the content, forcing user acknowledgement).
Visibility is controlled by `id`. A common use case is to define this output function to have
sole input from a button, and simply return whether the button has been clicked.

`title` and `content` can be dynamically set.

If you need to include multiple elements inside `content`, wrap them as a tuple.

!!! note
    For best results `dialog`s should be placed at the _end_ of your UI, after the layout.
    Placing them inside a layout can cause them to be hidden.
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

"""
    snackbar(id, content; color = "error", width = 500)

Display a snackbar at the bottom of the page to notify users of events or other info.
Visibility of the snackbar is controlled by `id`, which should be a boolean. A common use
case is to define this output function to have sole input from a button, and simply return
whether the button has been clicked.

`content` can be dynamically set. Snackbars are small, so you should only include (raw) text
i.e. (`text_output`) in the content, not other `UIElement`s.

If you need to include multiple elements inside `content`, wrap them as a tuple.

Snackbars automatically close based on the timeout set (in milliseconds). Set to 0 to keep
open indefinitely.

!!! note
    For best results `snackbar`s should be placed at the _end_ of your UI, after the layout.
    Placing them inside a layout can cause them to be hidden.
"""
function snackbar(id, content; color = "error", timeout = 6000)
    (UIElement("""
    <v-snackbar
          v-model="$id"
          color = "$color"
          :timeout="$timeout">"""),
    content,
    UIElement("""<v-btn
            text
            @click="$id = false"
          >
            Close
          </v-btn>
        </v-snackbar>""",
    "$id: false"))
end

"""
    tooltip(content, tip)

Add a mouseover-activated tooltip to the UI elements contained in `content`. Works best for
small elements like buttons.

If you need to include multiple elements inside `content`, wrap them as a tuple.
"""
function tooltip(content, tip)
    (UIElement("""<v-tooltip bottom>
      <template v-slot:activator="{ on }">
        <span v-on="on">"""),
    content,
    UIElement("""
        </span>
      </template>
      <span>$tip</span>
    </v-tooltip>
    """))
end

"""
    visible_if(id, content...)

Create a span that only shows `content` if the variable `id` is `true`. As with all Matte
logic `id` should be a function defined in the `Server` module of your app.
"""
function visible_if(id, content...)
    (UIElement("""<span v-if = "$id">""", "$id: false"),
    content...,
    UIElement("</span>"))
end

"""
    circular_loader(width = 3, color = "primary")

Add a circular spinning loading animation to your UI. Best wrapped in a `visible_if` so you
can hide it once the relevant content has finished loading.
"""
function circular_loader(width::Integer = 3, color::AbstractString = "primary")
    UIElement("""<v-progress-circular
      :width="$width"
      color="$color"
      indeterminate
    ></v-progress-circular>""")
end
