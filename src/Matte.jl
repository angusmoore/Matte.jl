module Matte

import Genie, Genie.Router

export sidebar_layout
export p, h1, h2, h3, slider, text_input
export text_output
export run_app

include("reflection.jl")
include("ui-input-elements.jl")
include("ui-layouts.jl")
include("ui-output-elements.jl")
include("generate-js.jl")
include("template.jl")
include("run.jl")
include("backend.jl")

end # module
