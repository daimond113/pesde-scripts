local process = require("@lune/process")

process.spawn("rojo", { "sourcemap" }, { cwd = process.cwd, stdio = "forward" })
