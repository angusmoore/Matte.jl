module HelloWorldApp

using Matte

const title = "Hello World"

function ui()
    sidebar_layout(
        side_panel(
            h1("Hello World!"),
            text_input("my_input", "Input some text")
        ),
        main_panel(
            h1("You wrote:"),
            p(text_output("my_output"))
        )
    )
end

module Server

function my_output(my_input)
    my_input
end

end

end
