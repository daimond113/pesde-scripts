local fs = require("@lune/fs")
local process = require("@lune/process")
local stdio = require("@lune/stdio")

local package_directory = process.args[1]

if fs.isFile(package_directory .. "/default.project.json") then
	process.spawn("rojo", { "sourcemap", package_directory }, { cwd = process.cwd, stdio = "forward" })
else
	-- use stderr to avoid this being parsed as the output of the sourcemap command
	stdio.ewrite("no default.project.json found in " .. package_directory)
end
