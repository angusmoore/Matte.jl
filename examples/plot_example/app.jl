module PlotsExample

using Matte

const title = "Using Plots with Matte"

function ui()
    sidebar_layout(
        side_panel(
            h1("Hello World!"),
            br(),
            radio("use_dist", ["Normal", "Exponential", "Uniform"], ["Normal", "Exponential", "Uniform"])
        ),
        main_panel(
            h1("Plot shows here: "),
            br(),
            plots_output("my_plot")
        )
    )
end

module Server

using Plots
import Random

function my_plot(use_dist)
    if use_dist != nothing
        if use_dist == "Normal"
            y = Random.randn(10)
        elseif use_dist == "Exponential"
            y = Random.randexp(10)
        else
            y = rand(10)
        end
        plot(1:10, y)
    end
end

end

end
