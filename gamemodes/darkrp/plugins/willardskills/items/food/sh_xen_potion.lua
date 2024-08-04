--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Xen Zehri"
ITEM.description = "Nadir bulunan Xen bileşenlerinden elde edilen son derece egzotik bir uzaylı maddesi, içen kişiye inanılmaz bir organik yenilenme sağlıyor."
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
	["red"] = "Kullanmadan önce, lütfen bulunduğunuz yere bir GM talep edin. Bu eşya için uygun Tıbbi RP gereklidir, uygun RP olmadan kullanmak derhal Ölümünüze ve bir PK'ya neden olabilir.",
	["blue"] = "Bunların nasıl doğru kullanılacağına dair uygun bir IC kılavuzu vardır. Önce IC bilgisine sahip olduğunuzdan emin olun."
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