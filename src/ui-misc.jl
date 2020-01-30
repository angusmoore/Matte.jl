struct UIElement
    html::AbstractString
    model::Union{AbstractString, Missing}
end

UIElement(html::AbstractString) = UIElement(html, missing)
UIElement(el::UIElement) = el
UIElement(els::Tuple) = unroll(els)

tag_wrap(tag, contents...) = (UIElement("<$tag>"), UIElement(contents), UIElement("</$tag>"))
