local config = require("poiekolon.config")

local M = {}

local set_lines = vim.api.nvim_buf_set_lines
local set_current_line = vim.api.nvim_set_current_line
local get_current_line = vim.api.nvim_get_current_line
local get_cursor = vim.api.nvim_win_get_cursor
local set_cursor = vim.api.nvim_win_set_cursor

M.get_indent = function(line)
    local indent = ""
    for c in line:gmatch(".") do
        if c:match("%s") then
            indent = indent .. c
        else
            break
        end
    end
    return indent
end

M.add_or_toggle_to_line = function(char, mode)
    if not mode then
        mode = ""
    end

    local line = get_current_line()
    local end_char = string.sub(line, #line)

    if end_char ~= char or mode:match("force") then
        line = line .. char
    elseif mode:match("toggle") and end_char == char then
        line = line:sub(1, -2)
    end

    if mode:match("newline") then
        local row, _ = unpack(get_cursor(0))
        local indent = config.current.auto_indent_after_newline and M.get_indent(line) or ""

        print("'" .. indent .. "', len:" .. tostring(#indent))
        set_lines(0, row - 1, row, true, { line, indent })
        set_cursor(0, { row + 1, #indent + 1 })
    else
        set_current_line(line)
    end
end

return M
