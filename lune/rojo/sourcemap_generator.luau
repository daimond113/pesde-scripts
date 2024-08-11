local process = require("@lune/process")
local fs = require("@lune/fs")
local stdio = require("@lune/stdio")

local project_path = process.args[1]

if fs.isFile(project_path .. "/default.project.json") then
	process.spawn("rojo", { "sourcemap", project_path }, { cwd = process.cwd, stdio = "forward" })
else
	-- use stderr to avoid this being parsed as the output of the sourcemap command
	stdio.ewrite("no default.project.json found in " .. project_path)
end
