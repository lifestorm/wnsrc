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

ITEM.name = "Landline Phone"
ITEM.model = Model("models/props/cs_office/phone.mdl")
ITEM.description = "A simple landline phone."
ITEM.width = 2
ITEM.height = 2
ITEM.category = "Technology"
ITEM.functions.Deploy = {
    name = "Deploy",
    OnRun = function(itemTable)
		local client = itemTable.player
		if client.CantPlace then
			client:NotifyLocalized("You need to wait before you can place this!")
			return false
		end

		client.CantPlace = true

		timer.Simple(3, function()
			if client then
				client.CantPlace = false
			end
		end)

		local phone = ents.Create("landline_phone")
		local tr    = client:GetEyeTrace()
		local dist  = client:EyePos():Distance(tr.HitPos)

		phone:SetPos(client:EyePos() + (tr.Normal * math.Clamp(dist, 0, 75)))
		phone:Spawn()

		ix.saveEnts:SaveEntity(phone)

		return true
	end
}
