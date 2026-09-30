require("codecompanion").setup({
	interactions = {
		chat = {
			adapter = "piacp",
			keymaps = {
				clear = false,
			},
		},
	},
	adapters = {
		acp = {
			piacp = function()
				local helpers = require("codecompanion.adapters.acp.helpers")
				return {
					name = "pi",
					formatted_name = "pi coding agent",
					type = "acp",
					roles = {
						llm = "assistant",
						user = "user",
					},
					commands = {
						default = {
							"pi-acp",
						},
					},
					defaults = {
						mcpServers = {},
						timeout = 20000,
					},
					parameters = {
						protocolVersion = 1,
						clientCapabilities = {
							fs = { readTextFile = true, writeTextFile = true },
						},
						clientInfo = {
							name = "CodeCompanion.nvim",
							version = "1.0.0",
						},
					},
					handlers = {
						setup = function(self)
							return true
						end,
						auth = function(self)
							return true
						end,
						form_messages = function(self, messages, capabilities)
							return helpers.form_messages(self, messages, capabilities)
						end,
						on_exit = function(self, code) end,
					},
				}
			end,
		},
	},
})
