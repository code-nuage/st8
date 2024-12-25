local st8 = {}
st8.__index = st8
st8.actives = {}

local function check_actives()
    if not next(st8.actives) then
        error("No active gamestate yet.")
    end
end

function st8:new(name)
    local instance = setmetatable({}, st8)

    instance.name = name

    return instance
end

function st8.push(state)
    st8.actives[#st8.actives + 1] = state
    if type(state.enter) == "function" then state:enter() end
end

function st8.pop()
    check_actives()

    local state = st8.actives[#st8.actives]
    if type(state.leave) == "function" then state:leave() end 
    st8.actives[#st8.actives] = nil
end

function st8.update(dt)
    check_actives()

    for _, state in ipairs(st8.actives) do
        if type(state.update) == "function" then state:update(dt) end
    end
end

function st8.draw()
    check_actives()

    for _, state in ipairs(st8.actives) do
        if type(state.draw) == "function" then state:draw() end
    end
end

return st8