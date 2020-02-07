abstract type AbstractUIElement end
abstract type AbstractUIHTMLElement <: AbstractUIElement end

struct UIElement <: AbstractUIHTMLElement
    html::String
end

struct UIHeader <: AbstractUIHTMLElement
    html::String
end

struct UIFooter <: AbstractUIHTMLElement
    html::String
end

struct UIModel <: AbstractUIElement
    id::String
    default::String
end

struct UIWatch <: AbstractUIElement
    id::String
    code::String
end

UIHeader(el::UIElement) = el
UIFooter(el::UIElement) = el
UIModel(el::UIModel) = el

UIHeader(els::Tuple) = unroll(els)
UIFooter(els::Tuple) = unroll(els)
UIModel(els::Tuple) = unroll(els)

tag_wrap(tag, contents...) = (UIElement("<$tag>"), contents, UIElement("</$tag>"))

extract_uitype(t::Type, el::AbstractUIElement) = el

function extract_uitype(t::Type, content::Tuple)
    out = ()
    for c in content
        if typeof(c) <: t
            out = (out..., c)
        end
    end
    out
end

convert_uielement(t::Type, el::AbstractUIHTMLElement) = t(el.html)
convert_uielement(t::Type, el::UIModel) = el # no op

function convert_uielement(t::Type, content::Tuple)
    map(c -> convert_uielement(t, c), content)
end

function unroll(content::Tuple)
    out = ()
    for c in content
        if typeof(c) <: AbstractUIElement
            out = (out..., c)
        elseif typeof(c) <: AbstractString
            out = (out..., UIElement(c))
        else
            out = (out..., unroll(c)...)
        end
    end
    out
end

function unroll(content::String)
    # Hit if UI is just a string
    UIElement(content)
end
