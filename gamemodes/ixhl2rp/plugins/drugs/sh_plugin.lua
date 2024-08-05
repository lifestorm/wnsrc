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

PLUGIN.name = "Drugs"
PLUGIN.author = "AleXXX_007"
PLUGIN.description = "Adds visual effects on certain items usage."

ix.option.Add("drugEffects", ix.type.bool, true, {
	category = "drugs"
})

local redUberMaterial = Material("effects/invuln_overlay_red.vmt")
local blueUberMaterial = Material("effects/invuln_overlay_blue.vmt")
local redMaterial = Material("effects/bleed_overlay.vmt")
local gasMaterial = Material("effects/gas_overlay.vmt")
local jarateUberMaterial = Material("effects/jarate_overlay.vmt")
local stealthMaterial = Material("effects/stealth_overlay.vmt")
local distort1Material = Material("effects/distortion_normal001.vmt")

PLUGIN.effects = {
	["sobel"] = function()
		DrawSobel(0.5)
	end,
	["sharpen"] = function()
		DrawSharpen(1.2, 1.2)
	end,
	["blackAndWhite"] = function()
		DrawColorModify({
			["$pp_colour_colour"] = 0
		})
	end,
	["saturated"] = function()
		DrawColorModify({
			["$pp_colour_colour"] = 3
		})
	end,
	["redtint"] = function()
		DrawColorModify({
			["$pp_colour_addr"] = 1.3
		})
	end,
	["greentint"] = function()
		DrawColorModify({
			["$pp_colour_addg"] = 1.3
		})
	end,
	["bluetint"] = function()
		DrawColorModify({
			["$pp_colour_addb"] = 1.3
		})
	end,
	["bloom"] = function()
		DrawBloom(0.5, 2, 9, 9, 1, 1, 1, 1, 1)
	end,
	["redUber"] = function()
		render.SetMaterial(redUberMaterial)
	end,
	["blueUber"] = function()
		render.SetMaterial(blueUberMaterial)
	end,
	["red"] = function()
		render.SetMaterial(redMaterial)
	end,
	["gas"] = function()
		render.SetMaterial(gasMaterial)
	end,
	["jarate"] = function()
		render.SetMaterial(jarateUberMaterial)
	end,
	["stealth"] = function()
		render.SetMaterial(stealthMaterial)
	end,
	["distort1"] = function()
		render.SetMaterial(distort1Material)
	end
}

--[[
	Simple texture may be registered by adding this:
	["redUber"] = function()
		render.SetMaterial("effect/path/here")
	end
--]]

ix.util.Include("cl_hooks.lua")
ix.util.Include("sv_hooks.lua")

ix.char.RegisterVar("drugEffects", {
	field = "drugEffects",
	default = {},
	bNoDisplay = true
})

do
	local COMMAND = {
		description = "@cmdRemoveDrugEffects",
		arguments = {
			ix.type.character
		},
		adminOnly = true
	}

	function COMMAND:OnRun(client, character)
		if (character) then
			character:SetDrugEffects({})
			if (character:GetPlayer() and ix.plugin.list.rave or character:GetPlayer() and ix.plugin.listravebutsapphire) then
				ix.plugin.list.rave:Clear(character:GetPlayer())
				ix.plugin.list.ravebutsapphire:Clear(character:GetPlayer())
			end

			client:Notify("Removed drug effects from "..character:GetName())
		end
	end

	ix.command.Add("RemoveDrugEffects", COMMAND)
end
