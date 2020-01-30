module MyApp

using Matte

const title = "Test"

#=function ui()
    sidebar_layout(
    side_panel(
        h1("hi there"),
        slider("slider","Slider",-100,11),
        text_input("textinput", "Add a number")
    ),
    main_panel(
        text_output("foo"),
        text_output("bar"),
        h1(text_output("baz")),
        p("just some more text"),
        "this is revising right?"
    ))
end=#

function ui()
    custom_grid_layout((
        custom_grid_row(
            custom_grid_column(
                (
                    h1(text_output("baz")),
                    p("just some more text"),
                    p(text_output("foo")),
                    p(text_output("bar")),
                    p(text_output("qux")),
                    dialog("mydialog", text_output("foo"), text_output("foo"))
                ),
                width = 6
            ),
            custom_grid_column(
                (
                    h1("hi there"),
                    slider("slider","Slider",-100,11),
                    number_input("numberinput", "Add a number"),
                    text_input("textinput", "add some text"),
                    tooltip(text_input("hi","hm"),"Hi!"),
                    tooltip(button("foobutton", "Button!"), "Click me!"),
                    button("mybutton", "Button!"),
                    visible_if("am_i_visible", p("Why yes!")),
                    floating_action_button("fab","fab", "top right")
                ),
                width = 6
            )
        )
    )),
    footer((p("test"), h1("foo")))
end

module Server

using DataFrames

function foo(slider)
    slider + 1
end

function bar(slider, numberinput)
    DataFrame()
    slider + numberinput
    #error("stop")
end

function baz(textinput)
    "YOU did say something really important?: $textinput"
end

function am_i_visible(slider)
    slider > -40
end

function qux(slider, mybutton)
    if mybutton
        slider
    end
end

function mydialog(fab)
    fab
end

end

end
