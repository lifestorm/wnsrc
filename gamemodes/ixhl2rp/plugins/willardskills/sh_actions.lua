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
	name = "Szybkie Przeładowanie",
	description = "Umożliwia przeładowanie przy użyciu tylko jednego punktu akcji podczas potyczki.",
	bNoLog = true,
	CanDo = 20
})

ix.action:RegisterSkillAction("guns", "guns_reload", {
	name = "Trening Przeładowania",
	description = "Ćwicz przeładowywanie i obsługę broni, aby zbudować pamięć mięśniową niezbędną do efektywnego korzystania z niej podczas walki.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 25},
		{level = 10, exp = 10},
		{level = 15, exp = 5},
		{level = 20, exp = 0},
	}
})

ix.action:RegisterSkillAction("guns", "guns_level_approp", {
	name = "Trening Celności",
	description = "Ćwicz strzelanie z broni do dowolnego celu, aby opanować jej odrzut i wyczuć jak celować.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 50},
		{level = 20, exp = 25},
		{level = 25, exp = 10},
		{level = 30, exp = 0},
	}
})

ix.action:RegisterSkillAction("guns", "guns_level_unapprop", {
	name = "Trening Celności 2",
	description = "Ćwicz z bronią, którą już umiesz się posługiwać - chyba, że celujesz zbyt wysoko na swój poziom umiejętności.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 25},
		{level = 10, exp = 10},
		{level = 20, exp = 0},
	}
})

ix.action:RegisterSkillAction("guns", "guns_hit", {
	name = "Trafienie w Cel",
	description = "Pomyślne trafienie celu NPC lub gracza.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 75},
		{level = 10, exp = 30},
		{level = 30, exp = 15},
		{level = 50, exp = 0},
	}
})

ix.action:RegisterSkillAction("guns", "guns_crit", {
	name = "Krytyczne Trafienie w Cel",
	description = "Pomyślne krytyczne trafienie celu NPC lub gracza.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 150},
		{level = 20, exp = 75},
		{level = 40, exp = 25},
		{level = 50, exp = 0},
	}
})

ix.action:RegisterSkillAction("guns", "guns_combat_move", {
	name = "Ruch w Walce z Bronią",
	description = "Poruszaj się w walce z bronią, by przyzwyczaić się do jej trzymania.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 10},
		{level = 5, exp = 0},
	}
})

ix.skill:RegisterSkillScale("guns", "guns_eff_range", {
	name = "Skuteczny Zasięg",
	description = "Maksymalny zasięg, w którym możesz skutecznie atakować cele, uwzględniając premię do celności.",
	minLevel = 0,
	maxLevel = 50,
	minValue = 50,
	increase = 150
})

ix.skill:RegisterSkillScale("guns", "guns_max_range", {
	name = "Maksymalny Zasięg",
	description = "Maksymalny zasięg, w którym można atakować cele bez utraty celności.",
	minLevel = 0,
	maxLevel = 50,
	minValue = 200,
	increase = 300
})

ix.skill:RegisterSkillScale("guns", "guns_moving_target_penalty", {
	name = "Kara Ruchomego Celu",
	description = "Kara przyznawana podczas walki z celem, który wykonał dowolną ilość akcji ruchu w swojej poprzedniej turze walki.",
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
	name = "Trening Zamachów",
	description = "Poćwicz zamachy bronią do walki wręcz, aby zdobyć podstawową biegłość w posługiwaniu się nią.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 10},
		{level = 5, exp = 2},
		{level = 10, exp = 0},
	}
})

ix.action:RegisterSkillAction("melee", "melee_slash_heavy", {
	name = "Trening Ciężkich Zamachów",
	description = "Ćwicz wykonywanie bardzo mocnych zamachów bronią do walki wręcz, aby jeszcze bardziej się z nią oswoić.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 10},
		{level = 10, exp = 0},
	}
})


ix.action:RegisterSkillAction("melee", "melee_hit", {
	name = "Uderzenie Celu",
	description = "Pomyślnie trafiony cel NPC lub gracza.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 50},
		{level = 20, exp = 20},
		{level = 40, exp = 10},
		{level = 50, exp = 0},
	}
})

ix.action:RegisterSkillAction("melee", "melee_crit", {
	name = "Uderzenie Krytyczne Celu",
	description = "Pomyślnie krytycznie trafiony cel NPC lub gracza.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 75},
		{level = 20, exp = 50},
		{level = 40, exp = 20},
		{level = 50, exp = 0},
	}
})

ix.action:RegisterSkillAction("melee", "melee_combat_move", {
	name = "Ruch w Walce z Bronią Białą",
	description = "Poruszaj się w walce z bronią do walki wręcz, nabierając wprawy w jej trzymaniu.",
	bNoLog = true,
	DoResult = {
		{level = 0, exp = 2},
		{level = 5, exp = 0},
	}
})

ix.skill:RegisterSkillScale("melee", "melee_light", {
	name = "Znajomość Lekkiej Broni Białej",
	description = "Znajomość lekkich broni do walki wręcz, odzwierciedlana przez szansę na trafienie krytyczne przeciwników w walce.",
	minLevel = 0,
	maxLevel = 20,
	minValue = 0.8,
	increase = 0.2,
	percentage = true,
})

ix.skill:RegisterSkillScale("melee", "melee_medium", {
	name = "Znajomość Średniej Broni Białej",
	description = "Znajomość średnich broni do walki wręcz, odzwierciedlana przez szansę na trafienie krytyczne przeciwników w walce.",
	minLevel = 0,
	maxLevel = 46,
	minValue = -0.15,
	increase = 1.15,
	percentage = true,
})

ix.skill:RegisterSkillScale("melee", "melee_heavy", {
	name = "Znajomość Ćiężkiej Broni Białej",
	description = "Znajomość ciężkich broni do walki wręcz, odzwierciedlana przez szansę na trafienie krytyczne przeciwników w walce.",
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
	name = "Wystarczająco Zabandażowany",
	description = "Pozwala stwierdzić, czy ktoś jest wystarczająco zabandażowany..",
	CanDo = 5
})

ix.skill:RegisterSkillScale("medicine", "bandage_skill", {
	name = "Skuteczność Bandaży",
	description = "To, jak dobry jesteś w prawidłowym zakładaniu bandaży, wpływa na ilość zdrowia uzyskiwanego dzięki bandażom.",
	minLevel = 0,
	maxLevel = 50,
	minValue = 0,
	increase = 1,
	add = true,
	percentage = true,
	digits = 0
})

ix.skill:RegisterSkillScale("medicine", "disinfectant_skill", {
	name = "Czas działania środka dezynfekującego",
	description = "To, jak dobrze radzisz sobie z oczyszczaniem ran, wpływa na długość działania środka dezynfekującego.",
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
	name = "Dodatkowy punkt ruchu",
	description = "Podczas wykonywania akcji ruchu w walce otrzymujesz jeden dodatkowy punkt ruchu.",
	bNoLog = true,
	CanDo = 15,
	DoResult = {
		{level = 0, exp = 20},
		{level = 50, exp = 0},
	}
})

ix.action:RegisterSkillAction("speed", "speed_move_point2", {
	name = "2-gi dodatkowy punkt ruchu",
	description = "Podczas wykonywania akcji ruchu w walce otrzymujesz jeden dodatkowy punkt ruchu.",
	CanDo = 30,
})

ix.action:RegisterSkillAction("speed", "speed_move_point_base", {
	name = "Drugi Bazowy Punkt Ruchu",
	description = "Zaczynasz swoją turę walki z 2 punktami ruchu zamiast 1.",
	CanDo = 40,
	DoResult = {
		{level = 40, exp = 10},
		{level = 50, exp = 0},
	}
})

ix.action:RegisterSkillAction("speed", "speed_sprint", {
	name = "Sprint na pewną odległość",
	description = "Trenuj szybkość, biegając sprintem na pewnym dystansie.",
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
	name = "Modyfikacja szansy na unik",
	description = "Modyfikacja szansy na unik, jeśli poruszałeś się podczas poprzedniej tury w walce.",
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
	name = "Premia do prędkości biegu",
	description = "Uzyskana prędkość biegu, ponieważ jesteś taki szybki!",
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
	name = "Trening Vortbeamu",
	description = "Ćwicz wystrzeliwanie wiązki vort.",
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
	name = "EXP Wejść Vortessencji",
	description = "EXP od dokonywania wpisów vortessence.",
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
	name = "Trafienie w cel wiązką",
	description = "Traf innych graczy wiązką vort.",
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
	name = "Czy potrafisz kierunkować swoją energię vort, by robić pewne rzeczy.",
	description = "Uderz innych graczy falą uderzeniową.",
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
					client:Notify("Jesteś zbyt wyczerpany, aby wykonać tę czynność w tej chwili!")
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
	name = "Trafienie celu falą uderzeniową",
	description = "Uderz innych graczy falą uderzeniową.",
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
	name = "Ruch w walce jako Vortigaunt",
	description = "Poruszanie się w walce jako vortigaunt",
    bNoLog = true,
    DoResult = {
        {level = 0, exp = 2},
        {level = 5, exp = 0},
    }
})

ix.skill:RegisterSkillScale("vort", "vort_beam", {
	name = "Siła wiązki Vort",
	description = "Ile obrażeń zadaje atak wiązką vort.",
	minLevel = 0,
	maxLevel = 50,
	minValue = 40,
	increase = 35,
})

ix.skill:RegisterSkillScale("vort", "vort_heal_amount", {
	name = "Wartość leczenia Vort",
	description = "Ile HP wyleczysz za pomocą swojej zdolności leczenia.",
	minLevel = 10,
	maxLevel = 50,
	minValue = 10,
	increase = 30,
})

ix.action:RegisterSkillAction("cooking", "harvest_plant", {
	name = "Zbierz plon",
	description = "Ciesz się obfitymi zbiorami.",
    DoResult = {
        {level = 0, exp = 400},
        {level = 20, exp = 250},
		{level = 40, exp = 150},
    }
})

ix.action:RegisterSkillAction("cooking", "plant_seed", {
	name = "Zasadź ziarno",
	description = "Zasadź coś, co kiedyś może zakwitnąć.",
    DoResult = {
        {level = 0, exp = 150},
        {level = 20, exp = 100},
		{level = 40, exp = 75},
    }
})