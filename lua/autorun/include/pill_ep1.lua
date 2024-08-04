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

pk_pills.register("ep1_advisorpod",{
	printName="Advisor Pod",
	side="hl_combine",
	type="phys",
	model="models/advisorpod.mdl",
	default_rp_cost=12000,
	camera={
		dist=500
	},
	health=5,
	onlyTakesExplosiveDamage=true,
	seqInit="idlefly",
	driveType="fly",
	driveOptions={
		speed=60,
		rotation2=90,
		rocketMode=true
	},
	attack={
		mode= "trigger",
		func= function(ply,ent)
			pk_pills.apply(ply,"ep2_advisor")
			ent:PillSound("breakout")
		end
	},
	damageFromWater=-1,
	sounds={
		loop_move="npc/combine_gunship/gunship_engine_loop3.wav",
		breakout="ambient/materials/cartrap_explode_impact1.wav"
	},
	trail={
		texture="trails/physbeam.vmt",
		width=200
	}
})

pk_pills.register("ep1_ministrider",{
	printName="Ministrider",
	side="hl_combine",
	type="ply",
	model="models/ministrider.mdl",
	default_rp_cost=8000,
	camera={
		offset=Vector(0,0,100),
		dist=150
	},
	hull=Vector(60,60,100),
	anims={
		default={
			idle="idle1",
			walk="walk_all",
			run="canter_all",
			melee="meleeleft"
		}
	},
	sounds={
		melee={"npc/ministrider/alert2.wav","npc/ministrider/alert4.wav"},
		melee_hit=pk_pills.helpers.makeList("npc/zombie/claw_strike#.wav",3),
		shoot="weapons/ar2/fire1.wav",
		step={"npc/ministrider/ministrider_footstep2.wav","npc/ministrider/ministrider_footstep5.wav"}
	},
	aim={
		attachment="MiniGun",
		fixTracers=true,
		simple=true
	},
	attack={
		mode= "auto",
		func=pk_pills.common.shoot,
		delay=.1,
		damage=10,
		spread=.02,
		tracer="AR2Tracer"
	},
	attack2={
		mode="trigger",
		func = pk_pills.common.melee,
		//animCount=3,
		delay=1,
		range=75,
		dmg=75
	},
	movePoseMode="yaw",
	moveSpeed={
		walk=200,
		run=500
	},
	jumpPower=0,
	health=300,
	noFallDamage=true
})

pk_pills.register("ep1_rollermine_orange",{
	parent="rollermine",
	printName="Orange Rollermine",
	side=false,
	subMats = {
		[0]="models/roller/rollermine_hacked",
		[1]="models/roller/rollermine_gloworange"
	},
	default_rp_cost=4000
})

/*

4	=	models/roller/rollermine_gloworange
6	=	models/roller/rollermine_glowred

*/

pk_pills.register("ep1_rollermine_red",{
	parent="ep1_rollermine_orange",
	printName="Red Rollermine",
	side="wild",
	subMats = {
		[0]="models/roller/rollermine_splode",
		[1]="models/roller/rollermine_glowred"
	},
})

pk_pills.register("ep1_zombine",{
	parent="zombie",
	printName="Zombine",
	model="models/zombie/zombie_soldier.mdl",
	default_rp_cost=8000,
	anims={
		default={
			walk="walk_all",
			run="run_all",
			nade="pullgrenade"
		},
		nade={
			idle="idle_grenade",
			walk="walk_all_grenade",
			run="run_all_grenade"
		}
	},
	moveSpeed={
		run=200
	},
	sounds={
		melee=pk_pills.helpers.makeList("npc/zombine/zombine_charge#.wav",2),
		nade=pk_pills.helpers.makeList("npc/zombine/zombine_readygrenade#.wav",2)
	},
	attack={
		func= function(ply,ent,tbl) if !ent.forceAnimSet then pk_pills.common.melee(ply,ent,tbl) end end
	},
	attack2={
		mode="trigger",
		func= function(ply,ent)
			if !ent.forceAnimSet then
				ent:PillAnim("nade",true)
				ent:PillSound("nade")
				ent.forceAnimSet="nade"

				local nade=ents.Create("npc_grenade_frag")
				nade:SetPos(ply:GetPos())
				nade:SetParent(ent:GetPuppet())
				nade:Spawn()
				nade:Fire("setparentattachment","grenade_attachment", 0)
				nade:Fire("SetTimer","6",0)
				nade:CallOnRemove("NadeSplodeKillPlayer",function()
					if IsValid(ent) then ply:Kill() end
				end)

				ent:PillFilterCam(nade)
			end
		end
	}
})

pk_pills.register("ep1_vort_blue",{
	parent="vort",
	printName="Transcendent Vortigaunt",
	visColor=Color(120,70,210),
	default_rp_cost=16000,
	superpowers=true,
	anims={
		default={teleport="todefend"}
	},
	sounds={
		ranged_fire="beams/beamstart5.wav",
		teleport="ambient/machines/teleport4.wav"
	},
	reload=function(ply,ent)
		if !ply:OnGround() or ent.cloaked then return end

		ent:PillAnim("teleport",true)

		timer.Simple(1,function()
			if !IsValid(ent) then return end
			local tracein={}
			tracein.maxs=Vector(16,16,72)
			tracein.mins=Vector(-16,-16,0)
			tracein.start=ply:EyePos()
			tracein.endpos=ply:EyePos()+ply:EyeAngles():Forward()*9999
			tracein.filter = {ply,ent,ent:GetPuppet()}

			local traceout= util.TraceHull(tracein)
			ply:SetPos(traceout.HitPos)
			ent:PillSound("teleport")
		end)
	end,
	health=1000
})