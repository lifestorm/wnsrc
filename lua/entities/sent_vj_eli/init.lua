--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.SingleSpawner = true -- If set to true, it will spawn the entities once then remove itself
ENT.Model = {"models/props_junk/popcan01a.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.EntitiesToSpawn = {

	{EntityName = "NPC1",SpawnPosition = {vForward=0,vRight=0,vUp=0},Entities = {"npc_vj_hl2_eli","npc_vj_hl2_eli2"}}--,WeaponsList = {"weapon_vj_spas12_hl2", "weapon_vj_smg1_hl2", "weapon_vj_smg1_hl2", "weapon_vj_arbalet_hl2", "weapon_vj_ar2_hl2", "weapon_vj_ar2_hl2", "weapon_vj_rpg_hl2"}},
}

function ENT:Initialize()

	if self:GetModel() == "models/error.mdl" then

	self:SetModel(VJ_PICKRANDOMTABLE(self.Model)) end
	self:DrawShadow(false)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self.CurrentEntities = {}
	self:CustomOnInitialize_BeforeNPCSpawn()
	self.NumberOfEntitiesToSpawn =  table.Count(self.EntitiesToSpawn)
	for k,v in ipairs(self.EntitiesToSpawn) do self:SpawnAnEntity(k,v,true) end
	self:CustomOnInitialize_AfterNPCSpawn()
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/