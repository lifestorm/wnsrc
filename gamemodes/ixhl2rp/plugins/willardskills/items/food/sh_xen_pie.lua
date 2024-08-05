--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Xenian Pie"
ITEM.description = "Otherworldly ingredients mixed to become a warm pie. Only a master chef could pull this off."
ITEM.category = "Xen"
ITEM.model = "models/willardnetworks/food/xen_pie.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(169.82, 142.5, 102.64),
  ang = Angle(24.95, 219.95, 0),
  fov = 2.78
}
ITEM.hunger = 100
ITEM.thirst = 100
ITEM.health = 15
ITEM.boosts = {
	strength = 7,
	perception = 7,
	agility = 7,
	intelligence = 7
}

ITEM.addVE = 50
function ITEM:OnConsume(client, character)
	if character:IsVortigaunt() then
		local percentage = ix.config.Get("maxVortalEnergy", 100) / 100
		percentage = percentage * self.addVE
		character:AddVortalEnergy(percentage)
	end
end

ITEM.useSound = "npc/barnacle/barnacle_crunch2.wav"