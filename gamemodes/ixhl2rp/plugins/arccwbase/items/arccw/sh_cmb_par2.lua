--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Overwatch Standard-Issue Pulse Rifle"
ITEM.description = "Dark Energy powered assault rifle manufactured by the Combine. The OSIPR is essentially a Combine variant of current assault rifles, commonly issued to Overwatch Soldiers and Overwatch Elites."
ITEM.model = "models/weapons/w_IRifle.mdl"
ITEM.class = "arrcw_ar2"
ITEM.weaponCategory = "primary"
ITEM.balanceCat = "assaultrifle"
ITEM.baseDamage = 20
ITEM.armorPen = 0.7
ITEM.width = 4
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-275.29, 1173.54, 46.1),
	ang = Angle(2.1, 642.98, 0),
	fov = 1.99
}

ITEM.replaceOnDeath = "dummy_biolock_ar2"

ITEM.magazines = {["magazine_pulse30"] = true}
