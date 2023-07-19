-- vim.g.vscode = true;

require "config"
require "utils"
require "options"
if not vim.g.vscode then
  require "pm"
  require "highlights"
  require "statusline"
  require "misc"
  require "ai"
end
