--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

ITEM.name = "Télévision"
ITEM.model = "models/props_c17/tv_monitor01.mdl"
ITEM.width = 1
ITEM.height = 1

ITEM.description = "La petite télévision est dotée d'un écran plat d'environ 15 pouces et est équipée d'un tuner analogique pour capter la chaîne locale. Elle possède également une petite antenne télescopique pour améliorer la réception du signal. Le boîtier est en plastique noir brillant et il y a un bouton d'alimentation sur le côté."

ITEM.description = "Cet écran rectangulaire trône au centre de la pièce, captivant l'attention de tous avec ses images lumineuses et ses sons captivants."

ITEM.category = "Autres"

ITEM.functions.Place = {
	name = "Placer",
	OnRun = function(itemTable)
		local client = itemTable.player
		local entity = ents.Create("ix_combinemonitor_tv")
		local trace = client:GetEyeTraceNoCursor()

		if (trace.HitPos:Distance( client:GetShootPos() ) <= 192) and !client.CantPlace then
			entity:SetPos(trace.HitPos + Vector( 0, 0, 8 ))
			entity:Spawn()
			entity:SetNWInt("owner", client:GetCharacter():GetID())

			client.CantPlace = true

			ix.saveEnts:SaveEntity(entity)

			timer.Simple(3, function()
				if client then
					client.CantPlace = false
				end
			end)
		elseif client.CantPlace then
			client:NotifyLocalized("Vous ne pouvez pas placer ça maintenant !")
			return false
		else
			client:NotifyLocalized("Vous ne pouvez pas le placer aussi loin !")
			return false
		end
	end
}