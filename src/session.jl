mutable struct SessionVars
    values::Dict{Symbol, Any}
    last_accessed::Dates.DateTime
end

struct Sessions
    sessions::Dict{String, SessionVars}
    fresh_session::Dict{Symbol, Any}
end

SessionVars(value::Dict) = SessionVars(value, Dates.now())

function Base.getproperty(s::SessionVars, name::Symbol)
    setfield!(s, :last_accessed, Dates.now())
    getfield(s, :values)[name]
end

function Base.setproperty!(s::SessionVars, name::Symbol, x)
    setfield!(s, :last_accessed, Dates.now())
    getfield(s, :values)[name] = x
end

function expire_sessions!(sessions)
    for (id, session) in sessions.sessions
        if Dates.now() - getfield(session, :last_accessed) > Dates.Minute(5)
            delete!(sessions.sessions, id)
        end
    end
    sessions
end

function Base.getindex(sessions::Sessions, session_id::AbstractString)
    expire_sessions!(sessions)
    if !haskey(sessions.sessions, session_id)
        sessions.sessions[session_id] = SessionVars(copy(sessions.fresh_session))
    end
    sessions.sessions[session_id]
end

function create_sessions(app)
    if :register_stateful in names(app, all = true)
        fresh_session = app.register_stateful()
    else
        fresh_session = Dict()
    end

    Sessions(Dict{String, SessionVars}(), fresh_session)
end
