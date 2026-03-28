-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

vim.keymap.set("n", "<leader>fo", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    vim.notify("No file associated with current buffer", vim.log.levels.WARN)
    return
  end
  vim.fn.system({ "open", file })
end, { desc = "Open file in default macOS app" })

vim.keymap.set("n", "<leader>md", function()
  vim.cmd("delmarks!")
  vim.cmd("delmarks A-Z0-9")
  vim.notify("All marks deleted")
end, { desc = "Delete all marks" })

vim.keymap.set("n", "<leader>mc", function()
  local current_line = vim.fn.line(".")
  local marks = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  local found_mark = nil

  for i = 1, #marks do
    local mark = marks:sub(i, i)
    local mark_pos = vim.fn.getpos("'" .. mark)
    -- mark_pos[2] is the line number (0 if mark doesn't exist)
    if mark_pos[2] == current_line then
      found_mark = mark
      break
    end
  end

  if found_mark then
    vim.cmd("delmarks " .. found_mark)
    vim.notify("Deleted mark '" .. found_mark .. "'")
  else
    vim.notify("No mark found on current line", vim.log.levels.WARN)
  end
end, { desc = "Delete mark on current line" })

vim.keymap.set("n", "<leader>fS", function()
  local current_dir = vim.fn.expand("%:p:h")
  vim.ui.input({ prompt = "Save as: ", default = current_dir .. "/" }, function(input)
    if input and input ~= "" then
      vim.cmd("saveas " .. input)
    end
  end)
end, { desc = "Save As" })

vim.keymap.set("n", "<leader>fN", function()
  local cwd = vim.fn.getcwd()
  vim.ui.input({ prompt = "New file: ", default = cwd .. "/" }, function(input)
    if input and input ~= "" then
      local parent_dir = vim.fn.fnamemodify(input, ":p:h")
      vim.fn.mkdir(parent_dir, "p")
      vim.cmd("edit " .. input)
    end
  end)
end, { desc = "New File at path" })
