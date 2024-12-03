local fs = require("@lune/fs")
local serde = require("@lune/serde")

local frktest = require("../../../lune_packages/frktest")
local check = frktest.assert.check

local syncConfig = require("./sync_config")

local TEST_PROJECTS_DIRS = {
    "./test-files/rojo/test-projects",
    "./test-files/rojo/rojo-test/serve-tests",
}

return function(test: typeof(frktest.test))
    test.suite("Generates Rojo valid sync configs", function()
        for _, dir in TEST_PROJECTS_DIRS do
            for _, file in fs.readDir(dir) do
                local fullPath = `{dir}/{file}`
                test.case(`{file}`, function()
                    local ok, config = syncConfig(fullPath, fs.readDir(fullPath), { writeToFile = false, force = true })
                    check.is_true(ok)

                    -- Make sure that the generated config and the real configs are similar
                    local generatedConfig, realConfig =
                        serde.decode("json", config),
                        serde.decode("json", fs.readFile(`{fullPath}/default.project.json`))

                    check.table.contains(realConfig, generatedConfig)
                end)
            end
        end
    end)
end
