--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ix.handsignal = ix.handsignal or {}
ix.handsignal.stored = ix.handsignal.stored or {}

function ix.handsignal:Register(data)
    if ix.handsignal.stored[data.id] then return "already exists" end
    ix.handsignal.stored[data.id] = data
end
function ix.handsignal:GetAnimClassGestures(animClass)
    local tbl = {}
    for k, v in pairs(ix.handsignal.stored) do
        if v.animClass == animClass then tbl[#tbl + 1] = v end
    end
    return tbl
end

-- female
ix.handsignal:Register({
    id = "wave",
    name = "Wave",
    animClass = "citizen_female",
    gesturePath = "g_wave"
})
ix.handsignal:Register({
    id = "display_r",
    name = "Display (Right)",
    animClass = "citizen_female",
    gesturePath = "g_right_openhand"
})
ix.handsignal:Register({
    id = "headshake",
    name = "Headshake",
    animClass = "citizen_female",
    gesturePath = "hg_headshake"
})
ix.handsignal:Register({
    id = "display_l",
    name = "Display (Left)",
    animClass = "citizen_female",
    gesturePath = "g_display_left"
})
-- male
ix.handsignal:Register({
    id = "clap",
    name = "Clap",
    animClass = "citizen_male",
    gesturePath = "g_clap"
})
ix.handsignal:Register({
    id = "clap_m",
    name = "Clap",
    animClass = "metrocop",
    gesturePath = "g_clap"
})

ix.handsignal:Register({
    id = "point",
    name = "Point",
    animClass = "citizen_male",
    gesturePath = "g_point_l"
})
ix.handsignal:Register({
    id = "point_m",
    name = "Point",
    animClass = "metrocop",
    gesturePath = "g_point_l"
})

ix.handsignal:Register({
    id = "point_left",
    name = "Point (Left)",
    animClass = "citizen_male",
    gesturePath = "g_pointleft_l"
})
ix.handsignal:Register({
    id = "point_left_m",
    name = "Point (Left)",
    animClass = "metrocop",
    gesturePath = "g_pointleft_l"
})

ix.handsignal:Register({
    id = "point_right",
    name = "Point (Right)",
    animClass = "citizen_male",
    gesturePath = "g_pointright_l"
})
ix.handsignal:Register({
    id = "point_right_m",
    name = "Point (Right)",
    animClass = "metrocop",
    gesturePath = "g_pointright_l"
})

ix.handsignal:Register({
    id = "wave_male",
    name = "Wave",
    animClass = "citizen_male",
    gesturePath = "g_wave"
})
ix.handsignal:Register({
    id = "wave_metro",
    name = "Wave",
    animClass = "metrocop",
    gesturePath = "g_wave"
})

ix.handsignal:Register({
    id = "wave_low",
    name = "Wave (Low)",
    animClass = "citizen_male",
    gesturePath = "g_lookatthis"
})
ix.handsignal:Register({
    id = "wave_low_m",
    name = "Wave (Low)",
    animClass = "metrocop",
    gesturePath = "g_lookatthis"
})

-- OTA

ix.handsignal:Register({
    id = "advance",
    name = "Advance",
    animClass = "overwatch",
    gesturePath = "signal_advance"
})
ix.handsignal:Register({
    id = "forward",
    name = "Point",
    animClass = "overwatch",
    gesturePath = "signal_forward"
})
ix.handsignal:Register({
    id = "group",
    name = "Group",
    animClass = "overwatch",
    gesturePath = "signal_group"
})
ix.handsignal:Register({
    id = "halt",
    name = "Halt",
    animClass = "overwatch",
    gesturePath = "signal_halt"
})
ix.handsignal:Register({
    id = "ota_point_r",
    name = "Point (Right)",
    animClass = "overwatch",
    gesturePath = "signal_right"
})
ix.handsignal:Register({
    id = "ota_point_l",
    name = "Point (Left)",
    animClass = "overwatch",
    gesturePath = "signal_left"
})
ix.handsignal:Register({
    id = "takecover",
    name = "Take Cover",
    animClass = "overwatch",
    gesturePath = "signal_takecover"
})