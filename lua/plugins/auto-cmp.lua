return {
    'L3MON4D3/LuaSnip',
    reloadable = true,
    build = (function()
        -- Build Step is needed for regex support in snippets
        -- This step is not supported in many windows environments
        -- Remove the below condition to re-enable on windows
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
	    return
	end
	return 'make install_jsregexp'
    end)(),
    dependencies = {
	-- `friendly-snippets` contains a variety of premade snippets.
      	--    See the README about individual language/framework/plugin snippets:
      	--    https://github.com/rafamadriz/friendly-snippets
      	-- {
      	--   'rafamadriz/friendly-snippets',
      	--   config = function()
      	--     require('luasnip.loaders.from_vscode').lazy_load()
      	--   end,
      	-- },
    },
    config = function()
	local ls = require("luasnip")
	ls.config.set_config({
	    enable_autosnippets = true,
	    store_selection_keys = "<Tab>",
	})
    end
}
