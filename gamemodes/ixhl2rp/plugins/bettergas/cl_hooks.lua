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
local L = L
local string = string
local timer = timer
local LocalPlayer = LocalPlayer
local CreateSound = CreateSound
local surface = surface
local ScrW, ScrH = ScrW, ScrH
local Color = Color
local ix = ix

local PLUGIN = PLUGIN

function PLUGIN:AdjustGasPoints(points)
    if (!points) then return 0 end

    if (points >= self.LETHAL_GAS) then return 1, true end
    if (points <= 0) then return 0 end

    local fl, cl = math.floor(points), math.ceil(points)
    local divideBy = points >= 60 and PLUGIN.LETHAL_GAS or 61
    if (fl == cl) then
        return PLUGIN.gasToCooldown[fl] / PLUGIN.gasToCooldown[divideBy], points >= 60
    else
        return math.Remap(points, fl, cl, PLUGIN.gasToCooldown[fl], PLUGIN.gasToCooldown[cl]) / PLUGIN.gasToCooldown[divideBy], points >= 60
    end
end

local gasMaterial = ix.util.GetMaterial("willardnetworks/nlrbleedout/gas-background.png")
function PLUGIN:DrawHUDOverlays(client, character)
    local gasPoints = math.min(character:GetGasPoints() / self.LETHAL_GAS, 1)
    if (gasPoints > 0.2) then
        surface.SetDrawColor(Color(255, 255, 255, math.Remap(gasPoints, 0.2, 1, 0, 255)))
        surface.SetMaterial(gasMaterial)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    end
end

local gasIcon = ix.util.GetMaterial("willardnetworks/hud/toxic.png")
function PLUGIN:DrawBars(client, character, alwaysShow, minimalShow, DrawBar)
    local faction = ix.faction.Get(client:Team())
    if (!faction or faction.noGas) then return end

    local gasPoints, secondary =  self:AdjustGasPoints(character:GetGasPoints())
    if (alwaysShow or gasPoints > 0 and !(secondary and gasPoints == 1)) then
        if (alwaysShow or !minimalShow or (gasPoints > 0.5 and !secondary)) then
            if (!secondary) then
                DrawBar(gasIcon, gasPoints)
            else
                DrawBar(gasIcon, 1, nil, gasPoints)
            end
        end
    end
end

function PLUGIN:DrawAlertBars(client, character, DrawBar)
    local faction = ix.faction.Get(client:Team())
    if (!faction or faction.noGas) then return end

    local gasPoints, secondary =  self:AdjustGasPoints(character:GetGasPoints())
    if (secondary) then
        DrawBar(L(gasPoints >= 1 and "gasLethal" or "gasHigh"))
    end
end

function PLUGIN:GetPlayerESPText(client, toDraw, distance, alphaFar, alphaMid, alphaClose)
    local character = client:GetCharacter()
    local gasPoints = character:GetGasPoints()
    if (gasPoints >= self.LETHAL_GAS) then
        toDraw[#toDraw + 1] = {alpha = alphaMid, priority = 16, text = string.format("Gas: LETHAL (%dm left)", math.ceil(180 - gasPoints))}
    elseif (gasPoints > 0) then
		toDraw[#toDraw + 1] = {alpha = alphaClose, priority = 24, text = "Gas: "..math.Round(character:GetGasPoints(), 1)}
	end
end

local heartbeatSound
local breathingSound
local breathingPlaying = false
function PLUGIN:InitPostEntity()
    timer.Create("ixBetterGasHeartbeat", 5, 0, function()
        local client = LocalPlayer()
        local faction = ix.faction.Get(client:Team())
        if (faction and faction.noGas) then return end

        local timerDelay = 60
        local playedHeartbeatSound = false

		if (client:Alive() and client:GetCharacter()) then
			local gasPointFraction = math.min(client:GetCharacter():GetGasPoints() / self.LETHAL_GAS, 1)
			if (gasPointFraction > 0.5) then
				if (!heartbeatSound) then
					heartbeatSound = CreateSound(client, "player/heartbeat1.wav")
				end

                timerDelay = 0.75 + math.Remap(gasPointFraction, 0.5, 1, 1.25, 0)
                heartbeatSound:PlayEx(math.Remap(gasPointFraction, 0.5, 1, 0.05, 0.75), 100)
				playedHeartbeatSound = true
			end
		end

        if (!playedHeartbeatSound and heartbeatSound) then
			heartbeatSound:Stop()
		end

        timer.Adjust("ixBetterGasHeartbeat", timerDelay)
    end)

    timer.Create("ixBetterGasBreathing", 5, 0, function()
        local client = LocalPlayer()
        local faction = ix.faction.Get(client:Team())
        if (faction and faction.noGas) then return end

        if (breathingPlaying) then
            breathingSound:Stop()
            timer.Adjust("ixBetterGasBreathing", 5)
        end

        if (client:Alive() and client:GetCharacter()) then
            local gasPointFraction = math.min(client:GetCharacter():GetGasPoints() / 100, 1)
            if (gasPointFraction > 0.3) then
                if (!breathingSound) then
                    breathingSound = CreateSound(client, "player/breathe1.wav")
                end

                local clamped = math.Clamp(gasPointFraction, 0.3, 1)
                if (!breathingPlaying and math.Remap(clamped, 0.3, 1, 0, 1) >= math.random()) then
                    local delay = math.Remap(clamped, 0.3, 1, 60, 20)
                    local duration = math.Remap(clamped, 0.3, 1, 3, 20)
                    breathingSound:PlayEx(math.Remap(clamped, 0.3, 1, 0.05, 0.75), 100)
                    breathingPlaying = true
                    if (duration < delay) then
                        timer.Simple(duration, function()
                            breathingSound:Stop()
                            breathingPlaying = false
                        end)
                    end

                    timer.Adjust("ixBetterGasBreathing", delay)
                    return
                end

                timer.Adjust("ixBetterGasBreathing", 5)
            else
                timer.Adjust("ixBetterGasBreathing", 60)
            end
        end
    end)
end

PLUGIN.OnReloaded = PLUGIN.InitPostEntity