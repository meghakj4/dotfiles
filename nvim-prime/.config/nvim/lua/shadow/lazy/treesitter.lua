return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	-- dependencies = {
	-- 	"nvim-treesitter/nvim-treesitter-textobjects",
	-- },
	config = function()
		require("nvim-treesitter.config").setup({
            modules = {},
            ignore_install = { "haskell" },
			ensure_installed = {
				"vimdoc",
				"javascript",
                "rust",
				"typescript",
				"c",
				"lua",
				"jsdoc",
				"bash",
				"markdown",
				"markdown_inline",
			},
			sync_install = false,
            auto_install = false,
			indent = {
				enable = true,
				disable = { "rust" },
			},
			highlight = {
				enable = true,
				disable = { "rust" },
				additional_vim_regex_highlighting = { "markdown" },
			},
		})
	end,
}
