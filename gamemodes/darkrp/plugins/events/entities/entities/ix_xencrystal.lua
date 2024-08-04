--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local AddCSLuaFile = AddCSLuaFile
local IsValid = IsValid
local ents = ents
local Vector = Vector
local timer = timer

AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Xen Crystal"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.PhysgunDisable = true

if (SERVER) then
	function ENT:Initialize()
		
		self:SetModel("models/hunter/triangles/1x1x2carved025.mdl")
		self:SetNoDraw(true)
		self:DrawShadow(false)
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType(SIMPLE_USE)
		self.health = 200
		self.barricadeEnt = ents.Create("sent_vj_xen_crystal")
		self.barricadeEnt:SetPos(self:GetPos())
		self.barricadeEnt:SetAngles(self:GetAngles())
		self.barricadeEnt:Spawn()
		self.barricadeEnt:Activate()
		self.barricadeEnt:SetNetVar("Persistent", true)
		self.barricadeEnt:DeleteOnRemove( self )
		self.barricadeEnt:EmitSound("vj_hlr/fx/alien_cycletone.wav", 200, 100, 5)

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end

	function ENT:Think() 
        for _, ent in pairs(ents.FindInSphere(self:GetPos(), 500)) do
            if ent:IsPlayer() then
                local character = ent:GetCharacter()
                local faction = character:GetFaction()
                if faction == FACTION_VORT then
					ent:ChatNotify("Kristal garip bir enerji yayıyor, kendinizi yeniden canlanmış hissediyorsunuz...")
				

					character:AddVortalEnergy(20)  	
					if ent:Health() < ent:GetMaxHealth() then 
						ent:SetHealth(ent:Health() + 2)
					end 

					ent:ScreenFade(SCREENFADE.IN, Color(50, 255, 0, 80), 1, 1)
				else 
					ent:ChatNotify("Kristal garip bir enerji yayıyor...")
					
					ent:ScreenFade(SCREENFADE.IN, Color(255, 255, 0, 100), 1, 1)
				end 
            end
        end
		self:NextThink(CurTime() + 10)
		return true 
	end

	function ENT:OnTakeDamage(damage)
		self.health = self.health - damage:GetDamage()
		self:EmitSound("physics/glass/glass_bottle_break"..math.random(1, 2)..".wav")
		if (self.health <= 0) and self.isDestroyed != true then
			self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			self.isDestroyed = true 
			
			for i, ply in ipairs(player.GetAll()) do			
				ply:ChatNotify("Kristal parçalanıyor ve yerden yükselen bir enerji dalgası hissediliyor...")
			end
			
			startGravityEvent()
			self:Remove()
		end
	end


	function ENT:OnRemove()
		if IsValid(self.barricadeEnt) then 
			self.barricadeEnt:Remove()
		end 
		self:StopSound("vj_hlr/fx/alien_cycletone.wav")
	end
end