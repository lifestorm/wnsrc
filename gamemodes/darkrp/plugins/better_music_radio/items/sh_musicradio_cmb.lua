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

ITEM.name = "Radio de Bienfaiteur"
ITEM.category = "Radio"
ITEM.model = Model("models/props_lab/citizenradio.mdl")
ITEM.description = "Une radio fabriquée dont la fréquence est synchronisée sur une station de radio de l'Union, qui propose à la fois de la musique classique et patriotique."
ITEM.width = 4
ITEM.height = 3
ITEM.functions.Deploy = {
    name = "Poser",
    OnRun = function(itemTable)
		local client = itemTable.player
		if client.CantPlace then
			client:NotifyLocalized("Vous devez attendre avant de pouvoir placer ceci !..")
			return false
		end

		client.CantPlace = true

		timer.Simple(3, function()
			if client then
				client.CantPlace = false
			end
		end)

        local radio = ents.Create("wn_musicradio")
        local tr = client:GetEyeTrace()
        local dist = client:EyePos():Distance(tr.HitPos)

        radio:SetPos(client:EyePos() + (tr.Normal * math.Clamp(dist, 0, 75)))
        radio:Spawn()
		radio:SetRadioClass("benefactor")

		ix.saveEnts:SaveEntity(radio)

        return true
    end
}
