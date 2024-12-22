return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'
    return {
      {
        '<F5>',
        function()
          if vim.fn.filereadable(".vscode/launch.json") then
            require("dap.ext.vscode").load_launchjs(nil, {})
          end
          dap.continue()
        end,
        desc = 'Debug: Start/Continue'
      },
      { '<F1>',            dap.step_into,           desc = 'Debug: Step Into' },
      { '<F2>',            dap.step_over,           desc = 'Debug: Step Over' },
      { '<F3>',            dap.step_out,            desc = 'Debug: Step Out' },
      { '<localleader>b',  dap.toggle_breakpoint,   desc = 'Debug: Toggle Breakpoint' },
      { '<localleader>cb', dap.clear_breakpoints(), desc = 'Debug: Clear Breakpoints' },
      {
        '<leader>B',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Breakpoint',
      },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      { '<F7>', dapui.toggle, desc = 'Debug: See last session result.' },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},
      ensure_installed = {
        'codelldb',
      },
    }

    require('nvim-dap-virtual-text').setup({})

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup()
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Setup adapters.
    dap.adapters["lldb-dap"] = {
      type = "executable",
      command = "/opt/homebrew/opt/llvm/bin/lldb-dap",
      name = "lldb-dap"
    }
    dap.configurations.cpp = {
      {
        name = 'Launch',
        type = 'lldb-dap',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      }
    }
    dap.configurations.c = dap.configurations.cpp

    dap.configurations.rust = {
      {
        name = 'Launch',
        type = 'lldb-dap',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        initCommands = function()
          -- Find out where to look for the pretty printer Python module
          local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

          local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
          local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

          local commands = {}
          local file = io.open(commands_file, 'r')
          if file then
            for line in file:lines() do
              table.insert(commands, line)
            end
            file:close()
          end
          table.insert(commands, 1, script_import)

          return commands
        end,
        -- ...,
      }
    }
  end,
}
