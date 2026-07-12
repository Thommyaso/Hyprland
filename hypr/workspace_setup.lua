local inspect = require("lib.inspect")

local PRIMARY_MONITORS = {'DP-1', 'HDMI-1'};
local SECONDARY_MONITOR = "eDP-1";

--local MAIN_WRK_SPCS = {"1","2","3","4","5","6","7"};
--local SECONDARY_WRK_SPCS = {"8","9","10"};

local M = {
	--MAIN_WRK_SPCS,
	--SECONDARY_WRK_SPCS
};

--Helper function to dump variables into log files while working on hyprland config
--@param value any - element that's meant to be investigated
--@param path string - optional path/name of the file
local function dump(value, path)
	path = path or "/tmp/lua-dump.log"

	local file = assert(io.open(path, "a"))
	file:write(inspect(value), "\n")
	file:close()
end

local function includes(tbl, val)
	for _, el in ipairs(tbl) do
		if el == val then
			return true;
		end
	end

	return false;
end

local function find_primary_monitor()
	local monitors = hl.get_monitors()

	for index, monitor in ipairs(monitors) do
		if includes(PRIMARY_MONITORS, monitor.name) then
			return monitor.name;
		end
	end

	return false;
end


function M.run()
	local connected_monitor = find_primary_monitor();

	if connected_monitor then
		for wrk_spc = 1, 7 do
		--for _, wrk_spc in ipairs(MAIN_WRK_SPCS) do
			hl.workspace_rule({ workspace = tostring(wrk_spc), monitor = connected_monitor});
		end

		for wrk_spc = 8, 10 do
		--for _, wrk_spc in ipairs(SECONDARY_WRK_SPCS) do
			hl.workspace_rule({ workspace = tostring(wrk_spc), monitor = SECONDARY_MONITOR});
		end
	end
end

return M;
