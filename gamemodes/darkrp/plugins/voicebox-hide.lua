--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

PLUGIN.name     = 'VoiceBox Remover'
PLUGIN.author   = 'Bilwin (edited by Enistein)'

if CLIENT then
	-- Font
	surface.CreateFont("SpeakingIndicatorFont", {
        font = "Helvetica",
        size = 32,
        weight = 500,
    })

    -- Oyuncu konuşuyor mu diye kontrol etmek için değişken
    local isSpeaking = false

    function PLUGIN:PlayerStartVoice(ply)
        if ply == LocalPlayer() then
            isSpeaking = true
        end

        if IsValid(g_VoicePanelList) then
            g_VoicePanelList:Remove()
        end
    end

    function PLUGIN:PlayerEndVoice(ply)
        if ply == LocalPlayer() then
            isSpeaking = false
        end
    end

    hook.Add("HUDPaint", "ShowSpeakingIndicator", function()
        if isSpeaking then
            local w, h = ScrW(), ScrH()
            local text = "Konuşuyorsun..."
            local font = "SpeakingIndicatorFont"
            
            surface.SetFont(font)
            local textWidth, textHeight = surface.GetTextSize(text)

            local x = w - textWidth - 50 -- 50 piksel sağdan boşluk
            local y = h - textHeight - 50 -- 50 piksel aşağıdan boşluk

            draw.SimpleText(text, font, x, y, Color(255,255,255,255))
        end
    end)
end
