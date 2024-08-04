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

ENT.PrintName = "Music Radio"
ENT.Author = "M!NT"
ENT.Category = "HL2 RP"
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.Spawnable = false
ENT.AdminOnly = true
ENT.Holdable = true

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "Enabled")
end

function ENT:IsPlayingMusic()
    return self:GetNWString("curChan", "") != ""
end

function ENT:GetChan()
    return self:GetNWString("curChan", "")
end

function ENT:GetVolume()
    return self:GetNWInt("vol", 1)
end

function ENT:GetLevel()
    return self:GetNWInt("db", 70)
end

if (CLIENT) then
    function ENT:GetIlluminatedVolButton()
        -- volume is a value of 0 - 1. converts that to 1 - 10 (active illum button)
        return math.Round(10 * self:GetNWInt("vol", 1), 0)
    end

    -- volume from 1 - 6
    function ENT:SetVolume(vol)
        if (vol > 10) then
            vol = 1
        end

        -- normalize vol between 0 and 1
        local normal = vol / 10
        -- normalize vol between maxdb (72) and mindb (57)
        local newLvl = math.ceil(57 + (vol - 1) * (72 - 57) / (10 - 1))

        net.Start("SetMusicRadioVolume")
            net.WriteEntity(self)
            net.WriteFloat(normal)
            net.WriteInt(newLvl, 8)
        net.SendToServer()
    end
end

function ENT:onTakeDmg()
    ix.musicRadio:PlayTuneStatic(self, true)
end

function ENT:PhysicsCollide(data, phys)
    if (!self:IsPlayingMusic()) then
        return
    end

    if (data.Speed < 125) then
        return
    end

    local curTime = CurTime()

    if (self.nextCollide and self.nextCollide > curTime) then
        return
    end

    self:onTakeDmg()
    self.nextCollide = curTime + 3
end

function ENT:OnTakeDamage(dmginfo)
    if (!self:IsPlayingMusic()) then
        return
    end

    if (dmginfo:GetDamage() < 5) then
        return
    end

    if (dmginfo:GetDamage() > 20) then
        self:DoBreak(dmginfo)
        return
    end

    local curTime = CurTime()

    if (self.nextDmg and self.nextDmg > curTime) then
        return
    end

    self:onTakeDmg()
    self.nextDmg = curTime + 3
end

function ENT:DoBreak(dmgInfo)
    self:StopCurrentSong(0)

	local explode = ents.Create("env_explosion")
	explode:SetPos(self:GetPos())
	explode:SetOwner(dmgInfo:GetAttacker())
	explode:Spawn()
	explode:SetKeyValue("iMagnitude", "10")
	explode:Fire("Explode", 0, 0)
	explode:EmitSound("Glass.Break", 120, 90)

    local gib = ents.Create("prop_physics")
    gib:SetModel("models/props_lab/citizenradio.mdl")
    gib:SetPos(self:GetPos())
    gib:Spawn()
    gib:Ignite(3, 100) -- ignite for 3s, ignite everything within 100hus
    gib:EmitSound("willardnetworks/musicradio/musicradio_static_loopable.mp3", 110, 85)

    self:Remove()
end

function ENT:SetChan(chan)
    if (CLIENT) then
        net.Start("SetMusicRadioChannel")
            net.WriteEntity(self)
            net.WriteString(chan)
        net.SendToServer()
    end

    if (SERVER) then
        if (self:IsPlayingMusic()) then
            ix.musicRadio:TuneOut(self, self:GetChan(), chan)
        end

        ix.musicRadio:TuneIn(self, chan)
        self:SetNWString("curChan", chan)
    end
end

function ENT:GetAbsolutePanelButtonPosition(x, y)
    local absPos = self:GetPos()
    absPos = absPos + self:GetForward() * 10
    absPos = absPos + self:GetRight() * (17 + (1 - (x * 0.1)))
    absPos = absPos + self:GetUp() * (24 + (1 - (y * 0.1)))
    return absPos
end

if (SERVER) then
    util.AddNetworkString("SetMusicRadioChannel")
    util.AddNetworkString("SetMusicRadioVolume")

    net.Receive("SetMusicRadioChannel", function(len, ply)
        local ent = net.ReadEntity()
        local ch = net.ReadString()

        ent:SetChan(ch)
    end)

    net.Receive("SetMusicRadioVolume", function(len, ply)
        local ent = net.ReadEntity()
        local vol = net.ReadString()
        local db  = net.ReadInt(8)

        ent:SetVolume(vol, db)
    end)

    -- handle the interaction with the volume knob
    function ENT:InteractVolumeKnob()
        local vol = math.ceil(self:GetVolume() * 10)
        if (vol >= 10) then
            vol = 1
        else
            vol = vol + 1
        end

        -- normalize vol between 0 and 1
        local newVol = vol / 10
        -- normalize vol between maxdb (65) and mindb (55)
        local newLvl = math.ceil(50 + (vol - 1) * (65 - 50) / (10 - 1))

        self:SetVolume(newVol, newLvl)

        -- play clicky noise for button
        self:EmitSound("willardnetworks/musicradio/musicradio_click_"..tostring(math.random(1, 4))..".mp3", 70)
    end

    --                   0 - 1, 60 - 85
    function ENT:SetVolume(vol, db, delta, bStop)
        local ch      = self:GetChan()
        local curSong = ix.musicRadio.destinations[ch].curSong
        if (!delta) then
            delta = 1
        end

        ix.musicRadio.destinations[ch][self:EntIndex()].soundCache[curSong]
            :ChangeVolume(vol, delta)

        ix.musicRadio.destinations[ch][self:EntIndex()].soundCache[curSong]
            :SetSoundLevel(db)

        if (bStop) then
            ix.musicRadio.destinations[ch][self:EntIndex()].soundCache[curSong]:Stop()
        end

        self:SetNWInt("vol", vol)
        self:SetNWInt("db", db)
    end

    function ENT:StopCurrentSong(delta)
        local ch      = self:GetChan()
        local curSong = ix.musicRadio.destinations[ch].curSong

        if (!ch or !curSong) then
            return
        end
        if (!delta) then
            delta = 0.5
        end

        if (!ix.musicRadio.destinations[ch][self:EntIndex()]) then
            return -- ??
        end

        ix.musicRadio.destinations[ch][self:EntIndex()].soundCache[curSong]:FadeOut(delta)
    end

    function ENT:Initialize()
        self:SetModel("models/props_lab/citizenradio.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)

        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            phys:EnableMotion(true)
            phys:Wake()
        end

        self:SetRadioClass("benefactor")
    end

    function ENT:SetRadioClass(className)
        self.defaultStation = ix.musicRadio:GetDefaultChannel(className)
    end

    function ENT:GetRadioClass()
        return ix.musicRadio.channels[self.defaultStation].class
    end

    function ENT:PerformPickup(client)
        if timer.Exists("ixCharacterInteraction" .. client:SteamID()) then return end

        local itemClassName = "musicradio_cmb"
        if (self:GetRadioClass() == "pirate") then
            itemClassName = "musicradio_reb"
        end

        client:PerformInteraction(0.5, self, function(_)
            local success = client:GetCharacter():GetInventory():Add(itemClassName)
            if (!success or success == false) then
                client:Notify("There is not enough room in your inventory!")
                return false
            end

            self:Remove()
            timer.Remove("ixCharacterInteraction" .. client:SteamID())
        end)
    end

    function ENT:Use(activator)
        local curTime = CurTime()

        if (self.nextUse and self.nextUse > curTime) then
            return
        end

        if activator:KeyDown(IN_WALK) then
            return self:PerformPickup(activator)
        end

        -- yay! magic numbers!!
        -- these loosely fit the derma buttons, which is why we're doing it this way
        local volButton  = self:GetAbsolutePanelButtonPosition(80, 170)
        local onButton   = self:GetAbsolutePanelButtonPosition(135, 150)
        local dialButton = self:GetAbsolutePanelButtonPosition(190, 170)

        local tr = activator:GetEyeTrace()
        if (tr.HitPos:Distance(volButton) <= 4) then
            if (self:IsPlayingMusic()) then
                self:InteractVolumeKnob()
            end

        elseif (tr.HitPos:Distance(onButton) <= 4) then
            self:EmitSound("willardnetworks/musicradio/musicradio_click_"..tostring(math.random(1, 4))..".mp3", 70)

            if (self:IsPlayingMusic()) then
                self:StopCurrentSong()
                ix.musicRadio:TuneOut(self, self:GetChan())
                self:SetNWString("curChan", "")
            else
                self:SetNWString("curChan", self.defaultStation)
                ix.musicRadio:TuneIn(self, self.defaultStation)
            end

        elseif (tr.HitPos:Distance(dialButton) <= 4) then
            if (self.nextUse and (self.nextUse + 2) > curTime) then
                return
            end

            if (self:IsPlayingMusic()) then
                -- only allow channel changes when the radio is on
                self:SetChan(ix.musicRadio:GetNextChannelName(
                    self:GetNWString("curChan", self.defaultStation)))
            end
        end

        self.nextUse = curTime + 1
	end
else
    function ENT:Think()
        self.ShowPlayerInteraction = LocalPlayer():KeyDown(IN_WALK)
    end
end
