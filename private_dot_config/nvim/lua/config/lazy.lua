-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Neovim 0.12 options
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

vim.opt.pumborder = "single"
vim.opt.pumblend = 10
vim.opt.clipboard = "unnamedplus"

vim.keymap.set("n", "<leader>qq", function()
  local modified = vim.tbl_filter(function(buf)
    return vim.bo[buf].modified
  end, vim.api.nvim_list_bufs())
  if #modified > 0 then
    local choice = vim.fn.confirm(
      "Unsaved changes in " .. #modified .. " buffer(s). Discard and quit? (y/Y = quit, any other = stay)",
      "&Stay\n&Yes, discard and quit", 1, "Question"
    )
    if choice == 2 then
      vim.cmd("qa!")
    end
  else
    vim.cmd("qa")
  end
end, { desc = "Quit all" })

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "catppuccin-mocha", "habamax" } },
  -- automatically check for plugin updates
  rocks = { enabled = false },
  checker = { enabled = true },
})
