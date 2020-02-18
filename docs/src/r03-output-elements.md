# [Output elements](@id r03-output-elements)

```@docs
text_output
datatable_output
plots_output
```

# Side effects / manually pushing updates to the UI

```@docs
update_output
```

`update_output` is a way to _manually_ change the value of an output variable in the UI from
within the function for a different output variable. This is not the typical Matte computation
model, but can be useful for logic flows like:

* Setting and unsetting loading animations for long-running computations
* Creating 'onclick' listeners for buttons that then change multiple elements

`update_output` _must_ be passed an argument called session, and that variable _must_ be an
argument to the function from within which it is called. See the guide on
[server-side state](@ref g06b-side-effects) for more details.
