--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "CP Captain Uniform"
ITEM.model = Model("models/wn7new/metropolice/cpuniform.mdl")
ITEM.description = "Combine issued Civil Protection uniform made for Captains."
ITEM.category = "Combine"
ITEM.replacementString = "wn7new/metropolice"
ITEM.model = "models/wn7new/metropolice/cpuniform.mdl"
ITEM.iconCam = {
  pos = Vector(-1.96, 13.01, 199.57),
  ang = Angle(84.7, 279.39, 0),
  fov = 4.8
}
ITEM.isCP = true
ITEM.maxArmor = 75

ITEM.channels = {"cmb", "tac-3", "tac-4", "tac-5", "ccr-tac"}

ITEM.bodyGroups = {
    ["Pants"] = 0,
    ["Base"] = 1,
    ["cp_Body"] = 16
}

ITEM.replaceOnDeath = "broken_cpuniform"