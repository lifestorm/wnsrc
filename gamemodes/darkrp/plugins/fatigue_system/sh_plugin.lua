--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Fatigue System"
PLUGIN.author = "LegAz"
PLUGIN.description = "Adds character \"energy\" var that influences several other mechanichs."

function PLUGIN:SetupAreaProperties()
	ix.area.AddType("rpArea")
end

function PLUGIN:StartCommand(client, userCmd)
	if (client:GetNetVar("actEnterAngle") and userCmd:KeyDown(IN_DUCK)) then
		userCmd:RemoveKey(IN_DUCK)
	end
end

-- I would've united all resting entities into one instead of creating this func and funcs alike, but this will result in admins having to place all resting entities again
function PLUGIN:FindModelActSequences(client, actName)
	local modelClass = ix.anim.GetModelClass(client:GetModel())
	local sequences = ix.act.stored[actName][modelClass]

	return sequences and sequences.sequence or false
end

ix.util.Include("meta/sh_player.lua")
ix.util.Include("meta/sh_character.lua")

ix.util.Include("sh_config.lua")
ix.util.Include("sh_overrides.lua")
ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_plugin.lua")
ix.util.Include("sv_hooks.lua")

ix.command.Add("CharSetEnergy", {
	description = "Set characters current energy level.",
	privelege = "Manage Character Energy",
	adminOnly = true,
	arguments = {
		ix.type.character,
		ix.type.number
	},
	OnRun = function(self, client, target, energyLevel)
		local clientName, targetName = client:GetName(), target:GetName()
		local targetPlayer = target:GetPlayer()
		energyLevel = math.Clamp(energyLevel, 0, 200)

		target:SetEnergy(energyLevel)

		for _, v in ipairs(player.GetAll()) do
			if (self:OnCheckAccess(v) or v == targetPlayer) then
				v:Notify(string.format("%s changed energy level of %s.", clientName, targetName))
			end
		end

		ix.log.Add(client, "energy", clientName, targetName, energyLevel)
	end
})
