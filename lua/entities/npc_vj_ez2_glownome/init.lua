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
ENT.Model = {"models/ez2/glownome.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 725
ENT.HullType = HULL_WIDE_HUMAN

function ENT:CustomOnInitialize() 
local GlowingBlueLight1 = ents.Create("light_dynamic")
GlowingBlueLight1:Fire("SetParentAttachment","goostring1_start")
GlowingBlueLight1:SetKeyValue("brightness", "4")
GlowingBlueLight1:SetKeyValue("distance", "160")
GlowingBlueLight1:SetPos(self:GetPos())
GlowingBlueLight1:Fire("Color", "60 150 255")
GlowingBlueLight1:SetParent(self)
GlowingBlueLight1:Spawn()
GlowingBlueLight1:Activate()
self:DeleteOnRemove(GlowingBlueLight1)

local GlowingBlueLight2 = ents.Create("light_dynamic")
GlowingBlueLight2:Fire("SetParentAttachment","goostring2_start")
GlowingBlueLight2:SetKeyValue("brightness", "4")
GlowingBlueLight2:SetKeyValue("distance", "160")
GlowingBlueLight2:SetPos(self:GetPos())
GlowingBlueLight2:Fire("Color", "60 150 255")
GlowingBlueLight2:SetParent(self)
GlowingBlueLight2:Spawn()
GlowingBlueLight2:Activate()
self:DeleteOnRemove(GlowingBlueLight2)

local GlowingBlueLight3 = ents.Create("light_dynamic")
GlowingBlueLight3:Fire("SetParentAttachment","goostring1_end")
GlowingBlueLight3:SetKeyValue("brightness", "2")
GlowingBlueLight3:SetKeyValue("distance", "160")
GlowingBlueLight3:SetPos(self:GetPos())
GlowingBlueLight3:Fire("Color", "60 150 255")
GlowingBlueLight3:SetParent(self)
GlowingBlueLight3:Spawn()
GlowingBlueLight3:Activate()
self:DeleteOnRemove(GlowingBlueLight3)

local GlowingBlueLight4 = ents.Create("light_dynamic")
GlowingBlueLight4:Fire("SetParentAttachment","goostring2_end")
GlowingBlueLight4:SetKeyValue("brightness", "2")
GlowingBlueLight4:SetKeyValue("distance", "160")
GlowingBlueLight4:SetPos(self:GetPos())
GlowingBlueLight4:Fire("Color", "60 150 255")
GlowingBlueLight4:SetParent(self)
GlowingBlueLight4:Spawn()
GlowingBlueLight4:Activate()
self:DeleteOnRemove(GlowingBlueLight4)
if GetConVarNumber("vj_can_gonomes_have_worldshake") == 1 then
self.HasWorldShakeOnMove = false
end
end
