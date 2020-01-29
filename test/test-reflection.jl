function foo(x, y)
    x + y
end

foobar(x::Int) = 2*x

@test Matte.argument_names(foo) == [:x, :y]
@test Matte.argument_names(foobar) == [:x]
