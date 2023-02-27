
function _toggle_tree()
    vim.cmd("NvimTreeToggle")
end

function _focus_tree()
    vim.cmd("NvimTreeFocus")
end
require("nvim-tree").setup{
    auto_reload_on_write = true,
    disable_netrw = true,
    sort_by = "name",
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
        mappings = {
            custom_only = false,
            list = {
                {key={"<CR>"}, action="edit"},
                {key={"<c-v>"}, action="vsplit"},
                {key={"<c-t>"}, action="tabnew"},
                {key={"<M-j>"}, action="next_sibling"},
                {key={"<M-k>"}, action="prev_sibling"},
                {key={"j"}, action="next_sibling"},
                {key={"k"}, action="prev_sibling"},
                {key={"<Tab>"}, action="preview"},
                {key={"gg"}, action="first_sibling"},
                {key={"G"}, action="last_sibling"},
                {key={"<c-r>"}, action="refresh"},
                {key={"o"}, action="create"},
                {key={"de"}, action="remove"},
                {key={"cc"}, action="rename"},
                {key={"dd"}, action="cut"},
                {key={"y"}, action="copy"},
                {key={"p"}, action="paste"},
                {key={"0"}, action="dir_up"},
                {key={"<c-o>"}, action="system_open"},
                {key={"<c-f>"}, action="search_node"},
            },
        },
    },
    renderer = {
            add_trailing = true,
            group_empty = false,
            highlight_git = true,
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
                        unstaged = "✗",
                        staged = "✓",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "★",
                        deleted = "",
                        ignored = "◌",
                    },
                },
                },
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
        open_file = {
            quit_on_open = false,
            resize_window = true,
        }
    },
}

vim.keymap.set("n", "<leader>e", "<cmd>lua _toggle_tree()<CR>")
-- vim.keymap.set("n", "<c-l>", "<cmd>lua _focus_tree()<CR>")