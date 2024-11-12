local fs = require("@lune/fs")
local process = require("@lune/process")
local serde = require("@lune/serde")
local stdio = require("@lune/stdio")

local package_directory = process.args[1]

if fs.isFile(package_directory .. "/default.project.json") then
	process.spawn("rojo", { "sourcemap", package_directory }, { cwd = process.cwd, stdio = "forward" })
elseif fs.isFile(package_directory .. "/init.luau") then
	local sourcemap = { filePaths = { "init.luau" } }
	stdio.write(serde.encode("json", sourcemap, false))
else
	-- use stderr to avoid this being parsed as the output of the sourcemap command
	stdio.ewrite("no default.project.json found in " .. package_directory)
end
