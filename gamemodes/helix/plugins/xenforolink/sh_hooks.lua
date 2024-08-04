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

do
    local PLAYER = FindMetaTable("Player")

    local inherits_from = sam.ranks.inherits_from
	function PLAYER:IsAdmin()
        return self:CheckGroup("admin")
	end

	function PLAYER:IsSuperAdmin()
		return self:CheckGroup("superadmin")
	end


	function PLAYER:CheckGroup(name)
		local ranks = self:GetLocalVar("xenforoRanks")

        if (ranks) then
            for _, v in ipairs(ranks) do
                if (inherits_from(v, name)) then
                    return true
                end
            end
        end

        return inherits_from(self:GetUserGroup(), name)
	end

    local has_permission = sam.ranks.has_permission
	function PLAYER:HasPermission(perm)
        local ranks = self:GetLocalVar("xenforoRanks")

        if (ranks) then
            for _, v in ipairs(ranks) do
                if (has_permission(v, perm)) then
                    return true
                end
            end
        end

		return has_permission(self:GetUserGroup(), perm)
	end
end

function PLUGIN:InitializedPlugins()
    if (SERVER) then
		self:InitAPIKey()
	end

    hook.Run("RegisterGroups", self)
end

hook.Add("CAMI.PlayerHasAccess", "ixXenforo.CAMI.PlayerHasAccess", function(ply, privilege, callback, target)
	if sam.type(ply) ~= "Player" then return end

    local ranks = ply:GetLocalVar("xenforoRanks")
    local bTargetIsPlayer = sam.type(target) == "Player"
    local bCanTarget = bTargetIsPlayer and ply:CanTarget(target)
    if (ranks) then
        for _, v in ipairs(ranks) do
            local has_permission = sam.ranks.has_permission(v, privilege)
            if (has_permission and (!bTargetIsPlayer or bCanTarget)) then
                callback(true)
                return true
            end
        end
    end

    local has_permission = ply:HasPermission(privilege)
	if (bTargetIsPlayer) then
		callback(has_permission and bCanTarget)
	else
		callback(has_permission)
	end

	return true
end)
hook.Remove("CAMI.PlayerHasAccess", "SAM.CAMI.PlayerHasAccess")

function PLUGIN:CharacterHasFlags(character, flags)
    local client = character:GetPlayer()
    if (!IsValid(client)) then return end

    local flagList = client:GetLocalVar("xenforoFlags")
    if (!flagList) then return end

	for i = 1, #flags do
		if (flagList:find(flags[i], 1, true)) then
			return true
		end
	end
end

if (CLIENT) then
    function PLUGIN:GetPlayerESPText(client, toDraw, distance, alphaFar, alphaMid, alphaClose)
        local tier = client:GetNetVar("xenforoTier")
        if (tier and PLUGIN.tiers[tier]) then
            toDraw[#toDraw + 1] = {alpha = alphaClose, priority = 29, text = PLUGIN.tiers[tier]}
        end
    end
end