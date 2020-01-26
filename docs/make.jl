using Documenter, Matte

makedocs(
    modules = [Matte],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    authors = "Angus Moore",
    sitename = "Matte.jl",
    pages = Any["index.md",
        "Getting started" => "getting-started.md",
        "Guides" => [
            "Introduction to Matte" => "intro.md",
            "Building Matte apps" => "building-app.md"
        ],
        "Reference" => [
            "Layouts" => "layouts.md",
            "Controlling style" => "ui-style.md",
            "Input elements" => "input-elements.md",
            "Output elements" => "output-elements.md"
        ]
    ],
    checkdocs = :exports
)

deploydocs(
    repo = "github.com/angusmoore/Matte.jl.git",
)
