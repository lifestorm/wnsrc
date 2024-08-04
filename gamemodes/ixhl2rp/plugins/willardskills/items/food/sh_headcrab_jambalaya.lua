--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Jambalaya z Headcraba"
ITEM.description = "Jambalaya z Headcraba to potrawa, która z połączeniem pikantnego ryżu, aromatycznych przypraw i mięsa z pewnością zaspokoi Twoje smakowe pragnienia i sprawi, że poczujesz się jak prawdziwy kucharz kuchni Cajun."
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