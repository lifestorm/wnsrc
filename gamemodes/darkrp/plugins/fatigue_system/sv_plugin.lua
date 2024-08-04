--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ix.log.AddType("energy", function(client, ...)
	local arg = {...}

	return Format("%s set energy level of %s to %d.", arg[1], arg[2], arg[3])
end)

function PLUGIN:EnterUntimedAct(client, sequence) -- maybe it's worth to move this to "act" plugin
	client:SetNetVar("actEnterAngle", client:GetAngles())
	client.ixUntimedSequence = true
	client:ForceSequence(sequence, function()
		client.ixUntimedSequence = nil
		client:SetNetVar("actEnterAngle")

		hook.Run("OnPlayerExitAct", client)

		net.Start("ixActLeave")
		net.Send(client)
	end, 0, nil)

	net.Start("ixActEnter")
		net.WriteBool(true)
	net.Send(client)
end

function PLUGIN:RestingEntity_FindSequenceNameAndDataByID(entityModel, client, actName, sequenceID)
	local sequences = self:FindModelActSequences(client, actName)

	if (!sequences) then
		return
	end

	local entityData = self.restingEntities[entityModel]
	local validSequences = entityData.sequences

	for k, v in ipairs(sequences) do
		if (sequenceID == k and validSequences[v]) then
			return entityData, v, validSequences[v]
		end
	end
end
