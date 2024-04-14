local function snake_to_camel_case(input)
  -- This function converts snake_case to CamelCase
  return input:gsub("(%a)([%w_]*)", function(head, rest)
      return head:upper() .. rest:lower():gsub("_%w", function(sub)
          return sub:sub(2):upper()
      end)
  end)
end

function _G.create_rspec_file()
  local path = vim.fn.expand('%:p')
  if not path:find('/app/') then
    print("Not in the app directory!")
    return
  end

  local spec_path = path:gsub("/app/", "/spec/"):gsub("%.rb$", "_spec.rb")
  local spec_dir = vim.fn.fnamemodify(spec_path, ':h')
  vim.fn.mkdir(spec_dir, "p")
  vim.cmd('edit ' .. spec_path)

  if vim.fn.filereadable(spec_path) == 0 then
    local filename = vim.fn.expand('%:t:r')
    local class_name = snake_to_camel_case(filename):gsub("Spec", "")
    local boilerplate = string.format([[
require 'rails_helper'

RSpec.describe %s do

end]], class_name)
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(boilerplate, "\n"))
  end
end
