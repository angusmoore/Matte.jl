module TestAPI

using Matte

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

end

run_app(TestAPI, async = true)

res = HTTP.request("POST", "http://localhost:8000/matte/api", [("Content-Type", "application/json")],
       """{"id": "foo", "session_id": "test_session", "input" : {"a" : 1}}""")

@test res.status == 200
@test String(res.body) == "{\"foo\":2}"
