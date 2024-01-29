--- Gets a list of all unicode characters human descriptions from the Unicode consortium
return function()
    local data_path = vim.fn.stdpath("data")
    local file_name = "NamesList.txt"
    if vim.fn.filereadable(data_path .. "/" .. file_name) ~= 1 then
        print("Unicode data not found, downloading...")
        local file_url = "http://www.unicode.org/Public/UCD/latest/ucd/" .. file_name
        vim.fn.system("curl -o " .. data_path .. "/" .. file_name .. " " .. file_url)
    end

    local file = io.open(data_path .. "/" .. file_name, "r")

    local utf8 = require("utf8")

    local characters = {}
    if file ~= nil then
        local control = false
        for line in file:lines() do
            if string.sub(line, 1, 2) == "	=" and not control then
                -- Add aliases to the last character definition
                local c = table.remove(characters, #characters)
                table.insert(c, string.sub(line, 4))
                table.insert(characters, c)
            elseif string.match(line, "^[0-9]+") then
                -- Start of a new character definition
                local code = utf8.char(tonumber(string.sub(line, 1, 4), 16))
                local name = string.sub(line, 6)

                -- Remove control characters
                if name ~= "<control>" then
                    table.insert(characters, { code, string.sub(line, 1, 4), name })
                    control = false
                else
                    control = true
                end
            end
        end
    end
    return characters
end
