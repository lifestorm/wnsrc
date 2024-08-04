--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ENT.Base = "base_entity"
ENT.Type = "filter"

--[[---------------------------------------------------------
	Name: Initialize
-----------------------------------------------------------]]
function ENT:Initialize()
end

--[[---------------------------------------------------------
	Name: KeyValue
	Desc: Called when a keyvalue is added to us
-----------------------------------------------------------]]
function ENT:KeyValue( key, value )
end

--[[---------------------------------------------------------
	Name: Think
	Desc: Entity's think function. 
-----------------------------------------------------------]]
function ENT:Think()
end

--[[---------------------------------------------------------
	Name: OnRemove
	Desc: Called just before entity is deleted
-----------------------------------------------------------]]
function ENT:OnRemove()
end

--[[---------------------------------------------------------
	Name: PassesFilter
-----------------------------------------------------------]]
function ENT:PassesFilter( trigger, ent )
	return true
end

--[[---------------------------------------------------------
	Name: PassesDamageFilter
-----------------------------------------------------------]]
function ENT:PassesDamageFilter( dmg )
	return true
end
