
function _toggle_tree()
    vim.cmd("NvimTreeToggle")
end

function _focus_tree()
    vim.cmd("NvimTreeFocus")
end
local actions = require('nvim-tree.actions')

local function move_to_trash(file_path)
  local trash_dir = "C:\\Users\\wojci\\Desktop\\nvimtrash"
  local file_name = vim.fn.fnamemodify(file_path, ":t")
  local trash_path = trash_dir .. file_name

  os.rename(file_path, trash_path)

  return trash_path
end

local api = require('nvim-tree.api')

    local all_keymaps = {

        ["<CR>"] = api.node.open.edit,
        ["<s-h>"] = api.node.open.vertical,
        ["<c-t>"] =  api.node.open.tab,
        ["<M-j>"] = api.node.navigate.none.next,
        ["<M-k>"] = api.node.navigate.none.prev,
        ["<M-l>"] = api.node.navigate.parent_close,
        ["j"] = api.node.navigate.none.next,
        ["k"] = api.node.navigate.none.prev,
        ["<Tab>"] = api.node.open.preview,
        -- ["gg"] = "first_sibling",
        -- ["G"] = "last_sibling",
        ["<c-r>"] = api.tree.reload,
        ["o"] = api.fs.create,
        ["de"] = api.fs.remove,
        -- ["de"] = function()
        --         local cursor_pos = vim.api.nvim_win_get_cursor(0)
        --         local node = vim.api.nvim_tree_get_node(cursor_pos)
        --           local file_path = node.absolute_path

        --           -- Move the file to the trash directory
        --           local trash_path = move_to_trash(file_path)

        --           -- Update the tree to remove the deleted file
        --           api.nvim_command("NvimTreeRefresh")

        --           -- Print a message to the user
        --           print(string.format("Moved file to trash: %s", trash_path))
        -- end,

        ["i"] = api.fs.rename,
        ["dd"] = api.fs.cut,
        ["y"] = api.fs.copy.filename,
        ["0"] = api.node.navigate.parent,
        ["p"] = api.fs.paste,
        ["<c-o>"] = api.node.run.system,
        ["<c-f>"] = api.tree.search_node,
    }

    local on_attach = function(bufnr)

        local opts = function()
            return { buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        for keys, cmd in pairs(all_keymaps) do
            vim.keymap.set('n', keys, cmd, opts{})
        end
end
require("nvim-tree").setup{
    on_attach = on_attach,
    auto_reload_on_write = true,
    disable_netrw = true,
    sort_by = "name",
    sync_root_with_cwd = true,
    git = {
        ignore = false
    },
--     Changes how files within the same directory are sorted.
-- Can be one of `name`, `case_sensitive`, `modification_time`, `extension` or a
-- function.
--   Type: `string` | `function(nodes)`, Default: `"name"`

--   Function is passed a table of nodes to be sorted, each node containing:
--   - `absolute_path`: `string`
--   - `executable`:    `boolean`
--   - `extension`:     `string`
--   - `link_to`:       `string`
--   - `name`:          `string`
--   - `type`:          `"directory"` | `"file"` | `"link"`

--   Example: sort by name length: >
--     local sort_by = function(nodes)
--       table.sort(nodes, function(a, b)
--         return #a.name < #b.name
--       end)
--     end
    view = {
        side = "right",
        signcolumn = "yes",
        hide_root_folder = true,
        centralize_selection = true,
        -- mappings = {
        --     custom_only = false,
        --     list = {
        --         {key={"<CR>"}, action="edit"},
        --         {key={"<c-v>"}, action="vsplit"},
        --         {key={"<c-t>"}, action="tabnew"},
        --         {key={"<M-j>"}, action="next_sibling"},
        --         {key={"<M-k>"}, action="prev_sibling"},
        --         {key={"j"}, action="next_sibling"},
        --         {key={"k"}, action="prev_sibling"},
        --         {key={"<Tab>"}, action="preview"},
        --         {key={"gg"}, action="first_sibling"},
        --         {key={"G"}, action="last_sibling"},
        --         {key={"<c-r>"}, action="refresh"},
        --         -- {key={"o"}, action="create"},
        --         {key={"de"}, action="remove"},
        --         {key={"cc"}, action="rename"},
        --         {key={"dd"}, action="cut"},
        --         {key={"y"}, action="copy"},
        --         {key={"P"}, action="api.node.navigate.parent"},
        --         {key={"p"}, action="paste"},
        --         {key={"p"}, action="paste"},
        --         {key={"0"}, action="dir_up"},
        --         {key={"<c-o>"}, action="system_open"},
        --         {key={"<c-f>"}, action="search_node"},
        --     },
        -- },
    },
    renderer = {
            add_trailing = true,
            group_empty = false,
            -- highlight_git = true,
            full_name = false,
            highlight_opened_files = "name",
            highlight_modified = "icon",
            indent_width = 2,
            indent_markers = {
                    enable = false,
                    inline_arrows = true,
                    icons = {
                        corner = "└",
                        edge = "│",
                        item = "│",
                        bottom = "─",
                        none = " ",
                    },
            },
            icons = {
                webdev_colors = true,
                git_placement = "before",
                modified_placement = "after",
                padding = " ",
                symlink_arrow = " ➛ ",
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                    modified = true,
                },
                glyphs = {
                    default = "",
                    symlink = "",
                    bookmark = "",
                    modified = "●",
                    folder = {
                        arrow_closed = "",
                        arrow_open = "",
                        default = "",
                        open = "",
                        empty = "",
                        empty_open = "",
                        symlink = "",
                        symlink_open = "",
                    },
                    git = {
                        unstaged = "M",
                        staged = "A",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "U",
                        deleted = "",
                        ignored = "◌",
                    },
                },
                },
    },
    hijack_directories = {
        enable = true,
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.ERROR,
        },
        icons = {
            info = "I",
            warning = "W",
            error = "E",
        },
    },
    actions = {
        use_system_clipboard = true,
        change_dir = {
            restrict_above_cwd = true,
        },
        open_file = {
            quit_on_open = false,
            resize_window = true,
        },
    },
}

vim.keymap.set("n", "<leader>e", "<cmd>lua _toggle_tree()<CR>")
-- vim.keymap.set("n", "<c->", "<cmd>lua _focus_tree()<CR>")
