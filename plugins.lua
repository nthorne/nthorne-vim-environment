local iron = require('iron')

iron.core.add_repl_definitions {
  cpp = {
    cling = {
      command = {"cling-env"}
    }
  },
}

iron.core.set_config {
  preferred = {
    cpp = "cling",
  }
}
