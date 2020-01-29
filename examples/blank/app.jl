module NewMatteApp

using Matte

const title = "My New Matte App"

function ui()
    sidebar_layout(
        side_panel(
            h1("Hello World!")
        ),
        main_panel(
            h1("Output here")
        )
    )
end

module Server

function my_output(my_input)
    my_input
end

end

end
