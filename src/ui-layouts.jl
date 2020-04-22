"""
    side_panel(content...)

A narrow/side control (1/3 width) panel to be embedded in a `sidebar_layout`

Should only be used as part of a `sidebar_layout`
"""
function side_panel(content...)
    (UIElement("""<v-col cols = "4"><v-card><v-card-text>"""),
    content...,
    UIElement("</v-card-text></v-card></v-col>"))
end

"""
     main_panel(content...)

A main (2/3 width) panel to be embedded in a `sidebar_layout`

Should only be used as part of a `sidebar_layout`
"""
function main_panel(content...)
    (UIElement("""<v-col cols = "8"><v-card><v-card-text>"""),
    content...,
    UIElement("</v-card-text></v-card></v-col>"))
end

"""
    sidebar_layout(leftpanel, rightpanel)

Create a side bar layout for your app: a 1/3 width control panel and a 2/3 width
main/output panel.
"""
function sidebar_layout(leftpanel, rightpanel)
    (UIElement("""<v-container cols = "12"><v-row>"""),
    leftpanel, rightpanel,
    UIElement("</v-row></v-container>"))
end

"""
    custom_grid_layout(content...)

Create a container to contain a custom layout.

Containers embed rows (which embed columns) to create layouts.
"""
function custom_grid_layout(content...)
    (UIElement("<v-container cols = \"12\">"), content, UIElement("</v-container>"))
end

"""
    custom_grid_row(content...)

Create a row for a custom layout

Rows wrap columns.
"""
function custom_grid_row(content...)
    (UIElement("<v-row>"), content, UIElement("</v-row>"))
end

"""
    custom_grid_column(content...; width = 12)

Create a layout column that covers width/12 of the row

Columns must be contained in rows (`custom_grid_row`)
"""
function custom_grid_column(content...; width = 12)
    (UIElement("<v-col cols = \"$width\">"), content, UIElement("</v-col>"))
end

"""
    custom_card(content...)

Create a 'card' to contain content. Cards are boxes with drop shadows.

For use in `custom_grid_layout`s, to define sections of the page inside a column
"""
function custom_card(content...)
    (UIElement("<v-card><v-card-text>"), content, UIElement("</v-card></v-card-text>"))
end

struct TabPanel
    title::String
    content
    model
end

"""
    tabs_layout(tabs...; vertical = false)

Create a tab layout -- app (or inset) with pages that can be navigated to using
a series of tabs
"""
function tabs_layout(tabs...; vertical = false)

    start = UIElement("""
    <v-tabs
      background-color="indigo darken-4"
      dark
      centered>""")

    tab_buttons = [UIElement("""<v-tab >$(tab.title)</v-tab>""") for (i, tab) in enumerate(tabs)]

    tab_content = ()
    for (i, tab) in enumerate(tabs)
        tab_content = (tab_content..., UIElement("""<v-tab-item>
          <v-card>"""), tab.content, tab.model,
          UIElement("""</v-card></v-tab-item>"""))
    end

    (start, tab_buttons..., tab_content, UIElement("</v-tabs>"))
end

"""
    tab_panel(title, content)

Define a panel for use in a tab layout

`tab_panel` should only be used as input to a `tabs_layout`
"""
function tab_panel(title, content)
    content = unroll(content)
    length(extract_uitype(UIFooter, content)) > 0 && error("Tab panels cannot contain a `footer`")
    length(extract_uitype(UIHeader, content)) > 0 && error("Tab panels cannot contain a `header`")

    model = extract_uitype(UIModel, content)
    content = extract_uitype(UIElement, content)

    TabPanel(title, content, model)
end

"""
    div(content...)

Create an html `<div>` and wrap `content` in it
"""

div(content...) = tag_wrap("div", content...)

"""
    span(content...)

Create an html `<span>` and wrap `content` in it
"""

span(content...) = tag_wrap("span", content...)


"""
    expansion_panel_list(items...)

Create a list of expansion panel items. `items` should _only_ be a set of `expansion_panel`s
"""
function expansion_panel_list(items...)
    tag_wrap("v-expansion-panels", items)
end

"""
    expansion_panel(header, content)

Create an expansion panel with that appears as `header` in the list and can expanded to also
show `content`

Should only be used inside an `expansion_panel_list`

If you need to include multiple elements inside `header` or `content`, wrap them as a tuple.
"""
function expansion_panel(header, content)
    tag_wrap("v-expansion-panel",
        (tag_wrap("v-expansion-panel-header", header),
        tag_wrap("v-expansion-panel-content", content)))
end

"""
    header(content, color, dark)

Define a custom app bar header. `content` should be html that will be included inside the
<v-app-bar> tag. See [Vuetify documentation](https://vuetifyjs.com/) for more information (or
a simple example is included in the Matte documentation).
"""
function header(content::AbstractString, color::AbstractString, dark::Bool)
    UIHeader("""
    <div>
    <v-app-bar
    color="$color"
    $(dark ? "dark" : "")>
        $content
    </v-app-bar>
    </div>
    """)
end

"""
    footer(content, bgcolor = "grey lighten-4")

Add a footer to your UI, containing `content`. If you need to include multiple elements
inside `content`, wrap them as a tuple.
"""
function footer(content, bgcolor = "grey lighten-4")
    (UIFooter("""<v-footer
      color = "$bgcolor">
      <v-col
        class="text-center"
        cols="12">"""),
    convert_uielement(UIFooter,unroll(content)),
    UIFooter("""
      </v-col>
    </v-footer>"""))
end

"""
    content_panel(content...)

Create the main content panel for your `footer_control_layout`. Should only be used as an
input to `footer_control_layout`.
"""
function content_panel(content...)
    content
end

"""
    control_panel(content...)

Create the control panel for your `footer_control_layout`. Should only be used as an input
to `footer_control_layout`.
"""
function control_panel(content...)
    content
end

"""
    footer_control_layout(main_panel, control_panel)

Creates a footer control layout, with a sticky/fixed-position footer at the bottom containing
the controls for the app, and the main content at the top.
"""
function footer_control_layout(main_panel, control_panel)
    UIElement("""<v-container><v-row><v-col cols = "12"><v-card><v-card-text>"""),
    main_panel,
    UIElement("</v-card-text></v-card></v-col></v-row></v-container>"),
    UIFooter("""<v-footer color = "white" fixed>
    <v-container><v-row><v-col
        class="text-center"
        cols="12">
    <v-card>
    <v-card-text>"""),
    convert_uielement(UIFooter,unroll(control_panel)),
    UIFooter("""
    </v-card-text>
    </v-card>
    </v-col>
    </v-row></v-container>
    </v-footer>""")
end
