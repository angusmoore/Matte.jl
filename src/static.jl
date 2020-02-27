function included_file_path(path::String)
    normpath(joinpath(@__DIR__, "..", path))
end

function included_file(path::String)
  read(included_file_path(path), String)
end
