--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props/de_inferno/scaffolding.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	self.items = 0
	self:SetNWInt("ItemsRequired", 0)
	self:SetUseType( SIMPLE_USE )
	self.LastUse = 0
	self.Delay = 2
end

function ENT:Use(activator)
-- Timer to pretend abuse
	if self.LastUse <= CurTime() then
		self.LastUse = CurTime() + self.Delay

		activator:Notify("Put building materials here.") -- Notify on press E
	end
end

local worksound = {
	"physics/wood/wood_box_break1.wav",
	"physics/wood/wood_box_break2.wav",
	"physics/wood/wood_crate_break2.wav",
	"physics/wood/wood_plank_break3.wav"
}
function ENT:StartTouch( hitEnt )
	if (self:GetNWInt("ItemsRequired") == 40) then return end -- max of items

	if (hitEnt:GetClass() == "ix_item") then
		if (hitEnt:GetItemID() != "buildingmaterials") then -- Check item id to accept item
			return
		end

		hitEnt:Remove()
		self.items = self.items + 1
		self:SetNWInt("ItemsRequired", self.items)
		self:EmitSound(worksound[math.random(1, #worksound)])

		ix.saveEnts:SaveEntity(self)

		--if self:GetNWInt("ItemsRequired") != 40 then return end
	end
end