--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Masque - Avancé"
ITEM.description = "Un masque avancé du Cartel. Offre une protection accrue contre les fumées, les gaz nocifs et certaines odeurs nauséabondes."
ITEM.category = "Combine"
ITEM.model = "models/wn7new/metropolice/n7_cp_gasmask1.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(-6.26, 381.14, 189.04),
  ang = Angle(26.03, 270.95, 0),
  fov = 1.91
}
ITEM.outfitCategory = "Head"
ITEM.bodyGroups = {
    ["cp_Head"] = 2 -- The actual name of the bodypart, then number in that bodypart (model-wise)
}

ITEM.isGasmask = true
ITEM.isCombineMask = true
ITEM.isPPE = true

ITEM.colorAppendix = {["red"] = "Il est totalement interdit d'avoir ce masque sur vous. Si une unité découvre que vous portez ce masque, attendez-vous à de terribles conséquences."}