return {
	generators = {
		rojo = {
			sourcemap = require("./generators/rojo/sourcemap"),
			syncConfig = require("./generators/rojo/sync_config"),
		},

		argon = {
			sourcemap = require("./generators/argon/sourcemap"),
			syncConfig = require("./generators/argon/sync_config"),
		}
	},
}
