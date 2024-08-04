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
    name = "Vient !",
    animClass = "citizen_female",
    gesturePath = "g_wave"
})
ix.handsignal:Register({
    id = "display_r",
    name = "A droite",
    animClass = "citizen_female",
    gesturePath = "g_right_openhand"
})
ix.handsignal:Register({
    id = "headshake",
    name = "Hochement de tête",
    animClass = "citizen_female",
    gesturePath = "hg_headshake"
})
ix.handsignal:Register({
    id = "display_l",
    name = "A gauche",
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
    name = "Pointer",
    animClass = "citizen_male",
    gesturePath = "g_point_l"
})
ix.handsignal:Register({
    id = "point_m",
    name = "Pointer",
    animClass = "metrocop",
    gesturePath = "g_point_l"
})

ix.handsignal:Register({
    id = "point_left",
    name = "Pointer à gauche",
    animClass = "citizen_male",
    gesturePath = "g_pointleft_l"
})
ix.handsignal:Register({
    id = "point_left_m",
    name = "Pointer à gauche",
    animClass = "metrocop",
    gesturePath = "g_pointleft_l"
})

ix.handsignal:Register({
    id = "point_right",
    name = "Pointer à droite",
    animClass = "citizen_male",
    gesturePath = "g_pointright_l"
})
ix.handsignal:Register({
    id = "point_right_m",
    name = "Pointer à droite",
    animClass = "metrocop",
    gesturePath = "g_pointright_l"
})

ix.handsignal:Register({
    id = "wave_male",
    name = "Vient !",
    animClass = "citizen_male",
    gesturePath = "g_wave"
})
ix.handsignal:Register({
    id = "wave_metro",
    name = "Vient !",
    animClass = "metrocop",
    gesturePath = "g_wave"
})

ix.handsignal:Register({
    id = "wave_low",
    name = "Vient ! (Doucement)",
    animClass = "citizen_male",
    gesturePath = "g_lookatthis"
})
ix.handsignal:Register({
    id = "wave_low_m",
    name = "Vient ! (Doucement)",
    animClass = "metrocop",
    gesturePath = "g_lookatthis"
})

-- OTA

ix.handsignal:Register({
    id = "advance",
    name = "Avancer",
    animClass = "overwatch",
    gesturePath = "signal_advance"
})
ix.handsignal:Register({
    id = "forward",
    name = "Pointer",
    animClass = "overwatch",
    gesturePath = "signal_forward"
})
ix.handsignal:Register({
    id = "group",
    name = "Grouper",
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
    name = "Pointer à droite",
    animClass = "overwatch",
    gesturePath = "signal_right"
})
ix.handsignal:Register({
    id = "ota_point_l",
    name = "Pointer à gauche",
    animClass = "overwatch",
    gesturePath = "signal_left"
})
ix.handsignal:Register({
    id = "takecover",
    name = "Prenez une couverture",
    animClass = "overwatch",
    gesturePath = "signal_takecover"
})