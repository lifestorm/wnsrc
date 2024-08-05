--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Landline Phone"
ENT.Author = "M!NT"
ENT.Category = "HL2 RP"
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.Spawnable = false
ENT.AdminOnly = true
ENT.Holdable = true
ENT.offHook = false
ENT.inUseBy = nil
ENT.isRinging = false
ENT.defaultRingTime = 60  -- how long the phone will ring (in seconds)
ENT.endpointID = nil
ENT.ringCallback = nil      -- FnOnce that is called when the phone stops ringing for whatever reason
ENT.hangUpCallback = nil    -- FnOnce that is called when the user runs hang up during a call
ENT.currentName = "Unknown" -- public name as stored currently in the PBX
ENT.currentPBX = 0          -- PBX this entity is attached to
ENT.currentExtension = nil  -- extension in the PBX

function ENT:GetIndicatorPos()
    local btnPos = self:GetPos()

    btnPos = btnPos + self:GetForward() * 4.3
    btnPos = btnPos + self:GetRight() * -1.1
    btnPos = btnPos + self:GetUp() * 2.0

    return btnPos
end

if SERVER then
    util.AddNetworkString("UpdateLandlineEntStatus")
    util.AddNetworkString("EnterLandlineDial")
    util.AddNetworkString("ForceHangupLandlinePhone")

    function ENT:Initialize()
        self:SetModel("models/props/cs_office/phone.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)

        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            phys:EnableMotion(true)
            phys:Wake()
        end

        self.endpointID = ix.phone.switch.endpoints:Register(self)
        self.currentExtension = math.random(100, 999)

        local usrCheckTimerName = "LandlineEnt"..tostring(self:EntIndex()).."UserCheck"
        timer.Create(usrCheckTimerName, 3, 0, function()
            -- check to see if, for some reason, inUseBy is still set but the usr is gone
            -- if so, use the magical powers of lua to hang ourselves up
            if (IsValid(self.inUseBy) and self.inUseBy:IsPlayer()) then
                local plys = ix.phone.switch.endpoints:GetPlayersInRadius(self.endpointID, 30)
                if (!plys or table.Count(plys) < 1 or
                    !IsValid(plys[self.inUseBy:SteamID64()])) then

                    net.Start("ForceHangupLandlinePhone")
                    net.Send(self.inUseBy)

                    self:HangUp()
                end
            else
                -- we shouldn't be offHook if we dont have inUseBy set
                if (!IsValid(self.inUseBy) and self.offHook) then
                    self:HangUp()
                end
            end
        end)

        self:CallOnRemove("OnRemoveLandlineCleanup", function(ent)
            if (self.currentExtension and self.currentPBX) then
                return
            end

            local connID = ix.phone.switch:GetActiveConnection(self.currentPBX,
                self.currentExtension)

            if (connID) then
                ix.phone.switch:Disconnect(connID)
            end

            timer.Remove(usrCheckTimerName)
        end)
    end

    function ENT:PerformPickup(client)
        if timer.Exists("ixCharacterInteraction" .. client:SteamID()) then return end

        client:PerformInteraction(.5, self, function(_)
            client:GetCharacter():GetInventory():Add("landline_phone")
            self:Remove()
        end)
    end

    function ENT:Use(activator)
        if (self.nextUse and self.nextUse > CurTime()) then
            return
        end

        self.nextUse = CurTime() + 1

        if (activator:GetMoveType() == MOVETYPE_FLY) then
            return self:PerformPickup(activator)
        end

        if (!self.offHook) then
            -- User is trying to pick up the phone
            self.inUseBy = activator

            self:SetModel("models/props/cs_office/phone_p1.mdl")

            ix.phone.switch:SetCharVars(self.inUseBy:GetCharacter(),
                true, self.currentPBX, self.currentExtension)

            ix.phone.switch.endpoints:AddListener(self.endpointID, self.inUseBy)

            if (self.isRinging) then
                timer.Remove("PhoneRinging"..self.endpointID)
                self:StopSound("landline_ringtone.wav")

                self.isRinging = false
                self:broadcastStatusOnChange()

                local _, _ = pcall(self.ringCallback, true)
                self.ringCallback = nil
            end

            self:EmitSound("landline_hangup.wav", 60, 100, 1, CHAN_STATIC)

            timer.Simple(0.1, function() -- dont ask me why we have to wait one frame. we just do. thanks garry
                self.offHook = true
                net.Start("EnterLandlineDial")
                    net.WriteInt(tonumber(self.endpointID), 15)
                    net.WriteInt(tonumber(self.currentPBX), 5)
                    net.WriteInt(tonumber(self.currentExtension), 11)
                    net.WriteString(self.currentName)
                    net.WriteInt(self:EntIndex(), 17)
                net.Send(self.inUseBy)
            end)
        end
	end

    function ENT:EnterRing(callback)
        -- this entity getting 'called'
        self:EmitSound("landline_ringtone.wav", 75, 100, 1, CHAN_STATIC)
        self.isRinging = true
        self.ringCallback = callback

        self:broadcastStatusOnChange()

        timer.Create("PhoneRinging"..self.endpointID, self.defaultRingTime, 1, function ()
            -- phone has rung too long
            self.isRinging = false
            self.offHook = false
            self:broadcastStatusOnChange()

            local _, _ = pcall(self.ringCallback, false)
            self.ringCallback = nil
        end)
    end

    function ENT:hangupDuringRing()
        if (!self.isRinging or !timer.Exists("PhoneRinging"..self.endpointID)) then
            return nil
        end

        timer.Remove("PhoneRinging"..self.endpointID)
        self:StopSound("landline_ringtone.wav")
        self:EmitSound("landline_hangup.wav", 60, 100, 1, CHAN_STATIC)

        self.isRinging = false
        self.offHook = false
        self:broadcastStatusOnChange()

        local _, _ = pcall(self.ringCallback, false)
    end

    function ENT:hangupDuringOffHook()
        self:EmitSound("landline_hangup.wav", 60, 100, 1, CHAN_STATIC)
        if (self.inUseBy) then
            ix.phone.switch:ResetCharVars(self.inUseBy:GetCharacter())

            ix.phone.switch.endpoints:RmListener(self.endpointID, self.inUseBy)
        end

        self.offHook = false

        self:broadcastStatusOnChange()
        if (self.hangUpCallback) then
            local _, _ = pcall(self.hangUpCallback)
            self.hangUpCallback = nil
        end
    end

    function ENT:ButtonPress()
        -- play a button clack sound because atle wants it
        local soundName = "landline_clack_"..tostring(math.random(1, 4))..".wav"
        self:EmitSound(soundName, 50, 100, 1, CHAN_STATIC)
    end

    function ENT:HangUp()
        self:SetModel("models/props/cs_office/phone.mdl")

        if (!self.isRinging and !self.offHook) then
            self:EmitSound("landline_hangup.wav", 70, 100, 1, CHAN_STATIC)
            return
        end

        if (self.offHook) then
            self:hangupDuringOffHook()
        end

        if (self.isRinging) then
            self:hangupDuringRing()
        end

        self.inUseBy = nil
    end

    function ENT:broadcastStatusOnChange()
        net.Start("UpdateLandlineEntStatus")
            net.WriteBool(self.isRinging)
            net.WriteBool(self.offHook)
            net.WriteInt(self.currentPBX, 11)
            net.WriteInt(self.currentExtension, 15)
        net.Broadcast()
    end
else
    local glowMaterial = ix.util.GetMaterial("sprites/glow04_noz")
    local colorGreen = Color(0, 255, 0, 255)
    local colorRed = Color(255, 50, 50, 255)
    local isRinging = false
    local offHook = false
    local nextFlashTime = CurTime()

    net.Receive("UpdateLandlineEntStatus", function()
        isRinging = net.ReadBool()
        offHook = net.ReadBool()

        -- reset the indicator status flashing
        colorRed.a = 255
        if (isRinging) then
            nextFlashTime = CurTime() + 1
        end
    end)

    function ENT:Draw()
        self:DrawModel()

        local btnPos = self:GetIndicatorPos()

        render.SetMaterial(glowMaterial)

        if (isRinging) then
            -- slow flash
            if (CurTime() > nextFlashTime) then
                colorRed.a = 255
                if (CurTime() > nextFlashTime + 0.5) then
                    nextFlashTime = CurTime() + 0.5
                end
            else
                colorRed.a = 0
            end
            render.DrawSprite(btnPos, 1, 1, colorRed)
        elseif (offHook) then
		    render.DrawSprite(btnPos, 1, 1, colorRed)
        else
            render.DrawSprite(btnPos, 1, 1, colorGreen)
        end
    end
end
