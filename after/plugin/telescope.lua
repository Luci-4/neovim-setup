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
	['ff'] = builtin.find_files,
	['fgf'] = builtin.git_files,
	['f*'] = builtin.grep_string,
	['fs'] = builtin.live_grep,
	['fb'] = builtin.buffers,
	['fc'] = builtin.commands,
	['f'] = builtin.oldfiles,
	['fch'] = builtin.command_history,
	['o'] = builtin.vim_options,
	['lm'] = builtin.marks,
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

for keys, cmd in pairs(leader_keybinds) do
	vim.keymap.set('n', keys, cmd, {})
end

for keys, cmd in pairs(leader_keybinds) do
	vim.keymap.set('n', string.format('<leader>%s', keys), cmd, {})
end

telescope.setup({
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