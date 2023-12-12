local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local themes = require("telescope.themes")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

M.unicode_chars = function(opts)
    opts = opts or themes.get_cursor()
    return pickers.new(opts, {
        prompt_title = "Pick a thing",
        finder = finders.new_table {
            results = require("unicode_picker.chars"),
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry[1] .. ": " .. entry[2],
                    ordinal = entry[1],
                }
            end
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry().value
                vim.api.nvim_put({ selection[2] }, "", false, true)
                vim.api.nvim_input("a") -- hack to get back into insert mode
            end)
            return true
        end,
    }):find()
end

return M
