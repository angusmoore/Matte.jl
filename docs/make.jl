using Documenter, Matte

makedocs(
    modules = [Matte],
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true",
        assets = ["assets/favicon.ico"]
    ),
    authors = "Angus Moore",
    sitename = "Matte.jl",
    pages = Any["index.md",
        "Getting started" => "g01-getting-started.md",
        "Guides" => [
            "Introduction to Matte" => "g02-intro.md",
            "Building UIs" => "g03-ui.md",
            "Server logic" => "g04-server.md",
            "Displaying data" => [
                "DataFrames" => "g05a-dataframes.md",
                "Plots" => "g05b-plots.md"
            ],
            "State and side-effects" => [
                "Server-side state" => "g06a-server-side-state.md",
                "Side effects and manually updating the UI" => "g06b-side-effects.md"
            ],
            "Dealing with long-running computations" => "g07-long-running-computations.md"
        ],
        "Reference" => [
            "UI Layouts" => "r01-layouts.md",
            "Input elements" => "r02-input-elements.md",
            "Output elements" => "r03-output-elements.md",
            "Controlling style" => "r04-ui-style.md",
            "Running and creating Matte apps" => "r05-running-creating.md"
        ]
    ],
    checkdocs = :exports
)

deploydocs(
    repo = "github.com/angusmoore/Matte.jl.git",
)
