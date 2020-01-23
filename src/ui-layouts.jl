"""
A narrow/side control (1/3 width) panel to be embedded in a `sidebar_layout`

Inputs:
    * content...: the content to fill the panel

Should only be used as part of a `sidebar_layout`
"""
function side_panel(content...)
    (UIElement("""<v-col cols = "4"><v-card><v-card-text>"""),
    content...,
    UIElement("</v-card></v-card-text></v-col>"))
end

"""
A main (2/3 width) panel to be embedded in a `sidebar_layout`

Inputs:
    * content...: the content to fill the panel

Should only be used as part of a `sidebar_layout`
"""
function main_panel(content...)
    (UIElement("""<v-col cols = "8"><v-card><v-card-text>"""),
    content...,
    UIElement("</v-card></v-card-text></v-col>"))
end

"""
Create a side bar layout for your app: a 1/3 width control panel and a 2/3 width
main/output panel.

Inputs:
    leftpanel: The panel (either a `main_panel` or `side_panel`) to go on the left side of the layout.
    rightpanel: The panel (either a `main_panel` or `side_panel`) to go on the right side of the layout.
"""
function sidebar_layout(leftpanel, rightpanel)
    (UIElement("""<v-container cols = "12"><v-row>"""),
    leftpanel, rightpanel,
    UIElement("</v-row></v-container>"))
end

"""
Create a container to contain a custom layout.

Containers embed rows (which embed columns) to create layouts.

Inputs:
    contents...: The content to go in the container. Must be rows.
"""
function custom_grid_layout(content...)
    (UIElement("<v-container cols = \"12\">"), content, UIElement("</v-container>"))
end

"""
Create a row for a custom layout

Inputs:
    content...: The content to go in the rows. Must be columns.

Rows wrap columns.
"""
function custom_grid_row(content...)
    (UIElement("<v-row>"), content, UIElement("</v-row>"))
end

"""
Create a layout column that covers width/12 of the row

Inputs:
    * content...: The content to go in the column
    * width: Width of the column. Full width = 12 . (Default 12)

Columns must be contained in rows (`custom_grid_row`)
"""
function custom_grid_column(content...; width = 12)
    (UIElement("<v-col cols = \"$width\">"), content, UIElement("</v-col>"))
end

"""
Create a 'card' to contain content. Cards are boxes with drop shadows.

For use in `custom_grid_layout`s, to define sections of the page inside a column

Inputs:
    content...: The content to be contained inside the card
"""
function custom_card(content...)
    (UIElement("<v-card><v-card-text>"), content, UIElement("</v-card></v-card-text>"))
end

struct TabPanel
    title::String
    content::Union{UIElement, NTuple{N, UIElement}} where N
end

"""
Create a tab layout -- app (or inset) with pages that can be navigated to using
a series of tabs

Input:
    tabs...: A tuple of `tab_panel`s to display in the layout
    vertical (optional, default false): Display the tabs as a vertical menu
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
Define a panel for use in a tab layout

Inputs:
    title: Title for the tab (appears in the tab bar)
    content: Content for the panel

`tab_panel` should only be used as input to a `tabs_layout`
"""
function tab_panel(title, content)
    TabPanel(title, unroll(content))
  end
