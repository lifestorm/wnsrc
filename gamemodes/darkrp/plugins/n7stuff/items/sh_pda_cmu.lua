--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "CMRU PDA"
ITEM.model = Model("models/fruity/tablet/tablet_sfm.mdl")
ITEM.description = "Civilian issued PDA for local CMRU groups."
ITEM.category = "Combine"
ITEM.width = 1
ITEM.height = 1
ITEM.KeepOnDeath = true

ITEM.functions.Open = {
	OnRun = function(item)
		net.Start("ixDataFilePDA_CMU_Open")
		net.Send(item.player)

		return false
	end,
	OnCanRun = function(item)
		local character = item.player:GetCharacter()

		return item.player:Team() == FACTION_MEDICAL or character:IsVortigaunt() and character:GetBioticPDA() == "CMU"
	end
}
