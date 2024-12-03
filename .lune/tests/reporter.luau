local stdio = require("@lune/stdio")

local frktest = require("../../lune_packages/frktest")
local Reporter = frktest._reporters.lune_console_reporter

local STYLE = table.freeze({
	suite = function(name: string)
		return `{stdio.style("bold")}{stdio.color("purple")}SUITE{stdio.style("reset")} {name}`
	end,

	report = function(name: string, state: "run" | "success" | "error" | "skip")
		local state_color: stdio.Color = if state == "run"
			then "white"
			elseif state == "success" then "green"
			elseif state == "error" then "red"
			elseif state == "skip" then "yellow"
			else error("Invalid test state")
		return `    {stdio.style("bold")}{stdio.color(state_color)}{if state == "skip" then "SKIP" else "TEST"}{stdio.style(
			"reset"
		)} {name}`
	end,
})

local ReporterExt = {}
function ReporterExt.init()
	frktest.test.on_suite_enter(function(suite)
		print(STYLE.suite(suite.name))
	end)

	frktest.test.on_suite_leave(function()
		stdio.write("\n")
	end)

	frktest.test.on_test_leave(function(test)
		print(STYLE.report(test.name, if test.failed then "error" else "success"))
	end)

	frktest.test.on_test_skipped(function(test)
		print(STYLE.report(test.name, "skip"))
	end)

	Reporter.init()
end

return setmetatable(ReporterExt, { __index = Reporter })