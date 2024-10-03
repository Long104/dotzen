return {
  'mfussenegger/nvim-dap',
  recommended = true,
  desc = 'Debugging support. Requires language specific adapters to be configured. (see lang extras)',

  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    -- virtual text for the debugger

    -- 'leoluz/nvim-dap-go',
    {
      'theHamsta/nvim-dap-virtual-text',
      -- opts = {},
      config = function()
        require('nvim-dap-virtual-text').setup {
          -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
        }
      end,
    },
  },

  -- stylua: ignore
  keys = {
    { "<leader>d", "", desc = "+debug", mode = {"n", "v"} },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    -- { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dv", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" }, { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
    { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
  },

  config = function()
    vim.keymap.set('n', '<space>?', function()
      require('dapui').eval(nil, { enter = true })
    end)
    -- require('telescope').load_extension('dap')
    -- vim.keymap.set ( 'n', '<leader>dff', ':Telescope dap frames<cr>', { desc = 'telscope debug' } )
    -- vim.keymap.set ( 'n', '<leader>dfb', ':Telescope dap list_breakpoint<cr>', { desc = 'telscope debug' } )

    -- load mason-nvim-dap here, after all adapters have been setup
    require('mason-nvim-dap').setup()

    require('dapui').setup()
    require('dap-go').setup()
    local dap, dapui = require 'dap', require 'dapui'
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    -- dap.listeners.before.event_terminated.dapui_config = function()
    --   dapui.close()
    -- end
    -- dap.listeners.before.event_exited.dapui_config = function()
    --   dapui.close()
    -- end

    vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

    vim.g.dap_virtual_text = true
    -- -- setup dap config by VsCode launch.json file
    -- local vscode = require("dap.ext.vscode")
    -- local json = require("plenary.json")
    -- vscode.json_decode = function(str)
    --   return vim.json.decode(json.json_strip_comments(str))
    -- end
    --
    -- -- Extends dap.configurations with entries read from .vscode/launch.json
    -- if vim.fn.filereadable(".vscode/launch.json") then
    --   vscode.load_launchjs()
    -- end
  end,
}
