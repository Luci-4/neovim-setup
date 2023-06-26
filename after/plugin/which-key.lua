
require("which-key").setup {
    hidden = {"^<", "<", "<*"},
    triggers_blacklist = {
        i = { "<", "i", "k" },
      },

    plugins = {
        presets = {
            nav = nil
        }
    }
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}
