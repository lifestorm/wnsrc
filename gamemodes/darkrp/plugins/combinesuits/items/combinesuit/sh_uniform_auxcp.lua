--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Uniforme PC - Recrue"
ITEM.model = Model("models/wn7new/metropolice/cpuniform.mdl")
ITEM.description = "Un uniforme auxiliaire de la Protection Civile. Design similaire, mais sans les technologies intégrées."
ITEM.category = "Combine"
ITEM.replacementString = "wn7new/metropolice"
ITEM.model = "models/wn7new/metropolice/cpuniform.mdl"
ITEM.iconCam = {
  pos = Vector(-1.96, 13.01, 199.57),
  ang = Angle(84.7, 279.39, 0),
  fov = 4.8
}
ITEM.isCP = true
ITEM.maxArmor = 25

ITEM.bodyGroups = {
    ["Pants"] = 0,
    ["cp_Body"] = 0
}

ITEM.replaceOnDeath = "broken_cpuniform"