module ServerStateExample

using Matte

const title = "Server-side state"

function ui()
    sidebar_layout(
        side_panel(
            h1("Push this button"),
            br(),
            button("my_button", "Push me")
        ),
        main_panel(
            p("You have pushed the button: ", text_output("my_count"), " times")
        )
    )
end

function register_stateful()
    Dict(
        :count => 0
    )
end

module Server

function my_count(my_button, stateful_vars)
    my_button && stateful_vars.count += 1
    stateful_vars.counts
end

end

end
