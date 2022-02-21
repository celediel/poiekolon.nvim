local config = require("poiekolon.config")
local funcs = require("poiekolon.funcs")

local M = {}

--- Invoke the configured default action.
--- @param char string The character to invoke the action with.
M.do_default = function(char)
    funcs.add_or_toggle_to_line(char, config.current.default_mode)
end

--- Add a character to the end of a line if it doesn't exist.
--- @param char string The character to add.
M.add_char = function(char)
    funcs.add_or_toggle_to_line(char)
end

--- Add a character to the end of a line even if it already exists.
--- @param char string The character to add.
M.force_add_char = function(char)
    funcs.add_or_toggle_to_line(char, "force")
end

--- Toggle a character at the end of a line.
--- @param char string The character to toggle.
M.toggle_char = function(char)
    funcs.add_or_toggle_to_line(char, "toggle")
end

--- Add a character to the end of a line if it doesn't exist, and go to the next line.
--- @param char string The character to add.
M.add_char_newline = function(char)
    -- call add_char(char)
    funcs.add_or_toggle_to_line(char, "newline")
end

--- Add a character to the end of a line even if it already exists, and go to the next line.
--- @param char string The character to add.
M.force_add_char_newline = function(char)
    funcs.add_or_toggle_to_line(char, "force_newline")
end

--- Toggle a character at the end of a line, and go to the next line.
--- @param char string The character to toggle.
M.toggle_char_newline = function(char)
    funcs.add_or_toggle_to_line(char, "toggle_newline")
end

--- Used for :Poiekolon command.
--- @param thing string A string containing the mode and char i.e. "add_char ;"
M.do_thing = function(thing)
    local mode, char = unpack(vim.fn.split(thing, " "))
    funcs.add_or_toggle_to_line(char, mode)
end

return M