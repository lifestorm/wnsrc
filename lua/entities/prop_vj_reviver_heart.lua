--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

/*--------------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()
if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end

ENT.Base 			= "prop_vj_animatable"
ENT.Type 			= "anim"
ENT.PrintName 		= "Used to be a flag"
ENT.Author 			= "DrVrej and cc123"
ENT.Contact 		= ""
ENT.Purpose 		= "Used for flags. Maybe."
ENT.Instructions 	= "Don't change anything. Please."
ENT.Category		= "Half-Life: Alyx"
ENT.SoundTbl_Idle   = {"creatures/headcrab_reviver/heartbeat_01.wav","creatures/headcrab_reviver/heartbeat_02.wav","creatures/headcrab_reviver/heartbeat_03.wav"}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

function ENT:CustomOnInitialize()
	self:SetModel("models/creatures/headcrabs/gibs/headcrab_reviver/reviver_heart.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:ResetSequence("heart_idle")
	
	self.WaveSound = VJ_CreateSound(self, self.SoundTbl_Idle, 60)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRemove()
	VJ_STOPSOUND(self.WaveSound)
end