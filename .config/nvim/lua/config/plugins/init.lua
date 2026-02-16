-- Dynamically source all plugin config modules in this script's directory.

--- The Lua 5.1 equivalent to _REQUIREDNAME
local required_name = ...

local dir = vim.fs.dirname(debug.getinfo(1, "S").source:sub(2))

local plugin_config_files = vim.fs.find(function(name, path)
    return name:match(".*%.lua")
end, {
    path = dir,
    type = "file",
})

for _, file in ipairs(plugin_config_files) do
    local module_name = required_name .. "." .. vim.fs.basename(file):gsub("%.lua$", "")
    require(module_name)
end
