module NoTitle
function ui()
end
module Server
end
end

module NoUI
title = "a"
module Server
end
end

module NoServer
title = "a"
function ui()
end
end

@test_throws ErrorException("You have not defined the `ui` function in your app module") run_app(NoUI)
@test_throws ErrorException("You have not set a `title` in your app module") run_app(NoTitle)
@test_throws ErrorException("You have not defined the `Server` module in your app module") run_app(NoServer)
