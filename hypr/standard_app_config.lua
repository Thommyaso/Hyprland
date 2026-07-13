local function standard_app_config()
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
        workspace = "2 silent",
    })
end

return standard_app_config;
