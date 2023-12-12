local telescope = require("telescope")

return telescope.register_extension({
    setup = function(ext_config, config)
        -- access extension config and user config)
    end,
    exports = {
        unicode_picker = require("unicode_picker").unicode_chars
    },
})
