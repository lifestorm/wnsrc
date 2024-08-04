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

PLUGIN.name = "Character Playermodel Resize"
PLUGIN.author = "M!NT"
PLUGIN.description = "Resizes a character's playermodel based on their actual IC height."

ix.config.Add("ModelScalingEnable", true, "Allows the server to scale playermodels depending on their height selected during character creation.",
	function(oldVal, newVal)
		if (!SERVER) then return end
		for _, v in ipairs(player.GetAll()) do
			if (v:GetCharacter()) then
				PLUGIN:resizeCharacter(v:GetCharacter())
			end
		end
	end, {
	category = "Resize"
})

ix.config.Add("ModelScalingMinInches", 58, "Minimum bounds for character height (in inches).",
	function(oldVal, newVal)
		if (!SERVER) then return end
		for _, v in ipairs(player.GetAll()) do
			if (v:GetCharacter()) then
				PLUGIN:resizeCharacter(v:GetCharacter())
			end
		end
	end, {
	data = {min = 50, max = 70},
	category = "Resize"
})

ix.config.Add("ModelScalingMin", 0.85, "Minimum bounds for character height (in real scale).",
	function(oldVal, newVal)
		if (!SERVER) then return end
		for _, v in ipairs(player.GetAll()) do
			if (v:GetCharacter()) then
				PLUGIN:resizeCharacter(v:GetCharacter())
			end
		end
	end, {
	data = {min = 0.5, max = 1.6, decimals = 2},
	category = "Resize"
})

ix.config.Add("ModelScalingMax", 1.3, "Maximum bounds for character height (in real scale).",
	function(oldVal, newVal)
		if (!SERVER) then return end
		for _, v in ipairs(player.GetAll()) do
			if (v:GetCharacter()) then
				PLUGIN:resizeCharacter(v:GetCharacter())
			end
		end
	end, {
	data = {min = 0.5, max = 2.1, decimals = 2},
	category = "Resize"
})

ix.config.Add("ModelScalingMaxInches", 78, "Maximum bounds for character height (in inches).",
	function(oldVal, newVal)
		if (!SERVER) then return end
		for _, v in ipairs(player.GetAll()) do
			if (v:GetCharacter()) then
				PLUGIN:resizeCharacter(v:GetCharacter())
			end
		end
	end, {
	data = {min = 65, max = 85},
	category = "Resize"
})

ix.config.Add("ModelScalingSexOffset", 0.1, "Offset extra height given to females (bc their base models are smaller)",
	function(oldVal, newVal)
		if (!SERVER) then return end
		for _, v in ipairs(player.GetAll()) do
			if (v:GetCharacter()) then
				PLUGIN:resizeCharacter(v:GetCharacter())
			end
		end
	end, {
	data = {min = 0.01, max = 2, decimals = 2},
	category = "Resize"
})

ix.util.Include("sv_hooks.lua")
