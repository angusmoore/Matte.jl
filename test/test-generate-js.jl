module TestGenerateJS

using Test
using Matte

function register_stateful()
    Dict(
        :counter => 0
    )
end

module Server

function foo(slider)
    slider + 1
end

function bar(slider, textinput)
    "textinput $slider"
end

function baz(slider, stateful_vars)
    stateful_vars.counter += slider
    stateful_vars.counter
end

end

@test Matte.reverse_dependency_tree(Server) == Dict("slider" => ["bar", "baz", "foo"], "textinput" => ["bar"])
@test Matte.dependency_tree(Server) == Dict("foo" => ["slider"], "bar" => ["slider", "textinput"], "baz" => ["slider"])

end
