local inspect = require("lib.inspect")

--Helper function to dump variables into log files while working on hyprland config
--@param value any - element that's meant to be investigated
--@param path string - optional path/name of the file
local function dump(value, path)
	path = path or "/tmp/lua-dump.log"

	local file = assert(io.open(path, "a"))
	file:write(inspect(value), "\n")
	file:close()
end

return dump;
