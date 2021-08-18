--[[ local iron = require('iron')

iron.core.add_repl_definitions {
  c = {
    cling = {
      command = {"cling-env"}
    }
  },
  cpp = {
    cling = {
      command = {"cling-env"}
    }
  },
}

iron.core.set_config {
  preferred = {
    c = "cling",
    cpp = "cling",
  }
}
--]]
