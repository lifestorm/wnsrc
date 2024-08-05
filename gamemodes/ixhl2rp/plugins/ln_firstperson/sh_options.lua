--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ix.option.Add("enableImmersiveFirstPerson", ix.type.bool, true, {
    category = "First Person"
})

ix.option.Add("smoothScale", ix.type.number, 0.7, {
    category = "First Person",
    min = 0,
    max = 0.9,
    decimals = 1
})

ix.option.Add("customCrosshair", ix.type.bool, true, {
    category = "First Person"
})
