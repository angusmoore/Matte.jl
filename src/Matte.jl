module Matte

import Genie, Genie.Router
import Base64: base64encode
import DataFrames, Dates, JSON, Logging, Pkg, Plots, Tables

import Base: getproperty, setproperty!

# layouts
export sidebar_layout, side_panel, main_panel
export tabs_layout, tab_panel
export footer_control_layout, content_panel, control_panel
export custom_grid_layout, custom_grid_row, custom_grid_column, custom_card
export expansion_panel_list, expansion_panel
export header, footer

# style elements
export p, h1, h2, h3, br, dialog, snackbar, div, span, show_if, hide_if, circular_loader
export divider, icon

# input elements
export slider, text_input, number_input, button, floating_action_button, tooltip, date_picker
export time_picker, selector, checkbox, switch, radio, list, list_item, button_group

# output elements
export text_output, plots_output, datatable_output, update_output

# functions and helpers
export run_app, stop_app
export new_matte_app, matte_example

include("reflection.jl")
include("ui-misc.jl")
include("ui-design-elements.jl")
include("ui-input-elements.jl")
include("ui-layouts.jl")
include("ui-output-elements.jl")
include("ui-update.jl")
include("generate-js.jl")
include("sanity.jl")
include("session.jl")
include("static.jl")
include("template.jl")
include("run.jl")
include("backend.jl")
include("usethis.jl")

end # module
