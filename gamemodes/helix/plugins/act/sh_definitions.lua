--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local function FacingWall(client)
	local data = {}
	data.start = client:EyePos()
	data.endpos = data.start + client:GetForward() * 20
	data.filter = client

	if (!util.TraceLine(data).Hit) then
		return "@faceWall"
	end
end

local function FacingWallBack(client)
	local data = {}
	data.start = client:LocalToWorld(client:OBBCenter())
	data.endpos = data.start - client:GetForward() * 20
	data.filter = client

	if (!util.TraceLine(data).Hit) then
		return "@faceWallBack"
	end
end

function PLUGIN:SetupActs()
	-- sit
	ix.act.Register("Sit", "metrocop", {
		sequence = {"n7_male_sit_ground", "n7_male_sit01", "n7_male_sit02", "n7_male_sit03", "n7_male_sit04", "n7_male_sit05", "n7_male_sit06", "n7_male_sit07"},
		untimed = true
	})

	ix.act.Register("Sit", "citizen_male", {
		sequence = {"willard_male_male_sit_ground", "willard_male_male_sit01", "willard_male_male_sit02", "willard_male_male_sit03", "willard_male_male_sit04", "willard_male_male_sit05", "willard_male_male_sit06", "willard_male_male_sit07"},
		untimed = true
	})

	ix.act.Register("Sit", "citizen_female", {
		sequence = {"willard_female_sit_ground", "willard_female_sit01", "willard_female_sit02", "willard_female_sit03", "willard_female_sit04", "willard_female_sit05", "willard_female_sit06", "willard_female_sit07"},
		untimed = true
	})

	ix.act.Register("Sit", "metrocop_female", {
		sequence = {"n7_female_sit_ground", "n7_female_sit01", "n7_female_sit02", "n7_female_sit03", "n7_female_sit04", "n7_female_sit05", "n7_female_sit06", "n7_female_sit07"},
		untimed = true
	})

	-- sitwall
	ix.act.Register("SitWall", "metrocop", {
		sequence = {
			{"n7_male_sitwall", check = FacingWallBack},
		},
		untimed = true,
		idle = true
	})

	ix.act.Register("SitWall", "citizen_male", {
		sequence = {
			{"willard_male_male_sitwall", check = FacingWallBack},
		},
		untimed = true,
		idle = true
	})

	ix.act.Register("SitWall", "metrocop_female", {
		sequence = {
			{"n7_female_sitwall", check = FacingWallBack},
		},
		untimed = true,
		idle = true
	})

	ix.act.Register("SitWall", "citizen_female", {
		sequence = {
			{"willard_female_sitwall", check = FacingWallBack},
		},
		untimed = true,
		idle = true
	})

	--sitlean
	ix.act.Register("SitLean", {"citizen_male", "citizen_female"}, {
		sequence = {"sitccouchtv1", "sitchair1", "sitchairtable1", "sitcouch1", "sitcouchknees1"},
		untimed = true,
		idle = true
	})

	ix.act.Register("SitChair", "citizen_male", {
		start = {"idle_to_sit_chair"},
		sequence = "sit_chair",
		finish = {"sit_chair_to_idle", duration = 2.1},
		untimed = true,
		idle = true
	})

	-- Idle
	ix.act.Register("Idle", "vortigaunt", {
		sequence = "idle_nectar",
		untimed = true,
		idle = true
	})

	-- Kneel
	ix.act.Register("Kneel", "vortigaunt", {
		sequence = "rescue_idle",
		untimed = true,
		idle = true
	})

	-- Sit
	ix.act.Register("Sit", "vortigaunt", {
		sequence = {"chess_wait", {"sit_rollercoaster", offset = function(client)
				return client:GetUp() * 25 + client:GetForward() * -30
			end}
		},
		untimed = true,
		idle = true
	})

	-- stand
	ix.act.Register("Stand","metrocop", {
		sequence = {"n7_male_stand01", "n7_male_stand02", "n7_male_stand03", "n7_male_stand04", "n7_male_stand05"},
		untimed = true
	})

	ix.act.Register("Stand", "citizen_male", {
		sequence = {"willard_male_male_stand01", "willard_male_male_stand02", "willard_male_male_stand03", "willard_male_male_stand04", "willard_male_male_stand05"},
		untimed = true
	})

	ix.act.Register("Stand", "metrocop_female", {
		sequence = {"n7_female_stand01", "n7_female_stand02", "n7_female_stand03", "n7_female_stand04", "n7_female_stand05"},
		untimed = true
	})

	ix.act.Register("Stand", "citizen_female", {
		sequence = {"willard_female_stand01", "willard_female_stand02", "willard_female_stand03", "willard_female_stand04", "willard_female_stand05"},
		untimed = true
	})

	-- type
	ix.act.Register("Type", "overwatch", {
		sequence = "console_type_loop",
		untimed = true,
		idle = true
	})

	-- cheer
	ix.act.Register("Cheer", {"citizen_male", "metrocop"}, {
		sequence = {{"cheer1", duration = 1.6}, "cheer2", "wave_smg1"}
	})

	ix.act.Register("Cheer", {"citizen_female", "metrocop_female"}, {
		sequence = {"cheer1", "wave_smg1"}
	})

	-- lean
	ix.act.Register("Lean", {"citizen_male", "citizen_female"}, {
		start = {"idle_to_lean_back", "", ""},
		sequence = {
			{"lean_back", check = FacingWallBack},
			{"plazaidle1", check = FacingWallBack},
			{"plazaidle2", check = FacingWallBack}
		},
		untimed = true,
		idle = true
	})

	ix.act.Register("Lean", {"metrocop"}, {
		sequence = {
				{"n7_male_lean01", check = FacingWallBack},
				{"n7_male_lean02", check = FacingWallBack},
				{"idle_baton", check = FacingWallBack},
		},
		untimed = true,
		idle = true
	})

	ix.act.Register("Lean", "citizen_male", {
		sequence = {
			{"willard_male_male_lean01", check = FacingWallBack, offset = function(client)
				return client:GetForward() * 4
			end},
			{"willard_male_male_lean02", check = FacingWallBack, offset = function(client)
				return client:GetForward() * 3
			end}
		},
		untimed = true,
		idle = true
	})

	ix.act.Register("Lean", "metrocop_female", {
		sequence = {
			{"n7_female_lean01", check = FacingWallBack, offset = function(client)
				return client:GetForward() * 6
			end},
			{"n7_female_lean02", check = FacingWallBack, offset = function(client)
				return client:GetForward() * 4
			end}
		},
		untimed = true,
		idle = true
	})

	ix.act.Register("Lean", "citizen_female", {
		sequence = {
			{"willard_female_lean01", check = FacingWallBack, offset = function(client)
				return client:GetForward() * 6
			end},
			{"willard_female_lean02", check = FacingWallBack, offset = function(client)
				return client:GetForward() * 4
			end}
		},
		untimed = true,
		idle = true
	})

	-- injured
	ix.act.Register("Injured", "metrocop", {
		sequence = {"n7_male_injured"},
		untimed = true,
		idle = true
	})

	ix.act.Register("Injured", "citizen_male", {
		sequence = {"willard_male_male_injured"},
		untimed = true,
		idle = true
	})

	ix.act.Register("Injured", "metrocop_female", {
		sequence = "n7_female_injured",
		untimed = true,
		idle = true
	})

	ix.act.Register("Injured", "citizen_female", {
		sequence = "willard_female_injured",
		untimed = true,
		idle = true
	})

	-- arrest
	ix.act.Register("Arrest", "metrocop", {
		sequence = {"n7_male_arrest", "n7_male_arrest_sit01", "n7_male_handsup"},
		untimed = true
	})

	ix.act.Register("Arrest", "citizen_male", {
		sequence = {"willard_male_male_arrest", "willard_male_male_arrest_sit01", "willard_male_male_handsup"},
		untimed = true
	})

	ix.act.Register("Arrest", "metrocop_female", {
		sequence = {"n7_female_arrest", "n7_female_arrest_sit01", "n7_female_handsup"},
		untimed = true
	})

	ix.act.Register("Arrest", "citizen_female", {
		sequence = {"willard_female_arrest", "willard_female_arrest_sit01", "willard_female_handsup"},
		untimed = true
	})

	-- threat
	ix.act.Register("Threat", "metrocop", {
		sequence = {"plazathreat1", "plazathreat2"}
	})

	-- search
	ix.act.Register("Search", "metrocop", {
		sequence = "spreadwall",
	})

	-- deny
	ix.act.Register("Deny", "metrocop", {
		sequence = {"harassfront2", "harassfront1"}
	})

	-- motion
	ix.act.Register("Motion", "metrocop", {
		sequence = {"motionleft", "motionright", "luggagewarn"}
	})

	-- wave
	ix.act.Register("Wave", {"citizen_male", "citizen_female"}, {
		sequence = {{"wave", duration = 2.75}, {"wave_close", duration = 1.75}}
	})

	-- pant
	ix.act.Register("Pant", {"citizen_male", "citizen_female"}, {
		start = {"d2_coast03_postbattle_idle02_entry", "d2_coast03_postbattle_idle01_entry"},
		sequence = {"d2_coast03_postbattle_idle02", {"d2_coast03_postbattle_idle01", check = FacingWall}},
		untimed = true
	})

	-- window
	ix.act.Register("Window", {"citizen_male", "metrocop"}, {
		sequence = "d1_t03_tenements_look_out_window_idle",
		untimed = true
	})

	ix.act.Register("Window", {"citizen_female", "metrocop_female"}, {
		sequence = "d1_t03_lookoutwindow",
		untimed = true
	})

	-- down
	ix.act.Register("Down", "metrocop", {
		sequence = {"n7_male_down01", "n7_male_down02", "n7_male_down03"},
		untimed = true,
		idle = true
	})

	ix.act.Register("Down", "citizen_male", {
		sequence = {"willard_male_male_down01", "willard_male_male_down02", "willard_male_male_down03"},
		untimed = true,
		idle = true
	})

	ix.act.Register("Down", "metrocop_female", {
		sequence = {"n7_female_down01", "n7_female_down02", "n7_female_down03"},
		untimed = true,
		idle = true
	})

	ix.act.Register("Down", "citizen_female", {
		sequence = {"willard_female_down01", "willard_female_down02", "willard_female_down03"},
		untimed = true,
		idle = true
	})


	-- Check
	ix.act.Register("Check", "metrocop", {
		sequence = {"n7_male_check"},
		untimed = true
	})

	ix.act.Register("Check", "citizen_male", {
		sequence = {"willard_male_male_check"},
		untimed = true
	})

	ix.act.Register("Check", "metrocop_female", {
		sequence = {"n7_female_check"},
		untimed = true
	})

	ix.act.Register("Check", "citizen_female", {
		sequence = {"willard_female_check"},
		untimed = true
	})


	-- Knock
	ix.act.Register("KnockIdle", "metrocop", {
		sequence = {"adoorcidle"},
		untimed = true
	})

	ix.act.Register("Knock", "metrocop", {
		sequence = {"adoorknock"},
		untimed = true
	})

	ix.act.Register("Knock", "citizen_male", {
		sequence = {"d1_town05_Leon_Door_Knock"}
	})
end
