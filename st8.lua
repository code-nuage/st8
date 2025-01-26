--[[
MIT License

Copyright (c) 2024 Eloi Nuage Hariot

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

local st8 = {}
st8.__index = st8
st8.states = {}
st8.states.__index = st8.states
st8.actives = {}

local function check_actives()
    if not next(st8.actives) then
        error("No active gamestate available.")
    end
end

function st8:new(name)
    local instance = setmetatable({}, st8.states)

    instance.name = name
    instance.state = "PLAY"

    return instance
end

function st8.states:pause()
    self.state = "PAUSE"
end

function st8.states:resume()
    self.state = "PLAY"
end

function st8.states:switch()
    st8.pop()
    st8.push(self)
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

function st8.clear()
    st8.actives = {}
end

function st8.update(dt)
    check_actives()

    for _, state in ipairs(st8.actives) do
        if type(state.update) == "function" and state.state == "PLAY" then state:update(dt) end
    end
end

function st8.draw()
    check_actives()

    for _, state in ipairs(st8.actives) do
        if type(state.draw) == "function" then state:draw() end
    end
end

return st8
