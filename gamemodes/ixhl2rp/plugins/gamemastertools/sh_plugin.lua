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

PLUGIN.name = "Gamemaster Tools"
PLUGIN.author = "Fruity"
PLUGIN.description = "Allows gamemasters to view info about characters concerning their backstory etc."

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")

ix.command.Add("ViewInfo", {
	description = "View info about characters concerning backstory etc. as gamemaster.",
	adminOnly = true,
	arguments = ix.type.character,
	OnRun = function(self, client, target)
		if (target) then
			local skillLevels = {}
			for skill, _ in pairs(target:GetSkill()) do
				skillLevels[skill] = target:GetSkillLevel(skill)
			end

			netstream.Start(client, "OpenGMInfo", target.player, {
				name = target:GetName(),
				gender = target:GetGender(),
				description = target:GetDescription(),
				money = target:GetMoney(),
				background = target:GetBackground(),
				skillLvl = skillLevels,
				faction = target:GetFaction(),
				special = target:GetSpecial(),
				genericData = target:GetGenericdata(),
				info = target:GetGmInfo(),
				age = target:GetAge(),
				height = target:GetHeight(),
				eyeColor = target:GetEyeColor(),
				createInfo = target:GetCreateTime()
			})
		end
	end
})

ix.char.RegisterVar("gmInfo", {
	field = "gmInfo",
	fieldType = ix.type.text,
	default = "",
	bNoNetworking = true,
	bNoDisplay = true
})