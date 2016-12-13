-- Adapted from Redux's documentation (http://redux.js.org/)

local createStore = require("lua-redux").createStore

--[[
This is a reducer, a pure function with (state, action) => state signature.
It describes how an action transforms the state into the next state.

The shape of the state is up to you: it can be a primitive, an array, an object,
or even an Immutable.lua data structure. The only important part is that you should
not mutate the state object, but return a new object if the state changes.

In this example, we use a `switch` statement and strings, but you can use a helper that
follows a different convention (such as function maps) if it makes sense for your
project.
]]--
local function counter(state, action)
  if state == nil then state = 1 end
  if action.type == "INCREMENT" then
    return state + 1
  elseif action.type == "DECREMENT" then
    return state - 1
  else
    return state
  end
end

-- Create a Redux store holding the state of your app.
-- Its API is { subscribe, dispatch, getState }.
local store = createStore(counter)

-- You can use subscribe() to update the UI in response to state changes.
-- Normally you'd use a view binding library (e.g. React Redux) rather than subscribe() directly. (no you won't this is Lua)
-- However it can also be handy to persist the current state in the localStorage. (wat this is Lua we don't have fancy things like that)
store:subscribe(function()
  print(store.getState())
end)

-- The only way to mutate the internal state is to dispatch an action.
-- The actions can be serialized, logged or stored and later replayed.
store.dispatch({ type = "INCREMENT" })
-- 1
store.dispatch({ type = "INCREMENT" })
-- 2
store.dispatch({ type = "DECREMENT" })
-- 1
