--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.Type = "anim";
ENT.Base = "base_gmodentity";
ENT.Author = "gb";
ENT.PrintName = "Ore Spawner";
ENT.Spawnable = true;
ENT.AdminSpawnable = true;
ENT.Category = "Gathering System";

if SERVER then 
	function ENT:Initialize()
		self:SetModel("models/props_junk/Shoe001a.mdl")
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
		self:SetNoDraw(true)
		local phys = self:GetPhysicsObject()
		phys:SetMass(120)

		self:SetupNextSpawn()

		self:CallOnRemove(
			"KillParentTimer",
			function(ent)
				ent.dead = true
				timer.Remove("spawner_ore_"..ent:EntIndex())

				if self.oreEnt then 
					self.oreEnt:Remove()
				end 
		end)
	end

	function ENT:SetupNextSpawn()
		if (self.dead) then return end

		local variation = ix.config.Get("Ore Respawn Variation") * 60
		local duration = math.max(ix.config.Get("Ore Respawn Timer") * 60 + math.random(-variation, variation), 60)
		self:SetNetVar("ixNextOreSpawn", CurTime() + duration)
		self:SetNetVar("ixSelectedOre", self:GetRandomVein())
		local uniqueID = "spawner_ore_"..self:EntIndex()
		if (timer.Exists(uniqueID)) then timer.Remove(uniqueID) end

		timer.Create(uniqueID, duration, 1, function()
			if (IsValid(self)) then
				self:SetNetVar("ixNextOreSpawn", -1)
				self.oreEnt = ents.Create(self:GetNetVar("ixSelectedOre"))
				if (IsValid(self.oreEnt)) then
					local ang = self:GetAngles()
					self.oreEnt:SetPos(self:GetPos())
					ang:RotateAroundAxis(ang:Right(), math.random(10, 100)) 
					ang:RotateAroundAxis(ang:Up(), math.random(10, 80)) 
					self.oreEnt:SetAngles(ang)

					self.oreEnt.ixSpawner = self
					self.oreEnt:Spawn()
					self.oreEnt:CallOnRemove(
						"RestartOreTimer",
						function(ent)
							if (IsValid(ent.ixSpawner)) then
								ent.ixSpawner:SetupNextSpawn()
							end
					end)
				end
			end
		end)
	end

	function ENT:UpdateTransmitState()
		return TRANSMIT_PVS
	end

	function ENT:PhysicsUpdate(physicsObject)
		if (!self:IsPlayerHolding() and !self:IsConstrained()) then
			physicsObject:SetVelocity( Vector(0, 0, 0) )
			physicsObject:Sleep()
		end
	end

	function ENT:Use(activator, caller)
		return
	end

	function ENT:CanTool(player, trace, tool)
		return false
	end

	function ENT:GetRandomVein()
		local coalChance = ix.config.Get("Ore Spawn Chance Coal", 50)
		local ironChance = ix.config.Get("Ore Spawn Chance Iron", 30)
		local goldChance = ix.config.Get("Ore Spawn Chance Gold", 20)
	
		local totalChance = coalChance + ironChance + goldChance
		local randomChance = math.random(1, totalChance)
	
		if randomChance <= coalChance then
			return "ix_vein_coal"
		elseif randomChance <= coalChance + ironChance then
			return "ix_vein_iron"
		else
			return "ix_vein_gold"
		end
	end 
end 