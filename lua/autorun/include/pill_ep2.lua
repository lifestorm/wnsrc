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

pk_pills.register("ep2_hunter",{
	printName="Hunter",
	side="hl_combine",
	type="ply",
	model="models/hunter.mdl",
	default_rp_cost=9000,
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
			jump="jump",
			glide="jump_idle",
			melee1="meleeleft",
			melee2="meleert",
			melee3="melee_02"
		}
	},
	sounds={
		melee=pk_pills.helpers.makeList("npc/ministrider/hunter_defendstrider#.wav",3),
		melee_hit=pk_pills.helpers.makeList("npc/zombie/claw_strike#.wav",3),
		shoot="npc/ministrider/ministrider_fire1.wav",
		step=pk_pills.helpers.makeList("npc/ministrider/ministrider_footstep#.wav",5)
	},
	aim={
		attachment="MiniGunBase",
		simple=true
	},
	attack={
		mode= "auto",
		func=function(ply,ent)
			ent:PillSound("shoot",true)
			local f = ents.Create("hunter_flechette")
			f:SetPos(ply:GetShootPos()+ply:EyeAngles():Forward()*80)
			f:SetVelocity(ply:EyeAngles():Forward()*2000+VectorRand()*10)
			f:SetAngles(ply:EyeAngles())
			f:Spawn()
		end,
		delay=.1
	},
	attack2={
		mode="trigger",
		func = pk_pills.common.melee,
		animCount=3,
		delay=.5,
		range=75,
		dmg=25
	},
	movePoseMode="yaw",
	moveSpeed={
		walk=200,
		run=500
	},
	jumpPower=400,
	health=300,
	noFallDamage=true
})

pk_pills.register("ep2_antlion_worker",{
	parent="antlion",
	printName="Antlion Worker",
	model="models/antlion_worker.mdl",
	default_rp_cost=6000,
	options=false,
	reload= function(ply,ent)
		ent:PillAnim("spit",true)
		
		timer.Simple(.5,function()
			if !IsValid(ply) then return end
			for i=1,5 do
				local n=math.random(3)
				local s = ents.Create("grenade_spit")
				s:SetPos(ply:GetShootPos()+ply:EyeAngles():Forward()*100+Vector(0,0,50))
				s:SetVelocity(ply:EyeAngles():Forward()*800+Vector(0,0,400)+VectorRand()*20)
				s:Spawn()
				if n==1 then
					s:SetModel("models/spitball_medium.mdl")
				elseif n==2 then
					s:SetModel("models/spitball_small.mdl")
				end
			end
		end)
	end,
	aim={nocrosshair=false},
	anims={
		default={
			spit="spit"
		}
	}
})

pk_pills.register("ep2_cturret",{
	parent="cturret",
	printName="Rebel Turret",
	side=false,
	default_rp_cost=3000,
	options=function() return {
		{visMat="models/combine_turrets/floor_turret/floor_turret_citizen"},
		{visMat="models/combine_turrets/floor_turret/floor_turret_citizen4"}
	} end,
})

pk_pills.register("ep2_guardian",{
	parent="antlion_guard",
	printName="Ancient Guardian",
	default_rp_cost=11000,
	visMat="Models/antlion_guard/antlionGuard2",
	attack={
		dmg=100
	},
	charge={
		dmg=200
	}
})

pk_pills.register("ep2_vort_scientist",{
	parent="vort",
	printName="Vortigaunt Scientist",
	model="models/vortigaunt_doctor.mdl",
})

pk_pills.register("ep2_sniper",{
	parent="csoldier",
	printName="Combine Sniper",
	default_rp_cost=7000,
	//model="models/Combine_Super_Soldier.mdl",
	//ammo={AR2AltFire=6},
	//health=300
	loadout={"pill_wep_csniper"}
})

pk_pills.register("ep2_inventor",{
	printName="The Inventor",
	type="ply",
	model="models/magnusson.mdl",
	default_rp_cost=10000,
	anims={
		default={
			idle="lineidle02",
			walk="walk_all",
			run="run_all",
			crouch="Crouch_idleD",
			crouch_walk="Crouch_walk_aLL",
			glide="jump_holding_glide",
			jump="jump_holding_jump",
			g_attack="gesture_shoot_smg1",
			g_reload="gesture_reload_smg1"
		},
		smg={
			idle="Idle_SMG1_Aim_Alert",
			walk="walkAIMALL1",
			run="run_alert_aiming_all",
			crouch="crouch_aim_smg1",
			crouch_walk="Crouch_walk_aiming_all"
		},
		ar2={
			idle="idle_angry_Ar2",
			walk="walkAIMALL1_ar2",
			run="run_aiming_ar2_all",
			crouch="crouch_aim_smg1",
			crouch_walk="Crouch_walk_aiming_all",
			g_attack="gesture_shoot_ar2",
			g_reload="gesture_reload_ar2"
		},
		shotgun={
			idle="Idle_Angry_Shotgun",
			walk="walkAIMALL1_ar2",
			run="run_aiming_ar2_all",
			crouch="crouch_aim_smg1",
			crouch_walk="Crouch_walk_aiming_all",
			g_attack="gesture_shoot_shotgun",
			g_reload="gesture_reload_ar2"
		}
	},
	aim={
		xPose="aim_yaw",
		yPose="aim_pitch"
	},
	moveSpeed={
		walk=60,
		run=200,
		ducked=40
	},
	loadout={"pill_wep_holstered","weapon_smg1","pill_wep_magnade"},
	ammo={SMG1=100},
	health=1000,
	validHoldTypes={"smg","ar2","shotgun","grenade"},
	movePoseMode="yaw"
})

pk_pills.register("ep2_grub",{
	printName="Grub",
	side="antlion",
	type="ply",
	model="models/antlion_grub.mdl",
	default_rp_cost=400,
	camera={
		offset=Vector(0,0,5),
		dist=80
	},
	hull=Vector(30,30,15),
	anims={},
	moveSpeed={
		walk=30,
		run=60
	},
	jumpPower=0,
	health=20
})

pk_pills.register("ep2_gnome",{
	printName="Garden Gnome",
	type="ply",
	model="models/props_junk/gnome.mdl",
	default_rp_cost=1000,
	camera={
		offset=Vector(0,0,15),
		dist=80
	},
	hull=Vector(10,10,30),
	anims={},
	moveSpeed={
		walk=60,
		run=120
	},
	attack={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("laugh")
		end
	},
	sounds={
		laugh=pk_pills.helpers.makeList("vo/ravenholm/madlaugh0#.wav",4),
		laugh_pitch=140
	},
	noragdoll=true,
	jumpPower=150,
	health=80,
	noFallDamage=true
})

pk_pills.register("ep2_advisor",{
	printName="Enhanced Advisor",
	parent="advisor",
	model="models/birdbrainswagtrain/episodic/advisor.mdl",
	default_rp_cost=10000,
	aim={},
	attack={
		mode="trigger",
		func=function(ply,ent)
			if ent:GetSequence()!=ent:LookupSequence("idle") then return end
			ent:PillAnim("melee",true)

			timer.Simple(.7,function()
				if !IsValid(ent) then return end

				local tr = util.TraceHull({
					start=ent:GetPos(),
					endpos=ent:GetPos()+ent:GetAngles():Forward()*200,
					filter={ent},
					mins=Vector(-25,-25,-25),
					maxs=Vector(25,25,25)
				})
				if IsValid(tr.Entity) then
					local dmg=DamageInfo()
					dmg:SetAttacker(ply)
					dmg:SetInflictor(ent)
					dmg:SetDamageType(DMG_SLASH)
					dmg:SetDamage(50)

					tr.Entity:TakeDamageInfo(dmg)
					
					ent:PillSound("hit")
				end
			end)
			timer.Simple(1.2,function()
				if !IsValid(ent) then return end
				ent:PillAnim("idle",true)
			end)
		end
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			if ent:GetSequence()!=ent:LookupSequence("idle") then return end
			ent:PillAnim("grab",true)

			timer.Simple(.7,function()
				if !IsValid(ent) then return end

				local tr = util.TraceHull({
					start=ent:GetPos(),
					endpos=ent:GetPos()+ent:GetAngles():Forward()*200,
					filter={ent},
					mins=Vector(-25,-25,-25),
					maxs=Vector(25,25,25)
				})
				if IsValid(tr.Entity) and not tr.Entity:IsFlagSet(FL_GODMODE) then

					local mdl_ent = pk_pills.getMappedEnt(tr.Entity) or tr.Entity

					mdl_ent = mdl_ent.subModel or mdl_ent

					mdl_ent = mdl_ent.GetPuppet and mdl_ent:GetPuppet() or mdl_ent

					if mdl_ent:LookupBone("ValveBiped.Bip01_Spine4") then
						local mdl_name = mdl_ent:GetModel()
						
						if tr.Entity:IsPlayer() then
							tr.Entity:KillSilent()
						else
							tr.Entity:Remove()
						end

						local attachment=ents.Create("pill_attachment_body")
						attachment.model = mdl_name
						attachment:SetPos(ent:GetPos())
						attachment:SetParent(ent)
						attachment:Spawn()

						ent.brainsucked=true
					else
						ent.brainsucked=false
					end
				else
					ent.brainsucked=false
				end

				if !ent.brainsucked then
					ent:PillAnim("fail",true)
				end
			end)
			timer.Simple(2.3,function()
				if !IsValid(ent) or !ent.brainsucked then return end
				
				ent:PillSound("brainsuck")

				local effectdata = EffectData()

				effectdata:SetOrigin(ent:LocalToWorld(Vector(75,0,-20)))
				effectdata:SetNormal(ent:GetAngles():Forward())
				effectdata:SetMagnitude(1)
				effectdata:SetScale(10)
				effectdata:SetColor(0)
				effectdata:SetFlags(3)

				util.Effect("bloodspray",effectdata)
			end)
			timer.Simple(5,function()
				if !IsValid(ent) then return end
				ent:PillAnim("idle",true)
			end)
		end
	},
	reload=function(ply,ent)
		local traceres = util.QuickTrace(ent:GetPos(),ply:EyeAngles():Forward()*99999,{ply,ent})

		local blast = ents.Create("pill_advisor_blast")
		blast:SetPos(traceres.HitPos)
		blast:SetOwner(ply)
		blast:Spawn()

		ent:PillSound("blast")
	end,
	sounds={
		brainsuck="physics/flesh/flesh_squishy_impact_hard3.wav",
		blast="npc/advisor/advisor_blast1.wav"
	}
})