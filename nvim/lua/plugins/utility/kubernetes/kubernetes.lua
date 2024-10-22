return {
  {
    "ramilito/kubectl.nvim",
    keys = {{
      "n",
      "<leader>k",
      '<cmd>lua require("kubectl").toggle()<cr>',
      desc = "Toggle kubectl terminal",
      { noremap = true, silent = true },
    }},
    config = function()
      require("kubectl").setup()
    end,
  },
}
-- vim.keymap.set("n", "<leader>k", '<cmd>lua require("kubectl").toggle()<cr>', { noremap = true, silent = true })
