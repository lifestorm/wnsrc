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
PLUGIN.name = "Conscript Bodymanage"
PLUGIN.author = "Naast"
PLUGIN.description = "Allow conscripts to use bodygroup manager."

ix.command.Add("CharEditBodygroup", {
	description = "cmdEditBodygroup",
	OnCheckAccess = function(self, client)
		local isConscript = ix.faction.Get(client:Team()).index == FACTION_CCR
		local isCombine = client:IsCombine()
		local isAdmin = client:IsAdmin()

		return isConscript or isCombine or isAdmin or false
	end,
	arguments = {
		bit.bor(ix.type.player, ix.type.optional)
	},
	OnRun = function(self, client, target)
		net.Start("ixBodygroupView")
			net.WriteEntity(target or client)
			net.WriteTable(target and target:GetCharacter():GetProxyColors() or {})
		net.Send(client)
	end
})

if SERVER then
	net.Receive("ixBodygroupTableSet", function(length, client)
		local isConscript = ix.faction.Get(client:Team()).index == FACTION_CCR
		if (!ix.command.HasAccess(client, "CharEditBodygroup") and !client:IsCombine() and !isConscript) then return end

		local target = net.ReadEntity()

		if (client:IsCombine() and !ix.command.HasAccess(client, "CharEditBodygroup") and target != client or isConscript and !ix.command.HasAccess(client, "CharEditBodygroup") and target != client) then return end

		if (!IsValid(target) or !target:IsPlayer() or !target:GetCharacter()) then
			return
		end

		local bodygroups = net.ReadTable()

		local groups = {}

		for k, v in pairs(bodygroups) do
			target:SetBodygroup(tonumber(k) or 0, tonumber(v) or 0)
			groups[tonumber(k) or 0] = tonumber(v) or 0

			local hairBG = client:FindBodygroupByName( "hair" )
			if k != hairBG then continue end
			if !client:GetModel():find("models/willardnetworks/citizens/") then continue end

			local curHeadwearBG = client:GetBodygroup(client:FindBodygroupByName( "headwear" ))
			local curHairBG = client:GetBodygroup(hairBG)

			local hairBgLength = 0
			for _, v2 in pairs(client:GetBodyGroups()) do
				if v2.name  != "hair" then continue end
				if !v2.submodels then continue end
				if !istable(v2.submodels) then continue end

				hairBgLength =  #v2.submodels
				break
			end

			if (curHeadwearBG != 0) then
				if curHairBG != 0 then
					client:SetBodygroup(hairBG, hairBgLength)
				end
			end
		end

		target:GetCharacter():SetData("groups", groups)

		local hairColor = net.ReadTable()
		local charProxies = target:GetCharacter():GetProxyColors() or {}

		charProxies["HairColor"] = Color(hairColor.r, hairColor.g, hairColor.b)

		target:GetCharacter():SetProxyColors(charProxies)

		ix.log.Add(client, "bodygroupEditor", target)
	end)
end