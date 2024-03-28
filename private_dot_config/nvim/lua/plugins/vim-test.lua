return {
  {
    "vim-test/vim-test",
    dependencies = { "preservim/vimux" },
    cmd = {
      "TestNearest",
      "TestFile",
      "TestSuite",
      "TestLast",
      "TestVisit",
    },
    keys = {
      { "<leader>t", "<cmd>TestNearest<cr>" },
      { "<leader>T", "<cmd>TestFile<cr>" },
      { "<leader>a", "<cmd>TestSuite<cr>" },
      { "<leader>l", "<cmd>TestLast<cr>" },
      { "<leader>g", "<cmd>TestVisit<cr>" },
    },
    config = function()
      vim.cmd("let test#strategy = 'vimux'")
    end,
  },
}
