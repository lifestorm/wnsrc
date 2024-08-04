--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local CAMI = CAMI
local LocalPlayer = LocalPlayer
local L = L
local SetClipboardText = SetClipboardText
local chat = chat
local net = net
local table = table
local string = string
local tonumber = tonumber
local render = render
local Color = Color
local gui = gui
local hook = hook
local surface = surface
local netstream = netstream
local ipairs = ipairs
local MsgN = MsgN
local ix = ix

local PLUGIN = PLUGIN

PLUGIN.infoIcon = ix.util.GetMaterial("icon16/information.png")

surface.CreateFont( "GMFont", {
    font = "Roboto-Bold",
    size = 48,
    weight = 700,
    antialias = true,
    shadow = true,
} )
surface.CreateFont( "GMSubtitleFont", {
    font = "Roboto-Regular",
    size = 18,
    weight = 500,
    antialias = true,
    shadow = true,
} )

ix.option.Add("staffChat", ix.type.bool, true, {
    category = "administration",
    hidden = function()
		return !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Hear Staff Chat", nil)
    end
})

function PLUGIN:PopulateScoreboardPlayerMenu(client, menu)
    if (CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Basic Admin Commands")) then
        menu:AddOption(L("bastionCopySteamName"), function()
            SetClipboardText(client:SteamName())
            LocalPlayer():NotifyLocalized("bastionCopiedSteamName")
        end)

        menu:AddOption(L("bastionCopyCharName"), function()
            SetClipboardText(client:Name())
            LocalPlayer():NotifyLocalized("bastionCopiedCharName")
        end)
    end

	if (sam and CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Basic Admin Commands") and !LocalPlayer():InVehicle() and client != LocalPlayer()) then
        menu:AddOption(L("bastionGoto"), function()
            if (LocalPlayer():GetMoveType() != MOVETYPE_NOCLIP) then
                LocalPlayer():ConCommand("noclip")
            end
            LocalPlayer():ConCommand("say !goto "..client:Name())
        end)
    end
end

function PLUGIN:PrintTarget(target)
    if (ix.option.Get("pgi")) then
        SetClipboardText(target:SteamID())
    end

    chat.AddText(self.infoIcon, target:Name(), " (", target:SteamName(), "; ", target:SteamID(),
        ") | HP: ", target:Health(), " | Armor: ", target:Armor())
end

function PLUGIN:PrintStaffList(amount)
    for _ = 1, amount do
        local group = net.ReadString()
        local members = net.ReadUInt(8)
        local memberList = {}
        for _ = 1, members do
            memberList[#memberList + 1] = net.ReadEntity():SteamName()
        end

        table.sort(memberList)
        chat.AddText(self.infoIcon, "[", string.utf8upper(group), "]: ", table.concat(memberList, ", "))
    end
end

function PLUGIN:ShouldDisplayArea(id)
    if (LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP and !LocalPlayer():InVehicle()) then
        return false
    end
end

local commands = {
    ["playsound"] = 2,
    ["gmpresence"] = 1,
    ["localevent"] = 2,
    ["showentsinradius"] = 1,
    ["localbroadcast"] = 2,
    ["localbroadcastme"] = 2,
    ["localbroadcastit"] = 2,
    ["playsong"] = 3,
    ["screenshake"] = 4,
	["moviebars"] = 1,
    ["removepersistedprops"] = 1,
    ["removeclientprops"] = 1
}

function PLUGIN:PostDrawTranslucentRenderables(bDrawingDepth, bDrawingSkybox)
    local command = string.utf8lower(ix.chat.currentCommand)

    if (commands[command]) then
        local range = tonumber(ix.chat.currentArguments[commands[command]])

        if (range) then
            render.SetColorMaterial()
            render.DrawSphere(LocalPlayer():GetPos(), 0 - range, 50, 50, Color(255, 150, 0, 100))
        end
    end
end

net.Receive("ixOpenURL", function(len)
    gui.OpenURL(net.ReadString())
end)

net.Receive("ixPlayerInfo", function(len)
    PLUGIN:PrintTarget(net.ReadEntity())
end)

net.Receive("ixStaffList", function(len)
    PLUGIN:PrintStaffList(net.ReadUInt(8))
end)

net.Receive("ixPlaySound", function(len)
    local sound = net.ReadString()
    local isGlobal = net.ReadBool()

    if (hook.Run("PrePlaySound", sound, isGlobal) != false) then
        surface.PlaySound(sound)

        hook.Run("PostPlaySound", sound, isGlobal)
    end
end)

net.Receive("ixGMPresence", function(len)
    local sound = "music/stingers/stinger1.ogg"

    if (hook.Run("PrePlaySound", sound) != false) then
        surface.PlaySound(sound)

        hook.Run("PostPlaySound", sound)
    end

        local fadeDuration = 5
        local fadeDelay = 15

        local text = "İlahi bir varlığın sizi izlediği hissine kapılıyorsunuz."
        local subtitle = "[GM Aktif]"

        local startTime = CurTime()
        local endTime = startTime + fadeDuration
        local fadeOutTime = endTime + fadeDelay

        hook.Add("HUDPaint", "FadeText", function()
            local currentTime = CurTime()

            if currentTime < endTime then
                local alpha = math.Clamp((currentTime - startTime) / fadeDuration, 0, 1) * 255

                surface.SetTextColor(Color(255, 178, 80, alpha))

                local x = ScrW() / 2
                local y = ScrH() / 4

                draw.SimpleText(text, "GMFont", x, y, Color(255, 178, 80, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                draw.SimpleText(subtitle, "GMSubtitleFont", x, y * 1.15, Color(100, 100, 100, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            elseif currentTime < fadeOutTime then
                local alpha = math.Clamp(1 - (currentTime - endTime) / fadeDuration, 0, 1) * 255

                surface.SetTextColor(Color(255, 178, 80, alpha))

                local x = ScrW() / 2
                local y = ScrH() / 4

                draw.SimpleText(text, "GMFont", x, y, Color(255, 178, 80, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                draw.SimpleText(subtitle, "GMSubtitleFont", x, y * 1.15, Color(100, 100, 100, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                hook.Remove("HUDPaint", "FadeText")
            end
        end)
end)

netstream.Hook("PrintInfoList", function(list)
    for _, v in ipairs(list) do
        MsgN(v)
    end
end)

function PLUGIN:OnPlayerChat()
    if (ix.config.Get("suppressOnPlayerChat", true)) then
        return true
    end
end
