
# tests
foo(x::Int) = 2*x
argument_names(which(foo, (Int,))) # picking a method
argument_names(foo)                # unambiguous
argument_names(x->2*x)             # closures OK
argument_names((x;y=9) -> x*y)     # keyword arguments OK
