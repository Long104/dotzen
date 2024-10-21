return {
  "huggingface/llm.nvim",
  enabled = false,
  event = "VeryLazy",
  keys = {
    {
      "<c-e>",
      function()
        require("llm.completion").complete()
      end,
      mode = "i",
      desc = "complete",
    },
  },
  opts = {
    lsp = {
      -- bin_path = '/etc/profiles/per-user/s1n7ax/bin/llm-ls',
      -- bin_path = '/etc/profiles/per-user/s1n7ax/bin/llm-ls',
      bin_path = "~/.local/share/nvim/mason/bin/llm-ls",
      cmd_env = { LLM_LOG_LEVEL = "DEBUG" },
    },

    backend = "ollama",
    model = "deepseek-coder-v2:latest",
    url = "http://localhost:11434", -- llm-ls uses "/api/generate"
    -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
    fim = {
      enabled = true,
      prefix = "<｜fim▁begin｜>",
      suffix = "<｜fim▁hole｜>",
      middle = "<｜fim▁end｜>",
    },
    accept_keymap = "<Tab>",
    dismiss_keymap = "<S-Tab>",
    request_body = {
      -- Modelfile options for the model you use
      options = {
        temperature = 0.2,
        top_p = 0.95,
      },
    },
  },
}
