--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- This thing is unfinished and pretty unpolished, but you can mess with it if you want to
local PLUGIN = PLUGIN
PLUGIN.name = "Cutscenes/Slideshow"
PLUGIN.author = "chancer, vented/caramel"
PLUGIN.description = "A system for cutscenes."
PLUGIN.fadeDelay = 2
PLUGIN.cutscenes = PLUGIN.cutscenes or {}

ix.config.Add("PlayCutsceneOnCharacterLoad", true, "Whether or not to play a cutscene/slideshow when a player loads a character.", nil, {
	category = "!Intro"
})
ix.config.Add("CutsceneID", "act4finale", "The [cutsceneID] of the cutscene/slideshow used for the intro.", nil, {
	category = "!Intro"
})

if (SERVER) then
    util.AddNetworkString("ix_cutscene")

    --runs a cutscene on a single target
    function PLUGIN:runCutscene(client, cutsceneID, bIntro)
        net.Start("ix_cutscene")
            net.WriteString(cutsceneID)
            net.WriteBool(bIntro)
        net.Send(client)
    end

    --runs a cutscene on everyone
    function PLUGIN:runCutsceneAll(cutsceneID)
        for k, client in pairs(player.GetAll()) do
            net.Start("ix_cutscene")
                net.WriteString(cutsceneID)
            net.Send(client)

        end
    end
else
    function PLUGIN:runCutscene(cutsceneID, bIntro)
        local cutscene = PLUGIN.cutscenes[cutsceneID]
        if (not cutscene) then return end
        local client = LocalPlayer()
        local cutStarted = false
        local fadeDelay = PLUGIN.fadeDelay
        --A panel for fading in and fading out.
        local fade = vgui.Create("DPanel")
        fade:SetSize(ScrW(), ScrH())
        fade:SetSkin("Default")
        fade:SetBackgroundColor(color_black)
        fade:SetAlpha(0)
        if bIntro then
            fade:SetAlpha(255)
        end
        fade:SetZPos(999)
        --panel that holds the image and subtitles
        local scenePanel = vgui.Create("DPanel")
        scenePanel:SetSize(ScrW(), ScrH())
        scenePanel:SetZPos(999)
        --image
        local image = scenePanel:Add("DHTML")
        image:SetSize(ScrW(), ScrH() * 0.75)
        local w, h, ft, clmp
        local tSizeX
        local tSizeY
        --local fade
        --local fade2
        --local fadeout
        w, h = ScrW(), ScrH()

        --subtitles
        scenePanel.Paint = function()
            client = LocalPlayer()
            ft = FrameTime()
            curTime = CurTime()

            --black background
            if (cutStarted) then
                surface.SetDrawColor(0, 0, 0, 255)
                surface.DrawRect(-1, -1, w + 2, h + 2)
            end

            --subtitle drawing
            if (client.scene) then
                local scene = client.scene

                if (scene.subtitle) then
                    --subtitle text
                    surface.SetFont(scene.font)
                    local textColor = scene.color
                    local red = textColor and textColor.r or 64
                    local green = textColor and textColor.g or 100
                    local blue = textColor and textColor.b or 100
                    surface.SetTextColor(red, green, blue, 255)
                    local lines = ix.util.WrapText(scene.subtitle, w * 0.5, scene.font)
                    local lineOffset = 0

                    for k, line in pairs(lines) do
                        tSizeX, tSizeY = surface.GetTextSize(line)
                        surface.SetTextPos(w * 0.5 - tSizeX * 0.5, h * 0.8 + tSizeY * 0.5 + lineOffset)
                        surface.DrawText(line)
                        lineOffset = lineOffset + tSizeY + 8
                    end
                end
            end
        end

        -- Add darkness
        local function fadeIn()
            fade:AlphaTo(255, fadeDelay, 0)
        end

        -- Remove darkness
        local function fadeOut()
            fade:AlphaTo(0, fadeDelay, 0)
        end

        --change the background image
        local function changeImage(url)
            if (url) then
                image:SetHTML([[
					<html>
						<body style="margin: 0; padding: 0; overflow: hidden;">
							<img src="]] .. url .. [[" width="]] .. ScrW() .. [[" height="]] .. (ScrH() * 0.75) .. [[" />
						</body>
					</html>
				]])
            else
                image:SetHTML("")
            end
        end

        --starts/changes the subtitles
        local function subtitleStart(subtitle)
            if (subtitle.sound) then
                --surface.PlaySound(subtitle.sound)
                LocalPlayer():EmitSound(subtitle.sound, 75, 100, 0.4)
            end

            --sent to client for drawing
            local clientScene = {
                subtitle = subtitle.text,
                color = subtitle.color,
                font = subtitle.font,
                sound = subtitle.sound,
            }

            client.scene = clientScene
        end

        --ends the 
        local function endCutscene(scene)
            scenePanel:Remove()
            fadeOut()

            if (scene.songFade and ix.cutsceneMusic) then
                local i = 0

                timer.Create("cutSongFade", 0.5, 5, function()
                    i = i + 2

                    if (ix.cutsceneMusic.SetVolume) then
                        ix.cutsceneMusic:SetVolume(0.5 - i / 20)
                    else
                        ix.cutsceneMusic:ChangeVolume(1 - i / 10)
                    end

                    if (ix.cutsceneMusic:GetVolume() == 0) then
                        ix.cutsceneMusic:Stop()
                        ix.cutsceneMusic = nil
                    end
                end)
            end

            timer.Simple(fadeDelay, function()
                fade:Remove()
            end)
        end

        --gross timer nonsense here, there's definitely a better way to do this
        local delay = 0
        --cutscene starts with a fade in
        delay = delay + fadeDelay

        for k, scene in SortedPairs(cutscene) do
            -- every scene starts with a fade out
            delay = delay + fadeDelay
            scene.startTime = delay

            for k, subtitle in pairs(scene.subtitles) do
                subtitle.startTime = delay
                delay = delay + subtitle.duration
            end

            -- every scene ends with fade in
            delay = delay + fadeDelay
        end

        --fade in to start cutscene
        fadeIn()

        sound.PlayURL("common_computer/phone/pick_up.ogg", "noblock", function(music, errorID, fault) 
            if music then
                music:SetVolume(0.5)
                ix.cutsceneMainMusic = music
                ix.cutsceneMainMusic:Play()
            end
        end)

        for k, scene in SortedPairs(cutscene) do
            -- Scene timer, delays the scene
            timer.Simple(scene.startTime, function()
                fadeOut() -- Remove darkness, revealing the image
                cutStarted = true
                changeImage(scene.image)

                if (scene.sound) then
                    if (ix.cutsceneMusic) then
                        ix.cutsceneMusic:Stop()
                        ix.cutsceneMusic = nil
                    end

                    if (scene.sound:find("http")) then
                        sound.PlayURL(scene.sound, "noplay", function(music, errorID, fault)
                            if (music) then
                                music:SetVolume(10.0)
                                ix.cutsceneMusic = music
                                ix.cutsceneMusic:Play()
                            end
                        end)
                    else
                        ix.cutsceneMusic = CreateSound(client, scene.sound)
                        ix.cutsceneMusic:PlayEx(1, 100)
                    end
                end
            end)

            for k2, subtitle in SortedPairs(scene.subtitles) do
                -- Subtitle timer, delays each subtitle
                timer.Simple(subtitle.startTime, function()
                    subtitleStart(subtitle)

                    -- last subtitle of scene, fade to black
                    if (k2 == #scene.subtitles) then
                        fadeIn()

                        timer.Simple(fadeDelay, function()
                            changeImage()
                            client.scene = nil

                            -- last subtitle of last scene, end the cutscene
                            if (k == #cutscene) then
                                timer.Simple(fadeDelay, function()
                                    endCutscene(scene)
                                end)
                            end
                        end)
                    end
                end)
            end
        end
    end

    --server tells client to run cutscene
    net.Receive("ix_cutscene", function(cutsceneID)
        local cutsceneID = net.ReadString()
        local bIntro = net.ReadBool()
        PLUGIN:runCutscene(cutsceneID, bIntro)
    end)
end

--commands to run these things
ix.command.Add("PlaySlideshowAll", {
    adminOnly = true,
    syntax = "<string cutscene>",
    arguments = {ix.type.string},
    OnRun = function(self, client, cutsceneID)
        -- local cutsceneID = arguments[1]
        if (not cutsceneID) then
            client:Notify("Missing information.")

            return false
        end

        if (not PLUGIN.cutscenes[cutsceneID]) then
            client:Notify("Invalid cutscene " .. cutsceneID .. ".")

            return false
        end

        PLUGIN:runCutsceneAll(cutsceneID)
    end
})

--commands to run these things
ix.command.Add("PlaySlideshowTarget", {
    adminOnly = true,
    syntax = "<string target> <string cutscene>",
    arguments = {ix.type.player, ix.type.string},
    OnRun = function(self, client, target, cutsceneID)
        if (IsValid(target) and target:GetCharacter()) then
            if (not cutsceneID) then
                client:Notify("Missing information.")

                return false
            end

            if (not PLUGIN.cutscenes[cutsceneID]) then
                client:Notify("Invalid cutscene " .. cutsceneID .. ".")

                return false
            end

            PLUGIN:runCutscene(target, cutsceneID)
        end
    end
})

-- run on first spawn
--CharacterLoaded OnCharacterCreated
function PLUGIN:CharacterLoaded(client)
    timer.Simple(1, function()
        if ix.config.Get("PlayCutsceneOnCharacterLoad", true) then
            PLUGIN:runCutscene(client, ix.config.Get("CutsceneID"), true)
        end
    end)
end