--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "junk_gascan"
ITEM.name = "Empty Gascan"
ITEM.description = "An empty gas canister used for carrying fuel or something similar. It's empty."
ITEM.category = "Junk"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
    pos = Vector(200, 0, 0),
    ang = Angle(0, 180, 0),
    fov = 6.48
}
ITEM.model = "models/props_junk/metalgascan.mdl"
ITEM.colorAppendix = {["blue"] = "This item can be broken down into its basic components with the Crafting skill."}
ITEM.holdData = {
    vectorOffset = {
        right = 3,
        up = -13,
        forward = 5
    },
    angleOffset = {
        right = 90,
        up = 90,
        forward = -0
    },
}