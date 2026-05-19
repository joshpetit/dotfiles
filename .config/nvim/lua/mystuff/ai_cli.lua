local M = {}

function M.open_claude()
  vim.cmd("belowright split | terminal claude --continue")
  vim.cmd("startinsert")
end

function M.open_claude_new()
  vim.cmd("belowright split | terminal claude")
  vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>ta", M.open_claude, { desc = "Claude CLI (resume)" })
vim.keymap.set("n", "<leader>tA", M.open_claude_new, { desc = "Claude CLI (new)" })

local function get_terminal_bufs()
  local terms = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "terminal" then
      table.insert(terms, { buf = buf, name = vim.api.nvim_buf_get_name(buf) })
    end
  end
  return terms
end

local function focus_terminal(term_buf)
  local wins = vim.fn.win_findbuf(term_buf)
  if #wins > 0 then
    vim.api.nvim_set_current_win(wins[1])
    vim.cmd("startinsert")
  end
end

local function send_to_terminal(term_buf, lines)
  local chan = vim.bo[term_buf].channel
  for _, line in ipairs(lines) do
    vim.api.nvim_chan_send(chan, line .. "\n")
  end
  vim.schedule(function() focus_terminal(term_buf) end)
end

local active_scratch = nil

local function open_scratch_to_terminal(prefill)
  if active_scratch and vim.api.nvim_buf_is_valid(active_scratch) and #vim.fn.win_findbuf(active_scratch) > 0 then
    if prefill then
      local count = vim.api.nvim_buf_line_count(active_scratch)
      vim.api.nvim_buf_set_lines(active_scratch, count, count, false, { "" })
      vim.api.nvim_buf_set_lines(active_scratch, count + 1, count + 1, false, prefill)
    end
    return
  end

  local scratch = vim.api.nvim_create_buf(false, true)
  active_scratch = scratch
  vim.cmd("belowright split")
  vim.api.nvim_win_set_buf(0, scratch)

  if prefill then
    vim.api.nvim_buf_set_lines(scratch, 0, -1, false, prefill)
  end

  vim.cmd("startinsert")

  vim.api.nvim_create_autocmd("BufWinLeave", {
    buffer = scratch,
    once = true,
    callback = function()
      local lines = vim.api.nvim_buf_get_lines(scratch, 0, -1, false)
      while #lines > 0 and lines[#lines] == "" do
        table.remove(lines)
      end
      if #lines == 0 then return end

      local terms = get_terminal_bufs()
      if #terms == 0 then
        vim.notify("No open terminals", vim.log.levels.WARN)
      elseif #terms == 1 then
        send_to_terminal(terms[1].buf, lines)
      else
        vim.ui.select(terms, {
          prompt = "Send to terminal:",
          format_item = function(t) return t.name end,
        }, function(choice)
          if choice then send_to_terminal(choice.buf, lines) end
        end)
      end

      vim.schedule(function()
        active_scratch = nil
        vim.api.nvim_buf_delete(scratch, { force = true })
      end)
    end,
  })
end

function M.write_to_terminal()
  open_scratch_to_terminal()
end

function M.write_selection_to_terminal()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
  local start_line = vim.fn.line("'<")
  local rel_path = vim.fn.expand("%:.")
  local ft = vim.bo.filetype
  local selection = vim.fn.getregion(vim.fn.getpos("'<"), vim.fn.getpos("'>"), { type = vim.fn.visualmode() })
  local header = { "", rel_path .. ":" .. start_line, "```" .. ft }
  for _, line in ipairs(selection) do
    table.insert(header, line)
  end
  table.insert(header, "```")
  open_scratch_to_terminal(header)
end

vim.keymap.set("n", "<leader>ti", M.write_to_terminal, { desc = "Write to terminal" })
vim.keymap.set("v", "<leader>ti", M.write_selection_to_terminal, { desc = "Send selection to terminal" })

return M
