-- Dynamically source all plugin config modules in this script's directory.

--- The Lua 5.1 equivalent to _REQUIREDNAME
local required_name = ...

local dir = vim.fs.dirname(debug.getinfo(1, "S").source:sub(2))

local plugin_config_files = vim.fs.find(function(filename, path)
	return filename:match(".*%.lua$") and filename ~= "init.lua"
end, {
	path = dir,
	type = "file",
	limit = math.huge,
})

local base_module_name = required_name:gsub("%.init$", "")

for _, file in ipairs(plugin_config_files) do
	local module_name = base_module_name .. "." .. vim.fs.basename(file):gsub("%.lua$", "")
	require(module_name)
end
