--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Antlion Stew"
ITEM.description = "An otherwordly mixture of meat chunks, vegetables and spice combined to produce a seemingly apetizing stew."
ITEM.category = "Food"
ITEM.model = "models/willardnetworks/food/meatysoup.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(125.61, 104.91, 78.59),
	ang = Angle(24.78, 219.86, 0),
	fov = 3
}
ITEM.hunger = 65
ITEM.thirst = 15
ITEM.boosts = {
	strength = 5
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