--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "OICW"
ITEM.description = "Fusil de combat à tir rapide conçu pour remplacer l'armements standard des Forces de l'Overwatch dans l'arsenal du Cartel, avec un mode rafale à 5 coups toujours plus rapide. Bon pour courir et tirer."
ITEM.model = "models/weapons/oicw/w_oicw.mdl"
ITEM.class = "arccw_oicw"
ITEM.weaponCategory = "primary"
ITEM.category = "Armes"
ITEM.balanceCat = "assaultrifle"
ITEM.baseDamage = 16
ITEM.armorPen = 0.7
ITEM.width = 4
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-651.9, 34.32, 11.62),
	ang = Angle(0.77, 356.24, 0),
	fov = 3.04
}

ITEM.replaceOnDeath = "dummy_biolock_ociw"

ITEM.magazines = {["magazine_tac60"] = true}

