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

PLUGIN.stopDraw = 0

local COLOR_BLACK_WHITE = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = -0.1,
	["$pp_colour_contrast"] = 0.9,
	["$pp_colour_colour"] = 0,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}

function PLUGIN:HUDPaint()
	if (IsValid(LocalPlayer()) and LocalPlayer():IsAFK() and LocalPlayer():GetAimVector() and self.stopDraw < CurTime()) then
		draw.SimpleText(
			"YOU ARE AFK",
			"HUDFontExtraLargeNoClamp",
			ScrW() * 0.5,
			ScrH() - SScaleMin(230 / 3),
			Color(255, 255, 255, 255),
			TEXT_ALIGN_CENTER
		)
		draw.SimpleText(
			"Timers for Hunger, Thirst, and Rations are paused",
			"WNBleedingTextNoClamp",
			ScrW() * 0.5,
			ScrH() - SScaleMin(165 / 3),
			Color(255, 255, 255, 255),
			TEXT_ALIGN_CENTER
		)
		draw.SimpleText(
			"You may be kicked",
			"WNBleedingTextNoClamp",
			ScrW() * 0.5,
			ScrH() - SScaleMin(135 / 3),
			Color(255, 78, 69, 255),
			TEXT_ALIGN_CENTER
		)
	end
end

local afkColor = Color(255, 78, 69, 255)
function PLUGIN:PopulateCharacterInfo(client, character, tooltip)
	if (client:IsAFK()) then
		local afk = tooltip:AddRowAfter("name", "afk")
		afk:SetBackgroundColor(afkColor)
		afk:SetText(L("playerIsAFK"))
		afk:SizeToContents()
	end
end

function PLUGIN:GetPlayerESPText(client, toDraw, distance, alphaFar, alphaMid, alphaClose)
	if (client:IsAFK()) then
		toDraw[#toDraw + 1] = {alpha = alphaFar, priority = 2, text = "AFK - "..math.floor(client:GetNetVar("afkTime", 0) / 60).."m"}
	end
end

function PLUGIN:Think()
	if (LocalPlayer():IsAFK()) then
		if ((!self.aimVector or !self.posVector) and self.stopDraw < CurTime()) then
			self.aimVector = LocalPlayer():GetAimVector()
			self.posVector = LocalPlayer():GetPos()
		elseif (self.aimVector != LocalPlayer():GetAimVector() or
				self.posVector != LocalPlayer():GetPos()) then
			self.stopDraw = CurTime() + 5
			self.aimVector = nil
			self.posVector = nil
		end
	end
end

function PLUGIN:RenderScreenspaceEffects()
	if (LocalPlayer():IsAFK() and self.stopDraw < CurTime()) then
		DrawColorModify(COLOR_BLACK_WHITE)
	end
end

net.Receive("ixPrintAfkPlayers", function()
	local text = net.ReadString()
	chat.AddText(Color(255,255,255), text)
end)
