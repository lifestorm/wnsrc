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

-- Glasses stuff
ix.option.Add("useImmersiveGlasses", ix.type.bool, true, {
	category = "appearance",
	hidden = function()
		return ix.config.Get("forceImmersiveGlasses")
	end
})

netstream.Hook("OpenBeardStyling", function(target)
	if (IsValid(ix.gui.menu)) then
		ix.gui.menu:Remove()
	end

	if IsValid(beardStyling) then
        beardStyling:Remove()
    end

	local beardStyling = vgui.Create("BeardStyling")
	beardStyling:CustomInit(target)
end)

netstream.Hook("GetStylingConfirmation", function(attempter)
	Derma_Query("Someone wants to style your hair/beard! Allow?", "Hair/Beard Styling", "Allow", function()
		netstream.Start("AcceptStyling", attempter)
	end, "Disallow")
end)

-- Called when blurry screen space effects should be rendered.
function PLUGIN:RenderScreenspaceEffects()
	if (!ix.config.Get("forceImmersiveGlasses")) then
		if (!ix.option.Get("useImmersiveGlasses", true)) then return end
	end

	local client = LocalPlayer()
	if (client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle()) then return end

	local character = client:GetCharacter()
	if (!character) then return end

	local needsGlasses = character:GetGlasses()
	local hasGlasses = character:HasGlasses()
	if ((needsGlasses and !hasGlasses) or (!needsGlasses and hasGlasses)) then
		DrawToyTown(28,ScrH())
	end
end
