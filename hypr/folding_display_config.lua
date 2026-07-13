local standard_app_config = require("standard_app_config");

local function folding_display_config(displays)
         if #displays > 1 then
             hl.monitor({
                 output = displays[1],
                 mode = "1920x1080@60",
                 position = "1280x900",
                 scale = 1.2,
             })

             hl.monitor({
                 output = displays[2],
                 mode = "1920x1080@60",
                 position = "1280x0",
                 scale = 1.2,
             })

             for wrk_spc = 1, 5 do
                 hl.workspace_rule({
                     workspace = tostring(wrk_spc),
                     monitor = displays[2]
                 });
             end

             for wrk_spc = 6, 10 do
                 hl.workspace_rule({
                     workspace = tostring(wrk_spc),
                     monitor = displays[1]
                 });
             end

             hl.window_rule({
                 name = "ghostty-workspace",
                 match = {
                     class = "com.mitchellh.ghostty"
                 },
                 workspace = "1 silent",
             })

             hl.window_rule({
                 name = "brave-workspace",
                 match = {
                     class = "brave-browser"
                 },
                 workspace = "6 silent",
             })
         else
             standard_app_config();
         end
end

return folding_display_config;
