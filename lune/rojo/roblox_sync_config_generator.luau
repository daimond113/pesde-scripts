local fs = require("@lune/fs")
local process = require("@lune/process")
local serde = require("@lune/serde")

local package_directory = process.args[1]

if fs.isFile(package_directory .. "/default.project.json") then
	return
end

local output = {
	tree = {},
}

for i, file in process.args do
	if i == 1 then
		continue
	end

	local name = string.gsub(file, ".luau?$", "")

	if name == "init" then
		output.tree["$path"] = file
		continue
	end

	output.tree[name] = {
		["$path"] = file,
	}
end

if not output.tree["$path"] then
	output.tree["$className"] = "Folder"
end

if not output.tree["roblox_packages"] then
	output.tree["roblox_packages"] = {
		["$path"] = {
			optional = "roblox_packages",
		},
	}
end

fs.writeFile(package_directory .. "/default.project.json", serde.encode("json", output, true))
