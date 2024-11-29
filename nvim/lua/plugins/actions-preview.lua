return {
  "aznhe21/actions-preview.nvim",
  keys = {
    {
      mode = { "n", "v" },
      "<leader>ap",
      require("actions-preview").code_actions,
    },
    -- config = function()
    --    vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
    --  end,
  },
}
