--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ix.teleporters = ix.teleporters or {}

ENT.PrintName = "Teleporter"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Model = Model("models/props_c17/door01_left.mdl")
ENT.ID = nil
ENT.Mate = nil
ENT.EntModel = nil
ENT.WarpSound = ENT.WarpSound or ""
ENT.UniqueName = ENT.UniqueName or "Default"
ENT.WarpPos = nil
ENT.WarpAngles = nil

if (SERVER) then
	function ENT:Initialize()
		self:SetModel(self.Model)
		self:SetUseType(SIMPLE_USE)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		local phys = self:GetPhysicsObject()

		if (phys:IsValid()) then
			phys:EnableMotion(false)
			phys:Wake()
		end

		self.ID = self:EntIndex()

		ix.saveEnts:SaveEntity(self)
	end

	function ENT:Use(activator)
		if (ix.teleporters:IsDefaultTeleporter(self)) then
			netstream.Start(activator, "ixTeleportersPassSelection", self.ID)

			return
		end

		if (ix.teleporters:IsMateValid(self.Mate)) then
			local teleporter = ix.teleporters:TeleporterFindByID(self.Mate)

			self:EmitSound(self.WarpSound, 100, 100, 1)
			teleporter:EmitSound(self.WarpSound, 100, 100, 1)

			activator:ScreenFade(SCREENFADE.IN, Color(16, 16, 16), 0.5, 1)
			activator:SetPos(teleporter.WarpPos and teleporter.WarpPos or teleporter:GetPos())
			activator:SetEyeAngles(teleporter.WarpAngles and teleporter.WarpAngles or Angle(0, 0, 0))
			return
		end

		activator:Notify("This leads nowhere.")
	end
end