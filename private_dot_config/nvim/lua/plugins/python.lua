return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    ft = { "python" },
    config = function()
      -- Set PYTHONPATH to ./src for LSP and runtime awareness
      vim.env.PYTHONPATH = vim.fn.getcwd() .. "/src"

      -- Mason setup
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ruff" },
      })

      -- LSP Setup
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if cmp_ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      -- Pyright setup
      lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
          python = {
            defaultInterpreterPath = "./.venv/bin/python",
            analysis = {
              typeCheckingMode = "strict",
              autoImportCompletions = true,
              diagnosticMode = "workspace",
              include = { "src" },
              exclude = { "tests/fixtures", "**/__pycache__", ".venv", "build", "dist" },
            },
          },
        },
      })

      lspconfig.ruff.setup({
	      capabilities = capabilities,
	      settings = {
		      configuration = "pyproject.toml",
		      lint = { run = "onType", select = {}, ignore = {}, preview = true },
		      format = { preview = true },
		      lineLength = 120,
	      },
      })

      -- Format on save with Ruff
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.py",
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })

      -- Python-specific editor settings
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          vim.opt_local.tabstop = 4
          vim.opt_local.shiftwidth = 4
          vim.opt_local.expandtab = true
          vim.opt_local.textwidth = 120
          vim.opt_local.colorcolumn = "120"
          vim.opt_local.formatoptions:remove("t")
        end,
      })

      -- Ignore patterns for Telescope/FZF
      vim.g.telescope_ignore_patterns = {
        "__pycache__",
        "%.pyc",
        ".pytest_cache",
        ".coverage",
        ".mypy_cache",
        ".ruff_cache",
        "build",
        "dist",
        "%.egg%-info",
        ".venv",
      }
    end,
  },
}
