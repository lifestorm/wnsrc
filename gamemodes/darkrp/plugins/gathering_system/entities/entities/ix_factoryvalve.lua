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
ENT.PrintName = "Factory Valve";
ENT.Spawnable = false;
ENT.AdminSpawnable = true;
ENT.Category = "Gathering System";

local PLUGIN = PLUGIN 
if (SERVER) then 
	function ENT:Initialize()
		self:SetModel("models/props_pipes/valvewheel002a.mdl");
		self:SetMoveType(MOVETYPE_VPHYSICS);
		self:PhysicsInit(SOLID_VPHYSICS);
		self:SetUseType(SIMPLE_USE);
		self:SetSolid(SOLID_VPHYSICS);
		
		local physicsObject = self:GetPhysicsObject();
		
		if (IsValid(physicsObject)) then
			physicsObject:Wake();
			physicsObject:EnableMotion(false);
		end;
	end;

	function ENT:UpdateTransmitState()
		return TRANSMIT_ALWAYS;
	end;

	function ENT:StartOverheating()
		if self.overheating ~= true then
			self.overheating = true;
			self.sound = CreateSound(self, "ambient/gas/steam_loop1.wav", RecipientFilter():AddPVS(self:GetPos()));
			self.sound:PlayEx(1, 150);
			
			self.steam = ents.Create("prop_physics");
			self.steam:SetPos(self:GetPos());
			self.steam:SetModel("models/hunter/blocks/cube025x025x025.mdl");
			self.steam:Spawn();
			self.steam:SetCollisionGroup(COLLISION_GROUP_WORLD);
			self.steam:SetRenderMode(RENDERMODE_TRANSALPHA);
			self.steam:SetColor(Color(0, 0, 0, 0));
			self.steam:DrawShadow(false);
			
			local physicsObject = self.steam:GetPhysicsObject();
			
			if (IsValid(physicsObject)) then
				physicsObject:Wake();
				physicsObject:EnableMotion(false);
			end;
			
			ParticleEffect("steam_jet_80_steam", self.steam:GetPos(), self.steamAngles or self:GetAngles(), self.steam);
		end
	end

	function ENT:StopOverheating()
		self.overheating = false;
		
		if IsValid(self.steam) then
			self.steam:Remove();
		end
		
		if self.sound then
			self.sound:Stop();
		end
		
	end

	function ENT:Use(activator, caller)
	end;

	function ENT:OnRemove()
		if IsValid(self.steam) then
			self.steam:Remove();
		end
		
		if self.sound then
			self.sound:Stop();
		end
	end;
else
	function ENT:OnPopulateEntityInfo(container)
		if self.overheating == true then
			local name = container:AddRow("name")
			name:SetImportant()
			name:SetText(L("Valve"))
			name:SizeToContents()

			local description = container:AddRow("description")
			description:SetText(L("Press [E] to interact"))
			description:SizeToContents()
		end 
	end
end  