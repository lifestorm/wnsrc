--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

CreateConVar("dog_friendly_fire","0",{FCVAR_ARCHIVE,FCVAR_REPLICATED,FCVAR_SERVER_CAN_EXECUTE})
CreateConVar("dog_follows","1",{FCVAR_ARCHIVE,FCVAR_REPLICATED,FCVAR_SERVER_CAN_EXECUTE})
CreateConVar("dog_healths","2100",{FCVAR_ARCHIVE,FCVAR_REPLICATED,FCVAR_SERVER_CAN_EXECUTE})
CreateConVar("dog_campaignfixs","0",{FCVAR_ARCHIVE,FCVAR_REPLICATED,FCVAR_SERVER_CAN_EXECUTE})

function FindNearestEntity( className, pos, range )
local nearestEnt
    range = range ^ 2
	for _, ent in pairs( ents.FindByClass( className ) ) do
	if IsValid(ent) and !ent.IsThrown and !(ent:OBBMaxs().x > 140 or ent:OBBMaxs().y > 140 or ent:OBBMaxs().z > 140) and IsValid(ent:GetPhysicsObject()) and ent:GetPhysicsObject():GetMass() >= 10 then
	local distance = (pos - ent:GetPos()):LengthSqr()
        if( distance <= range ) then
            nearestEnt = ent
            range = distance
        end
	end
	end
		return nearestEnt
end
function FindNearestEntity2( className, pos, range )
local nearestEnt
    range = range ^ 2
	for _, ent in pairs( ents.FindByClass( className ) ) do
	if IsValid(ent) then
	local distance = (pos - ent:GetPos()):LengthSqr()
        if( distance <= range ) then
            nearestEnt = ent
            range = distance
        end
	end
	end
		return nearestEnt
end

local function Spawn_lightning(owner,victim)
   local bone = owner:LookupBone("Dog_Model.Hand_R")
   local m = owner:GetBoneMatrix(bone)
   if (m) then
   pos, ang = m:GetTranslation() , m:GetAngles()
   end
   local teslaStart = ents.Create( "info_target" )
   teslaStart:SetPos( pos )
   teslaStart:SetName( "teslaStart" .. owner:EntIndex() )
   
   local teslaEnd = ents.Create( "info_target" )
   teslaEnd:SetPos( victim:GetPos() )
   teslaEnd:SetName( "teslaEnd" .. owner:EntIndex() )
   teslaEnd:Spawn( )
   teslaEnd:SetParent(victim)
   
  local teslaBeam = ents.Create( "env_beam" )
   teslaBeam:SetPos(pos)
   teslaBeam:SetName( "teslaBeam" )
   teslaBeam:SetKeyValue( "texture", "sprites/physcannon_bluelight1.vmt")
   teslaBeam:SetKeyValue( "renderamt", "255" )
   teslaBeam:SetKeyValue( "rendercolor", "255 255 255" )
   teslaBeam:SetKeyValue( "life", "0" )
   teslaBeam:SetKeyValue( "damage", "0" )
   teslaBeam:SetKeyValue( "LightningStart", "teslaStart" .. owner:EntIndex() )
   teslaBeam:SetKeyValue( "LightningEnd", "teslaEnd" .. owner:EntIndex() )
   teslaBeam:SetKeyValue( "spawnflags", "1" )
   teslaBeam:SetKeyValue( "TouchType", 0 )
   teslaBeam:SetKeyValue( "framestart", 0 )
   teslaBeam:SetKeyValue( "framerate", 0 )
   teslaBeam:SetKeyValue( "NoiseAmplitude", 5 )
   teslaBeam:SetKeyValue( "TextureScroll", 35 )
   teslaBeam:SetKeyValue( "BoltWidth", 4 )
   teslaBeam:SetKeyValue( "Radius", 256 )
   teslaBeam:SetKeyValue( "StrikeTime", 1 )

   teslaStart:Spawn( )
   teslaBeam:Spawn( )

   teslaBeam:Activate( )
   teslaBeam:Fire( "TurnOn", "", 0)
   teslaBeam:Fire("kill", "", 1.8)
   teslaStart:Fire( "kill", "", 1.8 )
   teslaEnd:Fire( "kill", "", 1.8 )
   teslaStart:SetParent(owner)
   
end

hook.Add("OnNPCKilled","DOGGSS_Hide_Weapon",function(npc,attacker,inflictor)
if IsValid(npc:GetActiveWeapon()) and npc:GetClass()=="npc_vj_hl2_dog" then
npc:GetActiveWeapon():Remove()
end
if GetConVar("dog_campaignfixs"):GetBool() and npc:GetClass()=="npc_vj_hl2_dog" and !npc.SpawnedForCampaign then
return
end
if npc:GetClass()=="npc_vj_hl2_dog" then
npc:EmitSound("NPC_dog.Scared_1")
end
end)

hook.Add("PreCleanupMap","DOGGSS_Fix",function()
for k,v in pairs(hook.GetTable().Think) do
if string.find(k,"bigdoggsattac") then
hook.Remove("Think",k)
end
end
for k,v in pairs(hook.GetTable().EntityTakeDamage) do
if string.find(k,"bigdoggsattac_func") then
hook.Remove("EntityTakeDamage",k)
end
end
end)

function FollowDoggs( ply, key )
if (key == IN_USE) then
if !GetConVar("dog_follows"):GetBool() then
return
end
local tr = util.TraceLine( {
start = ply:EyePos( ),
endpos = ply:EyePos( ) + ply:GetAimVector( ) * 100,
filter = ply })
if GetConVar("dog_campaignfixs"):GetBool() and IsValid(tr.Entity) and tr.Entity:GetClass() == "npc_vj_hl2_dog" and !tr.Entity.SpawnedForCampaign then
return
end
if IsValid(tr.Entity) and tr.Entity:GetClass() == "npc_vj_hl2_dog" and (tr.Entity:Disposition(ply) == D_LI or tr.Entity:Disposition(ply) == D_NU) and tr.Entity:GetNWFloat("next_follow_wait") < CurTime() and SERVER then
if !tr.Entity.FollowFreeman then
tr.Entity:EmitSound("NPC_dog.Playful_5")
tr.Entity.FollowFreeman = true
tr.Entity.FollowEnt = ply
tr.Entity:SetNWFloat("next_follow_wait",(tr.Entity:SequenceDuration( tr.Entity:LookupSequence("excitedpound") )) + CurTime())
tr.Entity:AddGestureSequence( tr.Entity:LookupSequence("excitedpound"), true )
tr.Entity:SetSchedule(SCHED_WAIT_FOR_SCRIPT)
tr.Entity.Attac = true
timer.Create("doggs_stop_excite" .. tr.Entity:EntIndex(),tr.Entity:SequenceDuration( tr.Entity:LookupSequence("excitedpound") ),1, function()
if IsValid(tr.Entity) then
tr.Entity.Attac = false
tr.Entity:SetSchedule(SCHED_COMBAT_FACE)
end
end)
else
tr.Entity.FollowFreeman = false
tr.Entity.FollowEnt = nil
tr.Entity:EmitSound("NPC_dog.Dissapointed_1")
tr.Entity:SetNWFloat("next_follow_wait",(tr.Entity:SequenceDuration( tr.Entity:LookupSequence("disappointed") )) + CurTime())
tr.Entity:AddGestureSequence( tr.Entity:LookupSequence("disappointed"), true )
tr.Entity:SetSchedule(SCHED_WAIT_FOR_SCRIPT)
tr.Entity.Attac = true
timer.Create("doggs_stop_excite" .. tr.Entity:EntIndex(),tr.Entity:SequenceDuration( tr.Entity:LookupSequence("disappointed") ),1, function()
if IsValid(tr.Entity) then
tr.Entity.Attac = false
tr.Entity:SetSchedule(SCHED_COMBAT_FACE)
end
end)
end
end
end
end
        			
hook.Add( "KeyPress", "FollowDoggs", FollowDoggs )

hook.Add("PlayerSpawnedNPC","DOGGSS_SpawnMode",function(ply,ent)
if GetConVar("dog_campaignfixs"):GetBool() then
if ent:GetClass()=="npc_vj_hl2_dog" then
ent.SpawnedForCampaign = true
end
end
end)

hook.Add("OnEntityCreated","DOGGSS_he_attac",function(ent)
if ent:GetClass()=="npc_hunter" then
local entidx2 = "hate_doggs" .. ent:EntIndex()
timer.Create(entidx2,1,0,function()
if IsValid(ent) then
local findent = FindNearestEntity("npc_vj_hl2_dog",ent:GetPos(), 1000)
if IsValid(findent) then
ent:ClearEnemyMemory()
ent:SetEnemy(findent)
end
else
timer.Remove(entidx2)
end
end)
end
if string.find(ent:GetClass(),"npc_helicopter") or string.find(ent:GetClass(),"npc_combinegunship") or string.find(ent:GetClass(),"prop_vehicle_apc") or string.find(ent:GetClass(),"npc_hunter") then
for k,v in pairs(ents.GetAll()) do
if string.find(v:GetClass(),"npc_vj_hl2_dog") then
v:AddEntityRelationship(ent,1,99)
end
end
end
if string.find(ent:GetClass(),"npc_strider") then
for k,v in pairs(ents.GetAll()) do
if string.find(v:GetClass(),"npc_vj_hl2_dog") then
v:AddEntityRelationship(ent,2,99)
end
end
end
timer.Simple(GetConVar("dog_campaignfixs"):GetBool() and 0.02 or 0,function()
if IsValid(ent) then
if ent:GetClass()=="npc_vj_hl2_dog" then
if GetConVar("dog_campaignfixs"):GetBool() and !ent.SpawnedForCampaign then
return
end
timer.Simple(0.05,function()
if IsValid(ent) then
ent:SetMaxHealth( GetConVarNumber("dog_healths") )
ent:SetHealth( GetConVarNumber("dog_healths") )
end
end)
ent:Give("weapon_crowbar")
ent:GetActiveWeapon():SetNoDraw(true)
for k,v in pairs(ents.GetAll()) do
if string.find(v:GetClass(),"npc_helicopter") or string.find(v:GetClass(),"npc_combinegunship") or string.find(v:GetClass(),"prop_vehicle_apc") or string.find(v:GetClass(),"npc_hunter") then
ent:AddEntityRelationship(v,1,99)
end
if string.find(v:GetClass(),"npc_strider") then
ent:AddEntityRelationship(v,2,99)
end 
end
local entidx = ent:EntIndex()
	hook.Add( "EntityTakeDamage", "bigdoggsattac_func" .. entidx, function( target, dmginfo )
	if dmg_doggsattac then return end
	dmg_doggsattac = true
	local ent = Entity(entidx)
	if target == ent and IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker():IsPlayer() and (target:Disposition(dmginfo:GetAttacker()) == D_LI or target:Disposition(dmginfo:GetAttacker()) == D_NU) and GetConVar("dog_friendly_fires"):GetBool() then
	target:AddEntityRelationship(dmginfo:GetAttacker(),1,0)
	end
	if target == ent and IsValid(dmginfo:GetAttacker()) and (dmginfo:GetAttacker():GetClass()=="npc_headcrab_black" or dmginfo:GetAttacker():GetClass()=="npc_headcrab_poison") then
	target:SetHealth(target:Health() + 100)
	end
	if target == ent and IsValid(dmginfo:GetAttacker()) and (dmginfo:GetAttacker():GetClass()=="npc_antlionguard" ) then
	dmginfo:SetDamage(math.Clamp(dmginfo:GetDamage(),0,22))
	target:TakeDamageInfo(dmginfo)
	end
	if IsValid(target) and target == ent and IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker() == target then
	dmginfo:SetDamage(0)
	target:TakeDamageInfo(dmginfo)
	end
	if IsValid(target) and target == ent and IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker():IsRagdoll() then
	dmginfo:SetDamage(0)
	target:TakeDamageInfo(dmginfo)
	end
	if IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker() == ent and (target:IsNPC() or target:IsPlayer()) then
	if IsValid(target) and IsValid(ent) and target != ent and (ent:Disposition(target) == D_LI or ent:Disposition(target) == D_NU) then
	dmginfo:SetDamage(0)
	target:TakeDamageInfo(dmginfo)
	end
	end
	dmg_doggsattac = false
	end)
	hook.Add("Think", "bigdoggsattac" .. entidx,function()
	local ent = Entity(entidx)
	if !IsValid(ent) then  
	hook.Remove("Think","bigdoggsattac" .. entidx)
	hook.Remove("EntityTakeDamage","bigdoggsattac_func" .. entidx)
	return 
	end
	if ent.FollowFreeman and IsValid(ent.FollowEnt) and !ent.Attac then
	if ent:GetNWFloat("next_follow_wait") < CurTime() and ent:GetNWFloat("next_follow") < CurTime() and ((!IsValid(ent:GetEnemy())) or (IsValid(ent:GetEnemy()) and (ent:GetPos():Distance(ent:GetEnemy():GetPos()) >= 600))) then
	ent:SetNWFloat("next_follow",1 + CurTime())
	if (ent:GetPos():Distance(ent.FollowEnt:GetPos()) > 150) then
	ent:SetLastPosition(ent.FollowEnt:GetPos() + Vector(math.Rand(-80,80),math.Rand(-80,80),0))
	ent:SetSchedule(SCHED_FORCED_GO_RUN)
	else
	if ent:IsCurrentSchedule(SCHED_FORCED_GO_RUN) then
	ent:ClearSchedule()
	ent:StopMoving()
	end
	end
	end
	end
	if !IsValid(ent:GetEnemy()) then
	local nearent
	nearent = FindNearestEntity2("prop_vehicle_apc",ent:GetPos(), 7000)
	if IsValid(nearent) and ent:GetNWFloat("search_for_prop") < CurTime() and !ent:IsCurrentSchedule(SCHED_WAIT_FOR_SCRIPT) then
	ent:SetNWFloat("search_for_prop",5 + CurTime())
	if (ent:GetPos():Distance(nearent:GetPos()) > 100) then
	ent:SetLastPosition(nearent:GetPos())
	ent:SetSchedule(SCHED_FORCED_GO_RUN)
	end
	end
	local nearent
	nearent = FindNearestEntity2("prop_vehicle_apc",ent:GetPos(), 7000)
	if IsValid(nearent) and (ent:GetPos():Distance(nearent:GetPos()) <= math.Clamp(nearent:OBBMaxs().x/1.5 + nearent:OBBMaxs().y/1.5 + nearent:OBBMaxs().z/1.5,75,135)) and !ent.Attac then
	if ent:IsCurrentSchedule(SCHED_FORCED_GO_RUN) then
	ent:ClearSchedule()
	ent:StopMoving()
	ent:SetNWFloat("next_attac",ent:SequenceDuration( ent:LookupSequence("apc_throw") ) + CurTime())
	ent:AddGestureSequence( ent:LookupSequence("apc_throw"), true )
	ent:SetSchedule(SCHED_WAIT_FOR_SCRIPT)
	ent.ThrowEnt = nearent
	ent.Attac = true
	--ent.ThrowEnt:SetPos(ent:GetAttachment(ent:LookupAttachment( "chestTarget" )).Pos)
	--ent.ThrowEnt:SetParent(ent)
	--ent.ThrowEnt:Fire("setparentattachment", "chestTarget", 0.01)
	local WPos = ent.ThrowEnt:GetPos()
	local PPos = ent:GetPos()
    local Ang = WPos - PPos
    Ang = Ang:Angle()
	ent:SetAngles(Angle(0,Ang.yaw,Ang.roll))
	timer.Create("doggs_attac_lauch_attach" .. ent:EntIndex(),ent:SequenceDuration( ent:LookupSequence("apc_throw") )/5,1, function()
	if IsValid(ent) and IsValid(ent.ThrowEnt) then
	ent:EmitSound("NPC_dog.Angry_2")
	ent.Throw = true
	constraint.NoCollide( ent.ThrowEnt, ent, 0, 0 )
	local bone = ent:LookupBone("Dog_Model.forward")
	local m = ent:GetBoneMatrix(bone)
	if (m) then
	pos, ang = m:GetTranslation() , m:GetAngles()
	end
	ent.ThrowEnt:SetPos(ent:EyePos() + ent:GetForward()*-10 + ent:GetUp()*-60)
	ent.ThrowEnt:FollowBone( ent, ent:LookupBone("Dog_Model.forward") )
	ent.ThrowEnt.Anglebone = ent.ThrowEnt:GetAngles()
	end
	end)
	timer.Create("doggs_attac_lauch" .. ent:EntIndex(),ent:SequenceDuration( ent:LookupSequence("apc_throw") )/1.3,1, function()
	if IsValid(ent) then
	ent.Throw = false
	if IsValid(ent.ThrowEnt) then
	ent.ThrowEnt:FollowBone(NULL,0)
	ent.ThrowEnt:SetAngles(ent.ThrowEnt.Anglebone)
	ent.ThrowEnt:GetPhysicsObject():EnableMotion(true)
	ent.ThrowEnt:GetPhysicsObject():SetVelocity(ent:GetForward()*20000 + Vector(0,0,1000))
	ent.ThrowEnt.Owner = ent
	ent.ThrowEnt.IsThrown = true
	ent.ThrowEnt.CollGroup = ent.ThrowEnt:GetCollisionGroup()
	ent.ThrowEnt:SetCollisionGroup( COLLISION_GROUP_WORLD )
	local entthrou = ent.ThrowEnt
	timer.Simple(0.02,function()
	if IsValid(entthrou) then
	entthrou:SetCollisionGroup( COLLISION_GROUP_NONE )
	end
	end)
	timer.Simple(1,function()
	if IsValid(entthrou) and entthrou:GetClass() == "prop_vehicle_apc" then
	entthrou:Fire("Destroy","",0)
	end
	end)
	ent.ThrowEnt:AddCallback( "PhysicsCollide", function( obj, data )
	if obj:GetClass()=="prop_vehicle_apc" then
	obj:Fire("Destroy","",0)
	end
	if data.HitEntity:GetClass() == "npc_strider" or data.HitEntity:GetClass() == "npc_hunter" or data.HitEntity:GetClass() == "npc_antlionguard" then
	data.HitEntity:TakeDamage(data.Speed)
	end
	if data.Speed >= 200 and obj:GetPhysicsObject():GetMass() >= 50 then
	for k,v in pairs(ents.FindInSphere(obj:GetPos(),350)) do
	if v:GetClass()=="npc_strider" then
	v:TakeDamage(data.Speed)
	end
	if (v:GetClass()=="npc_helicopter" or v:GetClass()=="npc_combinegunship") then
	v:Fire("SelfDestruct","",0)
	end
	end
	end
	end)
	end
	ent.ThrowEnt.IsThrown = false
	ent.ThrowEnt = nil
	end
	end)
	timer.Create("doggs_attac_lauch_stop" .. ent:EntIndex(),ent:SequenceDuration( ent:LookupSequence("apc_throw") ),1, function()
	if IsValid(ent) then
	ent.Throw = false
	if IsValid(ent.ThrowEnt) then
	ent.ThrowEnt.IsThrown = false
	end
	ent.ThrowEnt = nil
	ent.Attac = false
	ent:SetSchedule(SCHED_COMBAT_FACE)
	end
	end)
	end
	end
	end
	if !IsValid(ent:GetEnemy()) then  
	return 
	end
	if IsValid(ent) then 
	local enemy = ent:GetEnemy()
	--[[ 
	if IsValid(enemy) then
	if ent:GetNWFloat("next_attac") < CurTime() then
	ent:SetNWFloat("next_attac",1 + CurTime())
	if (ent:GetPos():Distance(enemy:GetPos()) > 50) then
	ent:SetLastPosition(enemy:GetPos() + Vector(math.Rand(-50,50),math.Rand(-50,50),0))
	ent:SetSchedule(SCHED_FORCED_GO_RUN)
	else
	if ent:IsCurrentSchedule(SCHED_FORCED_GO_RUN) then
	ent:ClearSchedule()
	ent:StopMoving()
	end
	end
	end
	end
	--]]
	if (ent:GetPos():Distance(enemy:GetPos()) >= 300) then
	local nearent
	nearent = FindNearestEntity2("prop_vehicle_apc",ent:GetPos(), enemy:GetClass()=="npc_strider" and 7000 or 700)
	if !IsValid(nearent) then
	nearent = FindNearestEntity("prop_physics",ent:GetPos(),enemy:GetClass()=="npc_strider" and 7000 or 700)
	end
	if IsValid(nearent) and (ent:GetPos():Distance(nearent:GetPos()) <= math.Clamp(nearent:OBBMaxs().x/1.5 + nearent:OBBMaxs().y/1.5 + nearent:OBBMaxs().z/1.5,75,135)) and !ent.Attac then
	if ent:IsCurrentSchedule(SCHED_FORCED_GO_RUN) then
	ent:ClearSchedule()
	ent:StopMoving()
	ent:SetNWFloat("next_attac",ent:SequenceDuration( ent:LookupSequence("apc_throw") ) + CurTime())
	ent:AddGestureSequence( ent:LookupSequence("apc_throw"), true )
	ent:SetSchedule(SCHED_WAIT_FOR_SCRIPT)
	ent.ThrowEnt = nearent
	ent.Attac = true
	if ent.ThrowEnt:GetClass() != "prop_vehicle_apc" then
	ent.ThrowEnt:GetPhysicsObject():EnableMotion(false)
	end
	--ent.ThrowEnt:SetPos(ent:GetAttachment(ent:LookupAttachment( "chestTarget" )).Pos)
	--ent.ThrowEnt:SetParent(ent)
	--ent.ThrowEnt:Fire("setparentattachment", "chestTarget", 0.01)
	local WPos = ent.ThrowEnt:GetPos()
	local PPos = ent:GetPos()
    local Ang = WPos - PPos
    Ang = Ang:Angle()
	ent:SetAngles(Angle(0,Ang.yaw,Ang.roll))
	timer.Create("doggs_attac_lauch_attach" .. ent:EntIndex(),ent:SequenceDuration( ent:LookupSequence("apc_throw") )/5,1, function()
	if IsValid(ent) and IsValid(ent.ThrowEnt) then
	ent:EmitSound("NPC_dog.Angry_2")
	ent.Throw = true
	constraint.NoCollide( ent.ThrowEnt, ent, 0, 0 )
	local bone = ent:LookupBone("Dog_Model.forward")
	local m = ent:GetBoneMatrix(bone)
	if (m) then
	pos, ang = m:GetTranslation() , m:GetAngles()
	end
	ent.ThrowEnt:SetPos(ent:EyePos() + ent:GetForward()*-10 + ent:GetUp()*-60)
	ent.ThrowEnt:FollowBone( ent, ent:LookupBone("Dog_Model.forward") )
	ent.ThrowEnt.Anglebone = ent.ThrowEnt:GetAngles()
	end
	end)
	timer.Create("doggs_attac_lauch" .. ent:EntIndex(),ent:SequenceDuration( ent:LookupSequence("apc_throw") )/1.3,1, function()
	if IsValid(ent) and IsValid(enemy) then
	ent.Throw = false
	if IsValid(ent.ThrowEnt) then
	local vecup = enemy:GetClass()=="npc_strider" and 40 or 0
	ent.ThrowEnt:FollowBone(NULL,0)
	ent.ThrowEnt:SetAngles(ent.ThrowEnt.Anglebone)
	ent.ThrowEnt:GetPhysicsObject():EnableMotion(true)
	ent.ThrowEnt:GetPhysicsObject():SetVelocity((ent.ThrowEnt:GetPos() - (enemy:EyePos() + Vector(0,0,vecup)))*-200)
	ent.ThrowEnt.Owner = ent
	ent.ThrowEnt.IsThrown = true
	ent.ThrowEnt.CollGroup = ent.ThrowEnt:GetCollisionGroup()
	ent.ThrowEnt:SetCollisionGroup( COLLISION_GROUP_WORLD )
	local entthrou = ent.ThrowEnt
	timer.Simple(0.02,function()
	if IsValid(entthrou) then
	entthrou:SetCollisionGroup( COLLISION_GROUP_NONE )
	end
	end)
	timer.Simple(1,function()
	if IsValid(entthrou) and entthrou:GetClass() == "prop_vehicle_apc" then
	entthrou:Fire("Destroy","",0)
	end
	end)
	ent.ThrowEnt:AddCallback( "PhysicsCollide", function( obj, data )
	if obj:GetClass()=="prop_vehicle_apc" then
	obj:Fire("Destroy","",0)
	end
	if data.HitEntity:GetClass() == "npc_strider" or data.HitEntity:GetClass() == "npc_hunter" or data.HitEntity:GetClass() == "npc_antlionguard" then
	data.HitEntity:TakeDamage(data.Speed)
	end
	if data.Speed >= 200 and obj:GetPhysicsObject():GetMass() >= 50 then
	for k,v in pairs(ents.FindInSphere(obj:GetPos(),350)) do
	if v:GetClass()=="npc_strider" then
	v:TakeDamage(data.Speed)
	end
	if (v:GetClass()=="npc_helicopter" or v:GetClass()=="npc_combinegunship") then
	v:Fire("SelfDestruct","",0)
	end
	end
	end
	end)
	end
	ent.ThrowEnt.IsThrown = false
	ent.ThrowEnt = nil
	end
	end)
	timer.Create("doggs_attac_lauch_stop" .. ent:EntIndex(),ent:SequenceDuration( ent:LookupSequence("apc_throw") ),1, function()
	if IsValid(ent) then
	ent.Throw = false
	if IsValid(ent.ThrowEnt) then
	ent.ThrowEnt.IsThrown = false
	end
	ent.ThrowEnt = nil
	ent.Attac = false
	ent:SetSchedule(SCHED_COMBAT_FACE)
	end
	end)
	end
	end
	end
	if ent.Throw and IsValid(ent.ThrowEnt) then
	local bone = ent:LookupBone("Dog_Model.Hand_L")
	local m = ent:GetBoneMatrix(bone)
	if (m) then
	pos, ang = m:GetTranslation() , m:GetAngles()
	end
	--ent.ThrowEnt:SetPos(LocalToWorld( Vector(30,ent.ThrowEnt:OBBMaxs().z/3,50), Angle(0,0,0), pos, ang ))
	local WPos = enemy:GetPos()
	local PPos = ent:GetPos()
    local Ang = WPos - PPos
    Ang = Ang:Angle()
	ent:SetAngles(Angle(0,Ang.yaw,Ang.roll))
	end
	if ent.Attac then
	ent:SetSchedule(SCHED_WAIT_FOR_SCRIPT)
	end
	if IsValid(enemy) then
	local nearent
	nearent = FindNearestEntity2("prop_vehicle_apc",ent:GetPos(), ent:GetClass()=="npc_strider" and 7000 or 700)
	if !IsValid(nearent) then
	nearent = FindNearestEntity("prop_physics",ent:GetPos(),ent:GetClass()=="npc_strider" and 7000 or 700)
	end
	if IsValid(nearent) and (ent:GetPos():Distance(enemy:GetPos()) >= 300) and ent:GetNWFloat("search_for_prop") < CurTime() and !ent:IsCurrentSchedule(SCHED_WAIT_FOR_SCRIPT) then
	ent:SetNWFloat("search_for_prop",5 + CurTime())
	if (ent:GetPos():Distance(nearent:GetPos()) > 100) then
	ent:SetLastPosition(nearent:GetPos())
	ent:SetSchedule(SCHED_FORCED_GO_RUN)
	end
	end
	if !(enemy:Health() <= 0) and (ent:GetPos():Distance(enemy:GetPos()) <= 250) and !(ent:GetPos():Distance(enemy:GetPos()) <= 100) and ent:GetNWFloat("next_pull") < CurTime() then
	if !ent:IsCurrentSchedule(SCHED_WAIT_FOR_SCRIPT) then
	if math.random(1,3) == 3 then
	ent:ClearSchedule()
	ent:StopMoving()
	ent:AddGestureSequence( ent:LookupSequence("pick_up"), true )
	ent:SetNWFloat("next_pull",7 + CurTime())
	ent:SetSchedule(SCHED_WAIT_FOR_SCRIPT)
	ent.Attac = true
	local WPos = enemy:GetPos()
	local PPos = ent:GetPos()
    local Ang = WPos - PPos
    Ang = Ang:Angle()
	ent:SetAngles(Angle(0,Ang.yaw,Ang.roll))
	local oldenemy = enemy
	timer.Create("doggs_pull_start" .. ent:EntIndex(),ent:SequenceDuration( ent:LookupSequence("pick_up") )/2,1, function()
	if IsValid(ent) and IsValid(oldenemy) then
	local WPos = oldenemy:GetPos()
	local PPos = ent:GetPos()
    local Ang = WPos - PPos
    Ang = Ang:Angle()
	ent:SetAngles(Angle(0,Ang.yaw,Ang.roll))
	ent:AddGestureSequence( ent:LookupSequence("idle_holding"), true )
	ent:EmitSound("Weapon_PhysCannon.Pickup")
	local vecpull = (oldenemy:IsPlayer()) and -1 or (oldenemy:GetClass()=="npc_antlionguard") and -0.1 or -0.15
	local vecup = oldenemy:IsPlayer() and 700 or 500
	local vecforward = (oldenemy:IsPlayer()) and 70 or (oldenemy:GetClass()=="npc_antlionguard") and 40 or 20
	local plydown = (oldenemy:IsPlayer()) and -10 or 0
	oldenemy:SetVelocity(Vector(0,0,vecup))
	timer.Create("doggs_pull_fixvel" .. ent:EntIndex(),0.1,10, function()
	if IsValid(ent) and IsValid(oldenemy) then
	oldenemy:SetVelocity((oldenemy:GetPos() - (ent:GetPos() + ent:GetForward()*vecforward + Vector(0,0,-50)))*vecpull + Vector(0,0,plydown))
	end
	end)
	Spawn_lightning(ent,oldenemy)
	timer.Create("doggs_pull_stop" .. ent:EntIndex(),1.8,1, function()
	if IsValid(ent) then
	--ent:AddGestureSequence( ent:LookupSequence("throw"), true )
	ent.Attac = false
	ent:SetSchedule(SCHED_COMBAT_FACE)
	end
	end)
	end
	end)
	else
	ent:SetNWFloat("next_pull",7 + CurTime())
	end
	end
	end
	if !(enemy:Health() <= 0) and (ent:GetPos():Distance(enemy:GetPos()) <= (enemy:GetClass()=="npc_antlionguard" and 120 or 70)) and ent:GetNWFloat("next_attac") < CurTime() then
	if !ent:IsCurrentSchedule(SCHED_WAIT_FOR_SCRIPT) then
	ent:ClearSchedule()
	ent:StopMoving()
	if math.random(1,20) > 18 then
	ent:SetNWFloat("next_attac",ent:SequenceDuration( ent:LookupSequence("pound") ) + CurTime())
	ent:AddGestureSequence( ent:LookupSequence("pound"), true )
	ent:SetSchedule(SCHED_WAIT_FOR_SCRIPT)
	ent.Attac = true
	local WPos = enemy:GetPos()
	local PPos = ent:GetPos()
    local Ang = WPos - PPos
    Ang = Ang:Angle()
	ent:SetAngles(Angle(0,Ang.yaw,Ang.roll))
	timer.Create("doggs_attac" .. ent:EntIndex(),ent:SequenceDuration( ent:LookupSequence("pound") )/2.5,1, function()
	if IsValid(ent) then
	local hitpos = ent:GetPos() + ent:GetForward()*35
	ParticleEffect( "rock_splinter_stalactite", hitpos + Vector(0,0,10),Angle(0,0,0))
	local shake = ents.Create( "env_shake" )
	shake:SetPos( hitpos )
	shake:SetKeyValue( "amplitude", "50" )
	shake:SetKeyValue( "radius", "300" )
	shake:SetKeyValue( "duration", "1" )
	shake:SetKeyValue( "frequency", "140" )
	shake:SetKeyValue( "spawnflags", "4" )
	shake:Spawn()
	shake:Activate()
	shake:Fire( "StartShake", "", 0 )
	shake:Fire( "kill", 0, 5 )
	ent:EmitSound(Sound("vehicles/v8/vehicle_impact_heavy3.wav"))
	for k,v in pairs(ents.FindInSphere(ent:GetPos(),100)) do
	if v != ent and !(ent:Disposition(v) == D_FR or ent:Disposition(v) == D_NU) then
	local dmg = DamageInfo()
	dmg:SetDamage(100)
	dmg:SetDamageForce(Vector(0,0,-1000) + VectorRand()*-200)
	dmg:SetDamageType(DMG_GENERIC)
	dmg:SetAttacker(ent)
	if v:IsPlayer() then
	v:ViewPunch(Angle( math.Rand(-8,-4)*5, math.Rand(-2,2)*5, math.Rand(-2,2)*5 ) )
	end
	util.BlastDamageInfo( dmg, hitpos, 150 )
	end
	end
	end
	end)
	timer.Create("doggs_attac_stop" .. ent:EntIndex(),ent:SequenceDuration( ent:LookupSequence("pound") ),1, function()
	if IsValid(ent) then
	ent.Attac = false
	ent:SetSchedule(SCHED_COMBAT_FACE)
	end
	end)
	elseif math.random(1,20) < 17 then
	ent:SetNWFloat("next_attac",ent:SequenceDuration( ent:LookupSequence("throw") ) + CurTime())
	ent:AddGestureSequence( ent:LookupSequence("throw"), true )
	ent:SetSchedule(SCHED_WAIT_FOR_SCRIPT)
	ent.Attac = true
	local WPos = enemy:GetPos()
	local PPos = ent:GetPos()
    local Ang = WPos - PPos
    Ang = Ang:Angle()
	ent:SetAngles(Angle(0,Ang.yaw,Ang.roll))
	ent:EmitSound(Sound("NPC_dog.Pneumatic_1"))
	timer.Create("doggs_attac" .. ent:EntIndex(),ent:SequenceDuration( ent:LookupSequence("throw") )/2.5,1, function()
	if IsValid(ent) and IsValid(enemy) and (ent:GetPos():Distance(enemy:GetPos()) <= (enemy:GetClass()=="npc_antlionguard" and 120 or 100)) then
	local hitpos = enemy:EyePos()
	ParticleEffect( "blood_impact_red_01", hitpos,Angle(0,0,0))
	local dmg = DamageInfo()
	dmg:SetDamage(50)
	dmg:SetDamageForce(ent:GetAimVector()*(2000*10)) -- sdsd sdsdsd
	dmg:SetDamageType(DMG_GENERIC)
	dmg:SetAttacker(ent)
	if enemy:IsPlayer() then
	enemy:ViewPunch(Angle( math.Rand(8,4)*5, math.Rand(-6,6)*5, math.Rand(-6,6)*5 ) )
	end
	enemy:TakeDamageInfo(dmg)
	enemy:EmitSound("npc/vort/foot_hit.wav")
	end
	end)
	timer.Create("doggs_attac_stop" .. ent:EntIndex(),ent:SequenceDuration( ent:LookupSequence("throw") ),1, function()
	if IsValid(ent) then
	ent.Attac = false
	ent:SetSchedule(SCHED_COMBAT_FACE)
	end
	end)
	elseif math.random(1,20) == 17 or math.random(1,20) == 18 then
	ent:SetNWFloat("next_attac",ent:SequenceDuration( ent:LookupSequence("wallpound") ) + CurTime())
	ent:AddGestureSequence( ent:LookupSequence("wallpound"), true )
	ent:SetSchedule(SCHED_WAIT_FOR_SCRIPT)
	ent.Attac = true
	local WPos = enemy:GetPos()
	local PPos = ent:GetPos()
    local Ang = WPos - PPos
    Ang = Ang:Angle()
	ent:SetAngles(Angle(0,Ang.yaw,Ang.roll))
	timer.Create("doggs_attac1" .. ent:EntIndex(),ent:SequenceDuration( ent:LookupSequence("wallpound") )/3.2,1, function()
	if IsValid(ent) and IsValid(enemy) then
	if (ent:GetPos():Distance(enemy:GetPos()) <= (enemy:GetClass()=="npc_antlionguard" and 120 or 100)) then
	local hitpos = enemy:EyePos()
	ParticleEffect( "blood_impact_red_01", hitpos,Angle(0,0,0))
	local dmg = DamageInfo()
	dmg:SetDamage(50)
	dmg:SetDamageForce(ent:GetAimVector()*(2000*10)) -- sdsd sdsdsd
	dmg:SetDamageType(DMG_GENERIC)
	dmg:SetAttacker(ent)
	if enemy:IsPlayer() then
	enemy:ViewPunch(Angle( math.Rand(8,4)*5, math.Rand(-6,6)*5, math.Rand(-6,6)*5 ) )
	end
	enemy:TakeDamageInfo(dmg)
	enemy:EmitSound("npc/vort/foot_hit.wav")
	local WPos = enemy:GetPos()
	local PPos = ent:GetPos()
    local Ang = WPos - PPos
    Ang = Ang:Angle()
	ent:SetAngles(Angle(0,Ang.yaw,Ang.roll))
	end
	end
	end)
	timer.Create("doggs_attac2" .. ent:EntIndex(),ent:SequenceDuration( ent:LookupSequence("wallpound") )/1.8,1, function()
	if IsValid(ent) and IsValid(enemy) then
	if (ent:GetPos():Distance(enemy:GetPos()) <= (enemy:GetClass()=="npc_antlionguard" and 120 or 100)) then
	local hitpos = enemy:EyePos()
	ParticleEffect( "blood_impact_red_01", hitpos,Angle(0,0,0))
	local dmg = DamageInfo()
	dmg:SetDamage(50)
	dmg:SetDamageForce(ent:GetAimVector()*(2000*10)) -- sdsd sdsdsd
	dmg:SetDamageType(DMG_GENERIC)
	dmg:SetAttacker(ent)
	if enemy:IsPlayer() then
	enemy:ViewPunch(Angle( math.Rand(8,4)*5, math.Rand(-6,6)*5, math.Rand(-6,6)*5 ) )
	end
	enemy:TakeDamageInfo(dmg)
	enemy:EmitSound("npc/vort/foot_hit.wav")
	local WPos = enemy:GetPos()
	local PPos = ent:GetPos()
    local Ang = WPos - PPos
    Ang = Ang:Angle()
	ent:SetAngles(Angle(0,Ang.yaw,Ang.roll))
	end
	end
	end)
	timer.Create("doggs_attac3" .. ent:EntIndex(),ent:SequenceDuration( ent:LookupSequence("wallpound") )/1.4,1, function()
	if IsValid(ent) and IsValid(enemy) then
	if (ent:GetPos():Distance(enemy:GetPos()) <= (enemy:GetClass()=="npc_antlionguard" and 120 or 100)) then
	local hitpos = enemy:EyePos()
	ParticleEffect( "blood_impact_red_01", hitpos,Angle(0,0,0))
	local dmg = DamageInfo()
	dmg:SetDamage(75)
	dmg:SetDamageForce(ent:GetAimVector()*(2000*12)) -- sdsd sdsdsd
	dmg:SetDamageType(DMG_GENERIC)
	dmg:SetAttacker(ent)
	if enemy:IsPlayer() then
	enemy:ViewPunch(Angle( math.Rand(8,4)*5, math.Rand(-6,6)*5, math.Rand(-6,6)*5 ) )
	end
	enemy:TakeDamageInfo(dmg)
	enemy:EmitSound("npc/vort/foot_hit.wav")
	end
	end
	end)
	timer.Create("doggs_attac_stop" .. ent:EntIndex(),ent:SequenceDuration( ent:LookupSequence("wallpound") ),1, function()
	if IsValid(ent) then
	ent.Attac = false
	ent:SetSchedule(SCHED_COMBAT_FACE)
	end
	end)
	end
	end
	end
	end
	end
	end)
end
end
end)
end)

