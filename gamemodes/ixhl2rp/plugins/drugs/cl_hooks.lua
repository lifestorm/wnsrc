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
					if (ix.option.Get("drugEffects", true) == false) then
						local drugHighText = "You are currently high!"

						surface.SetTextColor(239, 37, 14)
						surface.SetFont("HUDFontExtraLarge")
						surface.SetTextPos(ScrW() / 2 - (surface.GetTextSize(drugHighText) / 2), 0 + SScaleMin(100 / 3))
						surface.DrawText(drugHighText)

						surface.SetDrawColor(239, 37, 14, 200)
						surface.DrawOutlinedRect(0, 0, ScrW(), ScrH(), 10)

						return
					end

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

	if (!table.IsEmpty(drugEffects) or client:GetNetVar("ixRave") or client:GetNetVar("ixSapphireDrug") and !client:GetNetVar("ixMaskEquipped")) then
		local row = tooltip:AddRow("drug")
		row:SetText("This figure is clearly high")
		row:SetBackgroundColor(Color(215, 0, 215, 255))
		row:SizeToContents()
	end
end
