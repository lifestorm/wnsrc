--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Overwatch Standard-Issue Carbine"
ITEM.description = "The SR-1A is the standard assault weapon of the Overwatch Forces. Unlike the AR-2, it fires light rounds capable of piercing light armoured targets."
ITEM.model = "models/weapons/oar/w_orifle.mdl"
ITEM.class = "arccw_ordinalar2"
ITEM.weaponCategory = "primary"
ITEM.balanceCat = "assaultrifle"
ITEM.baseDamage = 19
ITEM.armorPen = 0.75
ITEM.width = 3
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-106.92, 352.12, -8.62),
	ang = Angle(-1.77, 645.61, 0),
	fov = 5.89
}

ITEM.replaceOnDeath = "dummy_biolock_sr1"

ITEM.magazines = {["magazine_pulse30"] = true}
