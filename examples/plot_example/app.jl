module PlotsExample

using Matte

const title = "Matte Example :: Using Plots with Matte"

function ui()
    sidebar_layout(
        side_panel(
            selector("xvar", "X variable", "['SepalLength', 'SepalWidth', 'PetalLength', 'PetalWidth', 'Species']"),
            br(),
            selector("yvar", "Y variable", "['SepalLength', 'SepalWidth', 'PetalLength', 'PetalWidth', 'Species']"),
        ),
        main_panel(
            plots_output("output_plot")
        )
    )
end

module Server

using Plots
using RDatasets
iris = dataset("datasets","iris")

function output_plot(xvar, yvar)
    if typeof(xvar) <: AbstractString && typeof(yvar) <: AbstractString
        plot(iris[!, Symbol(xvar)], iris[!, Symbol(yvar)], seriestype=:scatter)
    end
end

end

end
