local function apply_tinty_theme()
	local vim_artifact = vim.fn.expand("~/.local/share/tinted-theming/tinty/artifacts/tinted-vim-colors-file.vim")
	if vim.fn.filereadable(vim_artifact) == 1 then
		vim.cmd("source " .. vim_artifact)
	else
		vim.cmd("colorscheme base16-gruvbox-dark-hard")
	end
	-- Make main UI transparent
	vim.cmd([[
		highlight Normal guibg=NONE ctermbg=NONE
		highlight NormalNC guibg=NONE ctermbg=NONE
		highlight SignColumn guibg=NONE
		highlight VertSplit guibg=NONE
		highlight EndOfBuffer guibg=NONE
	]])
end

local function handle_focus_gained()
	apply_tinty_theme()
end

local function main()
	vim.o.termguicolors = true
	vim.g.tinted_colorspace = 256
	apply_tinty_theme()

	vim.api.nvim_create_autocmd("FocusGained", {
		callback = handle_focus_gained,
	})
end

main()
