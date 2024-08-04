--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Ekstrakt z Antliona"
ITEM.description = "Twoje ciało wydaje się totalnie odprężone. Ekstrakt się świeci."
ITEM.category = "Xen"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/n7/larval_essence01.mdl"
ITEM.colorAppendix = {["red"] = "Potrzebujesz zgody administracji lub przywództwa Vortów żeby używać tego przedmiotu, nie upuszczaj go i nie przekazuj innym graczom."}
ITEM.outlineColor = Color(255, 0, 0, 100)

ITEM.functions.Consume = {
	icon = "icon16/user.png",
	OnRun = function(item)
		local client = item.player
		local character = item.player:GetCharacter()
		item:OnConsume(client, character)
	end,
    OnCanRun = function(item)
        return item.player:IsVortigaunt()
    end
}

function ITEM:OnConsume(client, character)
	if !character:IsVortigaunt() then return end
	ix.plugin.Get("vortigaunts"):ExtractConsume(client, character)
end