sidebar = sidebar_layout(
    side_panel(
        h1("hi there"),
        slider("slider","Slider",-100,11),
        text_input("textinput", "Add a number")
    ),
    main_panel(
        text_output("foo"),
        text_output("bar"),
        h1(text_output("baz")),
        p("just some more text")
    )
)

@test typeof(sidebar) <: Tuple
@test typeof(sidebar[1]) <: Matte.UIElement

tabs = tabs_layout(
    tab_panel("Tab 1", (
        h1("hi there"),
        slider("slider","Slider",-100,11),
        text_input("textinput", "Add a number")
    )),
    tab_panel("Tab 2", (
        text_output("foo"),
        text_output("bar"),
        h1(text_output("baz")),
        p("just some more text")
    ))
)

@test typeof(tabs) <: Tuple
@test typeof(tabs[1]) <: Matte.UIElement

module TestTablayout
using Matte
const title = "Test Tab Layout"
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
module Server
end

end

run_app(TestTablayout, async = true)

# Test that we can actually fetch the javascript that powers Matte
res = HTTP.request("GET", "http://localhost:8000/")
@test res.status == 200
stop_app()

custom = custom_grid_layout((
    custom_grid_row(
        custom_grid_column(
            (
                h1(text_output("baz")),
                p("just some more text")
            ),
            width = 6
        ),
        custom_grid_column(
            (
                h1("hi there"),
                slider("slider","Slider",-100,11),
                text_input("textinput", "Add a number")
            ),
            width = 6
        )
    )
))

@test typeof(custom) <: Tuple
@test typeof(custom[1]) <: Matte.UIElement
