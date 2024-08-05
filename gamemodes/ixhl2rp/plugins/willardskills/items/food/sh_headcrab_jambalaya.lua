--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Headcrab Jambalaya"
ITEM.description = "Boiled headcrab mixed in with a spicy gravy, vegetables and other ingredients."
ITEM.category = "Food"
ITEM.model = "models/willardnetworks/food/stew1.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(69.87, 58.63, 44.49),
	ang = Angle(24.51, 219.92, 0),
	fov = 4.27
}
ITEM.hunger = 65
ITEM.thirst = 15
ITEM.boosts = {
	agility = 5
}
ITEM.spoil = true
ITEM.useSound = "ambient/levels/canals/toxic_slime_gurgle4.wav"

ITEM.addVE = 20
function ITEM:OnConsume(client, character)
	if character:IsVortigaunt() then
		local percentage = ix.config.Get("maxVortalEnergy", 100) / 100
		percentage = percentage * self.addVE
		character:AddVortalEnergy(percentage)
	end
end