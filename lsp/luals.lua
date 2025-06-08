---@type vim.lsp.Config
return {
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      workspace = {
        library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
      },
      telemetry = {
        enable = false,
      },
      completion = {
        callSnippet = 'Replace',
      },
      diagnostics = {
        globals = { "vim" },
      },
      hint = {
        enable = true,
        arrayIndex = "Enable",
        await = true,
        paramName = "All",
        paramType = true,
        semicolon = "Disable",
        setType = true,
      },
    },
  },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", "luarc.lua", ".git" },
}
