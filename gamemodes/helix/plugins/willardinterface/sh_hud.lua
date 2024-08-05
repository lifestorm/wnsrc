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

ix.lang.AddTable("english", {
	optHUDMinimalShow = "Use Minimal Info Bars",
	optdHUDMinimalShow = "Will lessen how often your HUD info bars are shown by limiting them to only show when required.",
	optHUDScalePercent = "User Interface Scale",
	optdHUDScalePercent = "Scale your user interface to be larger or smaller, based on your preference.",
	optHUDPosition = "Info Bar Position",
	optdHUDPosition = "Choose where to display the HUD info bars on your screen.",
	optAmmoPosition = "Ammo Bar Position",
	optdAmmoPosition = "Choose where to display the ammo bar on your screen."
})

ix.lang.AddTable("spanish", {
	optdAmmoPosition = "Elige donde mostrar la barra de munición en tu pantalla.",
	optHUDPosition = "Posición de la Barra de Información",
	optdHUDScalePercent = "Re-escala tu interfaz de usuario para hacerla más grande o más pequeña, según tu preferencia.",
	optAmmoPosition = "Posición de la Barra de Munición",
	optHUDScalePercent = "Escala de la Interfaz de Usuario",
	optdHUDPosition = "Elige donde mostrar las barras de información de la HUD en tu pantalla.",
	optHUDMinimalShow = "Usar Barras de Información Minimalistas",
	optdHUDMinimalShow = "Reducirá las veces que tus barras de información son mostradas en pantalla, limitándolas de forma que solo aparecerán cuando sean necesarias."
})

if (CLIENT) then
	local staminaIcon = ix.util.GetMaterial("willardnetworks/hud/stamina.png")
	local vortIcon = ix.util.GetMaterial("willardnetworks/tabmenu/inventory/inv_vort.png")

	local yellow = Color(255, 204, 0, 255)
	local fakeHealthColor = Color(253, 161, 0, 255)
	local background = Color(0, 0, 0, 128)

	local paddingX, paddingY = SScaleMin(30 / 3), SScaleMin(30 / 3)
	local iconW, iconH = SScaleMin(14 / 3), SScaleMin(14 / 3)
	local iconRightPadding = SScaleMin(10 / 3)
	local iconBottomPadding = SScaleMin(10 / 3)
	local barWidth = SScaleMin(115 / 3)
	local barHeight = iconH / 2
	local yaw = 0

	local function CreateRow(icon, value, secondaryEnd, secondaryOverlap)
		local scale = ix.option.Get("HUDScalePercent")
		local x = paddingX + ((iconW / 100) * scale) + ((iconRightPadding / 100) * scale)
		local y = paddingY + ((yaw / 100) * scale) + (iconH / 2) - ((iconH / 2) - (barHeight / 2))
		local w = barWidth * math.Clamp(value, 0, 1)
		local h = barHeight
		local configpos = ix.option.Get("HUDPosition")
		local hudposX, hudposY = 0, 0

		if configpos == "Top Right" then
			hudposX = ScrW() - x - ((barWidth / 100) * scale) - paddingX
		elseif configpos == "Bottom Right" then
			hudposX = ScrW() - x - ((barWidth / 100) * scale) - paddingX
			hudposY = ScrH() - y - barHeight - paddingY - ((yaw / 100) * scale)
		elseif configpos == "Bottom Left" then
			hudposY = ScrH() - y - barHeight - paddingY - ((yaw / 100) * scale)
		end

		-- Draw icon
		surface.SetDrawColor(color_white)
		surface.SetMaterial(icon)
		surface.DrawTexturedRect(paddingX + hudposX, paddingY + ((yaw / 100) * scale) + hudposY, (iconW / 100) * scale, (iconH / 100) * scale)

		-- Bar background
		surface.SetDrawColor(background)
		surface.DrawRect(x + hudposX, y + hudposY, (barWidth / 100 * scale), (h / 100) * scale)

		-- Draw behind primary bar so it 'sticks' out at the end
		if (secondaryEnd and secondaryEnd > value) then
			surface.SetDrawColor(fakeHealthColor)
			surface.DrawRect(x + hudposX, y + hudposY, (barWidth * math.Clamp(secondaryEnd, 0, 1) / 100) * scale, (h / 100) * scale)
		end

		-- Actual info
		surface.SetDrawColor(yellow)
		surface.DrawRect(x + hudposX, y + hudposY, (w / 100) * scale, (h / 100) * scale)

		-- Draw over primary bar so it overlaps at the beginning
		if (secondaryOverlap) then
			surface.SetDrawColor(fakeHealthColor)
			surface.DrawRect(x + hudposX, y + hudposY, (barWidth * math.Clamp(secondaryOverlap, 0, 1) / 100) * scale, (h / 100) * scale)
		end

		yaw = yaw + iconH + iconBottomPadding
	end

	local function CreateAlertRow(value, bFlash)
		local scale = ix.option.Get("HUDScalePercent")
		local bleedingRectH = SScaleMin(20 / 3)
		local x = paddingX + ((iconW / 100) * scale) + ((iconRightPadding / 100) * scale)
		local y = paddingY + ((yaw / 100) * scale) + (iconH / 2) - ((iconH / 2) - (barHeight / 2))
		local configpos = ix.option.Get("HUDPosition")
		local hudposX, hudposY = 0, 0

		if configpos == "Top Right" then
			hudposX = ScrW() - x - ((barWidth / 100) * scale) - paddingX
		elseif configpos == "Bottom Right" then
			hudposX = ScrW() - x - ((barWidth / 100) * scale) - paddingX
			hudposY = ScrH() - y - bleedingRectH - paddingY - ((yaw / 100) * scale)
		elseif configpos == "Bottom Left" then
			hudposY = ScrH() - y - bleedingRectH - paddingY - ((yaw / 100) * scale)
		end

		local newWidth = ((barWidth + iconRightPadding + iconW) / 100) * scale
		local newHeight = (bleedingRectH / 100) * scale
		if (bFlash) then
			local sin = math.sin(CurTime() * 10)
			draw.RoundedBox(4, paddingX + hudposX, y + hudposY, newWidth, newHeight, Color(255, math.Remap(sin, -1, 1, 78, 150), math.Remap(sin, -1, 1, 69, 150), 255))
		else
			draw.RoundedBox(4, paddingX + hudposX, y + hudposY, newWidth, newHeight, Color(255, 78, 69, 255))
		end

		surface.SetFont("HUDBleedingFontBold")
		surface.SetTextColor( 255, 255, 255 )

		local txWidth = surface.GetTextSize(value)
		surface.SetTextPos(paddingX + hudposX + (newWidth - txWidth) / 2, y + hudposY + (newHeight * 0.15))
		surface.DrawText(value)

		yaw = yaw + newHeight + iconBottomPadding
	end

	do
		ix.option.Add("HUDMinimalShow", ix.type.bool, false, {
			category = "appearance"
		})

		ix.option.Add("HUDScalePercent", ix.type.number, 100, {
			category = "appearance",
			min = 0, max = 100, decimals = 0, OnChanged = function()
				surface.CreateFont( "HUDBleedingFontBold", {
					font = "Open Sans Bold",
					extended = false,
					size = (SScaleMin(15 / 3) / 100) * ix.option.Get("HUDScalePercent"),
					weight = 550,
					antialias = true,
				} )
			end
		})

		ix.option.Add("HUDPosition", ix.type.array, "Top Left", {
			category = "appearance",
			populate = function()
				local entries = {}

				for _, v in SortedPairs({"Top Left", "Top Right", "Bottom Left", "Bottom Right"}) do
					local name = v
					local name2 = v:utf8sub(1, 1):utf8upper() .. v:utf8sub(2)

					if (name) then
						name = name
					else
						name = name2
					end

					entries[v] = name
				end

				return entries
			end
		})
		
		ix.option.Add("AmmoPosition", ix.type.array, "Bottom Right", {
			category = "appearance",
			populate = function()
				local entries = {}

				for _, v in SortedPairs({"Top Left", "Top Right", "Bottom Left", "Bottom Right"}) do
					local name = v
					local name2 = v:utf8sub(1, 1):utf8upper() .. v:utf8sub(2)

					if (name) then
						name = name
					else
						name = name2
					end

					entries[v] = name
				end

				return entries
			end
		})

		surface.CreateFont( "HUDBleedingFontBold", {
			font = "Open Sans Bold",
			extended = false,
			size = (SScaleMin(15 / 3) / 100) * ix.option.Get("HUDScalePercent"),
			weight = 550,
			antialias = true,
		} )
	end

	function PLUGIN:HUDPaint()
		local client = LocalPlayer()
		local character = client:GetCharacter()
		if (!character) then return end

		yaw = 0
		hook.Run("DrawImportantBars", client, character, ix.option.Get("alwaysShowBars", true), ix.option.Get("HUDMinimalShow"), CreateRow)

		-- Stamina
		if (client:GetLocalVar("stm", 0) < 100 and ix.option.Get("StaminaBarEnabled", true)) then
			 CreateRow(staminaIcon, client:GetLocalVar("stm", 0) / 100)
		end
		-- Vorts
		if ix.plugin.Get("vortigaunts") then
			if character:IsVortigaunt() then
				CreateRow(vortIcon, character:GetVortalEnergy() / ix.config.Get("maxVortalEnergy", 100))
			end
		end

		hook.Run("DrawBars", client, character, ix.option.Get("alwaysShowBars", true), ix.option.Get("HUDMinimalShow"), CreateRow)
		hook.Run("DrawAlertBars", client, character, CreateAlertRow)

		hook.Run("DrawHUDOverlays", client, character)

		ix.bar.newTotalHeight = yaw + paddingY
	end
end
