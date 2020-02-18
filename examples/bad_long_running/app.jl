module BadLongRunningExample

using Matte

const title = "Matte Example :: Long-running Computations"

function ui()
    sidebar_layout(
        side_panel(
            h1("Choose two numbers"),
            br(),
            slider("slider1", "Number 1", 0, 100),
            slider("slider2", "Number 2", 0, 100)
        ),
        main_panel(
            h1("The sum of your numbers is:"),
            br(),
            text_output("my_sum")
        )
    )
end

module Server

function my_sum(slider1, slider2)
    sleep(10)
    slider1 + slider2
end

end

end
