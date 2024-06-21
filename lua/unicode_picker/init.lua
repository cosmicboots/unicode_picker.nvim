local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local themes = require("telescope.themes")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

---Table mapping unicode caracter to it's vim digraph
local digraph_map = {}

---Open telescope picker for unicode characters
M.unicode_chars = function(opts)
    local initial_mode = vim.api.nvim_get_mode()
    opts = opts or themes.get_cursor()

    local chars = require("unicode_picker.chars")
    return pickers.new(opts, {
        prompt_title = "Pick a unicode character",
        finder = finders.new_table({
            results = chars(),
            entry_maker = function(entry)
                local desc = table.concat(entry, " ", 2)

                local dg = digraph_map[entry[1]]

                local display_text = ""
                if dg ~= nil then
                    display_text = string.format("[%s] (%s): %s",
                        entry[1], dg, desc)
                else
                    display_text = string.format("[%s]: %s",
                        entry[1], desc)
                end

                return {
                    value = entry,
                    display = display_text,
                    ordinal = table.concat(entry, " ", 2),
                }
            end
        }),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry().value
                -- Return to insert mode if we started there
                if initial_mode.mode == "i" then
                    vim.api.nvim_feedkeys("a", "i", false)
                end

                vim.api.nvim_put({ selection[1] }, "c", false, true)
                vim.api.nvim_notify("Digraph for " .. selection[1] .. " is " ..
                    digraph_map[selection[1]], vim.log.levels.INFO, {})
            end)
            return true
        end,
    }):find()
end

---Setup unicode_picker
---This function must be called for digraph support inside the picker.
M.setup = function()
    for _, dig in ipairs(vim.fn.digraph_getlist(true)) do
        digraph_map[dig[2]] = dig[1]
    end
end

return M
