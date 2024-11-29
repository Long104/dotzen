return {
  event = "LspAttach",
  "aznhe21/actions-preview.nvim",
  config = function()
    require("actions-preview").setup()
    vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
  end,
}
