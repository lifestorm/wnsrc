--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

hook.Add("SetupMove", "CombineSuitsPlayerModelDetection", function()
	for k, v in pairs(player.GetAll()) do
		if v then
			if GetConVarNumber("suits_detect_models") == 1 then
					model = v:GetModel() 
					if model=="models/player/breen.mdl" || model == "models/player/soldier_stripped.mdl" || model == "models/taggart/gallahan.mdl" || model == "models/player/female_02_suit.mdl"|| model == "models/humans/suitfem/female_02.mdl" then
					v.HasValidModel = true
					else
					v.HasValidModel = false
				end
			else
			v.HasValidModel = nil
			end
		end
	end
end)

local function CombineSuitsOS()
	for k, v in pairs(player.GetAll()) do
if v then
	if v.CombineSuitUser == true or v.HasValidModel == true then -- SUIT TRUE
	v.onlyonce = false
	local NPCStrue = ents.FindByClass("npc_*")
	local Match = math.random(1,2)
	for _, NPCt in pairs( NPCStrue ) do
	if NPCt then
	local TARGIT = ents.FindByClass("npc_*")
	for _, TAR in pairs( TARGIT ) do
	if NPCt:GetClass() == "npc_alyx" then
	if Match == 1 then
	if NPCt:Disposition(TAR) == 1 then
	NPCt:AddEntityRelationship( TAR, D_HT, 99 )
	end
	elseif Match == 2 then
	NPCt:AddEntityRelationship( v, D_HT, 99 )
	end
	end
		if NPCt:GetClass() == "npc_barney" then
	if Match == 1 then
	if NPCt:Disposition(TAR) == 1 then
	NPCt:AddEntityRelationship( TAR, D_HT, 99 )
	end
	elseif Match == 2 then
	NPCt:AddEntityRelationship( v, D_HT, 99 )
	end
	end
		if NPCt:GetClass() == "npc_citizen" then
	if Match == 1 then
	if NPCt:Disposition(TAR) == 1 then
	NPCt:AddEntityRelationship( TAR, D_HT, 99 )
	end
	elseif Match == 2 then
	NPCt:AddEntityRelationship( v, D_HT, 99 )
	end
	end
		if NPCt:GetClass() == "npc_dog" then
	if Match == 1 then
	if NPCt:Disposition(TAR) == 1 then
	NPCt:AddEntityRelationship( TAR, D_HT, 99 )
	end
	elseif Match == 2 then
	NPCt:AddEntityRelationship( v, D_HT, 99 )
	end
	end
		if NPCt:GetClass() == "npc_eli" then
	if Match == 1 then
	if NPCt:Disposition(TAR) == 1 then
	NPCt:AddEntityRelationship( TAR, D_HT, 99 )
	end
	elseif Match == 2 then
	NPCt:AddEntityRelationship( v, D_HT, 99 )
	end
	end
		if NPCt:GetClass() == "npc_kleiner" then
	if Match == 1 then
	if NPCt:Disposition(TAR) == 1 then
	NPCt:AddEntityRelationship( TAR, D_HT, 99 )
	end
	elseif Match == 2 then
	NPCt:AddEntityRelationship( v, D_HT, 99 )
	end
	end
		if NPCt:GetClass() == "npc_magnusson" then
	if Match == 1 then
	if NPCt:Disposition(TAR) == 1 then
	NPCt:AddEntityRelationship( TAR, D_HT, 99 )
	end
	elseif Match == 2 then
	NPCt:AddEntityRelationship( v, D_HT, 99 )
	end
	end
		if NPCt:GetClass() == "npc_mossman" then
	if Match == 1 then
	if NPCt:Disposition(TAR) == 1 then
	NPCt:AddEntityRelationship( TAR, D_HT, 99 )
	end
	elseif Match == 2 then
	NPCt:AddEntityRelationship( v, D_HT, 99 )
	end
	end
		if NPCt:GetClass() == "npc_vortigaunt" then
	if Match == 1 then
	if NPCt:Disposition(TAR) == 1 then
	NPCt:AddEntityRelationship( TAR, D_HT, 99 )
	end
	elseif Match == 2 then
	NPCt:AddEntityRelationship( v, D_HT, 99 )
	end
	end
		if NPCt:GetClass() == "npc_monk" then
	if Match == 1 then
	if NPCt:Disposition(TAR) == 1 then
	NPCt:AddEntityRelationship( TAR, D_HT, 99 )
	end
	elseif Match == 2 then
	NPCt:AddEntityRelationship( v, D_HT, 99 )
	end
	end
	end
		if NPCt:GetClass() == "npc_combine_s" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetClass() == "npc_combinedropship" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetClass() == "npc_combinegunship" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetClass() == "npc_cscanner" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetClass() == "npc_helicopter" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetClass() == "npc_hunter" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetClass() == "npc_manhack" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetClass() == "npc_metropolice" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetClass() == "npc_sniper" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetClass() == "npc_stalker" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetClass() == "npc_strider" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetClass() == "npc_turret_ceiling" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetClass() == "npc_turret_floor" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetClass() == "npc_turret_ground" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetClass() == "npc_combine_camera" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetClass() == "npc_rollermine" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetClass() == "npc_clawscanner" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetClass() == "npc_apcdriver" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetClass() == "npc_turret_ground" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetName() == "goodcitizen" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetName() == "policeofficer" then
	NPCt:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCt:GetName() == "rebel" then
	NPCt:AddEntityRelationship( v, D_HT, 99 )
	end
	end
	end
end	 -- SUIT TRUE
	if (v.CombineSuitUser == false or v.CombineSuitUser == nil) and v.onlyonce == false and (v.HasValidModel == false or v.HasValidModel == nil) then -- SUIT FALSE
	if v.onlyonce == false then 
	v.onlyonce = true
	end
	local NPCSfalse = ents.FindByClass("npc_*")
	for _, NPCf in pairs( NPCSfalse ) do
	if NPCf then
   	if NPCf:GetClass() == "npc_alyx" then
	NPCf:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCf:GetClass() == "npc_barney" then
	NPCf:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCf:GetClass() == "npc_citizen" then
	NPCf:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCf:GetClass() == "npc_dog" then
	NPCf:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCf:GetClass() == "npc_eli" then
	NPCf:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCf:GetClass() == "npc_kleiner" then
	NPCf:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCf:GetClass() == "npc_magnusson" then
	NPCf:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCf:GetClass() == "npc_mossman" then
	NPCf:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCf:GetClass() == "npc_vortigaunt" then
	NPCf:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCf:GetClass() == "npc_monk" then
	NPCf:AddEntityRelationship( v, D_LI, 99 )
	end
		if NPCf:GetClass() == "npc_combine_s" then
	NPCf:AddEntityRelationship( v, D_HT, 99 )
	end
		if NPCf:GetClass() == "npc_combinedropship" then
	NPCf:AddEntityRelationship( v, D_HT, 99 )
	end
		if NPCf:GetClass() == "npc_combinegunship" then
	NPCf:AddEntityRelationship( v, D_HT, 99 )
	end
		if NPCf:GetClass() == "npc_cscanner" then
	NPCf:AddEntityRelationship( v, D_HT, 99 )
	end
		if NPCf:GetClass() == "npc_helicopter" then
	NPCf:AddEntityRelationship( v, D_HT, 99 )
	end
		if NPCf:GetClass() == "npc_hunter" then
	NPCf:AddEntityRelationship( v, D_HT, 99 )
	end
		if NPCf:GetClass() == "npc_manhack" then
	NPCf:AddEntityRelationship( v, D_HT, 99 )
	end
		if NPCf:GetClass() == "npc_metropolice" then
	NPCf:AddEntityRelationship( v, D_HT, 99 )
	end
		if NPCf:GetClass() == "npc_sniper" then
	NPCf:AddEntityRelationship( v, D_HT, 99 )
	end
		if NPCf:GetClass() == "npc_stalker" then
	NPCf:AddEntityRelationship( v, D_HT, 99 )
	end
		if NPCf:GetClass() == "npc_strider" then
	NPCf:AddEntityRelationship( v, D_HT, 99 )
	end
		if NPCf:GetClass() == "npc_turret_ceiling" then
	NPCf:AddEntityRelationship( v, D_HT, 99 )
	end
		if NPCf:GetClass() == "npc_turret_floor" then
	NPCf:AddEntityRelationship( v, D_HT, 99 )
	end
		if NPCf:GetClass() == "npc_turret_ground" then
	NPCf:AddEntityRelationship( v, D_HT, 99 )
	end
		if NPCf:GetClass() == "npc_combine_camera" then
	NPCf:AddEntityRelationship( v, D_HT, 99 )
	end
		if NPCf:GetClass() == "npc_rollermine" then
	NPCf:AddEntityRelationship( v, D_HT, 99 )
	end
		if NPCf:GetClass() == "npc_clawscanner" then
	NPCf:AddEntityRelationship( v, D_HT, 99 )
	end
		if NPCf:GetClass() == "npc_turret_ground" then
	NPCt:AddEntityRelationship( v, D_HT, 99 )
	end
		if NPCf:GetName() == "goodcitizen" then
	NPCf:AddEntityRelationship( v, D_NU, 99 )
	end
		if NPCf:GetName() == "policeofficer" then
	NPCf:AddEntityRelationship( v, D_NU, 99 )
	end
		if NPCf:GetName() == "rebel" then
	NPCf:AddEntityRelationship( v, D_NU, 99 )
	end
	end
	end
	end	
end
end
end

hook.Add("PlayerButtonDown", "CSdete1", CombineSuitsOS)
hook.Add("PlayerButtonUp", "CSdete2", CombineSuitsOS)
hook.Add("PlayerFootstep", "CSdete3", CombineSuitsOS) 
hook.Add("PlayerSpawn", "CSdete4", CombineSuitsOS)
hook.Add("PlayerNoClip", "CSdete5", CombineSuitsOS)
hook.Add("OnViewModelChanged", "CSdete6", CombineSuitsOS)

hook.Add( "PlayerSay", "SoldierMessage", function( ply, text, team )
for _,v in pairs (player.GetAll()) do
	if v:IsPlayer() and v.CombineSuitUser == true then
	if ( string.sub( text, 1, 3 ) == "/SM" ) then
		v:EmitSound( "PlayerInSuitSoldier.RadioOn" )
		if v.CombineSuitUser == true then
		v:PrintMessage( HUD_PRINTTALK, ply:GetName() .. ": " .. string.sub( text, 4 ) )
		v:EmitSound( "PlayerInSuitSoldier.RadioOff" )
		return ""
	end
	end
	end
	end
end )

--FootSteps-- :D

local function Steppy(ply,pos,foot,snd,vol,filter)
if GetConVarNumber("suits_foot_steps") == 1 then
if(ply.CombineSuitUser == true and (ply.CombineSuitUsercop == nil or ply.CombineSuitUsercop == false))then		
ply:EmitSound( "PlayerInSuitSoldier.WalkSold" )
elseif(ply.CombineSuitUser == true and ply.CombineSuitUsercop == true)then
ply:EmitSound( "PlayerInSuitSoldier.WalkMetr" )
end
end
end
hook.Add("PlayerFootstep","CombineSuitsFoot", Steppy)

--Juger--
hook.Add("EntityTakeDamage", "CombineSuitsJuger", function(target, dmginfo)
	local attacker = dmginfo:GetAttacker()
	if ( target:IsPlayer() and target.CombineSuitUserheavy == true ) then

		dmginfo:ScaleDamage( 0.50 )

	end
	
	if (( target:IsPlayer() and target.CombineSuitUser == true or target.HasValidModel == true ) and ( attacker:IsPlayer() and attacker.CombineSuitUser == true or attacker.HasValidModel == true ) ) and GetConVarNumber("suits_no_friendly_fire") == 1 then
	
		dmginfo:ScaleDamage( 0 )
	
	end
	
	if (( target:IsPlayer() and target.CombineSuitUser == true and target.Assassin == true ) and dmginfo:IsDamageType(DMG_FALL) ) then
	
		dmginfo:ScaleDamage( 0 )
	
	end
	
	if ( target:IsNPC() and target.SuitAI == true ) then
	
		dmginfo:ScaleDamage( 0 )
	
	end
	
	if (( target:IsPlayer() and target.CombineSuitUser == true or target.HasValidModel == true ) and (attacker:GetClass()=="cup_fuel_tank" or attacker:GetClass()=="npc_stalker" or attacker:GetClass()=="npc_combine_s" or attacker:GetClass()=="npc_metropolice" or attacker:GetClass()=="npc_cscanner" or attacker:GetClass()=="npc_manhack" or attacker:GetClass()=="npc_strider" or attacker:GetClass()=="npc_hunter" or attacker:GetClass()=="npc_rollermine" or attacker:GetClass()=="npc_clawscanner" or attacker:GetClass()=="npc_turret_floor" or attacker:GetClass()=="npc_turret_ceiling" or attacker:GetClass()=="npc_combine_camera" or attacker:GetClass()=="npc_combinedropship" or attacker:GetClass()=="npc_combinegunship" or attacker:GetClass()=="npc_helicopter" or attacker:GetClass()=="npc_turret_ground" or attacker:GetClass()=="npc_apcdriver") ) and GetConVarNumber("suits_no_friendly_fire") == 1 then
	
		dmginfo:ScaleDamage( 0 )
	
	end
	
	if (( target:IsPlayer() and target.CombineSuitUser == true and target.Sterilizer == true ) and dmginfo:IsDamageType(DMG_BURN) ) then
	
		dmginfo:ScaleDamage( 0.50 )
	
	end
	
	if (( target:GetClass()=="cup_fuel_tank" or target:GetClass()=="npc_stalker" or target:GetClass()=="npc_combine_s" or target:GetClass()=="npc_metropolice" or target:GetClass()=="npc_cscanner" or target:GetClass()=="npc_manhack" or target:GetClass()=="npc_strider" or target:GetClass()=="npc_hunter" or target:GetClass()=="npc_rollermine" or target:GetClass()=="npc_clawscanner" or target:GetClass()=="npc_turret_floor" or target:GetClass()=="npc_turret_ceiling" or target:GetClass()=="npc_combine_camera" or target:GetClass()=="npc_combinedropship" or target:GetClass()=="npc_combinegunship" or target:GetClass()=="npc_helicopter" or target:GetClass()=="npc_turret_ground" or target:GetClass()=="npc_apcdriver" ) and ( attacker:IsPlayer() and attacker.CombineSuitUser == true or attacker.HasValidModel == true ) ) and GetConVarNumber("suits_no_friendly_fire") == 1 then
	
		dmginfo:ScaleDamage( 0 )
	
	end
	
	if (( target:IsPlayer() and target.CombineSuitUser == true ) and target.CombineSuitUsercop == nil or target.CombineSuitUsercop == false) then
	
		target:ViewPunch(Angle( math.random(-4,4), math.random(-4,4), math.random(-4,4) ))
		
		target:EmitSound("PlayerInSuitSoldier.PainSold")
		
	
	end
	
	if (( target:IsPlayer() and target.CombineSuitUser == true ) and target.CombineSuitUsercop == true) then
	
		target:ViewPunch(Angle( math.random(-4,4), math.random(-4,4), math.random(-4,4) ))
		
		target:EmitSound("PlayerInSuitSoldier.PainMetr")
		
	
	end
	
end)

--Commander--
hook.Add("EntityTakeDamage", "CombineSuitsEliteBonus", function(ent, dmginfo)
	local attacker = dmginfo:GetAttacker()
	if attacker.Elite == true then
		dmginfo:ScaleDamage(2.5)
	end
end)

--Script Loop



