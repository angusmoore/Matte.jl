module AustralianWages

using Matte

const title = "Australian Wages by Occupation"

function ui()
    sidebar_layout(
        side_panel(
            h3("Choose an occupation"),
            br(),
            selector("sub_major", "Occupation major group", "sub_groups", true, true),
            show_if("show_unit",
                selector("unit", "Occupation unit group", "unit_groups", true, true),
                show_if("show_occ",
                    selector("selected_occs", "Occupation", "occupation_list", true, true)
                )
            ),
            h3("Sex"),
            radio("sex", ["Male", "Female", "Total"], ["Male", "Female", "Total"]),
            button("calculate_plot", "Create plot!"; color = "primary")
        ),
        main_panel(
            h1("Australian Wages by Occupation"),
            br(),
            hide_if("plot_loaded",
                circular_loader()
            ),
            show_if("plot_loaded",
                plots_output("plot_output")
            )
        )
    ),
    footer(p("Powered by Matte.jl; Data from Australian Taxation Office, 2016/17"))
end

function register_session_vars()
    Dict(
        :plot_loaded => false
    )
end

module Server

import CSV
using DataFrames, Plots
using Plots.PlotMeasures

## DATA IMPORT
wage_data = CSV.read("ts17individual15occupationgender.csv")

function show_unit(sub_major)
    length(sub_major) > 0
end

function show_occ(unit)
    length(unit) > 0
end

function sub_groups()
    wage_data[:, Symbol("Sub-major group")]
end

function unit_groups(sub_major)
    if !(typeof(sub_major) <: AbstractArray)
        sub_major = [sub_major] # selector with multiple selector returns element if one selected, array otherwise
    end
    keep = [x in sub_major for x in wage_data[:, Symbol("Sub-major group")]]
    wage_data[keep, Symbol("Unit group")]
end

function occupation_list(unit)
    if !(typeof(unit) <: AbstractArray)
        unit = [unit] # selector with multiple selector returns element if one selected, array otherwise
    end
    keep = [x in unit for x in wage_data[:, Symbol("Unit group")]]
    wage_data[keep, Symbol("Occupation")]
end

function plot_loaded(session, calculate_plot)
    session.plot_loaded || calculate_plot
end

function plot_output(selected_occs, sex, session, calculate_plot)
    if calculate_plot && sex != nothing && length(selected_occs) > 0
        session.plot_loaded = true
        keep_occ = [x in selected_occs for x in wage_data[:, Symbol("Occupation")]]
        keep_sex = wage_data[:, :Sex] .== sex
        plot_data = wage_data[keep_occ .& keep_sex, Symbol("Average taxable income")]
        plot_labels = wage_data[keep_occ .& keep_sex, Symbol("Occupation")]
        plot(plot_labels, plot_data, linetype = :bar, legend = false, left_margin = 100px)
    else
        nothing
    end
end

end

end
