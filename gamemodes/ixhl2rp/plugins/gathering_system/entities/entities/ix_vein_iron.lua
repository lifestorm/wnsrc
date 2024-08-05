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
ENT.PrintName = "Iron Pile";
ENT.Spawnable = true;
ENT.AdminSpawnable = true;
ENT.Category = "Gathering System";

if (SERVER) then 		
	function ENT:Initialize()
		self:SetModel("models/willard/work/copperrock.mdl");
		self:SetMoveType(MOVETYPE_VPHYSICS);
		self:PhysicsInit(SOLID_VPHYSICS);
		self:SetUseType(SIMPLE_USE);
		self:SetSolid(SOLID_VPHYSICS);
		self.BreakSounds = {"physics/concrete/boulder_impact_hard1.wav", "physics/concrete/boulder_impact_hard2.wav", "physics/concrete/boulder_impact_hard3.wav", "physics/concrete/boulder_impact_hard4.wav"};
		
		local physicsObject = self:GetPhysicsObject();
		
		if (IsValid(physicsObject)) then
			physicsObject:Wake();
			physicsObject:EnableMotion(false);
		end;
	end;

	function ENT:OnTakeDamage(damageInfo)
		local player = damageInfo:GetAttacker();
		
		if IsValid(player) and player:IsPlayer() then
			local activeWeapon = tostring(player:GetActiveWeapon())

			if string.find(activeWeapon, "tfa_nmrih_pickaxe") then
				local activeWeapon = player:GetActiveWeapon();
				
				self:EmitSound(self.BreakSounds[math.random(1, #self.BreakSounds)]);
				
				if !self.oreLeft then
					self.oreLeft = math.random(6, 8);
				end
				
				if !self.strikesRequired then
					self.strikesRequired = math.random(5, 10);
				end
				
				self.strikesRequired = self.strikesRequired - 1;
				
				
				if self.strikesRequired <= 0 then
					local entPos = self:GetPos();
					local character = player:GetCharacter()
					local inventory = character:GetInventory()
					local pickaxe = inventory:HasItem("pickaxe") 

					if (pickaxe:GetData("equip")) then
						pickaxe:DamageDurability(1)
					end 

					if (!character:GetInventory():Add("iron_ore")) then
						ix.item.Spawn("iron_ore", player)
					end

					ix.chat.Send(player, "me", "mines some ore!")
					self:EmitSound("physics/concrete/concrete_break2.wav");
	
					self.oreLeft = self.oreLeft - 1;
					self.strikesRequired = math.random(5, 10);
				end
				
				if self.oreLeft <= 0 then
					self:EmitSound("physics/concrete/concrete_break2.wav");
					self:Remove();
				end
			end
		end
	end

	function ENT:OnRemove()
	end;
end 