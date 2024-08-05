--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Antlion Extract"
ITEM.description = "Your body feels at ease in its presence. It's glowing."
ITEM.category = "Xen"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/n7/larval_essence01.mdl"
ITEM.colorAppendix = {["red"] = "You need permission from CT Coordinators or Vort Leads to spawn or use this item, do not drop or hand it to other players."}
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