sidebar_layout = sidebar_layout(
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

@test typeof(sidebar_layout) <: Tuple
@test typeof(sidebar_layout[1]) <: UIElement

tab_layout = tabs_layout(
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

@test typeof(tab_layout) <: Tuple
@test typeof(tab_layout[1]) <: UIElement

custom_layout = custom_grid_layout((
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

@test typeof(custom_layout) <: Tuple
@test typeof(custom_layout[1]) <: UIElement
