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

local COLOR_MODIFY = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = 0,
	["$pp_colour_contrast"] = 1,
	["$pp_colour_colour"] = 0,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}

PLUGIN.currentType = ix.inebriation.types.SOBER

function PLUGIN:HUDPaint()
	if (IsValid(LocalPlayer())) then
        if (PLUGIN.textAlpha and PLUGIN.textAlpha > 0) then
            draw.SimpleText(
                PLUGIN.currentType.description or "",
                "WNBleedingTextBold",
                ScrW() * 0.5,
                ScrH() - SScaleMin(135 / 3),
                Color(255, 78, 69, PLUGIN.textAlpha or 0),
                TEXT_ALIGN_CENTER
            )
        end
	end
end

local drunkColor = Color(69, 255, 69)
function PLUGIN:PopulateCharacterInfo(client, character, tooltip)
    local inebriation = client:GetInebriation()
    if (inebriation < 10) then return end

    local _type = ix.inebriation:GetType(inebriation)
	if (client:GetInebriation() > 40) then
		local drunkText = tooltip:AddRowAfter("name", "drunk")
		drunkText:SetBackgroundColor(drunkColor)
		drunkText:SetText("Appears to be "..string.lower(_type.name)..".")
		drunkText:SizeToContents()
	end
end

function PLUGIN:Think()
    local inebriation = LocalPlayer():GetInebriation()
    if (inebriation < 10) then return end

    local lerpTo = 0
    local _type = ix.inebriation:GetType(inebriation)
    if (_type != PLUGIN.currentType) then
        PLUGIN.currentType = _type
        PLUGIN.textAlpha = 0
        PLUGIN.changeTime = SysTime()
        PLUGIN.animateTime = SysTime()
        PLUGIN.textShouldFadeOut = true
    elseif (SysTime() - PLUGIN.changeTime > 15) then
        lerpTo = 0
        if (PLUGIN.textShouldFadeOut) then
            PLUGIN.textShouldFadeOut = false
            PLUGIN.animateTime = SysTime()
        end
    else
        lerpTo = 255
    end

    PLUGIN.textAlpha = Lerp((SysTime() - PLUGIN.animateTime) / 0.9, PLUGIN.textAlpha, lerpTo)
end

function PLUGIN:RenderScreenspaceEffects()
    local _ineb = LocalPlayer():GetInebriation()
    if (_ineb < 10) then return end

    local percent = math.Clamp(_ineb / 100, 0, 1)
    local cMul = 1 - percent
    COLOR_MODIFY["$pp_colour_mulr"] = cMul
    COLOR_MODIFY["$pp_colour_mulg"] = cMul
    COLOR_MODIFY["$pp_colour_mulb"] = cMul

    DrawColorModify(COLOR_MODIFY)
    DrawBloom(0.5, percent * 0.5, 9, 7, 5, 1, 1, 1, 1)
    DrawMaterialOverlay("effects/water_warp01", percent * 0.05)
    DrawBokehDOF(3 * percent, 1, 12 * percent)
end