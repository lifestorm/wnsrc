--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Toque de vortigaunt"
ITEM.description = "Les Vortigaunts sont bien connus pour leurs capacités dans les arts culinaires en raison de leur lien avec la Vortessence. La seule étape restante pour qu'un Vortigaunt agisse temporairement comme un chef expert est de porter l'un de ces chapeaux idiots."
ITEM.category = "Vortigaunt"
ITEM.model = "models/willardnetworks/clothingitems/head_chefhat.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(-138.87, -116.79, 85.76),
  ang = Angle(25.28, 400.12, 0),
  fov = 4.26
}
ITEM.outfitCategory = "Head"
ITEM.factionList = {FACTION_VORT}

ITEM.bodyGroups = {
    ["head"] = 1 -- The actual name of the bodypart, then number in that bodypart (model-wise)
}
