module TestGenerateJS

module Server

function foo(slider)
    slider + 1
end

function bar(slider, textinput)
    "textinput $slider"
end

end

@test Matte.get_watch_tree(Server) == Dict["slider" => ["bar", "foo"], "textinput" => ["bar"]]

end
