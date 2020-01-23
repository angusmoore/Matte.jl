struct UIElement
    html::AbstractString
    model::Union{AbstractString, Missing}
end

UIElement(html::AbstractString) = UIElement(html, missing)
UIElement(el::UIElement) = el

tag_wrap(tag, contents) = (UIElement("<$tag>"), UIElement(contents), UIElement("</$tag>"))
