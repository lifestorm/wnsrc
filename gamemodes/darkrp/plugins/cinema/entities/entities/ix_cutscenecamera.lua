--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Author = "gb"
ENT.PrintName = "Cutscene Camera"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "Cutscene"
local PLUGIN = PLUGIN

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "CameraID")
end

function ENT:Initialize()
    self:SetModel("models/dav0r/camera.mdl")
    self:SetMoveType(MOVETYPE_NONE)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
    self:DrawShadow(false)
    local physicsObject = self:GetPhysicsObject()

    if IsValid(physicsObject) then
        physicsObject:Wake()
        physicsObject:EnableMotion(false)
    end
end

if CLIENT then
    function ENT:Draw()
        if LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP then 
            self:DrawModel()
        end 
    end
end

if SERVER then
    function ENT:Use(act, caller)
        if IsValid(caller) and caller:IsPlayer() and caller:IsSuperAdmin() then
            caller:SendLua("SetCameraID(" .. self:EntIndex() .. ")")
        end
    end
end


properties.Add("ixSetCameraID", {
    MenuLabel = "Set ID",
    Order = 500,
    MenuIcon = "icon16/lightning_add.png",

    Filter = function(self, entity, client)
        if (entity:GetClass() == "ix_cutscenecamera" and client:IsAdmin()) then
            return true
        end
    end,

    Action = function(self, entity)
        Derma_StringRequest(
            "Defin the Cam ID",
            "Type the new ID for the cam:",
            "",
            function(text)
                if IsValid(entity) then
					self:MsgStart()
						net.WriteEntity(entity)
						net.WriteString(text)
					self:MsgEnd()
                end
            end,
            function() end, 
            "Set",
            "Cancel"
        )
    end,

    Receive = function(self, length, client)
        local entity = net.ReadEntity()
		local text = net.ReadString() 
        if (!IsValid(entity)) then
            return
        end

        if (!self:Filter(entity, client)) then
            return
        end

        entity:SetNWInt("CameraID", text)
    end
})
