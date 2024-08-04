--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Cremator"
PLUGIN.author = "DrodA & Aspect™"
PLUGIN.description = "Adds a cremator faction."

ix.util.Include("cl_hooks.lua")
ix.util.Include("sv_hooks.lua")

game.AddParticles("particles/fire_01.pcf")
game.AddParticles("particles/burning_fx.pcf")

PrecacheParticleSystem("fire_jet_01_flame")
PrecacheParticleSystem("burning_character_c") -- burning_character_e

ix.anim.cremator = {
	normal = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE},
		[ACT_MP_WALK] = {ACT_WALK, ACT_WALK},
		[ACT_MP_RUN] = {ACT_WALK, ACT_WALK},
		[ACT_LAND] = {ACT_IDLE, ACT_IDLE},
		[ACT_MP_CROUCH_IDLE] = {ACT_IDLE, ACT_IDLE},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, ACT_WALK}
	},
	glide = ACT_IDLE
}

ix.anim.SetModelClass("models/wn7new/combine_cremator/cremator.mdl", "cremator")

local movementBlacklist = {
--	[IN_JUMP] = true,
	[IN_SPEED] = true,
	[IN_RUN] = true,
	[IN_WALK] = true,
--	[IN_DUCK] = true
}

function PLUGIN:SetupMove(client, moveData, cmd)
	if (client:Team() == FACTION_CREMATOR and client:GetMoveType() != MOVETYPE_NOCLIP) then
		for key, _ in pairs(movementBlacklist) do
			if (moveData:KeyDown(key)) then
				moveData:SetButtons(bit.band(moveData:GetButtons(), bit.bnot(key)))
			end
		end
	end
end

function PLUGIN:InitializedPlugins()
	if (ix.plugin.list.inventoryslosts and FACTION_CREMATOR) then
		ix.plugin.list.inventoryslots.noEquipFactions[FACTION_CREMATOR] = true
	end
end