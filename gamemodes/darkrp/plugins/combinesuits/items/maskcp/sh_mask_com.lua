--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Masque à gaz PMG-5 (AUG) avancé"
ITEM.description = "Tout comme le masque original, mais avec des visuels améliorés, une meilleure connexion à OCIN et un réglage amélioré pour les communications."
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
    ["cp_Head"] = 3 -- The actual name of the bodypart, then number in that bodypart (model-wise)
}

ITEM.isGasmask = true
ITEM.isCombineMask = true
ITEM.energyConsumptionRate = 0.001 -- fatigue_system
