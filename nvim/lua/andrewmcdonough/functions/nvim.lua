function _G.reload_config()
  for name, _ in pairs(package.loaded) do
    if name:match("^config") then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
end

vim.api.nvim_create_user_command('CopyBufferPaths', function()
  local buffers = vim.api.nvim_list_bufs()
  local paths = {}

  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local name = vim.api.nvim_buf_get_name(buf)
      if name ~= "" then
        table.insert(paths, "@" .. name)
      end
    end
  end

  if #paths > 0 then
    local content = table.concat(paths, "\n")
    vim.fn.system("pbcopy", content)
    print("Copied " .. #paths .. " buffer paths to clipboard")
  else
    print("No buffer paths found")
  end
end, {})
