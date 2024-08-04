--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Faction Intercoms"
PLUGIN.author = "Aspect™"
PLUGIN.description = "Adds faction intercoms."

ix.util.Include("sv_hooks.lua")

properties.Add("ixChangeIntercomChannel", {
	MenuLabel = "Change Channel",
	Order = 405,
	MenuIcon = "icon16/cog_edit.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() == "ix_intercom" and CAMI.PlayerHasAccess(client, "Helix - Basic Admin Commands", nil)) then return true end
	end,

	Action = function(self, entity)
		self:MsgStart()
			net.WriteEntity(entity)
		self:MsgEnd()
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()

		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end

		client:RequestString("Changer le canal d'interphone", "Entrez un canal valide pour basculer vers", function(channelID)
			if (!channelID or channelID == "") then return end
			channelID = string.lower(channelID)

			local channel = ix.radio.channels[channelID]
			if (!channel) then
				client:Notify("Ce n'est pas un canal valide!")

				return
			end

			entity:SetChannel(channelID)
			client:Notify("Modification du canal d'interphone : " .. channelID)
		end, "")
	end
})
