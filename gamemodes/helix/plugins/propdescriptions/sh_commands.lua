--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


do
	local COMMAND = {}
	COMMAND.description = "Add a text describing a specific prop."
	COMMAND.arguments = {ix.type.string, ix.type.text}
	COMMAND.alias = {"PropDescAdd"}

	function COMMAND:OnRun(client, title, description)
		local curTime = CurTime()

		if (client.nextStaticText and client.nextStaticText >= curTime) then
			client:NotifyLocalized("notNow")

			return
		end

		if (title == "" or description == "") then
			return
		end

		local entity = client:GetEyeTraceNoCursor().Entity

		if (!IsValid(entity) or entity:GetClass() != "prop_physics") then
			client:NotifyLocalized("invalidProp")

			return
		end

		if (client:SteamID() != entity.ownerSteamID and !client:IsAdmin()) then
			client:NotifyLocalized("propNotYours")

			return
		end

		client.nextStaticText = curTime + 5
		client:NotifyLocalized("propDescriptionAdded")

		entity:SetNetVar("description", {title, description})

		ix.log.Add(client, "propDescriptionAdded", title, description)
	end

	ix.command.Add("PropDescriptionAdd", COMMAND)
end

do
	local COMMAND = {}
	COMMAND.description = "Add a permanent text describing a specific prop."
	COMMAND.arguments = {ix.type.string, ix.type.text}
	COMMAND.adminOnly = true
	COMMAND.alias = {"PermPropDescAdd"}

	function COMMAND:OnRun(client, title, description)
		local curTime = CurTime()

		if (client.nextStaticText and client.nextStaticText >= curTime) then
			client:NotifyLocalized("notNow")

			return
		end

		if (title == "" or description == "") then
			return
		end

		local entity = client:GetEyeTraceNoCursor().Entity

		if (!IsValid(entity) or entity:GetClass() != "prop_physics") then
			client:NotifyLocalized("invalidProp")

			return
		end

		client.nextStaticText = curTime + 5
		client:NotifyLocalized("propDescriptionAdded")

		entity:SetNetVar("description", {title, description})
		entity.saveDescription = true

		ix.log.Add(client, "propDescriptionAdded", title, description)
	end

	ix.command.Add("PermanentPropDescriptionAdd", COMMAND)
end

do
	local COMMAND = {}
	COMMAND.description = "Removes a prop's description text."
	COMMAND.alias = {"PropDescRemove"}

	function COMMAND:OnRun(client)
		local entity = client:GetEyeTraceNoCursor().Entity

		if (!IsValid(entity) or entity:GetClass() != "prop_physics") then
			client:NotifyLocalized("invalidProp")

			return
		end

		if (client:SteamID() != entity.ownerSteamID and !client:IsAdmin()) then
			client:NotifyLocalized("propNotYours")

			return
		end
 
		client:NotifyLocalized("propDescriptionRemoved")

		entity:SetNetVar("description", nil)

		ix.log.Add(client, "propDescriptionRemoved")
	end

	ix.command.Add("PropDescriptionRemove", COMMAND)
end
