--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


if (SERVER) then
    util.AddNetworkString("ixBindGrab")
    util.AddNetworkString("ixBindGrabList")
end

CAMI.RegisterPrivilege({
	Name = "Helix - Check Bind",
	MinAccess = "superadmin"
})

ix.command.Add("PlyGetBinds", {
	description = "Get a list of all of someone's binds.",
	privilege = "Check Bind",
    arguments = {ix.type.player, bit.bor(ix.type.optional, ix.type.bool)},
	OnRun = function(self, client, target, all)
        if (IsValid(target.ixBindGrab) and target.ixBindGrabTime and target.ixBindGrabTime > CurTime()) then
            return "Someone else is checking this player's binds already. Please wait a few seconds!"
        end

        target.ixBindGrab = client
        target.ixBindGrabTime = CurTime() + 5
        target.ixBindGrabAll = all
        net.Start("ixBindGrab")
        net.Send(target)
	end,
	bNoIndicator = true
})

if (CLIENT) then
    net.Receive("ixBindGrab", function()
        net.Start("ixBindGrab")
            for i = 1, BUTTON_CODE_LAST do
                net.WriteString(string.Left(input.LookupKeyBinding(i) or "", 255))
            end
        net.SendToServer()
    end)

    local blacklist = {
        ["slot0"] = true,
        ["slot1"] = true,
        ["slot2"] = true,
        ["slot3"] = true,
        ["slot4"] = true,
        ["slot5"] = true,
        ["slot6"] = true,
        ["slot7"] = true,
        ["slot8"] = true,
        ["slot9"] = true,
        ["+zoom"] = true,

        ["+forward"] = true,
        ["+back"] = true,
        ["+moveleft"] = true,
        ["+moveright"] = true,
        ["+jump"] = true,
        ["+speed"] = true,
        ["+walk"] = true,
        ["+duck"] = true,

        ["+lookup"] = true,
        ["+left"] = true,
        ["+lookdown"] = true,
        ["+right"] = true,

        ["+attack"] = true,
        ["+attack2"] = true,
        ["+reload"] = true,
        ["+use"] = true,
        ["invprev"] = true,
        ["invnext"] = true,

        ["+menu"] = true,
        ["+menu_context"] = true,
        ["gmod_undo"] = true,

        ["+showscores"] = true,
        ["gm_showhelp"] = true,
        ["gm_showteam"] = true,
        ["gm_showspare1"] = true,
        ["gm_showspare2"] = true,

        ["noclip"] = true,
        ["messagemode"] = true,

        ["toggleconsole"] = true,
        ["cancelselect"] = true,
        ["pause"] = true,
        ["save quick"] = true,
        ["load quick"] = true,

        ["impulse 100"] = true,
        ["+voicerecord"] = true,
        ["jpeg"] = true,
    }
    net.Receive("ixBindGrabList", function()
        local all = net.ReadBool()
        MsgN(net.ReadString().."'s binds ("..net.ReadString()..")")
        for i = 1, BUTTON_CODE_LAST do
            local bind = net.ReadString()
            if (!all and blacklist[bind]) then continue end

            if (bind and bind != "") then
                if (#bind == 255) then
                    bind = bind.."..."
                end
                MsgN((input.GetKeyName(i) or i)..": ", bind)
            end
        end

        LocalPlayer():Notify("Binds were printed in console!")
    end)
else
    net.Receive("ixBindGrab", function(len, client)
        if (!IsValid(client.ixBindGrab) or !CAMI.PlayerHasAccess(client.ixBindGrab, "Helix - Check Bind")) then return end
        net.Start("ixBindGrabList")
            net.WriteBool(client.ixBindGrabAll)
            net.WriteString(client:SteamName())
            net.WriteString(client:SteamID())
            for i = 1, BUTTON_CODE_LAST do
                net.WriteString(string.Left(net.ReadString(), 255))
            end
        net.Send(client.ixBindGrab)

        client.ixBindGrab = nil
    end)
end