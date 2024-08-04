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
PLUGIN.name = "Text Screen"
PLUGIN.author = "M!NT"
PLUGIN.description = "A custom text screen that can be put on user's display."
PLUGIN.textLines = {}
PLUGIN.targetSoundFile = ""
PLUGIN.active = false
PLUGIN.fadeOut = false
PLUGIN.colorBWFadeInMultiple = 0.005

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Text Screen",
	MinAccess = "admin"
})

ix.command.Add("EditTextScreen", {
	description = "Edit the text screen.",
	privilege = "Manage Text Screen",
	OnRun = function(self, client)
        if (SERVER) then netstream.Start(client, "EditTextScreen") end
	end
})

ix.command.Add("EnterTextScreen", {
	description = "Plays currently configured text screen to all players on the servers.",
	privilege = "Manage Text Screen",
    OnRun = function(self, client)
        if (SERVER) then
		    for _, v in pairs(player.GetAll()) do
			    netstream.Start(v, "TextScreenShow")
		    end
	    end
    end
})

ix.config.Add(
    "Text Screen Fade In Time",
    3,
    "How long the text screen should fade in for in seconds",
    nil,
    {
        data = {min = 1, max = 240},
        category = "Text Screen"
    }
)

ix.config.Add(
    "Text Screen Fade Out Time",
    3,
    "How long the text screen should fade out for in seconds",
    nil,
    {
        data = {min = 1, max = 240},
        category = "Text Screen"
    }
)

ix.config.Add(
    "Text Screen Freeze Time",
    3,
    "How long the text screen should remain at full alpha in seconds",
    nil,
    {
        data = {min = 1, max = 240},
        category = "Text Screen"
    }
)

ix.config.Add(
    "Text Screen Text Font",
    "DermaLarge",
    "How long the text screen should remain at full alpha in seconds",
    nil,
    {category = "Text Screen"}
)

ix.config.Add(
    "Text Screen Text Font Vertical Spacing",
    40,
    "How long the text screen should remain at full alpha in seconds",
    nil,
    {
        data = {min = 10, max = 255},
        category = "Text Screen"
    }
)

ix.config.Add(
    "Text Screen Fade In Alpha",
    255,
    "Maximum alpha (0-255) that the background can fade into",
    nil,
    {
        data = {min = 0, max = 255},
        category = "Text Screen"
    }
)

ix.config.Add(
    "Text Screen Fade In Text Line Offset",
    1,
    "Seconds of delay between lines of text fading in",
    nil,
    {
        data = {min = 0.0, max = 9.9},
        category = "Text Screen"
    }
)

if (CLIENT) then
    local colorBW = {
        ["$pp_colour_addr"] = 0,
        ["$pp_colour_addg"] = 0,
        ["$pp_colour_addb"] = 0,
        ["$pp_colour_brightness"] = 0,
        ["$pp_colour_contrast"] = 1,
        ["$pp_colour_colour"] = 1,
        ["$pp_colour_mulr"] = 0,
        ["$pp_colour_mulg"] = 0,
        ["$pp_colour_mulb"] = 0
    }

    local function multiplyBWShader(multiple)
        colorBW["$pp_colour_colour"] = math.Clamp(colorBW["$pp_colour_colour"] + multiple, 0.1, 1.1)
    end

    netstream.Hook("EditTextScreen", function()
        vgui.Create("ixTextScreenEditor")
    end)

    netstream.Hook("TextScreenShow", function()
        vgui.Create("ixTextScreenShow")
        PLUGIN.active = true
    end)

    net.Receive("UpdateTextScreenText", function(len, ply)
        if (IsValid(ply) and ply:IsPlayer()) then
            return
        else
            PLUGIN.textLines = ix.compnettable:Read()
            PLUGIN.targetSoundFile = net.ReadString()
        end
    end)

    local FadeInPanel = {}
    function FadeInPanel:Init()
        self:SetSize(ScrW(), ScrH())
        self:SetDraggable(false)
        self:ShowCloseButton(false)
        self:SetAlpha(0)
        self:SetTitle(" ")
        self.Paint = function(this, w, h)
            surface.SetDrawColor(0, 0, 0, ix.config.Get("Text Screen Fade In Alpha"))
            surface.DrawRect(0, 0, w, h)
            Derma_DrawBackgroundBlur(this, 1)
        end

        local height = (ScrH() / 2) - (#PLUGIN.textLines * ix.config.Get("Text Screen Text Font Vertical Spacing"))
        local fadeInStep = 0
        for k, str in pairs(PLUGIN.textLines) do
            local line = self:Add("DLabel")
            line:SetFont(ix.config.Get("Text Screen Text Font"))
            line:SetColor(Color(255, 255, 255, 255))
            line:SetText(tostring(str))
            line:SizeToContents()
            line:SetPos(0, height)
            height = height + ix.config.Get("Text Screen Text Font Vertical Spacing")
            fadeInStep = fadeInStep + ix.config.Get("Text Screen Fade In Text Line Offset")
            line:CenterHorizontal()
            line:SetAlpha(0)
            line:AlphaTo(255, fadeInStep, fadeInStep, function() return end)
        end
        
        self:SetContentAlignment(5)

        if (PLUGIN.targetSoundFile and PLUGIN.targetSoundFile != "") then
            surface.PlaySound(PLUGIN.targetSoundFile)
        end

        PLUGIN.fadeOut = false
        self:AlphaTo(255, ix.config.Get("Text Screen Fade In Time"), 0, function()
            timer.Create("RemoveTextScreen", ix.config.Get("Text Screen Freeze Time"), 1, function()
                PLUGIN.fadeOut = true
                self:AlphaTo(0, ix.config.Get("Text Screen Fade Out Time"), 0, function()
                    self:Remove()
                    PLUGIN.active = false
                end)
            end)
        end)
    end

    vgui.Register("ixTextScreenShow", FadeInPanel, "DFrame")

    local EditPanel = {}
    function EditPanel:Init()
        self:SetSize(ScrW(), ScrH())
        self.Paint = function(this, w, h)
            surface.SetDrawColor(Color(63, 58, 115, 220))
            surface.DrawRect(0, 0, w, h)

            Derma_DrawBackgroundBlur(this, 1)
        end

        self.content = self:Add("EditablePanel")
        self.content:SetSize(500, 650)
        self.content:Center()
        self.content:MakePopup()
        self.content.Paint = function(this, w, h)
            surface.SetDrawColor(0, 0, 0, 130)
            surface.DrawRect(0, 0, w, h)
        end

        local textEntry = self.content:Add("DTextEntry")
        textEntry:SetMultiline(true)
        textEntry:SetSize(500, 400)
        textEntry:Dock(TOP)
        textEntry:DockMargin(10, 10, 10, 0)
        textEntry:CenterHorizontal()
        local currentValue = ""
        for _, v in ipairs(PLUGIN.textLines) do
            currentValue = currentValue.."\n"..v
        end
        textEntry:SetValue(currentValue)

        local textEntrySoundFile = self.content:Add("DTextEntry")
        textEntrySoundFile:SetMultiline(false)
        textEntrySoundFile:SetSize(500, 75)
        textEntrySoundFile:Dock(TOP)
        textEntrySoundFile:DockMargin(10, 10, 10, 20)
        textEntrySoundFile:CenterHorizontal()
        textEntrySoundFile:SetValue(PLUGIN.targetSoundFile)

        local saveOrReset = self.content:Add("Panel")
        saveOrReset:Dock(BOTTOM)
        saveOrReset:SetTall(75)
        
        local save = saveOrReset:Add("DButton")
        save:Dock(LEFT)
        save:SetWide(self.content:GetWide() * 0.5)
        save:SetText("SAVE")
        save:SetFont("DermaLarge")
        save.DoClick = function()
            PLUGIN.textLines = {}
            for line in textEntry:GetValue():gmatch('[^\n]+') do
                PLUGIN.textLines[#PLUGIN.textLines + 1] = line
            end
            netstream.Start(
                "TextScreenEditText",
                PLUGIN.textLines,
                textEntrySoundFile:GetValue()
            )
        end

        local reset = saveOrReset:Add("DButton")
        reset:Dock(FILL)
        reset:SetText("RESET")
        reset:SetFont("DermaLarge")
        reset.DoClick = function()
            PLUGIN.textLines = {}
            textEntry:SetValue("")
            netstream.Start("TextScreenEditText", {})
        end
    end

    vgui.Register("ixTextScreenEditor", EditPanel, "DFrame")

    function PLUGIN:RenderScreenspaceEffects()
        if (PLUGIN.fadeOut == false and PLUGIN.active) then
            multiplyBWShader(PLUGIN.colorBWFadeInMultiple * -1)
        elseif (colorBW["$pp_colour_colour"] < 1) then
            multiplyBWShader(PLUGIN.colorBWFadeInMultiple)
        end
        DrawColorModify(colorBW)
    end
end

if (SERVER) then 
    util.AddNetworkString("UpdateTextScreenText")

    netstream.Hook("TextScreenEditText", function(client, textLines, soundFile)
        if !client:IsAdmin() then return end

        PLUGIN.textLines = textLines

        net.Start("UpdateTextScreenText")
            ix.compnettable:Write(textLines)
            net.WriteString(soundFile)
        net.Broadcast()

        client:NotifyLocalized("Updated event screen.")
    end)
end