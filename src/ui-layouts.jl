"""
    side_panel(content...)

A narrow/side control (1/3 width) panel to be embedded in a `sidebar_layout`

Should only be used as part of a `sidebar_layout`
"""
function side_panel(content...)
    (UIElement("""<v-col cols = "4"><v-card><v-card-text>"""),
    content...,
    UIElement("</v-card></v-card-text></v-col>"))
end

"""
     main_panel(content...)

A main (2/3 width) panel to be embedded in a `sidebar_layout`

Should only be used as part of a `sidebar_layout`
"""
function main_panel(content...)
    (UIElement("""<v-col cols = "8"><v-card><v-card-text>"""),
    content...,
    UIElement("</v-card></v-card-text></v-col>"))
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
    content::Union{UIElement, NTuple{N, UIElement}} where N
end

"""
    tabs_layout(tabs...; vertical = false)

Create a tab layout -- app (or inset) with pages that can be navigated to using
a series of tabs
"""
function tabs_layout(tabs...; vertical = false)

    start = UIElement("""
    <v-tabs
      background-color="deep-purple accent-4"
      centered>""")

    tab_buttons = [UIElement("""<v-tab >$(tab.title)</v-tab>""") for (i, tab) in enumerate(tabs)]

    tab_content = ()
    for (i, tab) in enumerate(tabs)
        tab_content = (tab_content..., UIElement("""<v-tab-item>
          <v-card>"""), tab.content,
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
    TabPanel(title, unroll(content))
  end
