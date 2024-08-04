--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "OSPR2A-EXP"
ITEM.description = "Une version plus lourde et plus puissante de l'AR-2. Extrêmement imprécise lors du déplacement, le lanceur de boule a énergie n'est pas inclus."
ITEM.model = "models/weapons/irifle2/w_irifle2.mdl"
ITEM.class = "arccw_ar21"
ITEM.weaponCategory = "primary"
ITEM.category = "Armes"
ITEM.balanceCat = "assaultrifle"
ITEM.baseDamage = 23
ITEM.armorPen = 0.8
ITEM.width = 4
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-19.67, 199.67, 5.91),
	ang = Angle(1.2, 633.49, 0),
	fov = 10.64
}

ITEM.replaceOnDeath = "dummy_biolock_expar2"

ITEM.magazines = {["magazine_ospr_24rnd"] = true}

