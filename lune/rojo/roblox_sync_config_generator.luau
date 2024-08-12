local process = require("@lune/process")
local fs = require("@lune/fs")
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
		output["$path"] = file
		continue
	end

	output.tree[name] = {
		["$path"] = file,
	}
end

if not output["$path"] then
	output["$className"] = "Folder"
end

fs.writeFile(package_directory .. "/default.project.json", serde.encode("json", output, true))
