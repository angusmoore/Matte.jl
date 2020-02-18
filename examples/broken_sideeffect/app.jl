module BrokenSideEffect

using Matte

const title = "MatteExample :: Broken Side-effects"

function ui()
    sidebar_layout(
        side_panel(
            h1("Push this button"),
            br(),
            button("my_button", "Push me"),
            br(),
            slider("slider", "Choose a number", 1, 10)
        ),
        main_panel(
            p("You have pushed the button: ", text_output("my_count"), " times"),
            br(),
            p("Times the slider is equal to: ", text_output("my_calc"))
        )
    )
end

function register_session_vars()
    Dict(
        :count => 0
    )
end

module Server

function my_calc(slider, session)
    slider * session.count
end

function my_count(my_button, session)
    if my_button
        session.count += 1
    end
    session.count
end

end

end
