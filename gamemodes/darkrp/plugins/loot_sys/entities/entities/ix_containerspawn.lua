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
ENT.PrintName = "Loot spawner"
ENT.Category = "WN7"
ENT.Spawnable = false
ENT.bNoPersist = true
ENT.PhysgunDisable = true


if (SERVER) then
		function ENT:Initialize()
			self:PhysicsInit(SOLID_NONE)
			self:SetSolid(SOLID_NONE)
			self:SetUseType(SIMPLE_USE)
			self:SetModel("models/props_junk/sawblade001a.mdl")
			self:DrawShadow( false ) 		
			self:SetCollisionGroup(COLLISION_GROUP_WORLD)
			self:SetMoveType(MOVETYPE_NONE)
			self:SetNoDraw( true )
			self.nextSpawn = CurTime()
			local phy = self:GetPhysicsObject()
			if IsValid(phy) then
				phy:Sleep()
			end
			local id = self:EntIndex()
			timer.Create("lootySpawner" .. id, 1, 0, function()
				if not IsValid(self) then
					timer.Remove("lootySpawner" .. id)
					return
				end
				self:SpawnLoot()
			end)
		end
		function ENT:GetLootEnt()
			for k, v in pairs(ix.loot.entities) do
				if k == self:GetLootType() then 
					return v
				end 
			end			
		end
		function ENT:SpawnLoot()
			if CurTime() < self.nextSpawn then 
				return
			end 
			if IsValid(self.loot) then 
				self.loot:Remove()
			end
			self:UpdateTimer()
			self.loot = ents.Create(self:GetLootEnt())
			self.loot:SetPos(self:GetPos() + self:GetUp()*20)
			self.loot:SetAngles(self:GetAngles())
			self.loot:Spawn()
		end
		function ENT:UpdateTimer()
			self.nextSpawn = CurTime() + (ix.config.Get("lootTimer", 1) * 60)
		end
		function ENT:Think()
			self:NextThink( CurTime() + 2 )
			self:SetNetVar("lootSpawn", ix.config.Get("lootTimer", 1))
			return true 
		end	
		function ENT:OnRemove()
			if IsValid(self.loot) then 
				self.loot:Remove()
			end
		end
		function ENT:SetLootType(type)
			self:SetNetVar("lootType", type)
		end
		function ENT:GetLootType()
			return self:GetNetVar("lootType", "Basic")
		end
	else

end

