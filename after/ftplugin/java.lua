local jdtls_path = vim.fn.expand('$HOME/opt/jdtls/bin/jdtls')
local config = {
  cmd = { jdtls_path },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  settings = {
    java = {
      signatureHelp = { enabled = true },
      format = {
        settings = {
          url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
        }
      }
    }
  },
}
require('jdtls').start_or_attach(config)
