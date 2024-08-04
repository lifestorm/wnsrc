--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Eliksir Xen"
ITEM.description = "Bardzo egzotyczna, obca substancja stworzona z rzadkich składników Xen, przynosząca niesamowitą organiczną regenerację dla każdego, kto ją wypije."
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
	["red"] = "Przed użyciem skontaktuj się z administracją. Do użyciu tego przedmiotu wymagane jest odegranie poprawnego MedRP, użycie tego przedmiotu bez akcji może skończyć się śmiercią i CK.",
	["blue"] = "Upewnij się, że masz wiedzę IC jak wykorzystać ten przedmiot."
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