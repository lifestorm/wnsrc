--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if (SERVER) then
	AddCSLuaFile();
end;

DEFINE_BASECLASS("base_entity");

ENT.PrintName		= "Ladder (BASE)";
ENT.Category		= "Ladders";
ENT.Spawnable		= false;
ENT.AdminOnly		= false;
ENT.Model			= Model("models/props_c17/metalladder001.mdl");
ENT.RenderGroup 	= RENDERGROUP_BOTH;

if (SERVER) then

	function ENT:Initialize()
		self:SetModel(self.Model);
		self:SetSolid(SOLID_VPHYSICS);
		self:PhysicsInit(SOLID_VPHYSICS);
		self:SetUseType(SIMPLE_USE);
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON);
		local phys = self:GetPhysicsObject();

		if (IsValid(phys)) then
			phys:EnableMotion(false);
		end;

		self:UpdateLadder(true);
	end;

	function ENT:UpdateLadder(bCreate)
		if (bCreate) then
			local oldAngs = self:GetAngles();

			self:SetAngles(Angle(0, 0, 0));

			local pos = self:GetPos();
			local dist = self:OBBMaxs().x + 17;
			local dismountDist = self:OBBMaxs().x + 49;
			local bottom = self:LocalToWorld(Vector(0, 0, self:OBBMins().z));
			local top = self:LocalToWorld(Vector(0, 0, self:OBBMaxs().z));

			for k, v in pairs(self:GetChildren()) do
				SafeRemoveEntity(v);
			end;

			self.ladder = ents.Create("func_useableladder");
			self.ladder:SetPos(pos + self:GetForward() * dist);
			self.ladder:SetKeyValue("point0", tostring(bottom + self:GetForward() * dist));
			self.ladder:SetKeyValue("point1", tostring(top + self:GetForward() * dist));
			self.ladder:SetKeyValue("targetname", "zladder_" .. self:EntIndex());
			self.ladder:SetParent(self);
			self.ladder:Spawn();

			self.bottomDismount = ents.Create("info_ladder_dismount");
			self.bottomDismount:SetPos(bottom + self:GetForward() * dismountDist);
			self.bottomDismount:SetKeyValue("laddername", "zladder_" .. self:EntIndex());
			self.bottomDismount:SetParent(self);
			self.bottomDismount:Spawn();

			self.topDismount = ents.Create("info_ladder_dismount");
			self.topDismount:SetPos(top - self:GetForward() * dist);
			self.topDismount:SetKeyValue("laddername", "zladder_" .. self:EntIndex());
			self.topDismount:SetParent(self);
			self.topDismount:Spawn();

			self.ladder:Activate();

			self:SetAngles(oldAngs);
		else
			self.ladder:Activate();
		end;
	end;

	function ENT:Think()
		if (IsValid(self.ladder)) then
			self:UpdateLadder();
			self:NextThink(CurTime() + 1);
			return true;
		end;
	end;

elseif (CLIENT) then

	function ENT:Initialize()
		self:SetSolid(SOLID_VPHYSICS);
	end;

	function ENT:Draw()
		self:DrawModel();
	end;
end;