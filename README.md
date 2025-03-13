# `st8`
What is `st8`?
`st8` is a Lua library designed to simplify the management of game states in your Lua game projects. It provides an easy-to-use interface for handling different screens or modes within your game, such as menus, gameplay, and pause screens.

When to use `st8`?
`st8` is useful when you need to manage multiple screens or states in your game. For example, if you want to display a main menu with buttons and a separate "playing" state, st8 can help you organize and transition between these states seamlessly.

How to install `st8`?
To install `st8`, simply download the st8.lua file from the repository, place it in your project directory, and require it in your main Lua file.
```
_G.st8 = require("st8")
```
How to use `st8`?

`st8` is straightforward to use. Here's a quick guide to get you started:
Key Functions and Methods

Library Functions:
    `st8.push(state)`: Adds a state to the active stack and calls its enter method if defined.
    `st8.pop()`: Removes the top state from the active stack and calls its leave method if defined.
    `st8.update(dt)`: Updates all active states that are in the "PLAY" mode.
    `st8.draw()`: Draws all active states.
    `st8.clear()`: Clears all active states.

State Methods:
    `State:enter()`: Called when the state is pushed onto the stack.
    `State:leave()`: Called when the state is popped from the stack.
    `State:update(dt)`: Called every frame to update the state.
    `State:draw()`: Called every frame to draw the state.
    `State:pause()`: Pauses the state, preventing it from updating.
    `State:resume()`: Resumes the state, allowing it to update again.
    `State:switch()`: Switches to this state by popping the current state and pushing this one.

Example Usage
The following example creates three states: a "Main Menu" state, a "Playing" state, and a "Paused" state.

```
-- Create states
local mainMenu = st8:new("MainMenu")
local playing = st8:new("Playing")
local paused = st8:new("Paused")


-- Define state methods
function mainMenu:enter()
    print("Entering Main Menu")
end

function mainMenu:update(dt)
    -- Check for input to switch to the playing state
    if love.keyboard.isDown("space") then
        playing:switch()
    end
end

function mainMenu:draw()
    love.graphics.print("Main Menu", 10, 10)
end

function playing:enter()
    print("Entering Playing State")
end

function playing:update(dt)
    -- Game logic here
    if love.keyboard.isDown("escape") then
        paused:switch()
    end
end

function playing:draw()
    love.graphics.print("Playing State", 10, 10)
end

function paused:enter()
    print("Entering Paused State")
    playing:pause()
end

function paused:leave()
    playing:resume()
end

function paused:update(dt)
    if love.keyboard.isDown("escape") then
        playing:switch()
    end
end

function paused:draw()
    love.graphics.print("Paused State", 10, 10)
end

-- Push the initial state
st8.push(mainMenu)

-- In your game's update and draw functions
function love.update(dt)
    st8.update(dt)
end

function love.draw()
    st8.draw()
end
```

Notes
The `State:pause()` and `State:resume()` methods should not be modified. They are used to control the update logic of the state.
You can define additional methods and properties on your states as needed.
