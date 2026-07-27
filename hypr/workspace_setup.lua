local standard_app_config = require("standard_app_config");
local folding_cfg = require("folding_display_config");
local dump = require "lib.dump"

local SECONDARY_MONITOR = "eDP-1";
local TRAVEL_MONITOR_DESC = "Invalid Vendor Codename - RTK 0x2555 0x20231128";

local M = {};

local function detect_folding_display()
	    local setup = {};
	 local monitors = hl.get_monitors()

	 for _, monitor in ipairs(monitors) do
        if monitor.description == TRAVEL_MONITOR_DESC then
            table.insert(setup, monitor.name);
        end
	 end

     return setup;
end

local function detect_primary_display()
	local monitors = hl.get_monitors()
	for _, monitor in ipairs(monitors) do
        if monitor.name:match("^DP") or monitor.name:match("^HDMI") then
			return monitor.name;
		end
	end

	return false;
end

function M.run()

    local folding_monitors = detect_folding_display();
    if #folding_monitors > 0 then
        folding_cfg(folding_monitors);
        return;
     end

    standard_app_config();

	local connected_monitor = detect_primary_display();
    if connected_monitor then
        for wrk_spc = 1, 7 do
            hl.workspace_rule({ workspace = tostring(wrk_spc), monitor = connected_monitor});
        end

        for wrk_spc = 8, 10 do
            hl.workspace_rule({ workspace = tostring(wrk_spc), monitor = SECONDARY_MONITOR});
        end
        return;
    end

    for wrk_spc = 1, 10 do
        hl.workspace_rule({ workspace = tostring(wrk_spc), monitor = SECONDARY_MONITOR});
    end
end

return M;
