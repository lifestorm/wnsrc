--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local ix = ix
local bit = bit
local netstream = netstream
local hook = hook

local PLUGIN = PLUGIN

ix.command.Add("EditDesc", {
	description = "Edit character's extended description.",
	arguments = bit.bor(ix.type.player, ix.type.optional),
	OnRun = function(self, client, target)
		netstream.Start(client, "ixExtendedDescription", target or client, hook.Run("CanPlayerEditDescription", client, target))
	end
})
