local Popup = require("nui.popup")
local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

local base64Chars =
'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'                     -- You will need this for encoding/decoding
local function b64encode(data)
  return ((data:gsub('.', function(char)
    local bitString, byte = '', char:byte()
    for i = 8, 1, -1 do
      bitString = bitString .. (byte % 2 ^ i - byte % 2 ^ (i - 1) > 0 and '1' or '0')
    end
    return bitString;
  end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(bitString)
    if (#bitString < 6) then return '' end
    local index = 0
    for i = 1, 6 do
      index = index + (bitString:sub(i, i) == '1' and 2 ^ (6 - i) or 0)
    end
    return base64Chars:sub(index + 1, index + 1)
  end) .. ({ '', '==', '=' })[#data % 3 + 1])
end

-- This function asks a question using a prompt and returns the answer as a list of lines.
-- Parameters:
--   cmd: a table containing the start and end line numbers of the content to be included in the prompt
--   instruction: the instruction to be included in the prompt
--   options: additional options to be passed to the x-cli command
local function ask_question(cmd, instruction, options)
  -- Display a message to indicate that a question is being asked
  vim.api.nvim_echo({ { "Asking..." } }, false, {})

  -- Get the content to be included in the prompt
  local content = vim.api.nvim_buf_get_lines(0, cmd.line1 - 1, cmd.line2, false)
  local content_string = table.concat(content, '\n')

  -- Construct the prompt
  local prompt = "\n" .. content_string .. "\n\n\n" .. instruction

  -- Encode the prompt and construct the command to ask the question
  local answer_query = "x-cli prompt " ..
      options .. " --base64 --question " .. b64encode(prompt)

  -- Ask the question and get the answer
  local answer = vim.fn.system(answer_query)

  -- Display an empty message to indicate that the question has been asked
  vim.api.nvim_echo({ { "" } }, false, {})

  -- Split the answer into a list of lines and return it
  local answer_lines = {}
  for s in answer:gmatch("[^\r\n]+") do
    table.insert(answer_lines, s)
  end
  return answer_lines
end

local function ask_chat(cmd, instruction)
  return ask_question(cmd, instruction, "--chat")
end

local function ask_code(cmd, instruction)
  return ask_question(cmd, instruction, "--code")
end

local function create_popup()
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

  popup:on(event.BufLeave, function()
    popup:unmount()
  end)

  popup:map("n", "<esc>", function(_)
    popup:unmount()
  end)

  popup:map("n", "q", function(_)
    popup:unmount()
  end)

  popup:mount()

  return popup
end

local function xcli_show(cmd, instruction)
  local answer_lines = ask_chat(cmd, instruction)
  local popup = create_popup()

  vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, answer_lines)
end

local function xcli_modify(cmd, instruction)
  local answer_lines = ask_code(cmd, instruction)

  vim.api.nvim_buf_set_lines(0, cmd.line1 - 1, cmd.line2, false, answer_lines)
end

local function xcli_explain(cmd)
  xcli_show(cmd, "Write a explanation for the code above as paragraphs of text.")
end

local function xcli_simplify(cmd)
  xcli_show(cmd, "Rewrite the code to reduce the complexity.")
end

local function xcli_free(cmd)
  local input = Input({
    relative = "cursor",
    position = {
      row = 1,
      col = 0,
    },
    size = {
      width = 20,
    },
    border = {
      style = "single",
      text = {
        top = "Prompt",
        top_align = "left",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
    prompt = "> ",
    default_value = "",
    on_submit = function(value)
      xcli_modify(cmd, value)
    end,
  })

  -- mount/open the component
  input:mount()

  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

vim.api.nvim_create_user_command('Explain', xcli_explain, { range = 1 })
vim.api.nvim_create_user_command('Simplify', xcli_simplify, { range = 1 })
vim.api.nvim_create_user_command('AI', xcli_free, { range = 1 })
