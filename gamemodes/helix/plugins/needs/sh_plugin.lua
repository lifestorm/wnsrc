--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Needs"
PLUGIN.author = "Gr4Ss"
PLUGIN.description = "Implements needs."

ix.char.RegisterVar("hunger", {
	field = "hunger",
	fieldType = ix.type.number,
	default = 0,
	isLocal = true,
	bNoDisplay = true
})

ix.char.RegisterVar("thirst", {
	field = "thirst",
	fieldType = ix.type.number,
	default = 0,
	isLocal = true,
	bNoDisplay = true
})

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Needs",
	MinAccess = "admin"
})

ix.config.Add("killOnMaxNeeds", false, "Enable players being killed when reaching max hunger or thirst", nil, {
	category = "needs"
})

ix.config.Add("needsPermaKill", false, "Enable players being perma-killed when reaching max hunger or thirst. Only works if 'killOnMaxNeeds' is enabled too!", nil, {
	category = "needs"
})

ix.config.Add("needsDeathDamage", 2, "The amount of damage to apply to players that are dying from max needs.", nil, {
	data = {min = 1, max = 5},
	category = "needs"
})

ix.config.Add("hungerHours", 6, "How many hours it takes for a player to gain 60 hunger", nil, {
	data = {min = 1, max = 24},
	category = "needs"
})

ix.config.Add("thirstHours", 4, "How many hours it takes for a player to gain 60 thirst", nil, {
	data = {min = 1, max = 24},
	category = "needs"
})

ix.config.Add("needsTickTime", 300, "How many seconds between each time a player's needs are calculated", nil, {
	data = {min = 60, max = 300},
	category = "needs"
})

ix.util.Include("sv_hooks.lua")

ix.command.Add("CharSetHunger", {
	description = "Set character's hunger",
	privilege = "Manage Needs",
	arguments = {
		ix.type.character,
		bit.bor(ix.type.number, ix.type.optional),
	},
	OnRun = function(self, client, character, level)
		character:SetHunger(level or 0)
		client:Notify(character:GetName().."'s hunger was set to "..(level or 0))
	end
})

ix.command.Add("CharSetThirst", {
	description = "Set character's thirst",
	privilege = "Manage Needs",
	arguments = {
		ix.type.character,
		bit.bor(ix.type.number, ix.type.optional),
	},
	OnRun = function(self, client, character, level)
		character:SetThirst(level or 0)
		client:Notify(character:GetName().."'s thirst was set to "..(level or 0))
	end
})

ix.command.Add("CharSetNeeds", {
	description = "Set character's thirst",
	privilege = "Manage Needs",
	arguments = {
		ix.type.character,
		bit.bor(ix.type.number, ix.type.optional),
	},
	OnRun = function(self, client, character, level)
		character:SetThirst(level or 0)
		character:SetHunger(level or 0)
		client:Notify(character:GetName().."'s needs were set to "..(level or 0))
	end
})

if (CLIENT) then
	local thirstIcon = ix.util.GetMaterial("willardnetworks/hud/thirst.png")
	local foodIcon = ix.util.GetMaterial("willardnetworks/hud/food.png")

	function PLUGIN:DrawBars(client, character, alwaysShow, minimalShow, DrawBar)
		local faction = ix.faction.Get(client:Team())
		if (!faction) then return end
		if (faction.noNeeds) then return end

		if (alwaysShow or character:GetHunger() > 20) then
			if (alwaysShow or !minimalShow or character:GetHunger() > 40) then
				 DrawBar(foodIcon, (100 - character:GetHunger()) / 100)
			end
		end
		if (alwaysShow or character:GetThirst() > 20) then
			if (alwaysShow or !minimalShow or character:GetThirst() > 40) then
				DrawBar(thirstIcon, (100 - character:GetThirst()) / 100)
			end
		end
	end

	function PLUGIN:RenderScreenspaceEffects()
		if (ix.option.Get("ColorModify", true)) then
			local character = LocalPlayer():GetCharacter()

			if (character) then
				local needsSum = character:GetHunger() + character:GetThirst()

				if (needsSum >= 100) then
					DrawColorModify({
						["$pp_colour_addr"] = 0,
						["$pp_colour_addg"] = 0,
						["$pp_colour_addb"] = 0,
						["$pp_colour_brightness"] = 0,
						["$pp_colour_contrast"] = 1,
						["$pp_colour_colour"] = 1 - math.Remap(math.min(200, needsSum), 100, 200, 0, 0.9),
						["$pp_colour_mulr"] = 0,
						["$pp_colour_mulg"] = 0,
						["$pp_colour_mulb"] = 0
					})
				end
			end
		end
	end
end
