using Documenter, Matte

makedocs(
    modules = [Matte],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    authors = "Angus Moore",
    sitename = "Matte.jl",
    pages = Any["index.md"],
    checkdocs = :exports
)

deploydocs(
    repo = "github.com/angusmoore/Matte.jl.git",
)
