module TestAPI

using Matte

const title = "Test API"

ui = function()
    sidebar_layout((
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

# Test that we can actually fetch the javascript that powers Matte
res = HTTP.request("GET", "http://localhost:8000/bundle.min.js")
@test res.status == 200

# Test that submitting inputs to the backend gives the right result
HTTP.WebSockets.open("ws://127.0.0.1:8001") do ws
    payload = Dict(
        :channel => "matte",
        :message => "api",
        :payload => Dict(
            :id => "foo",
            :session_id => "test_session",
            :input => Dict(
                :a => 1
            )
        )
    )
    expected = Dict(
        "id" => "foo",
        "value" => 2
    )
    write(ws, JSON.json(payload))
    @test JSON.parse(String(readavailable(ws))) == expected
end

stop_app()
