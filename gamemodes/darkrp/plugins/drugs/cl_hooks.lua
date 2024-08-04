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

function PLUGIN:RenderScreenspaceEffects()
	local character = LocalPlayer():GetCharacter()

	DrawColorModify({
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = 0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 1,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	})

	if (character) then
		local drugEffects = character:GetDrugEffects()

		if (!table.IsEmpty(drugEffects)) then
			for k, v in pairs(drugEffects) do
				local DrawEffect = PLUGIN.effects[k]

				if (v > os.time() and isfunction(DrawEffect)) then
					render.UpdateScreenEffectTexture()
					DrawEffect()
					render.DrawScreenQuad()
				end
			end
		end
	end
end

function PLUGIN:PopulateCharacterInfo(client, character, tooltip)
	local drugEffects = character:GetDrugEffects()

	if (!table.IsEmpty(drugEffects) or client:GetNetVar("ixRave") and !client:GetNetVar("ixMaskEquipped")) then
		local row = tooltip:AddRow("drug")
		row:SetText("Cette personne est intoxiquée.")
		row:SetBackgroundColor(Color(215, 0, 215, 255))
		row:SizeToContents()
	end
end
