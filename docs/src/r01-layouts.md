# [Layouts](@id r01-layouts)

## Sidebar layouts

Sidebar layouts split the page into one-third (for a control panel) and two-thirds (for the
output). Each third is displayed in a card to visually separate it.

```@docs
sidebar_layout
side_panel
main_panel
```

## Tab panel layout

Layout with pages/panels controlled by a tab bar.

```@docs
tabs_layout
tab_panel
```

!!! example
    Create a `tabs_layout` UI with three tabs (all of which have some placeholder content).
    Tab 1 wraps its content in a tuple because it needs multiple elements in the panel
    content.
    ```
    function ui()
      tabs_layout(
        tab_panel(
          "Tab 1",
          (
            h1("Content for tab 1 goes here"),
            br(),
            slider("slider1", "Number 1", 0, 100)
          )
        ),
        tab_panel(
          "Tab 2",
          sidebar_layout(
            side_panel(h1("You can even inset sidebar layouts inside tab!")),
            main_panel(plots_output("my_plot"))
          )
        ),
        tab_panel(
          "Tab 3",
          "You can have as many tabs as you like..."
        )
      )
    end
    ```

## Control panel in the footer

```@docs
footer_control_layout
content_panel
control_panel
```

Similar to a `sidebar_layout` except that the control panel appears at the bottom, underneath
the main content/output of your app.

!!! note
    The layout of `footer_control_layout` isn't working for apps with large amounts of content
    in the `content_panel`; the control panel obscures scrolling down.

## Custom layouts

Functions to create custom flexgrid layouts using Vuetify's built-in container layout.

```@docs
custom_grid_layout
custom_grid_row
custom_grid_column
custom_card
```

## Customising look and feel

### Customer header

```@docs
header
```

The `header` function allows you to define your own, custom HTML, header. The `content` in a
`header` is wrapped inside a `<v-app-bar>` tag. You can include any valid elements inside a
`<v-app-bar>` that are understood by [Vuetify](https://www.vuetifyjs.com). This gives you a
lot of flexibility, but has a steeper learning curve. As an example, here's how to add a title
and some navigation icons to your custom header:
```
function ui() {
  header(
    "<v-toolbar-title>Page title</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn icon>
        <v-icon>mdi-heart</v-icon>
      </v-btn>
      <v-btn icon>
        <v-icon>mdi-magnify</v-icon>
      </v-btn>",
    "deep-purple accent-4",
    true  
  )
}
```

### Custom footer

```@docs
footer
```
