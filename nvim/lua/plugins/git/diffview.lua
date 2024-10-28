return {
  "sindrets/diffview.nvim",
  cmd = "Diff",
  keys = {
    { mode = "n", "<leader>gdvc", "<cmd>DiffviewClose<CR>", desc = "Close Diffview" },
    { mode = "n", "<leader>gdvo", "<cmd>DiffviewOpen<CR>", desc = "Open Diffview" },
    { mode = "n", "<leader>gdvr", "<cmd>DiffviewRefresh<CR>", desc = "Refresh Diffview" },
    { mode = "n", "<leader>gdvt", "<cmd>DiffviewToggleFiles<CR>", desc = "Toggle Files Diffview" },
    { mode = "n", "<leader>gdvfh", "<cmd>DiffviewFileHistory<CR>", desc = "diffview file history" },
    { mode = "n", "<leader>gdvl", "<cmd>DiffviewLog<CR>", desc = "diffview log" },
    { mode = "n", "<leader>gdvff", "<cmd>DiffviewFocusFiles<CR>", desc = "diffview focus files" },
  },
  config = function()
    require("diffview").setup {}
  end,
}
