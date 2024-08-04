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

ITEM.name = "Radio Rebelii"
ITEM.model = Model("models/props_lab/citizenradio.mdl")
ITEM.description = "Małe radio z odzysku radio dostrojone na pirackie stacji radiowe nadawające przeciwko Kombiantu."
ITEM.category = "Technology"
ITEM.width = 4
ITEM.height = 3
ITEM.functions.Deploy = {
    name = "Rozmieść",
    OnRun = function(itemTable)
		local client = itemTable.player
		if client.CantPlace then
			client:NotifyLocalized("Musisz poczekać zanim będziesz mógł to postawić!..")
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
		radio:SetRadioClass("pirate")

		ix.saveEnts:SaveEntity(radio)

        return true
    end
}