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
ENT.PrintName = "Water Cache"
ENT.Base = "base_entity"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true

if (SERVER) then
    function ENT:Initialize()
        self:SetModel("models/props_canal/mattpipe.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
            phys:EnableMotion(false)
        end

        self:SpawnProps()
    end

    function ENT:SpawnProps()
        local pipe = ents.Create("prop_dynamic")
        pipe:SetPos(self:GetPos() + self:GetUp() * 39 + self:GetForward() * -4.2)
        pipe:SetAngles(self:GetAngles())
        pipe:SetModel("models/props_c17/gaspipes006a.mdl")
        pipe:Activate()
        pipe:SetParent(self)
        pipe:Spawn()
        pipe:DeleteOnRemove(self)
    end
else
	function ENT:Draw()
		self:DrawModel()
	end

	ENT.PopulateEntityInfo = true

	function ENT:OnPopulateEntityInfo(container)
		local name = container:AddRow("name")
		name:SetImportant()
		name:SetText("Water Cache")
		name:SizeToContents()
	end
end