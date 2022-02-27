local M = {}

local map = vim.api.nvim_set_keymap

local funcs = {
    default = { autokey = "", command = "<CMD>lua require('poiekolon').do_default('%')<CR>" },
    add_char = { autokey = "a", command = "<CMD>lua require('poiekolon').add_char('%')<CR>" },
    force_add_char = { autokey = "f", command = "<CMD>lua require('poiekolon').force_add_char('%')<CR>" },
    toggle_char = { autokey = "t", command = "<CMD>lua require('poiekolon').toggle_char('%')<CR>" },
    add_char_newline = { autokey = "A", command = "<CMD>lua require('poiekolon').add_char_newline('%')<CR>" },
    force_add_char_newline = { autokey = "F", command = "<CMD>lua require('poiekolon').force_add_char_newline('%')<CR>" },
    toggle_char_newline = { autokey = "T", command = "<CMD>lua require('poiekolon').toggle_char_newline('%')<CR>" },
}

M.default = {
    default_mode = "add", -- add, force, or toggle. Add "newline" to add a newline after.
    auto_indent_after_newline = true, -- matches indent of current line
    prefix = "<localleader>", -- prefix for autokeys
    autokeys = {}, -- chars to be automatically setup for hotkeys. See 'Autokeys' in README.md for more info
    maps = {}, -- See 'Maps' in README.md for more info
}

M.current = {}

M.setup = function(conf)
    conf = vim.tbl_extend("keep", conf or M.current, M.default)

    -- setup autokeys
    if conf.autokeys and type(conf.autokeys) == "table" then
        for _, autokey in pairs(conf.autokeys) do
            for _, func in pairs(funcs) do
                local command = func.command:gsub("%%", autokey)
                map("n", conf.prefix .. func.autokey .. autokey, command, { silent = true, noremap = true })
            end
        end
    end

    -- setup custom mappings
    if conf.maps and type(conf.maps) == "table" then
        for mode, maps in pairs(conf.maps) do
            for _, m in pairs(maps) do
                map(mode, m.key, funcs[m.func].command:gsub("%%", m.char), { silent = true, noremap = true })
            end
        end
    end
    M.current = conf
end

return M
