--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Datapad UTC-Recrue"
ITEM.model = Model("models/fruity/tablet/tablet_sfm.mdl")
ITEM.description = "Un datapad pour les recrues UTC."
ITEM.category = "Combine"
ITEM.width = 1
ITEM.height = 1
ITEM.KeepOnDeath = true

ITEM.functions.Open = {
	OnRun = function(item)
		net.Start("ixDataFilePDA_CWU_Open")
		net.Send(item.player)

		return false
	end,
	OnCanRun = function(item)
		local character = item.player:GetCharacter()

		return item.player:Team() == FACTION_WORKERS or character:IsVortigaunt() and character:GetBioticPDA() == "CWU"
	end
}
