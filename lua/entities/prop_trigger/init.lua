--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

resource.AddFile("materials/prop_trigger/toolstrigger.vmt")

function ENT:Initialize(model)
	if (!model) then return end

	self.Entity:SetModel(model)

	self.Entity:SetMaterial("prop_trigger/toolstrigger")
	self.Entity:SetCollisionBounds(Vector()*-2, Vector()*2)
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WORLD )
	self.Entity:DrawShadow(true)
	self.Entity:SetColor( Color(255,255,255,150) )
	self.Entity:SetRenderMode( RENDERMODE_TRANSALPHA )
	local phys = self.Entity:GetPhysicsObject()
		if phys and phys:IsValid() then 
			phys:Sleep()
			phys:EnableCollisions(false)
			phys:EnableMotion(false)
			phys:EnableGravity(false)
		end

	self.Entity:SetTrigger(true)

	constraint.NoCollide(self.Entity, game.GetWorld())
end
function ENT:PassesTriggerFilters(ent)
	if (self.settings["allow_players"] == "1") then
		return ent:IsPlayer()
	end
	if (self.settings["allow_npcs"] == "1") then
		return ent:IsNPC()
	end
	if (self.settings["allow_props"] == "1") then
		return ent:GetClass("prop_physics")
	end
end
function ENT:ForbiddenClass(ent)
	local forbidden = {
		"worldspawn",
		"soundent",
		"player_manager",
		"network",
		"env_fog_controller",
		"path_corner",
		"hint",
		"sky_camera",
		"shadow_control",
		"env_sun",
		"func_brush",
		"point_spotlight",
		"keyframe_rope",
		"info_player_start",
		"env_tonemap_controller",
		"lua_run",
		"path_track",
		"func_vehicleclip",
		"info_ladder_dismount",
		"env_sprite",
		"light_environment",
		"spotlight_end",
		"beam",
		"player",
		"filter_activator_name",
		"predicted_viewmodel",
		"phys_constraintsystem",
		"light",
		"func_reflective_glass",
		"func_button",
		"weapon_*",
		"logic_*",
		"phys_*",
		"info_*",
		"prop_trigger",
	}
	for _,class in pairs(forbidden) do
		if (class == ent:GetClass()) then
			return true
		end
	end
end
function ENT:ToggleSwitch()
	if (self:GetOwner().keystate[tonumber(self.settings["output1"])]) then
		numpad.Deactivate(self:GetOwner(), self.settings["output1"])
	else
		numpad.Activate(self:GetOwner(), self.settings["output1"])
	end
	if (self:GetOwner().keystate[tonumber(self.settings["output2"])]) then
		numpad.Deactivate(self:GetOwner(), self.settings["output2"])
	else
		numpad.Activate(self:GetOwner(), self.settings["output2"])
	end
end
function ENT:StartTouch( ent )
	if (!IsValid(self) and !IsValid(self:GetOwner())) then return end
	if (!self:PassesTriggerFilters(ent)) then return end
	
	if (self.settings["toggle_type"] == "0") then
		numpad.Activate(self:GetOwner(), self.settings["output1"])
		numpad.Activate(self:GetOwner(), self.settings["output2"])
		numpad.Deactivate(self:GetOwner(), self.settings["output1"])
		numpad.Deactivate(self:GetOwner(), self.settings["output2"])
	else
		self:ToggleSwitch()
	end

	if (IsValid(Entity(tonumber(self.settings["tar_index"])))) then
		local target = Entity(tonumber(self.settings["tar_index"]))
		if (!self:ForbiddenClass(target) && target != game.GetWorld()) then
			target:Fire(tostring(self.settings["tar_input"]), tostring(self.settings["tar_param"]), tonumber(self.settings["tar_delay"]))
		else
			self:GetOwner():SendLua("GAMEMODE:AddNotify('Forbidden Target index ".. self.settings["tar_index"] .."!', NOTIFY_ERROR, 5)")
		end
	end

	if (self.settings["type"] == "1") then
		self.triggered = true
		self:Remove()
	end
end
function ENT:EndTouch( ent )
	if (!IsValid(self) and !IsValid(self:GetOwner())) then return end
	if (!self:PassesTriggerFilters(ent)) then return end
	if (self.settings["toggle_type"] == "0") then
		return
	elseif (self.settings["toggle_type"] == "1") then
		self:ToggleSwitch()
	elseif(self.settings["toggle_type"] == "2") then
		return
	end
end
function ENT:OnRemove()
	if (IsValid(self:GetOwner())) then
		if (self:GetOwner().keystate[tonumber(self.settings["output1"])]) then
			numpad.Deactivate(self:GetOwner(), self.settings["output1"])
		end
		if (self:GetOwner().keystate[tonumber(self.settings["output2"])]) then
			numpad.Deactivate(self:GetOwner(), self.settings["output2"])
		end
		if (self.triggered != true) then
			local res_mdl = ents.Create( "prop_physics" )
				res_mdl:SetModel( self:GetModel() )
				res_mdl:PhysicsInit( SOLID_VPHYSICS )
				res_mdl:SetMoveType( MOVETYPE_VPHYSICS )
				res_mdl:SetSolid( SOLID_VPHYSICS )
				res_mdl:SetCollisionGroup( COLLISION_GROUP_NONE )
				res_mdl:SetPos( self:GetPos() )
				res_mdl:SetAngles(self:GetAngles() )
				res_mdl:SetColor( self:GetColor() )
				res_mdl:Spawn()
				res_mdl:Activate()
			undo.Create("prop")
				undo.AddEntity(res_mdl)
				undo.SetPlayer(self:GetOwner())
			undo.Finish()
		end
	end
end
function ENT:Think()
	if (!IsValid(self:GetOwner())) then
		self:Remove()
	end
end
 /*function ENT:Touch( ent )
	No need for this function.
end*/
/*function ENT:Use( activator, caller )
	Garry's Mod has a Button STool.
end*/