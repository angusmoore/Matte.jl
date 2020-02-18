module BetterLongRunningExample

using Matte

const title = "Matte Example :: Long-running Computations"

function ui()
    sidebar_layout(
        side_panel(
            h1("Choose two numbers"),
            br(),
            slider("slider1", "Number 1", 0, 100),
            slider("slider2", "Number 2", 0, 100),
            br(),
            button("calculate", "Calculate now!")
        ),
        main_panel(
            h1("The sum of your numbers is:"),
            br(),
            text_output("my_sum"),
            show_if("loading",
            circular_loader()
            )
        )
    )
end

module Server

using Matte

function my_sum(slider1, slider2, calculate, session)
    if calculate
        update_output("loading", true, session)
        sleep(10)
        result = slider1 + slider2
        update_output("loading", false, session)
        result
    end
end

end

end
