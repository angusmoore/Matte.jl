using Documenter, Matte

makedocs(
    modules = [Matte],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    authors = "Angus Moore",
    sitename = "Matte.jl",
    pages = Any["index.md",
        "Getting started" => "g01-getting-started.md",
        "Guides" => [
            "Introduction to Matte" => "g02-intro.md",
            "Building UIs" => "g03-guide-ui.md",
            "Server logic" => "g04-guide-server.md"
        ],
        "Reference" => [
            "UI Layouts" => "r01-layouts.md",
            "Input elements" => "r02-input-elements.md",
            "Output elements" => "r03-output-elements.md",
            "Controlling style" => "r04-ui-style.md",
            "Variables with 'state'" => "r05-server-side-state.md",
            "Changing the UI from server functions" => "r06-side-effects.md",
            "Running and creating Matte apps" => "r07-running-creating.md"
        ]
    ],
    checkdocs = :exports
)

deploydocs(
    repo = "github.com/angusmoore/Matte.jl.git",
)
