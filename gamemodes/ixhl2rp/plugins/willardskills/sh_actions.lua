--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


--[[
	GUNS
]]
ix.action:RegisterSkillAction("guns", "guns_quick_reload", {
	name = "Quick Reload",
	description = "Allows you to reload using only one action point during a firefight.",
	bNoLog = true,
	CanDo = 20
})

ix.action:RegisterSkillAction("guns", "guns_reload", {
	name = "Reload Practice",
	description = "Practice reloading and handling your gun to build the necessary muscle memory to efficiently use it during a fight.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 25},
		{level = 10, exp = 10},
		{level = 15, exp = 5},
		{level = 20, exp = 0},
	}
})

ix.action:RegisterSkillAction("guns", "guns_level_approp", {
	name = "Target Practice",
	description = "Practice firing your weapon at any target to master its recoil and get a feel for aiming it.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 50},
		{level = 20, exp = 25},
		{level = 25, exp = 10},
		{level = 30, exp = 0},
	}
})

ix.action:RegisterSkillAction("guns", "guns_level_unapprop", {
	name = "Target Practice 2",
	description = "Practice with a weapon you already know how to use - or is perhaps aimed too high for your current skill level.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 25},
		{level = 10, exp = 10},
		{level = 20, exp = 0},
	}
})

ix.action:RegisterSkillAction("guns", "guns_hit", {
	name = "Target Hit",
	description = "Successfully hit an NPC or Player target.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 75},
		{level = 10, exp = 30},
		{level = 30, exp = 15},
		{level = 50, exp = 0},
	}
})

ix.action:RegisterSkillAction("guns", "guns_crit", {
	name = "Target Critically Hit",
	description = "Successfully critically hit an NPC or Player target.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 150},
		{level = 20, exp = 75},
		{level = 40, exp = 25},
		{level = 50, exp = 0},
	}
})

ix.action:RegisterSkillAction("guns", "guns_combat_move", {
	name = "Combat Movement with Gun",
	description = "Move around in combat with your gun, getting used to holding it.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 10},
		{level = 5, exp = 0},
	}
})

ix.skill:RegisterSkillScale("guns", "guns_eff_range", {
	name = "Effective Range",
	description = "The maximum range at which you can effectively engage targets, giving a bonus to your accuracy.",
	minLevel = 0,
	maxLevel = 50,
	minValue = 50,
	increase = 150
})

ix.skill:RegisterSkillScale("guns", "guns_max_range", {
	name = "Maximum Range",
	description = "The maximum range at which you can engage targets without suffering an accuracy penalty.",
	minLevel = 0,
	maxLevel = 50,
	minValue = 200,
	increase = 300
})

ix.skill:RegisterSkillScale("guns", "guns_moving_target_penalty", {
	name = "Moving Target Penalty",
	description = "The penalty given when engaging a target that performed any amount of movement in his previous combat turn",
	minLevel = 30,
	maxLevel = 50,
	minValue = 1,
	increase = -0.5,
	percentage = true,
})



--[[
	MELEE
]]
ix.action:RegisterSkillAction("melee", "melee_slash", {
	name = "Practice Swings",
	description = "Practice swinging your melee weapon to gain some basic familiarity with it.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 10},
		{level = 5, exp = 2},
		{level = 10, exp = 0},
	}
})

ix.action:RegisterSkillAction("melee", "melee_slash_heavy", {
	name = "Practice Heavy Swings",
	description = "Practice doing very hard swings with your melee weapon to gain even more familiarity with it.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 10},
		{level = 10, exp = 0},
	}
})


ix.action:RegisterSkillAction("melee", "melee_hit", {
	name = "Target Hit",
	description = "Successfully hit an NPC or Player target.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 50},
		{level = 20, exp = 20},
		{level = 40, exp = 10},
		{level = 50, exp = 0},
	}
})

ix.action:RegisterSkillAction("melee", "melee_crit", {
	name = "Target Critically Hit",
	description = "Successfully critically hit an NPC or Player target.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 75},
		{level = 20, exp = 50},
		{level = 40, exp = 20},
		{level = 50, exp = 0},
	}
})

ix.action:RegisterSkillAction("melee", "melee_combat_move", {
	name = "Combat Movement with Melee Weapon",
	description = "Move around in combat with your melee weapon, getting used to holding it.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 2},
		{level = 5, exp = 0},
	}
})

ix.skill:RegisterSkillScale("melee", "melee_light", {
	name = "Light Melee Weapon Familiarity",
	description = "How familiar you are with light melee weapons, reflected by your chance to critically hit your opponents with them in fights.",
	minLevel = 0,
	maxLevel = 20,
	minValue = 0.8,
	increase = 0.2,
	percentage = true,
})

ix.skill:RegisterSkillScale("melee", "melee_medium", {
	name = "Medium Melee Weapon Familiarity",
	description = "How familiar you are with medium melee weapons, reflected by your chance to critically hit your opponents with them in fights.",
	minLevel = 0,
	maxLevel = 46,
	minValue = -0.15,
	increase = 1.15,
	percentage = true,
})

ix.skill:RegisterSkillScale("melee", "melee_heavy", {
	name = "Heavy Melee Weapon Familiarity",
	description = "How familiar you are with heavy melee weapons, reflected by your chance to critically hit your opponents with them in fights.n",
	minLevel = 0,
	maxLevel = 46,
	minValue = -1.3,
	increase = 2.3,
	percentage = true,
})



--[[
	MEDICINE
]]
ix.action:RegisterSkillAction("medicine", "check_sufficient_bandage", {
	name = "Sufficiently Bandaged",
	description = "Allows you to see if someone is sufficiently bandaged.",
	CanDo = 5
})

ix.skill:RegisterSkillScale("medicine", "bandage_skill", {
	name = "Bandage Effectiveness",
	description = "How good you are at applying bandages properly, affects the amount of health gained from bandages.",
	minLevel = 0,
	maxLevel = 50,
	minValue = 0,
	increase = 1,
	add = true,
	percentage = true,
	digits = 0
})

ix.skill:RegisterSkillScale("medicine", "disinfectant_skill", {
	name = "Disinfectant Duration",
	description = "How good you are at cleaning wounds, affects how long disinfectant will last.",
	minLevel = 0,
	maxLevel = 50,
	minValue = 0,
	increase = 9,
	add = true,
	percentage = true,
	digits = 0
})



--[[
	SPEED
]]
ix.action:RegisterSkillAction("speed", "speed_move_point", {
	name = "Extra Move Point",
	description = "When performing a move action in combat, you get one additional move point.",
	bNoLog = true,
	CanDo = 15,
	DoResult = {
		{level = 0, exp = 20},
		{level = 50, exp = 0},
	}
})

ix.action:RegisterSkillAction("speed", "speed_move_point2", {
	name = "2nd Extra Move Point",
	description = "When performing a move action in combat, you get one additional move point.",
	CanDo = 30,
})

ix.action:RegisterSkillAction("speed", "speed_move_point_base", {
	name = "2nd Base Move Point",
	description = "You begin your combat turn with 2 move points instead of 1.",
	CanDo = 40,
	DoResult = {
		{level = 40, exp = 10},
		{level = 50, exp = 0},
	}
})

ix.action:RegisterSkillAction("speed", "speed_sprint", {
	name = "Sprint for some distance",
	description = "Train your speed by sprinting for some distance.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 8},
		{level = 50, exp = 0},
	}
})
--[[
ix.action:RegisterSkillAction("speed", "speed_never_lose_initiative", {
	name = "Never Lose Initiative",
	description = "You are so fast, you can never lose an initiative roll.",
	CanDo = 50
})
--]]
ix.skill:RegisterSkillScale("speed", "speed_dodge_mod", {
	name = "Dodge Chance Modification",
	description = "The modification of your dodge chance if you were moving during your previous turn in a firefight.",
	minLevel = 0,
	maxLevel = 50,
	minValue = 0,
	increase = 1,
	add = true,
	percentage = true,
	digits = 2
})
--[[
ix.skill:RegisterSkillScale("speed", "initiative_power", {
	name = "Initiative Power",
	description = "Gain initiative during combat, allowing you to jump forward in the turn order.",
	minLevel = 0,
	maxLevel = 50,
	minValue = 0,
	increase = 15,
	add = true,
})
--]]
ix.skill:RegisterSkillScale("speed", "run_speed", {
	name = "Run Speed Bonus",
	description = "The amount of run speed gained, because you are soooo fast!",
	minLevel = 0,
	maxLevel = 50,
	minValue = 0,
	increase = 50,
	add = true,
})



--[[
	VORT
]]
ix.action:RegisterSkillAction("vort", "vort_beam_practice", {
	name = "Vortbeam Practice",
	description = "Practice firing your vort beam.",
	bNoLog = true,
    DoResult = {
		{level = 0, exp = 30},
		{level = 10, exp = 25},
        {level = 20, exp = 10},
        {level = 30, exp = 5},
        {level = 50, exp = 0},
    }
})

ix.action:RegisterSkillAction("vort", "vort_vortessence_entry", {
	name = "Vortessence Entry EXP",
	description = "EXP from making vortessence entries.",
	bNoLog = false,
    DoResult = {
		{level = 0, exp = 80},
		{level = 10, exp = 60},
        {level = 20, exp = 40},
        {level = 30, exp = 20},
        {level = 50, exp = 0},
    }
})

ix.action:RegisterSkillAction("vort", "vort_beam_shoot", {
	name = "Vortbeam Target Hit",
	description = "Hit other players with a vort beam.",
	CanDo = 0,
	bNoLog = true,
    DoResult = {
        {level = 0, exp = 150},
        {level = 20, exp = 75},
        {level = 30, exp = 20},
        {level = 50, exp = 0},
    }
})

ix.action:RegisterSkillAction("vort", "vort_channel", {
	name = "Whether or not you can channel your vort energy to do things.",
	description = "Hit other players with a shockwave blast.",
	bNoLog = true,
	CanDo = function(_, character, skillLevel)
		if (CLIENT) then return end

		local client = character:GetPlayer()
		local lastAttempt = client.nextHealAttempt or 0

		if (lastAttempt <= CurTime()) then
			client.nextHealAttempt = CurTime() + 1

			if (skillLevel > 10) then
				local lastHeal = client.lastVortHeal or 0
				local curTime = CurTime()

				if (lastHeal <= curTime) then
					return true
				else
					client:Notify("You are too exhausted to do this action at the moment!")
				end
			end
		end

		return false
	end,
	DoResult = {
		{level = 20, exp = 150},
		{level = 35, exp = 75},
		{level = 50, exp = 0}
	}
})

ix.action:RegisterSkillAction("vort", "vort_shockwave_shoot", {
	name = "Shockwave Target Hit",
	description = "Hit other players with a shockwave blast.",
	bNoLog = true,
	CanDo = 20,
    DoResult = {
        {level = 20, exp = 150},
        {level = 30, exp = 75},
        {level = 40, exp = 20},
        {level = 50, exp = 0},
    }
})

ix.action:RegisterSkillAction("vort", "vort_combat_move", {
	name = "Combat Movement as Vortigaunt",
	description = "Move in combat as a vortigaunt.",
    bNoLog = true,
    DoResult = {
        {level = 0, exp = 2},
        {level = 5, exp = 0},
    }
})

ix.skill:RegisterSkillScale("vort", "vort_beam", {
	name = "Vort Beam Power",
	description = "How much damage your vort beam attack does.",
	minLevel = 0,
	maxLevel = 50,
	minValue = 40,
	increase = 35,
})

ix.skill:RegisterSkillScale("vort", "vort_heal_amount", {
	name = "Vort Heal Amount",
	description = "How much HP you will heal using your healing ability.",
	minLevel = 10,
	maxLevel = 50,
	minValue = 10,
	increase = 30,
})

ix.action:RegisterSkillAction("cooking", "harvest_plant", {
	name = "Harvest Plant",
	description = "Ejoy the bountiful harvest.",
    DoResult = {
        {level = 0, exp = 400},
        {level = 20, exp = 250},
		{level = 40, exp = 150},
    }
})

ix.action:RegisterSkillAction("cooking", "plant_seed", {
	name = "Plant a Seed",
	description = "Plant something that you may someday sow.",
    DoResult = {
        {level = 0, exp = 150},
        {level = 20, exp = 100},
		{level = 40, exp = 75},
    }
})