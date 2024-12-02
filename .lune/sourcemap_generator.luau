local function enter(fn: (args: { string }) -> number?): never
	local process = require("@lune/process")
	local stdio = require("@lune/stdio")

	local startTime = os.clock()
	local exitCode = fn(table.clone(process.args))

	stdio.ewrite(
		`\ndone in {stdio.style("dim")}{string.format("%.2fs", os.clock() - startTime)}{stdio.style("reset")}!\n`
	)

	return process.exit(exitCode)
end

return enter(function(args: { string }): number?
	return tonumber(require("../src").generators.rojo.sourcemap(
        args[1]
    ))
end)