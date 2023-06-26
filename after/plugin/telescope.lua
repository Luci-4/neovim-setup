local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require("telescope.actions")

-- actions = {}
-- local mtable = {
-- 	__index = function (t, k)
-- 		print(t)
-- 		print(k)
-- 		print(_actions[k])
-- 		return function() return _actions[k]() end
-- 	end
-- }
-- setmetatable(actions, mtable)

-- vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

local leader_keybinds = {
	['f'] = builtin.find_files,
	['fgf'] = builtin.git_files,
	-- ['*'] = function() builtin.grep_string({initial_mode="normal"}) end,
	-- ['fs'] = builtin.live_grep,
	['<Tab>'] = function() builtin.buffers({initial_mode = "normal"}) end,
	['c'] = builtin.commands,
	['fh'] = builtin.oldfiles, 
	['ch'] = builtin.command_history,
	['fo'] = builtin.vim_options,
	['m'] = builtin.marks,
	-- ['lr'] = builtin.lsp_references,
	-- ['lic'] = builtin.lsp_incoming_calls,
	-- ['loc'] = builtin.lsp_outgoing_calls,
	-- ['d'] = builtin.diagnostics,
	-- ['gi'] = builtin.lsp_implementations,
	-- ['gd'] = builtin.lsp_definitions,
	-- ['gtd'] = builtin.lsp_file_definitions,
}

local bare_keybinds = {
	['cx'] = builtin.quickfix,
	['cxh'] = builtin.quickfixhistory,
	['cs'] = builtin.spell_suggest,	
}
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
vim.keymap.set('n', '<leader>*', function() builtin.grep_string({initial_mode="normal"}) end, {})

for keys, cmd in pairs(bare_keybinds) do
	vim.keymap.set('n', keys, cmd, {})
end

for keys, cmd in pairs(leader_keybinds) do
	vim.keymap.set('n', string.format('<leader>%s', keys), cmd, {})
end

telescope.setup({
    disable_defaults = true,
    defaults = {
		mappings = {
			i = {

				['<M-j>'] = actions.move_selection_next,
				['<M-k>'] = actions.move_selection_previous,
				['<C-v>'] = actions.select_vertical,
				['<C-h>'] = actions.select_horizontal,

				["<C-c>"] = false,
				-- ["<C-b>"] = actions.preview_scrolling_up,
				-- ["<C-f>"] = actions.preview_scrolling_down,
				["<Tab>"] = actions.select_tab,
				-- ['<S-Tab>'] = actions.toggle_selection,
				["<C-g>"] = actions.move_to_top,
				["<C-G>"] = actions.move_to_bottom,
			},
			n = {
				['<C-v>'] = actions.select_vertical,
				['<C-h>'] = actions.select_horizontal,
				["<C-c>"] = false,
				['<M-j>'] = actions.move_selection_next,
				['<M-k>'] = actions.move_selection_previous,
				["<Tab>"] = actions.select_tab,
				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,
			}
		},
	}
})
-- TODO: handle git
