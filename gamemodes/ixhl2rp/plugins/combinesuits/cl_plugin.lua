--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local math = math
local Vector = Vector
local ix = ix
local Color = Color
local ipairs = ipairs
local surface = surface
local net = net
local IsValid = IsValid
local netstream = netstream
local unpack = unpack

local red = Color(255, 0, 0, 255)
local blue = Color(0, 125, 255, 255)

function PLUGIN:RenderESPNames(bIsOTA)
    local right = LocalPlayer():GetRight() * 25
    local scrW, scrH = ScrW(), ScrH()
    local marginX, marginY = scrH * .1, scrH * .1
    
    for _, v in ipairs(self.names) do
        local ply, teamColor, distance = v[1], (v[2] and red) or (v[3] and blue), math.sqrt(v[4])
        local plyPos = ply:GetPos()
        
        local min, max = ply:GetModelRenderBounds()
        min = min + plyPos + right
        max = max + plyPos + right
        
        local barMin = Vector((min.x + max.x) / 2, (min.y + max.y) / 2, min.z):ToScreen()
        local barMax = Vector((min.x + max.x) / 2, (min.y + max.y) / 2, max.z):ToScreen()
        local eyePos = ply:EyePos():ToScreen()
        local rightS = math.min(math.max(barMin.x, barMax.x), eyePos.x + 150)
        
        local barWidth = math.Remap(math.Clamp(distance, 500, 1000), 500, 1000, 120, 75)
        local barHeight = math.abs(barMax.y - barMin.y)
        local barX, barY = math.Clamp(rightS, marginX, scrW - marginX - barWidth),  math.Clamp(barMin.y - barHeight + 18, marginY, scrH - marginY)
        
        local alpha = math.Remap(math.Clamp(distance, 500, 1000), 500, 1000, 255, 0)
        
        if (bIsOTA and v[2]) then
            local bArmor = ply:Armor() > 0
            surface.SetDrawColor(40, 40, 40, 200 * alpha / 255)
            surface.DrawRect(barX - 1, barY - 1, barWidth + 2, 5)
            if (bArmor) then surface.DrawRect(barX - 1, barY + 9, barWidth + 2, 5)  end

            surface.SetDrawColor(teamColor.r * 1.6, teamColor.g * 1.6, teamColor.b * 1.6, alpha)
            surface.DrawRect(barX, barY, barWidth * math.Clamp(ply:Health() / ply:GetMaxHealth(), 0, 1), 3)
            
            if (bArmor) then
                extraHeight = 10
                surface.SetDrawColor(255, 255, 255, alpha)
                surface.DrawRect(barX, barY + 10, barWidth * math.Clamp(ply:Armor() / 50, 0, 1), 3)
            end
        end
        
        surface.SetFont("ixGenericFont")
        local width, height = surface.GetTextSize(ply:Name())
        
        surface.SetDrawColor(0, 0, 0, 175)
        surface.DrawRect(barX - 5, barY - 13 - height / 2, width + 10, height + 2)
        ix.util.DrawText(ply:Name(), barX, barY - 13, teamColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, "ixGenericFont", 255)
    end
end

function PLUGIN:RenderESPAimpoints()
    for _, v in ipairs(self.aimPoints) do
        local x, y = v[1], v[2]

        surface.SetDrawColor(red)
        surface.DrawLine(x + 10, y, x - 10, y)
        surface.DrawLine(x, y + 10, x, y - 10)
        if (v[3]) then
            surface.DrawOutlinedRect(x - 5, y - 5, 11, 11)
        end

        surface.SetFont("BudgetLabel")
        surface.SetTextColor(red)
        local width = surface.GetTextSize(v[4])
        surface.SetTextPos(x - width / 2, y + 17)
        surface.DrawText(v[4])
    end
end

net.Receive("ixVisorNotify", function(len)
    if (IsValid(ix.gui.visor)) then
        ix.gui.visor:Open()
    end
end)

netstream.Hook("CombineDisplayMessage", function(text, color, location, arguments, bObjective)
    if (!LocalPlayer():HasActiveCombineMask() and !LocalPlayer():IsDispatch()) then
		return
	end

    local client = LocalPlayer()
    local character = client:GetCharacter()

	if (IsValid(ix.gui.combine)) then
		ix.gui.combine:AddLine(text, color, location, unpack(arguments))
	end

    if bObjective and character:IsCombine() then
        vgui.Create("ixObjectiveUpdate")
    end
end)

netstream.Hook("ImportantCombineDisplayMessage", function(text, color, location, arguments)
	if (IsValid(ix.gui.combine)) then
		ix.gui.combine:AddImportantLine(text, color, location, unpack(arguments))
	end
end)