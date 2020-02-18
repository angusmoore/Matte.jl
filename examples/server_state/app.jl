module ServerStateExample

using Matte

const title = "Matte Example :: Server-side state"

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

function register_session_vars()
    Dict(
        :count => 0
    )
end

module Server

function my_count(my_button, session)
    if my_button
        session.count += 1
    end
    session.count
end

end

end
