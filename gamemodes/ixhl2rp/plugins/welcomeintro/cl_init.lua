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

local firstLabelText
local secondLabelDetails = {}
local thirdLabelDetails = {}
local firstDone = false
local clickedLastTick = false

surface.CreateFont( "WNTerminalMediumTextBold", {
	font = "Open Sans",
	extended = false,
	size = 48,
	weight = 700,
	scanlines = 2,
	antialias = true,
	outline = true
} )

local sounds = {
    [1] = 'music/stingers/hl1_stinger_song16.mp3',
    [2] = 'music/stingers/hl1_stinger_song27.mp3',
    [3] = 'music/stingers/hl1_stinger_song7.mp3',
    [4] = 'music/stingers/hl1_stinger_song8.mp3',
}

local keySounds = {
    [1] = 'ambient/machines/keyboard1_clicks.wav',
    [2] = 'ambient/machines/keyboard2_clicks.wav',
    [3] = 'ambient/machines/keyboard3_clicks.wav',
    [4] = 'ambient/machines/keyboard4_clicks.wav',
    [5] = 'ambient/machines/keyboard5_clicks.wav',
    [6] = 'ambient/machines/keyboard6_clicks.wav',
}

function PLUGIN:CharacterLoaded(char)
    timer.Simple(3, function()
        local scrw, scrh = ScrW(), ScrH()
        local container = vgui.Create("DPanel")
        local firstText = ":: SUBJECT ::"
        local client = LocalPlayer()
        container:SetPos(scrw * 0.325, scrh * 0.42)
        container:SetSize(scrw * 0.35, scrh * 0.4)
        --[[container.Paint = function(self, pw, ph)
            draw.RoundedBox(0, 0, 0, pw, ph, Color( 255, 255, 255 ))
        end--]]
        container.Paint = nil

        local firstLabel = container:Add("DLabel")
        firstLabel:Dock(TOP)
        firstLabel:SetHeight(scrh * 0.04)
        firstLabel:SetText("")
        firstLabel:SetFont("WNTerminalMediumTextBold")
        firstLabel:SetContentAlignment(8)
        firstLabel:SetColor(Color(41, 243, 229, 255))
        local secondLabel = container:Add("DLabel")
        secondLabel:Dock(TOP)
        secondLabel:SetText("")
        secondLabel:SetHeight(scrh * 0.03)
        secondLabel:SetFont("WNTerminalMediumSmallerText")
        secondLabel:SetContentAlignment(8)
        local thirdLabel = container:Add("DLabel")
        thirdLabel:Dock(TOP)
        thirdLabel:SetText("")
        thirdLabel:SetHeight(scrh * 0.03)
        thirdLabel:SetFont("WNTerminalMediumSmallerText")
        thirdLabel:SetContentAlignment(8)

        secondLabelDetails.text = "<:: " .. char:GetName() .. " ::>"
        secondLabelDetails.label = secondLabel
        secondLabelDetails.delay = 0.15
        secondLabelDetails.done = false

        thirdLabelDetails.text = "<:: #" .. (char:GetCid() or "") .. ", " .. (char:GetGender() or "") .. " ::>"
        thirdLabelDetails.label = thirdLabel
        thirdLabelDetails.delay = 0.15
        thirdLabelDetails.done = false

        if client:Team() == FACTION_OTA or client:Team() == FACTION_CREMATOR or client:Team() == FACTION_STALKER then
            firstText = ":: ASSET ::"
            firstLabel:SetColor(Color(245, 82, 71, 255))
            thirdLabelDetails.text = "<:: #" .. char:GetCid() .. " ::>"
        elseif client:Team() == FACTION_VORT then
            firstText = ":: VORTIGAUNT ::"
            firstLabel:SetColor(Color(199, 244, 125, 255))
            thirdLabelDetails.text = "<:: #" .. char:GetCid() .. ", " .. char:GetAge() .. " ::>"
        elseif client:Team() == FACTION_HEADCRAB or client:Team() == FACTION_BIRD then
            firstText = ":: CREATURE ::"
            firstLabel:SetColor(Color(244, 163, 136, 255))
            thirdLabelDetails.text = "<:: #" .. char:GetCid() .. " ::>"
        end

        animateText(firstText, firstLabel, 0.25)

        local rand = math.random(1, 4)
        timer.Simple(0.5, function()
        	surface.PlaySound(sounds[rand])
        end)
   end)
end

function animateText(targetText, label, delay)
    timer.Create(targetText .. "text-animator", delay, 0, function()
        if label:IsValid() and not (secondLabelDetails.label == label and secondLabelDetails.done) then
            if not clickedLastTick then
                local rand = math.random(1, 6)
                surface.PlaySound(keySounds[rand])
                clickedLastTick = true
            else
                clickedLastTick = false
            end
            local text = label:GetText()
            local newText = string.sub(targetText, 1, string.len(text) + 1)
            label:SetText(newText)
            if newText == targetText then
                surface.PlaySound('ambient/machines/keyboard7_clicks_enter.wav')
                    if firstDone then
                        if secondLabelDetails.done then
                            timer.Remove(thirdLabelDetails.text .. "text-animator")
                            timer.Simple(5, function()
                                if thirdLabelDetails.label then
                                    local panel = thirdLabelDetails.label:GetParent()
                                    panel:AlphaTo(0, 2, 0, function()
                                        thirdLabelDetails.label = nil
                                        panel:Remove()
                                        secondLabelDetails = {}
                                        thirdLabelDetails = {}
                                    end)
                                end
                            end)
                        else
                            timer.Remove(targetText .. "text-animator")
                            firstDone = true
                            secondLabelDetails.done = true
                            animateText(thirdLabelDetails.text, thirdLabelDetails.label, thirdLabelDetails.delay)
                        end
                    else
                        timer.Remove(targetText .. "text-animator")
                        firstDone = true
                        animateText(secondLabelDetails.text, secondLabelDetails.label, secondLabelDetails.delay)
                    end
            else
                --animateText(targetText, label, delay)
            end
        end
    end)
end