--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local entityMeta = FindMetaTable("Entity")
local playerMeta = FindMetaTable("Player")

ix.net = ix.net or {}
ix.net.globals = ix.net.globals or {}

net.Receive("ixGlobalVarSet", function()
	ix.net.globals[net.ReadString()] = net.ReadType()
end)

net.Receive("ixNetVarSet", function()
	local index = net.ReadUInt(16)

	ix.net[index] = ix.net[index] or {}
	ix.net[index][net.ReadString()] = net.ReadType()
end)

net.Receive("ixNetStatics", function()
	for _ = 1, net.ReadUInt(16) do
		local id = net.ReadUInt(16)
		if (id == 0) then continue end
		ix.net[id] = ix.net[id] or {}
		ix.net[id].Persistent = true
	end
end)

net.Receive("ixNetVarDelete", function()
	ix.net[net.ReadUInt(16)] = nil
end)

net.Receive("ixLocalVarSet", function()
	local key = net.ReadString()
	local var = net.ReadType()

	ix.net[LocalPlayer():EntIndex()] = ix.net[LocalPlayer():EntIndex()] or {}
	ix.net[LocalPlayer():EntIndex()][key] = var

	hook.Run("OnLocalVarSet", key, var)
end)

function GetNetVar(key, default) -- luacheck: globals GetNetVar
	local value = ix.net.globals[key]

	return value != nil and value or default
end

function entityMeta:GetNetVar(key, default)
	local index = self:EntIndex()

	if (ix.net[index] and ix.net[index][key] != nil) then
		return ix.net[index][key]
	end

	return default
end

playerMeta.GetLocalVar = entityMeta.GetNetVar
