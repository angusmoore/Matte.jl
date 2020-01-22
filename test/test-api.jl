

module TestAPI

ui = function()
    tabset_panel((
    h1("hi there"),
    slider("slider","Slider",-100,11)
    )
    ,"")
end

module Server

function foo(a)
    a + 1
end

end

run_app("test", ui, Server)

HTTP.request("POST", "http://localhost:8000/matte/api", [("Content-Type", "application/json")],
       """{"id": "foo", "input" : {"a" : 1}}""")

exit(0)

end
