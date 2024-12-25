# st8

## What is st8?
`st8` is a Lua library that helps you to easily manage gamestate in all your Lua game projects.

When to use `st8`?
`st8` is usefull when you need to split multiple screens in your game.
For exemple if I want to display a main menu thats requires buttons and a "playing" state

## How to install `st8`?
To install `st8`, just grab the `st8.lua` file from the repo, place it in your project and require it in your main lua file.

```lua
_G.st8 = require("st8.lua")
```

## How tu use `st8`?
`st8` is very easy to handle, you just need to know the tricky things.
We will use it in a LÖVE2D project but you can use in every load-update-draw loop engine

`st8` itself contains 4 functions: `st8.push(state)`, `st8.pop()`, `st8.update(dt)` and `st8.draw()`
`st8`'s states contains 6 methods: `State:enter()`, `State:leave()`, `State:update(dt)`, `State:draw()`, `State:pause()` and `State:resume()`

The `st8` functions will call states methods, that you can define by yourself.
The `st8`'s states methods will define their logic.

`State:pause()` and `State:resume()` should not be modified, they are used to pause and resume the update of the state (to keep your playing state freezed for exemple)

The following exemple creates three states, a "Main Menu" state, a "Playing" state and a "Playing Menu" state
