--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "AR-2"
ITEM.description = "Fusil d'assaut alimenté par une énergie noire fabriquée par le Cartel. L'AR-2 est essentiellement une variante Combine des fusils d'assaut actuels, généralement délivrés aux soldats et aux élites de l'Overwatch"
ITEM.model = "models/weapons/w_IRifle.mdl"
ITEM.class = "arrcw_ar2"
ITEM.weaponCategory = "primary"
ITEM.balanceCat = "assaultrifle"
ITEM.category = "Armes"
ITEM.baseDamage = 21
ITEM.armorPen = 0.55
ITEM.width = 4
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-275.29, 1173.54, 46.1),
	ang = Angle(2.1, 642.98, 0),
	fov = 1.99
}

ITEM.replaceOnDeath = "dummy_biolock_ar2"

ITEM.magazines = {["magazine_pulse30"] = true}
