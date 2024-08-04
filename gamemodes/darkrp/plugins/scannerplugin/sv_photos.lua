--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

util.AddNetworkString("ixScannerData")
util.AddNetworkString("ixScannerPicture")
util.AddNetworkString("ixScannerClearPicture")

net.Receive("ixScannerData", function(len, client)
    if (IsValid(client.ixScn) and client:GetViewEntity() == client.ixScn and (client.ixNextPic or 0) < CurTime()) then
        local delay = ix.config.Get("pictureDelay", 15)
        client.ixNextPic = CurTime() + delay - 1

        local length = net.ReadUInt(16)
        local data = net.ReadData(length)

        if (length != #data) then
            return
        end

        local receivers = {}

        for _, v in ipairs(player.GetAll()) do
            if (hook.Run("CanPlayerReceiveScan", v, client)) then
                receivers[#receivers + 1] = v
                v:EmitSound("npc/overwatch/radiovoice/scanner_visual.wav")
            end
        end

        if (#receivers > 0) then
            net.Start("ixScannerData")
                net.WriteUInt(#data, 16)
                net.WriteData(data, #data)
            net.Send(receivers)

            if (ix.combineNotify) then
                ix.combineNotify:AddNotification("LOG:// Receiving Visual Download from local Airwatch asset")
            end
        end
    end
end)

net.Receive("ixScannerPicture", function(length, client)
    if (not IsValid(client.ixScn)) then return end
    if (client:GetViewEntity() ~= client.ixScn) then return end
    if ((client.ixNextFlash or 0) >= CurTime()) then return end

    client.ixNextFlash = CurTime() + 1
    client.ixScn:Flash()
end)