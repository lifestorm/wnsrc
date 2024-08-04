--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if SAM_LOADED then return end

local sam, netstream = sam, sam.netstream

local globals

if SERVER then
	globals = {}
	local order = {}

	local get_order_key = function(key)
		for i = 1, #order do
			if order[i] == key then
				return i
			end
		end
	end

	function sam.set_global(key, value, force)
		if force or globals[key] ~= value then
			globals[key] = value

			if value ~= nil then
				if not get_order_key(key) then
					table.insert(order, key)
				end
			else
				local i = get_order_key(key)
				if i then
					table.remove(order, i)
				end
			end

			netstream.Start(nil, "SetGlobal", key, value)
		end
	end

	hook.Add("OnEntityCreated", "SAM.Globals", function(ent)
		if ent:IsPlayer() and ent:IsValid() then
			local delay = FrameTime() * 5
			local first = true
			for _, key in ipairs(order) do
				if (key == "Ranks") then
					for rank, value in pairs(globals[key]) do
						timer.Simple(delay, function() netstream.Start(ent, "SendRank", rank, value) end)
						delay = delay + FrameTime() * 2
					end
					timer.Simple(delay, function() netstream.Start(ent, "SendRank", "Last") end)
					delay = delay + FrameTime() * 5
				else
					if (first) then
						timer.Simple(delay, function() netstream.Start(ent, "SendGlobals", {[key] = globals[key]}, {key}) end)
						first = false
					else
						timer.Simple(delay, function() netstream.Start(ent, "SetGlobal", key, globals[key]) end)
					end
					delay = delay + FrameTime() * 5
				end
			end
		end
	end)
end

if CLIENT then
	function sam.set_global(key, value)
		if globals then
			globals[key] = value
			hook.Call("SAM.ChangedGlobalVar", nil, key, value)
		end
	end
	netstream.Hook("SetGlobal", sam.set_global)

	netstream.Hook("SendGlobals", function(vars, order)
		globals = vars

		for _, key in ipairs(order) do
			hook.Call("SAM.ChangedGlobalVar", nil, key, vars[key])
		end
	end)

	netstream.Hook("SendRank", function(rank, value)
		if (rank ~= "Last" and value) then
			globals = globals or {}
			globals["Ranks"] = globals["Ranks"] or {}
			globals["Ranks"][rank] = value
		elseif (rank == "Last") then
			hook.Call("SAM.ChangedGlobalVar", nil, "Ranks", globals["Ranks"])
		end
	end)
end

function sam.get_global(key, default)
	if globals then
		local value = globals[key]
		if value ~= nil then
			return value
		end
	end

	return default
end