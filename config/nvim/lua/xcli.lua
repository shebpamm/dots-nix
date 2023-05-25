local function xcli_prompt(cmd, instruction)
  local Popup = require("nui.popup")
  local event = require("nui.utils.autocmd").event
  local popup = Popup({
    enter = true,
    border = {
      style = "rounded",
      highlight = "FloatBorder",
      text = {
        top = "Copilot X",
        top_align = "center",
      },
    },
    relative = "editor",
    position = {
      row = "50%",
      col = "80%",
    },
    size = {
      width = "40%",
      height = "60%",
    },
    buf_options = {
      filetype = "markdown"
    },
    win_options = {
      linebreak = true,
      wrap = true,
    }
  })

  local content = vim.api.nvim_buf_get_lines(0, cmd.line1 - 1, cmd.line2, false)
  local content_string = table.concat(content, '\\n')
  local prompt = "```\\n" .. content_string .. "\\n```\\n\\n" .. instruction
  local answer_query = "x-cli prompt --chat --question '" .. prompt .. "'"
  local answer = vim.fn.system(answer_query)
  local answer_lines = {}
  for s in answer:gmatch("[^\r\n]+") do
      table.insert(answer_lines, s)
      table.insert(answer_lines, "")
  end

  popup:mount()
  popup:on(event.BufLeave, function()
    popup:unmount()
  end)

  popup:map("n", "<esc>", function(_)
    popup:unmount()
  end)

  vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, answer_lines )
end

local function xcli_explain(cmd)
  xcli_prompt(cmd, "Write a explanation for the code above as paragraphs of text.")
end

local function xcli_simplify(cmd)
  xcli_prompt(cmd, "Rewrite the code to reduce the complexity.")
end

vim.api.nvim_create_user_command('Explain', xcli_explain, { range = 1 })
vim.api.nvim_create_user_command('Simplify', xcli_simplify, { range = 1 })
