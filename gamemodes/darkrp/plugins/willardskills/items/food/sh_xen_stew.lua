--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Xenian Stew"
ITEM.description = "Otherworldly ingredients formed into a gravy induced stew. Only a master chef could pull this off."
ITEM.category = "Xen"
ITEM.model = "models/willardnetworks/food/xen_stew.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(125.61, 104.91, 78.59),
  ang = Angle(24.78, 219.86, 0),
  fov = 3
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
ITEM.useSound = "ambient/levels/canals/toxic_slime_gurgle4.wav"

ITEM.addVE = 50
function ITEM:OnConsume(client, character)
	if character:IsVortigaunt() then
		local percentage = ix.config.Get("maxVortalEnergy", 100) / 100
		percentage = percentage * self.addVE
		character:AddVortalEnergy(percentage)
	end
end