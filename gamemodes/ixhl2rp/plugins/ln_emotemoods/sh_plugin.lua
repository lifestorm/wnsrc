--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "LN | Emote Moods"
PLUGIN.author = "Aspect™ & Scotnay"
PLUGIN.description = "Gives the ability to players to change their mood and in turn some of their animations."

ix.util.Include("sv_hooks.lua")
ix.util.Include("sh_commands.lua")

PLUGIN.personaTypes = {
	["DEFAULT"] = true,
	["RELAXED"] = true,
	["HEADSTRONG"] = true,
	["SCARED"] = true,
	["FRUSTRATED"] = true,
	["OTAR"] = true
}

PLUGIN.lookupTable = {}

PLUGIN.lookupTable["RELAXED"] = {
	["idle"] = "LineIdle01",
	["walk"] = "walk_all_Moderate",
}

PLUGIN.lookupTable["RELAXEF"] = {
	["idle"] = "LineIdle01",
	["walk"] = "walk_all_Moderate",
}

PLUGIN.lookupTable["HEADSTRONG"] = {
	["idle"] = "idle_subtle",
	["run"] = "run_all_panicked",
}

PLUGIN.lookupTable["HEADSTRONGF"] = {
	["idle"] = "idle_subtle",
	["run"] = "run_panicked_2_all",
}

PLUGIN.lookupTable["SCARED"] = {
	["idle"] = "scaredidle",
	["run"] = "run_protected_all",
}

PLUGIN.lookupTable["SCAREDF"] = {
	["run"] = "run_protected_all",
}

PLUGIN.lookupTable["FRUSTRATED"] = {
	["idle"] = "LineIdle02",
	["walk"] = "pace_all",
}

PLUGIN.lookupTable["FRUSTRATEDF"] = {
	["idle"] = "willard_female_stand04",
}

PLUGIN.lookupTable["OTAR"] = {
	["idle"] = "Idle01",
	["walk"] = "walkeasy_all",
}

local vectorAngle = FindMetaTable("Vector").Angle
local normalAngle = math.NormalizeAngle

function PLUGIN:CalcMainActivity(client, velocity)
	if (client:GetNetVar("characterMood") and !client:GetNetVar("forcedSequence")) then
		local eyeAngle = client:EyeAngles()
		local yaw = vectorAngle(velocity)[2]
		local normal = normalAngle(yaw - eyeAngle[2])

		client:SetPoseParameter("move_yaw", normal)

		if (client:GetActiveWeapon() == NULL) then
			return
		end

		local mood = client:GetNetVar("characterMood")
		local moodTab = self.lookupTable[mood]

		if (!moodTab) then
			return
		end

		client.calcIdeal = ACT_IDLE
		client.calcSeqOverride = -1

		local baseClass = GAMEMODE.BaseClass

		if (!baseClass:HandlePlayerDriving(client) and !baseClass:HandlePlayerDucking(client, velocity) and!baseClass:HandlePlayerJumping(client, velocity) and !baseClass:HandlePlayerSwimming(client)) then
			if (velocity:Length2D() < 0.5 and client:GetActiveWeapon():GetClass() == "ix_hands") then
				client.calcSeqOverride = moodTab["idle"]
			elseif (velocity:Length2D() >= 0.5 and !client:IsRunning() and client:GetActiveWeapon():GetClass() == "ix_hands") then
				if (!client:IsOnGround()) then
					return
				end

				client.calcSeqOverride = moodTab["walk"]
			elseif (client:IsRunning()) then
				client.calcSeqOverride = moodTab["run"]
			end
		end
	end

	if (client.calcSeqOverride != -1 and isstring(client.calcSeqOverride)) then
		client.calcSeqOverride = client:LookupSequence(client.calcSeqOverride)
		
		return client.calcIdeal, client.calcSeqOverride
	end
end
