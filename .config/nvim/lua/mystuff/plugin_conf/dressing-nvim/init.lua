require("dressing").setup({
	select = {
		--backend = {"builtin"}
		get_config = function(opts)
			if opts.backend ~= nil then
				return {
					backend = opts.backend,
				}
			end
			return nil
		end,
	},
	input = {
		override = function(conf)
			conf.col = -1
			conf.row = 0
			return conf
		end,
	},
})
