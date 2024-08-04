--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "xen_concoction"
ITEM.name = "Mikstura z Ekstraktu"
ITEM.description = "Zaraz wyruszysz w podróż podczas której osiągniesz błogi spokój."
ITEM.category = "Xen"
ITEM.model = "models/willardnetworks/food/concoction.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
  pos = Vector(6.22, -199.61, 10.73),
  ang = Angle(3.08, 91.74, 0),
  fov = 2.58
}
ITEM.hunger = 100
ITEM.thirst = 100
ITEM.instantHeal = true
ITEM.boosts = {
	strength = 15,
	perception = 15,
	agility = 15,
	intelligence = 15
}
ITEM.spoil = false
ITEM.useSound = "ambient/levels/canals/toxic_slime_gurgle4.wav"
ITEM.colorAppendix = {["red"] = "Potrzebujesz zgody Opiekuna Vortów aby zrespić lub użyć ten przedmiot. Nie upuszczaj i nie oddawaj go innym graczom."}
ITEM.outlineColor = Color(255, 0, 0, 100)

function ITEM:OnConsume(client, character)
	if !character:IsVortigaunt() then return end
	ix.plugin.Get("vortigaunts"):ExtractConsume(client, character)
end