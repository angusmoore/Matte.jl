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
