--> Generates a Rojo sync config from a list of input files 

local function enter(fn: (args: { string }) -> number?): never
    local process = require("@lune/process")
    local stdio = require("@lune/stdio")

    local startTime = os.clock()
    local exitCode = fn(table.clone(process.args))

    stdio.write(`done in {stdio.style("dim")}{string.format("%.2fs", os.clock() - startTime)}{stdio.style("reset")}!\n`)

    return process.exit(exitCode)
end

return enter(function(args: { string }): number?
    local ok, _ = require("../src").generators.rojo.syncConfig(table.remove(args, 1), args, { writeToFile = true })

    return tonumber(ok)
end)
