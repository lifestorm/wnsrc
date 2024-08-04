--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Masque à gaz PMG-5"
ITEM.description = "Offre une protection adéquate contre les fumées et les gaz nocifs, ainsi que certaines odeurs nauséabondes. Il lui manque beaucoup de technologies que les masques PC standard possèdent."
ITEM.category = "Combine"
ITEM.model = "models/wn7new/metropolice/n7_cp_gasmask1.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(-6.26, 381.14, 189.04),
  ang = Angle(26.03, 270.95, 0),
  fov = 1.91
}
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "Head"
ITEM.bodyGroups = {
    ["cp_Head"] = 1 -- The actual name of the bodypart, then number in that bodypart (model-wise)
}

ITEM.isGasmask = true
ITEM.isCombineMask = false
ITEM.energyConsumptionRate = 0.001 -- fatigue_system