local ActionTypes = {
  INIT = "@@lua-redux/INIT"
}

local function inverse(table)
  local newTable = { }
  for k, v in pairs(table) do
    newTable[v] = k
  end
  return newTable
end

local function createStore(reducer, preloadedState)
  local store = {
    reducer = reducer,
    state = preloadedState,
    subscribers = {}
  }

  function store:subscribe(callback)
    local i = table.insert(self.subscribers, callback)
    return function()
      table.remove(self.subscribers, inverse(self.subscribers)[callback])
    end
  end
  function store:dispatch(action)
    self.state = self.reducer(self.state, action)
    for k, v in pairs(self.subscribers) do
      v()
    end
  end
  function store:getState()
    return self.state
  end
  function store:replaceReducer(reducer)
    self.reducer = reducer
    self:dispatch({
      type = ActionTypes.INIT
    })
  end

  store:dispatch({
    type = ActionTypes.INIT
  })

  return store
end

return {
  ActionTypes = ActionTypes,
  createStore = createStore
}
