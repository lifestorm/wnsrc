--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Potion Xen"
ITEM.description = "Une substance extraterrestre hautement exotique concoctée à partir d'ingrédients Xen rares, apportant une incroyable régénération organique à quiconque la boit."
ITEM.category = "Xen"
ITEM.model = "models/willardnetworks/props/xenpotion3.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(125.61, 104.91, 78.59),
	ang = Angle(24.15, 219.95, 0),
	fov = 3.72
}
ITEM.thirst = 100
ITEM.instantHeal = true
ITEM.spoil = false
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.colorAppendix = {
	["red"] = "Before using, please request a GM to your location. Proper Medical RP is required for this item, using it without proper RP may involve your immediate Death and a PK.",
	["blue"] = "There is a proper IC guide on how to use these correctly. Make sure you have the IC knowledge first."
}
ITEM.outlineColor = Color(255, 0, 0, 100)

ITEM.addVE = 50
function ITEM:OnConsume(client, character)
	if character:IsVortigaunt() then
		local percentage = ix.config.Get("maxVortalEnergy", 100) / 100
		percentage = percentage * self.addVE
		character:AddVortalEnergy(percentage)
	end
end