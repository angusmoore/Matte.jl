function sanitycheck(app_module)
    try getfield(app_module, :ui)
    catch
        rethrow(ErrorException("You have not defined the `ui` function in your app module"))
    end
    try getfield(app_module, :Server)
    catch
        rethrow(ErrorException("You have not defined the `Server` module in your app module"))
    end
    try getfield(app_module, :title)
    catch
        rethrow(ErrorException("You have not set a `title` in your app module"))
    end
end
