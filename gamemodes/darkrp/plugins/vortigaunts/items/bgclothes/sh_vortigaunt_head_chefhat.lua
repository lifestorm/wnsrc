--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Vortigaunt Şef Şapkası"
ITEM.description = "Vortigauntlar, Vortessence ile olan bağlantıları nedeniyle mutfak sanatlarındaki katıksız yetenekleriyle tanınırlar. Bir Vortigaunt'un geçici olarak uzman bir şef gibi davranması için geriye kalan tek adım, bu aptal şapkalardan birini takmaktır."
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
