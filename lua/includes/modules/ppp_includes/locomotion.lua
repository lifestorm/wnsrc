--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()

custom={}
if SERVER then
	function custom.meleeEx(ply,ent,tbl) 
	-- Small edit that can use a custom dmgType and doesn't force an animation, for morphs with multiple attacks in a single anim
		if !ply:IsOnGround() then return end
		timer.Simple(tbl.delay,function() if !IsValid(ent) then return end
			if !IsValid(ent) then return end
			if ply:TraceHullAttack(ply:EyePos(), ply:EyePos()+ply:EyeAngles():Forward()*tbl.range,
			Vector(-10,-10,-10),Vector(10,10,10),tbl.dmg,tbl.dmgType,0.1,true) then
				ent:PillSound("melee_hit")
			else
				ent:PillSound("melee_miss")
			end
		end)
	end

	function custom.LocoAnim(ply,ent,anim)
	-- New function that uses animation locomotion (ish)
		if !ply:IsOnGround() then return end
		ent:PillAnim(anim,true)
		local seq,dur = ent:GetPuppet():LookupSequence(ent.formTable.anims.default[anim])
		local ga,gb,gc = ent:GetPuppet():GetSequenceMovement(seq,0,1)
		if not ga then print("ga failed") return end -- The animation has no locomotion or it's invalid or we failed in some other way.
				
		local pos = ply:GetPos()
		
            local trin = {}
            trin.maxs = Vector(16, 16, 72)
            trin.mins = Vector(-16, -16, 0)
            trin.start = ply:EyePos()
            trin.endpos = gb
            trin.filter = {ply, ent, ent:GetPuppet()}
            local trout = util.TraceHull(trin)
			
		local gd_prev = ent:GetPuppet():GetCycle()
		
		for i=1,dur*1000 do 
			timer.Simple(0.001*i,function()
				if !IsValid(ent) then return end
				if ply:GetPos() == trout.HitPos then return end -- Avoid going through walls if possible chief.
				local gd_cur = ent:GetPuppet():GetCycle()
				local ga2,gb2,gc2 = ent:GetPuppet():GetSequenceMovement(seq,gd_prev,gd_cur)
				gd_prev = gd_cur
				if not ga2 then print("ga failed") return end
				
				if gd_cur==0 then return end
				
				if !util.IsInWorld(ply:LocalToWorld(gb2)) then return end
				ply:SetPos(ply:LocalToWorld(gb2))
				ply:SetAngles(ply:LocalToWorldAngles(gc2))
			end)
		end
	end
end