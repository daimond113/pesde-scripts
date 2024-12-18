local fs = require("@lune/fs")
local serde = require("@lune/serde")

local frktest = require("../../../lune_packages/frktest")
local check = frktest.assert.check

local syncConfig = require("./sync_config")

local TEST_PROJECTS_DIR = "./test-files/argon"

return function(test: typeof(frktest.test))
	test.suite("Generates valid Argon sync configs", function()
		for _, dir in fs.readDir(TEST_PROJECTS_DIR) do
			local fullPath = `{TEST_PROJECTS_DIR}/{dir}`
			if not fs.isDir(fullPath) or dir == ".git" then
				continue
			end

			test.case(`{dir}`, function()
				local ok, config = syncConfig(
					fullPath,
					fs.readDir(fullPath),
					{ writeToFile = false, force = true }
				)
				check.is_true(ok)

				-- Make sure that the generated config and the real configs are similar
				local generatedConfig, realConfig =
					serde.decode("json", config),
					serde.decode(
						"json",
						fs.readFile(`{fullPath}/default.project.json`)
					)

				check.table.contains(realConfig, generatedConfig)
			end)
		end
	end)
end
