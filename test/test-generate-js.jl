module TestGenerateJS

using Test
using Matte

module Server

function foo(slider)
    slider + 1
end

function bar(slider, textinput)
    "textinput $slider"
end

end

@test Matte.reverse_dependency_tree(Server) == Dict("slider" => ["bar", "foo"], "textinput" => ["bar"])
@test Matte.dependency_tree(Server) == Dict("foo" => ["slider"], "bar" => ["slider", "textinput"])

end
