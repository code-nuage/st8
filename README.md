# st8
## What is st8?
`st8` is a Lua library that helps you to easily manage gamestate in all your Lua game projects

When to use `st8`?
`st8` is usefull when you need to split multiple screens in your game.
For exemple if I want to display a main menu thats requires buttons and a "playing" state

## How to install `st8`?
To install `st8`, just grab the `st8.lua` file from the repo, place it in your project and require it in your main lua file.

```lua
require("st8.lua")
```

## How tu use `st8`?
`st8` is very easy to handle, you just need to know the tricky things.
We will use it in a LÖVE2D project but you can use in every load-update-draw loop engine

Start by creating a new Gamestate with `Gamestate:new(name)` and passing it a name and then append things to it
```lua
function love.load()
  MAIN = Gamestate:new("Main Menu")
end
```

There are two methods of things that you can append in `st8` with `Gamestate:append(method, function)`: `drawable` and `updatable`
`drawable` allows you to draw things to the screen from the current state
`updatable` allows you to update things in the current state
You need to give the function inside an anonymous function

```lua
local function drawPlayer(x, y, w, h)
  love.graphics.rectangle("fill", x, y, w, h)
end

function love.load()
  MAIN = Gamestate:new("Main Menu")
  MAIN:append("drawable", function() drawPlayer(16, 16, 32, 32) end)
end
```

You can switch between states with `Gamestate:switch()`
You need to switch to a state once to draw something when you launches your project
```lua
local function drawPlayer(x, y, w, h)
  love.graphics.rectangle("fill", x, y, w, h)
end

function love.load()
  MAIN = Gamestate:new("Main Menu")
  MAIN:append("drawable", function() drawPlayer(16, 16, 32, 32) end)
  MAIN:switch()
end
```

And finally `st8` provides it's own functions to update the current active state
```lua
local function drawPlayer(x, y, w, h)
  love.graphics.rectangle("fill", x, y, w, h)
end

function love.load()
  MAIN = Gamestate:new("Main Menu")
  MAIN:append("drawable", function() drawPlayer(16, 16, 32, 32) end)
  MAIN:switch()
end

function love.update(dt)
  Gamestate.update(dt)
end

function love.draw()
  Gamestate.draw()
end
```
