module IrisApp

using Matte

const title = "Matte Example App :: Iris Dataset"

function ui()
    sidebar_layout(
        side_panel(
            h1("What species would you like?"),
            br(),
            radio("species", ["setosa","versicolor","virginica"], ["Setosa","Versicolor","Virginica"])
        ),
        main_panel(
            h1("Iris data: ", text_output("selected_species")),
            br(),
            datatable_output("iris_df")
        )
    )
end

module Server

using RDatasets
using DataFrames
using InvertedIndices
iris = dataset("datasets", "iris")

function iris_df(species)
    if species != nothing
        iris[iris.Species .== species, Not(:Species)]
    else
        nothing
    end
end

function selected_species(species)
    if species == nothing
        "No species selected"
    else
        species
    end
end

end

end
