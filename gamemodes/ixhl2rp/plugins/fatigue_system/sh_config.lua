--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

-- Buffs and Debuffs
ix.config.Add("energyLevelToApplyBuffs", 25, "Starting from what level of energy character will be considered not fatigued and buffs will be applied.", function(_, newValue)
	PLUGIN.energyStatusSubBars[1].minLevel = newValue
end, {
	data = {min = 0, max = 100},
	category = "Fatigue System - Buffs and Debuffs"
})

ix.config.Add("energyMaxActionSpeedDebuff", 50, "How much slower (per cent wise) characters actions will become at energy level of 0.", nil, {
	data = {min = 0, max = 100},
	category = "Fatigue System - Buffs and Debuffs"
})
ix.config.Add("energyMaxActionSpeedBuff", 50, "How much faster (per cent wise) characters actions will become if energy level is higer than 100.", nil, {
	data = {min = 0, max = 100},
	category = "Fatigue System - Buffs and Debuffs"
})

ix.config.Add("energyMaxStaminaOffsetDebuff", 50, "How much lower (per cent wise) characters maximum stamina will be at energy level of 0.", function(_, newValue)
	PLUGIN.energyMaxStaminaOffsetDebuff = newValue / 100
end, {
	data = {min = 0, max = 100},
	category = "Fatigue System - Buffs and Debuffs"
})
ix.config.Add("energyMaxStaminaOffsetBuff", 50, "How much bigger (per cent wise) characters maximum stamina will be if energy level is higer than 100.", function(_, newValue)
	PLUGIN.energyMaxStaminaOffsetBuff = newValue / 100
end, {
	data = {min = 0, max = 100},
	category = "Fatigue System - Buffs and Debuffs"
})

-- Energy Consumption
ix.config.Add("maxEquipmentEnergyConsumptionReduction", 40, "How much less (per cent wise) will energy consumption for equipped gear be if characters strength level is 10.", function(_, newValue)
	PLUGIN.maxEquipmentEnergyConsumptionReduction = newValue / 100
end, {
	data = {min = 0, max = 100},
	category = "Fatigue System - Energy Consumption"
})
ix.config.Add("maxFilledSlotsEnergyConsumptionReduction", 40, "How much less (per cent wise) will energy consumption for filled inventory slots be if characters strength level is 10.", function(_, newValue)
	PLUGIN.maxFilledSlotsEnergyConsumptionReduction = newValue / 100
end, {
	data = {min = 0, max = 100},
	category = "Fatigue System - Energy Consumption"
})

ix.config.Add("jumpEnergyConsumption", 0.1, "How much energy will be substracted from character on every jump.", nil, {
	data = {min = 0, max = 1, decimals = 4},
	category = "Fatigue System - Energy Consumption"
})
ix.config.Add("baseEnergyConsumption", 0.004, "How much energy (per second) will be substracted from character by just walking.", nil, {
	data = {min = 0, max = 1, decimals = 4},
	category = "Fatigue System - Energy Consumption"
})
ix.config.Add("filledSlotEnergyConsumption", 0.001, "How much energy (per second) will be substracted from character by having one inventory slot filled (filled slots stack with each other).", nil, {
	data = {min = 0, max = 1, decimals = 4},
	category = "Fatigue System - Energy Consumption"
})
ix.config.Add("runningEnergyConsumption", 0.008, "How much energy (per second) will be substracted from character by running (stacks with base energy consumption).", nil, {
	data = {min = 0, max = 1, decimals = 4},
	category = "Fatigue System - Energy Consumption"
})
ix.config.Add("garbageCollectingEnergyConsumption", 0.0004, "How much energy (per second) will be substracted from character while collecting garbage pile.", nil, {
	data = {min = 0, max = 1, decimals = 4},
	category = "Fatigue System - Energy Consumption"
})

-- Energy Restoration
ix.config.Add("rpAreaEnergyRestoration", 0.017, "How much energy (per second) will be added to character by being in RP area and not being AFK.", nil, {
	data = {min = 0, max = 1, decimals = 4},
	category = "Fatigue System - Energy Restoration"
})
ix.config.Add("baseRestingEnergyRestoration", 0.004, "How much energy (per second) will be added to character by being in an untimed act.", nil, {
	data = {min = 0, max = 1, decimals = 4},
	category = "Fatigue System - Energy Restoration"
})

-- energy skill shifts
PLUGIN.energySkillShifts = {
	buffs = {
		melee = 4,
		guns = 4,
		speed = 8
	}
}

function PLUGIN:InitializedPlugins()
	self.noFatigueFactions = {
		[FACTION_OTA] = true,
		[FACTION_VORT] = true,
		[FACTION_BIRD] = true,
		[FACTION_HEADCRAB] = true
	}

	if (self.InitializedPlugins2) then -- all of this can be united into single func, but I want to keep it that way for simplier code reading
		self:InitializedPlugins2()
	end
end

function PLUGIN:InitializedConfig()
	self.energyMaxStaminaOffsetDebuff = ix.config.Get("energyMaxStaminaOffsetDebuff", 50) / 100
	self.energyMaxStaminaOffsetBuff = ix.config.Get("energyMaxStaminaOffsetBuff", 50) / 100
	self.maxEquipmentEnergyConsumptionReduction = ix.config.Get("maxEquipmentEnergyConsumptionReduction", 40) / 100
	self.maxFilledSlotsEnergyConsumptionReduction = ix.config.Get("maxFilledSlotsEnergyConsumptionReduction", 40) / 100
end

PLUGIN.restingEntities = PLUGIN.restEntities or {}
--[[
	THINGS TO KNOW BEFORE YOU START EDITING OFFSETS:
	"willard_male_male_sit02" and "n7_male_sit02" sequences have default rotation of model of about 10 degrees
	"willard_female_sit05" sequence has default model up offset lower than any other female sequence
	"willard_female_sit06" sequence has differetn pelvis level for each leg of the model, and so one leg either fly, or one leg sinks in the chair
	"willard_female_sit07" and "n7_female_sit07" sequences does not have default model forward offset
]]--

--[[ CHAIRS ]]-- (actually has entities with other sitting animations, but if we change class naming - it'll require admins to place entities again)
PLUGIN.restingEntities["models/chairs/armchair.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	maxEnergyBonus = 20,
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 29, upOffset = 19},
		["willard_male_male_sit02"] = {angleYawOffset = -10, rightOffset = 4, forwardOffset = 27, upOffset = 19},
		["willard_male_male_sit03"] = {rightOffset = -2, forwardOffset = 30, upOffset = 19},
		["willard_male_male_sit04"] = {forwardOffset = 30, upOffset = 17},
		["willard_male_male_sit05"] = {forwardOffset = 30, upOffset = 19},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 34, upOffset = 19},
		["willard_female_sit02"] = {rightOffset = -0.2, forwardOffset = 32, upOffset = 17},
		["willard_female_sit03"] = {rightOffset = -0.2, forwardOffset = 33, upOffset = 16},
		["willard_female_sit04"] = {rightOffset = -0.2, forwardOffset = 30, upOffset = 18},
		["willard_female_sit05"] = {rightOffset = -0.2, forwardOffset = 32, upOffset = 20},
		["willard_female_sit06"] = {forwardOffset = 37, upOffset = 16},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 29, upOffset = 19},
		["n7_male_sit02"] = {angleYawOffset = -10, rightOffset = 4, forwardOffset = 28, upOffset = 18},
		["n7_male_sit03"] = {rightOffset = -2, forwardOffset = 30, upOffset = 19},
		["n7_male_sit04"] = {forwardOffset = 30, upOffset = 17},
		["n7_male_sit05"] = {rightOffset = 0, forwardOffset = 30, upOffset = 19},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 33, upOffset = 18},
		["n7_female_sit02"] = {rightOffset = -0.2, forwardOffset = 32, upOffset = 17},
		["n7_female_sit03"] = {rightOffset = -0.2, forwardOffset = 33, upOffset = 16},
		["n7_female_sit04"] = {rightOffset = -0.2, forwardOffset = 30, upOffset = 18},
		["n7_female_sit05"] = {rightOffset = -0.2, forwardOffset = 32, upOffset = 20},
		["n7_female_sit06"] = {forwardOffset = 37, upOffset = 16},
	}
}

-- nova
-- TODO: find custom offset for every and each sequence (expect for `willard_male_male_sit01` and `willard_male_male_sit02`)
PLUGIN.restingEntities["models/nova/chair_office01.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		["willard_male_male_sit02"] = {angleYawOffset = 80, rightOffset = -18, forwardOffset = 4.5, upOffset = 7},
		["willard_male_male_sit03"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		["willard_male_male_sit04"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		["willard_male_male_sit05"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		-- citizen_female
		["willard_female_sit01"] = {angleYawOffset = 90, rightOffset = -23,upOffset = 7},
		["willard_female_sit02"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		["willard_female_sit03"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		["willard_female_sit04"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		["willard_female_sit05"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		["willard_female_sit06"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		-- metropolice
		["n7_male_sit01"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		["n7_male_sit02"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		["n7_male_sit03"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		["n7_male_sit04"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		["n7_male_sit05"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		-- metropolice_female
		["n7_female_sit01"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		["n7_female_sit02"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		["n7_female_sit03"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		["n7_female_sit04"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		["n7_female_sit05"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		["n7_female_sit06"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
		["n7_female_sit07"] = {angleYawOffset = 90, rightOffset = -23, upOffset = 7},
	}
}
PLUGIN.restingEntities["models/props_c17/chair_office01a.mdl"] = PLUGIN.restingEntities["models/nova/chair_office01.mdl"]
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/nova/chair_wood01.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["willard_male_male_sit02"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["willard_male_male_sit03"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["willard_male_male_sit04"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["willard_male_male_sit05"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		-- citizen_female
		["willard_female_sit01"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["willard_female_sit02"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["willard_female_sit03"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["willard_female_sit04"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["willard_female_sit05"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["willard_female_sit06"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["willard_female_sit07"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		-- metropolice
		["n7_male_sit01"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["n7_male_sit02"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["n7_male_sit03"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["n7_male_sit04"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["n7_male_sit05"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		-- metropolice_female
		["n7_female_sit01"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["n7_female_sit02"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["n7_female_sit03"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["n7_female_sit04"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["n7_female_sit05"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["n7_female_sit06"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
		["n7_female_sit07"] = {angleYawOffset = 90, rightOffset = -28, upOffset = -2},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/nova/chair_plastic01.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_male_male_sit02"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_male_male_sit03"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_male_male_sit04"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_male_male_sit05"] = {angleYawOffset = 90, rightOffset = -28},
		-- citizen_female
		["willard_female_sit01"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_female_sit02"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_female_sit03"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_female_sit04"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_female_sit05"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_female_sit06"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_female_sit07"] = {angleYawOffset = 90, rightOffset = -28},
		-- metropolice
		["n7_male_sit01"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_male_sit02"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_male_sit03"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_male_sit04"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_male_sit05"] = {angleYawOffset = 90, rightOffset = -28},
		-- metropolice_female
		["n7_female_sit01"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_female_sit02"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_female_sit03"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_female_sit04"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_female_sit05"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_female_sit06"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_female_sit07"] = {angleYawOffset = 90, rightOffset = -28},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/nova/chair_office02.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_male_male_sit02"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_male_male_sit03"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_male_male_sit04"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_male_male_sit05"] = {angleYawOffset = 90, rightOffset = -28},
		-- citizen_female
		["willard_female_sit01"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_female_sit02"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_female_sit03"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_female_sit04"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_female_sit05"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_female_sit06"] = {angleYawOffset = 90, rightOffset = -28},
		["willard_female_sit07"] = {angleYawOffset = 90, rightOffset = -28},
		-- metropolice
		["n7_male_sit01"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_male_sit02"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_male_sit03"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_male_sit04"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_male_sit05"] = {angleYawOffset = 90, rightOffset = -28},
		-- metropolice_female
		["n7_female_sit01"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_female_sit02"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_female_sit03"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_female_sit04"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_female_sit05"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_female_sit06"] = {angleYawOffset = 90, rightOffset = -28},
		["n7_female_sit07"] = {angleYawOffset = 90, rightOffset = -28},
	}
}

-- props_c17
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_c17/furniturechair001a.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 25, upOffset = -21},
		["willard_male_male_sit02"] = {forwardOffset = 25, upOffset = -21},
		["willard_male_male_sit03"] = {forwardOffset = 25, upOffset = -21},
		["willard_male_male_sit04"] = {forwardOffset = 25, upOffset = -21},
		["willard_male_male_sit05"] = {forwardOffset = 25, upOffset = -21},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 25, upOffset = -21},
		["willard_female_sit02"] = {forwardOffset = 25, upOffset = -21},
		["willard_female_sit03"] = {forwardOffset = 25, upOffset = -21},
		["willard_female_sit04"] = {forwardOffset = 25, upOffset = -21},
		["willard_female_sit05"] = {forwardOffset = 25, upOffset = -21},
		["willard_female_sit06"] = {forwardOffset = 25, upOffset = -21},
		["willard_female_sit07"] = {forwardOffset = 25, upOffset = -21},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 25, upOffset = -21},
		["n7_male_sit02"] = {forwardOffset = 25, upOffset = -21},
		["n7_male_sit03"] = {forwardOffset = 25, upOffset = -21},
		["n7_male_sit04"] = {forwardOffset = 25, upOffset = -21},
		["n7_male_sit05"] = {forwardOffset = 25, upOffset = -21},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 25, upOffset = -21},
		["n7_female_sit02"] = {forwardOffset = 25, upOffset = -21},
		["n7_female_sit03"] = {forwardOffset = 25, upOffset = -21},
		["n7_female_sit04"] = {forwardOffset = 25, upOffset = -21},
		["n7_female_sit05"] = {forwardOffset = 25, upOffset = -21},
		["n7_female_sit06"] = {forwardOffset = 25, upOffset = -21},
		["n7_female_sit07"] = {forwardOffset = 25, upOffset = -21},
	}
}
PLUGIN.restingEntities["models/props_c17/furniturechair001a_static.mdl"] = PLUGIN.restingEntities["models/props_c17/furniturechair001a.mdl"]
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_c17/chair_stool01a.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit02"] = {forwardOffset = 23, upOffset = 17},
		["willard_male_male_sit03"] = {forwardOffset = 23, upOffset = 17},
		["willard_male_male_sit04"] = {forwardOffset = 23, upOffset = 17},
		["willard_male_male_sit05"] = {forwardOffset = 23, upOffset = 17},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 23, upOffset = 17},
		["willard_female_sit03"] = {forwardOffset = 23, upOffset = 17},
		["willard_female_sit04"] = {forwardOffset = 23, upOffset = 17},
		["willard_female_sit05"] = {forwardOffset = 23, upOffset = 17},
		["willard_female_sit07"] = {forwardOffset = 23, upOffset = 17},
		-- metropolice
		["n7_male_sit02"] = {forwardOffset = 23, upOffset = 17},
		["n7_male_sit03"] = {forwardOffset = 23, upOffset = 17},
		["n7_male_sit04"] = {forwardOffset = 23, upOffset = 17},
		["n7_male_sit05"] = {forwardOffset = 23, upOffset = 17},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 23, upOffset = 17},
		["n7_female_sit03"] = {forwardOffset = 23, upOffset = 17},
		["n7_female_sit04"] = {forwardOffset = 23, upOffset = 17},
		["n7_female_sit05"] = {forwardOffset = 23, upOffset = 17},
		["n7_female_sit07"] = {forwardOffset = 23, upOffset = 17},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_c17/chair02a.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["willard_male_male_sit02"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["willard_male_male_sit03"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["willard_male_male_sit04"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["willard_male_male_sit05"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		-- citizen_female
		["willard_female_sit01"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["willard_female_sit02"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["willard_female_sit03"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["willard_female_sit04"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["willard_female_sit05"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["willard_female_sit06"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["willard_female_sit07"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		-- metropolice
		["n7_male_sit01"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["n7_male_sit02"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["n7_male_sit03"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["n7_male_sit04"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["n7_male_sit05"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		-- metropolice_female
		["n7_female_sit01"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["n7_female_sit02"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["n7_female_sit03"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["n7_female_sit04"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["n7_female_sit05"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["n7_female_sit06"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
		["n7_female_sit07"] = {rightOffset = -4, forwardOffset = 42, upOffset = -13},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_c17/chair_kleiner03a.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["willard_male_male_sit02"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["willard_male_male_sit03"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["willard_male_male_sit04"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["willard_male_male_sit05"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		-- citizen_female
		["willard_female_sit01"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["willard_female_sit02"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["willard_female_sit03"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["willard_female_sit04"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["willard_female_sit05"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["willard_female_sit06"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["willard_female_sit07"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		-- metropolice
		["n7_male_sit01"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["n7_male_sit02"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["n7_male_sit03"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["n7_male_sit04"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["n7_male_sit05"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		-- metropolice_female
		["n7_female_sit01"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["n7_female_sit02"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["n7_female_sit03"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["n7_female_sit04"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["n7_female_sit05"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["n7_female_sit06"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
		["n7_female_sit07"] = {angleYawOffset = 180, rightOffset = -1, forwardOffset = -25, upOffset = 25},
	}
}

-- props_furniture
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_furniture/cafe_barstool1.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 23, upOffset = 17},
		["willard_male_male_sit02"] = {forwardOffset = 23, upOffset = 17},
		["willard_male_male_sit03"] = {forwardOffset = 23, upOffset = 17},
		["willard_male_male_sit04"] = {forwardOffset = 23, upOffset = 17},
		["willard_male_male_sit05"] = {forwardOffset = 23, upOffset = 17},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 23, upOffset = 17},
		["willard_female_sit02"] = {forwardOffset = 23, upOffset = 17},
		["willard_female_sit03"] = {forwardOffset = 23, upOffset = 17},
		["willard_female_sit04"] = {forwardOffset = 23, upOffset = 17},
		["willard_female_sit05"] = {forwardOffset = 23, upOffset = 17},
		["willard_female_sit06"] = {forwardOffset = 23, upOffset = 17},
		["willard_female_sit07"] = {forwardOffset = 23, upOffset = 17},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 23, upOffset = 17},
		["n7_male_sit02"] = {forwardOffset = 23, upOffset = 17},
		["n7_male_sit03"] = {forwardOffset = 23, upOffset = 17},
		["n7_male_sit04"] = {forwardOffset = 23, upOffset = 17},
		["n7_male_sit05"] = {forwardOffset = 23, upOffset = 17},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 23, upOffset = 17},
		["n7_female_sit02"] = {forwardOffset = 23, upOffset = 17},
		["n7_female_sit03"] = {forwardOffset = 23, upOffset = 17},
		["n7_female_sit04"] = {forwardOffset = 23, upOffset = 17},
		["n7_female_sit05"] = {forwardOffset = 23, upOffset = 17},
		["n7_female_sit06"] = {forwardOffset = 23, upOffset = 17},
		["n7_female_sit07"] = {forwardOffset = 23, upOffset = 17},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_furniture/hotel_chair.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 30, upOffset = 5},
		["willard_male_male_sit02"] = {forwardOffset = 30, upOffset = 5},
		["willard_male_male_sit03"] = {forwardOffset = 30, upOffset = 5},
		["willard_male_male_sit04"] = {forwardOffset = 30, upOffset = 5},
		["willard_male_male_sit05"] = {forwardOffset = 30, upOffset = 5},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 30, upOffset = 5},
		["willard_female_sit02"] = {forwardOffset = 30, upOffset = 5},
		["willard_female_sit03"] = {forwardOffset = 30, upOffset = 5},
		["willard_female_sit04"] = {forwardOffset = 30, upOffset = 5},
		["willard_female_sit05"] = {forwardOffset = 30, upOffset = 5},
		["willard_female_sit06"] = {forwardOffset = 30, upOffset = 5},
		["willard_female_sit07"] = {forwardOffset = 30, upOffset = 5},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 30, upOffset = 5},
		["n7_male_sit02"] = {forwardOffset = 30, upOffset = 5},
		["n7_male_sit03"] = {forwardOffset = 30, upOffset = 5},
		["n7_male_sit04"] = {forwardOffset = 30, upOffset = 5},
		["n7_male_sit05"] = {forwardOffset = 30, upOffset = 5},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 30, upOffset = 5},
		["n7_female_sit02"] = {forwardOffset = 30, upOffset = 5},
		["n7_female_sit03"] = {forwardOffset = 30, upOffset = 5},
		["n7_female_sit04"] = {forwardOffset = 30, upOffset = 5},
		["n7_female_sit05"] = {forwardOffset = 30, upOffset = 5},
		["n7_female_sit06"] = {forwardOffset = 30, upOffset = 5},
		["n7_female_sit07"] = {forwardOffset = 30, upOffset = 5},
	}
}

-- props_interiors
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_interiors/chair_cafeteria.mdl"] = { -- non-existent
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 28, upOffset = 1},
		["willard_male_male_sit02"] = {forwardOffset = 28, upOffset = 1},
		["willard_male_male_sit03"] = {forwardOffset = 28, upOffset = 1},
		["willard_male_male_sit04"] = {forwardOffset = 28, upOffset = 1},
		["willard_male_male_sit05"] = {forwardOffset = 28, upOffset = 1},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 28, upOffset = 1},
		["willard_female_sit02"] = {forwardOffset = 28, upOffset = 1},
		["willard_female_sit03"] = {forwardOffset = 28, upOffset = 1},
		["willard_female_sit04"] = {forwardOffset = 28, upOffset = 1},
		["willard_female_sit05"] = {forwardOffset = 28, upOffset = 1},
		["willard_female_sit06"] = {forwardOffset = 28, upOffset = 1},
		["willard_female_sit07"] = {forwardOffset = 28, upOffset = 1},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 28, upOffset = 1},
		["n7_male_sit02"] = {forwardOffset = 28, upOffset = 1},
		["n7_male_sit03"] = {forwardOffset = 28, upOffset = 1},
		["n7_male_sit04"] = {forwardOffset = 28, upOffset = 1},
		["n7_male_sit05"] = {forwardOffset = 28, upOffset = 1},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 28, upOffset = 1},
		["n7_female_sit02"] = {forwardOffset = 28, upOffset = 1},
		["n7_female_sit03"] = {forwardOffset = 28, upOffset = 1},
		["n7_female_sit04"] = {forwardOffset = 28, upOffset = 1},
		["n7_female_sit05"] = {forwardOffset = 28, upOffset = 1},
		["n7_female_sit06"] = {forwardOffset = 28, upOffset = 1},
		["n7_female_sit07"] = {forwardOffset = 28, upOffset = 1},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_interiors/furniture_chair01a.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 25, upOffset = -19},
		["willard_male_male_sit02"] = {forwardOffset = 25, upOffset = -19},
		["willard_male_male_sit03"] = {forwardOffset = 25, upOffset = -19},
		["willard_male_male_sit04"] = {forwardOffset = 25, upOffset = -19},
		["willard_male_male_sit05"] = {forwardOffset = 25, upOffset = -19},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 25, upOffset = -19},
		["willard_female_sit02"] = {forwardOffset = 25, upOffset = -19},
		["willard_female_sit03"] = {forwardOffset = 25, upOffset = -19},
		["willard_female_sit04"] = {forwardOffset = 25, upOffset = -19},
		["willard_female_sit05"] = {forwardOffset = 25, upOffset = -19},
		["willard_female_sit06"] = {forwardOffset = 25, upOffset = -19},
		["willard_female_sit07"] = {forwardOffset = 25, upOffset = -19},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 25, upOffset = -19},
		["n7_male_sit02"] = {forwardOffset = 25, upOffset = -19},
		["n7_male_sit03"] = {forwardOffset = 25, upOffset = -19},
		["n7_male_sit04"] = {forwardOffset = 25, upOffset = -19},
		["n7_male_sit05"] = {forwardOffset = 25, upOffset = -19},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 25, upOffset = -19},
		["n7_female_sit02"] = {forwardOffset = 25, upOffset = -19},
		["n7_female_sit03"] = {forwardOffset = 25, upOffset = -19},
		["n7_female_sit04"] = {forwardOffset = 25, upOffset = -19},
		["n7_female_sit05"] = {forwardOffset = 25, upOffset = -19},
		["n7_female_sit06"] = {forwardOffset = 25, upOffset = -19},
		["n7_female_sit07"] = {forwardOffset = 25, upOffset = -19},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_interiors/chair_office2.mdl"] = { -- non-existent
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 27, upOffset = 1},
		["willard_male_male_sit02"] = {forwardOffset = 27, upOffset = 1},
		["willard_male_male_sit03"] = {forwardOffset = 27, upOffset = 1},
		["willard_male_male_sit04"] = {forwardOffset = 27, upOffset = 1},
		["willard_male_male_sit05"] = {forwardOffset = 27, upOffset = 1},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 27, upOffset = 1},
		["willard_female_sit02"] = {forwardOffset = 27, upOffset = 1},
		["willard_female_sit03"] = {forwardOffset = 27, upOffset = 1},
		["willard_female_sit04"] = {forwardOffset = 27, upOffset = 1},
		["willard_female_sit05"] = {forwardOffset = 27, upOffset = 1},
		["willard_female_sit06"] = {forwardOffset = 27, upOffset = 1},
		["willard_female_sit07"] = {forwardOffset = 27, upOffset = 1},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 27, upOffset = 1},
		["n7_male_sit02"] = {forwardOffset = 27, upOffset = 1},
		["n7_male_sit03"] = {forwardOffset = 27, upOffset = 1},
		["n7_male_sit04"] = {forwardOffset = 27, upOffset = 1},
		["n7_male_sit05"] = {forwardOffset = 27, upOffset = 1},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 27, upOffset = 1},
		["n7_female_sit02"] = {forwardOffset = 27, upOffset = 1},
		["n7_female_sit03"] = {forwardOffset = 27, upOffset = 1},
		["n7_female_sit04"] = {forwardOffset = 27, upOffset = 1},
		["n7_female_sit05"] = {forwardOffset = 27, upOffset = 1},
		["n7_female_sit06"] = {forwardOffset = 27, upOffset = 1},
		["n7_female_sit07"] = {forwardOffset = 27, upOffset = 1},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_interiors/furniture_couch02a.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 26, upOffset = -23},
		["willard_male_male_sit02"] = {forwardOffset = 26, upOffset = -23},
		["willard_male_male_sit03"] = {forwardOffset = 26, upOffset = -23},
		["willard_male_male_sit04"] = {forwardOffset = 26, upOffset = -23},
		["willard_male_male_sit05"] = {forwardOffset = 26, upOffset = -23},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 26, upOffset = -23},
		["willard_female_sit02"] = {forwardOffset = 26, upOffset = -23},
		["willard_female_sit03"] = {forwardOffset = 26, upOffset = -23},
		["willard_female_sit04"] = {forwardOffset = 26, upOffset = -23},
		["willard_female_sit05"] = {forwardOffset = 26, upOffset = -23},
		["willard_female_sit06"] = {forwardOffset = 26, upOffset = -23},
		["willard_female_sit07"] = {forwardOffset = 26, upOffset = -23},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 26, upOffset = -23},
		["n7_male_sit02"] = {forwardOffset = 26, upOffset = -23},
		["n7_male_sit03"] = {forwardOffset = 26, upOffset = -23},
		["n7_male_sit04"] = {forwardOffset = 26, upOffset = -23},
		["n7_male_sit05"] = {forwardOffset = 26, upOffset = -23},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 26, upOffset = -23},
		["n7_female_sit02"] = {forwardOffset = 26, upOffset = -23},
		["n7_female_sit03"] = {forwardOffset = 26, upOffset = -23},
		["n7_female_sit04"] = {forwardOffset = 26, upOffset = -23},
		["n7_female_sit05"] = {forwardOffset = 26, upOffset = -23},
		["n7_female_sit06"] = {forwardOffset = 26, upOffset = -23},
		["n7_female_sit07"] = {forwardOffset = 26, upOffset = -23},
	}
}
PLUGIN.restingEntities["models/props/de_inferno/furniture_couch02a.mdl"] = PLUGIN.restingEntities["models/props_interiors/furniture_couch02a.mdl"]
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_interiors/chairlobby01.mdl"] = { -- non existent
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["willard_male_male_sit02"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["willard_male_male_sit03"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["willard_male_male_sit04"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["willard_male_male_sit05"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		-- citizen_female
		["willard_female_sit01"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["willard_female_sit02"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["willard_female_sit03"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["willard_female_sit04"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["willard_female_sit05"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["willard_female_sit06"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["willard_female_sit07"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		-- metropolice
		["n7_male_sit01"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["n7_male_sit02"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["n7_male_sit03"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["n7_male_sit04"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["n7_male_sit05"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		-- metropolice_female
		["n7_female_sit01"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["n7_female_sit02"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["n7_female_sit03"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["n7_female_sit04"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["n7_female_sit05"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["n7_female_sit06"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
		["n7_female_sit07"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 2},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_interiors/sofa_chair02.mdl"] = { -- non existent
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 32, upOffset = 1},
		["willard_male_male_sit02"] = {forwardOffset = 32, upOffset = 1},
		["willard_male_male_sit03"] = {forwardOffset = 32, upOffset = 1},
		["willard_male_male_sit04"] = {forwardOffset = 32, upOffset = 1},
		["willard_male_male_sit05"] = {forwardOffset = 32, upOffset = 1},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 32, upOffset = 1},
		["willard_female_sit02"] = {forwardOffset = 32, upOffset = 1},
		["willard_female_sit03"] = {forwardOffset = 32, upOffset = 1},
		["willard_female_sit04"] = {forwardOffset = 32, upOffset = 1},
		["willard_female_sit05"] = {forwardOffset = 32, upOffset = 1},
		["willard_female_sit06"] = {forwardOffset = 32, upOffset = 1},
		["willard_female_sit07"] = {forwardOffset = 32, upOffset = 1},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 32, upOffset = 1},
		["n7_male_sit02"] = {forwardOffset = 32, upOffset = 1},
		["n7_male_sit03"] = {forwardOffset = 32, upOffset = 1},
		["n7_male_sit04"] = {forwardOffset = 32, upOffset = 1},
		["n7_male_sit05"] = {forwardOffset = 32, upOffset = 1},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 32, upOffset = 1},
		["n7_female_sit02"] = {forwardOffset = 32, upOffset = 1},
		["n7_female_sit03"] = {forwardOffset = 32, upOffset = 1},
		["n7_female_sit04"] = {forwardOffset = 32, upOffset = 1},
		["n7_female_sit05"] = {forwardOffset = 32, upOffset = 1},
		["n7_female_sit06"] = {forwardOffset = 32, upOffset = 1},
		["n7_female_sit07"] = {forwardOffset = 32, upOffset = 1},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_interiors/furniture_chair03a.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 26, upOffset = -18},
		["willard_male_male_sit02"] = {forwardOffset = 26, upOffset = -18},
		["willard_male_male_sit03"] = {forwardOffset = 26, upOffset = -18},
		["willard_male_male_sit04"] = {forwardOffset = 26, upOffset = -18},
		["willard_male_male_sit05"] = {forwardOffset = 26, upOffset = -18},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 26, upOffset = -18},
		["willard_female_sit02"] = {forwardOffset = 26, upOffset = -18},
		["willard_female_sit03"] = {forwardOffset = 26, upOffset = -18},
		["willard_female_sit04"] = {forwardOffset = 26, upOffset = -18},
		["willard_female_sit05"] = {forwardOffset = 26, upOffset = -18},
		["willard_female_sit06"] = {forwardOffset = 26, upOffset = -18},
		["willard_female_sit07"] = {forwardOffset = 26, upOffset = -18},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 26, upOffset = -18},
		["n7_male_sit02"] = {forwardOffset = 26, upOffset = -18},
		["n7_male_sit03"] = {forwardOffset = 26, upOffset = -18},
		["n7_male_sit04"] = {forwardOffset = 26, upOffset = -18},
		["n7_male_sit05"] = {forwardOffset = 26, upOffset = -18},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 26, upOffset = -18},
		["n7_female_sit02"] = {forwardOffset = 26, upOffset = -18},
		["n7_female_sit03"] = {forwardOffset = 26, upOffset = -18},
		["n7_female_sit04"] = {forwardOffset = 26, upOffset = -18},
		["n7_female_sit05"] = {forwardOffset = 26, upOffset = -18},
		["n7_female_sit06"] = {forwardOffset = 26, upOffset = -18},
		["n7_female_sit07"] = {forwardOffset = 26, upOffset = -18},
	}
}

-- de_nuke
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props/de_nuke/hr_nuke/nuke_office_chair/nuke_office_chair.mdl"] = { -- non-existent
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 26, upOffset = 4},
		["willard_male_male_sit02"] = {forwardOffset = 26, upOffset = 4},
		["willard_male_male_sit03"] = {forwardOffset = 26, upOffset = 4},
		["willard_male_male_sit04"] = {forwardOffset = 26, upOffset = 4},
		["willard_male_male_sit05"] = {forwardOffset = 26, upOffset = 4},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 26, upOffset = 4},
		["willard_female_sit02"] = {forwardOffset = 26, upOffset = 4},
		["willard_female_sit03"] = {forwardOffset = 26, upOffset = 4},
		["willard_female_sit04"] = {forwardOffset = 26, upOffset = 4},
		["willard_female_sit05"] = {forwardOffset = 26, upOffset = 4},
		["willard_female_sit06"] = {forwardOffset = 26, upOffset = 4},
		["willard_female_sit07"] = {forwardOffset = 26, upOffset = 4},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 26, upOffset = 4},
		["n7_male_sit02"] = {forwardOffset = 26, upOffset = 4},
		["n7_male_sit03"] = {forwardOffset = 26, upOffset = 4},
		["n7_male_sit04"] = {forwardOffset = 26, upOffset = 4},
		["n7_male_sit05"] = {forwardOffset = 26, upOffset = 4},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 26, upOffset = 4},
		["n7_female_sit02"] = {forwardOffset = 26, upOffset = 4},
		["n7_female_sit03"] = {forwardOffset = 26, upOffset = 4},
		["n7_female_sit04"] = {forwardOffset = 26, upOffset = 4},
		["n7_female_sit05"] = {forwardOffset = 26, upOffset = 4},
		["n7_female_sit06"] = {forwardOffset = 26, upOffset = 4},
		["n7_female_sit07"] = {forwardOffset = 26, upOffset = 4},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props/de_nuke/hr_nuke/nuke_chair/nuke_chair.mdl"] = { -- non_existent
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 24, upOffset = 1},
		["willard_male_male_sit02"] = {forwardOffset = 24, upOffset = 1},
		["willard_male_male_sit03"] = {forwardOffset = 24, upOffset = 1},
		["willard_male_male_sit04"] = {forwardOffset = 24, upOffset = 1},
		["willard_male_male_sit05"] = {forwardOffset = 24, upOffset = 1},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 24, upOffset = 1},
		["willard_female_sit02"] = {forwardOffset = 24, upOffset = 1},
		["willard_female_sit03"] = {forwardOffset = 24, upOffset = 1},
		["willard_female_sit04"] = {forwardOffset = 24, upOffset = 1},
		["willard_female_sit05"] = {forwardOffset = 24, upOffset = 1},
		["willard_female_sit06"] = {forwardOffset = 24, upOffset = 1},
		["willard_female_sit07"] = {forwardOffset = 24, upOffset = 1},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 24, upOffset = 1},
		["n7_male_sit02"] = {forwardOffset = 24, upOffset = 1},
		["n7_male_sit03"] = {forwardOffset = 24, upOffset = 1},
		["n7_male_sit04"] = {forwardOffset = 24, upOffset = 1},
		["n7_male_sit05"] = {forwardOffset = 24, upOffset = 1},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 24, upOffset = 1},
		["n7_female_sit02"] = {forwardOffset = 24, upOffset = 1},
		["n7_female_sit03"] = {forwardOffset = 24, upOffset = 1},
		["n7_female_sit04"] = {forwardOffset = 24, upOffset = 1},
		["n7_female_sit05"] = {forwardOffset = 24, upOffset = 1},
		["n7_female_sit06"] = {forwardOffset = 24, upOffset = 1},
		["n7_female_sit07"] = {forwardOffset = 24, upOffset = 1},
	}
}

-- props_urban
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_urban/hotel_chair001.mdl"] = { -- non-existent
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 32, upOffset = 5},
		["willard_male_male_sit02"] = {forwardOffset = 32, upOffset = 5},
		["willard_male_male_sit03"] = {forwardOffset = 32, upOffset = 5},
		["willard_male_male_sit04"] = {forwardOffset = 32, upOffset = 5},
		["willard_male_male_sit05"] = {forwardOffset = 32, upOffset = 5},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 32, upOffset = 5},
		["willard_female_sit02"] = {forwardOffset = 32, upOffset = 5},
		["willard_female_sit03"] = {forwardOffset = 32, upOffset = 5},
		["willard_female_sit04"] = {forwardOffset = 32, upOffset = 5},
		["willard_female_sit05"] = {forwardOffset = 32, upOffset = 5},
		["willard_female_sit06"] = {forwardOffset = 32, upOffset = 5},
		["willard_female_sit07"] = {forwardOffset = 32, upOffset = 5},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 32, upOffset = 5},
		["n7_male_sit02"] = {forwardOffset = 32, upOffset = 5},
		["n7_male_sit03"] = {forwardOffset = 32, upOffset = 5},
		["n7_male_sit04"] = {forwardOffset = 32, upOffset = 5},
		["n7_male_sit05"] = {forwardOffset = 32, upOffset = 5},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 32, upOffset = 5},
		["n7_female_sit02"] = {forwardOffset = 32, upOffset = 5},
		["n7_female_sit03"] = {forwardOffset = 32, upOffset = 5},
		["n7_female_sit04"] = {forwardOffset = 32, upOffset = 5},
		["n7_female_sit05"] = {forwardOffset = 32, upOffset = 5},
		["n7_female_sit06"] = {forwardOffset = 32, upOffset = 5},
		["n7_female_sit07"] = {forwardOffset = 32, upOffset = 5},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_urban/plastic_chair001.mdl"] = { -- non-existent
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 25, upOffset = 5},
		["willard_male_male_sit02"] = {forwardOffset = 25, upOffset = 5},
		["willard_male_male_sit03"] = {forwardOffset = 25, upOffset = 5},
		["willard_male_male_sit04"] = {forwardOffset = 25, upOffset = 5},
		["willard_male_male_sit05"] = {forwardOffset = 25, upOffset = 5},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 25, upOffset = 5},
		["willard_female_sit02"] = {forwardOffset = 25, upOffset = 5},
		["willard_female_sit03"] = {forwardOffset = 25, upOffset = 5},
		["willard_female_sit04"] = {forwardOffset = 25, upOffset = 5},
		["willard_female_sit05"] = {forwardOffset = 25, upOffset = 5},
		["willard_female_sit06"] = {forwardOffset = 25, upOffset = 5},
		["willard_female_sit07"] = {forwardOffset = 25, upOffset = 5},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 25, upOffset = 5},
		["n7_male_sit02"] = {forwardOffset = 25, upOffset = 5},
		["n7_male_sit03"] = {forwardOffset = 25, upOffset = 5},
		["n7_male_sit04"] = {forwardOffset = 25, upOffset = 5},
		["n7_male_sit05"] = {forwardOffset = 25, upOffset = 5},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 25, upOffset = 5},
		["n7_female_sit02"] = {forwardOffset = 25, upOffset = 5},
		["n7_female_sit03"] = {forwardOffset = 25, upOffset = 5},
		["n7_female_sit04"] = {forwardOffset = 25, upOffset = 5},
		["n7_female_sit05"] = {forwardOffset = 25, upOffset = 5},
		["n7_female_sit06"] = {forwardOffset = 25, upOffset = 5},
		["n7_female_sit07"] = {forwardOffset = 25, upOffset = 5},
	}
}

-- cs_office
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props/cs_office/chair_office.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 28},
		["willard_male_male_sit02"] = {forwardOffset = 28},
		["willard_male_male_sit03"] = {forwardOffset = 28},
		["willard_male_male_sit04"] = {forwardOffset = 28},
		["willard_male_male_sit05"] = {forwardOffset = 28},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 28},
		["willard_female_sit02"] = {forwardOffset = 28},
		["willard_female_sit03"] = {forwardOffset = 28},
		["willard_female_sit04"] = {forwardOffset = 28},
		["willard_female_sit05"] = {forwardOffset = 28},
		["willard_female_sit06"] = {forwardOffset = 28},
		["willard_female_sit07"] = {forwardOffset = 28},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 28},
		["n7_male_sit02"] = {forwardOffset = 28},
		["n7_male_sit03"] = {forwardOffset = 28},
		["n7_male_sit04"] = {forwardOffset = 28},
		["n7_male_sit05"] = {forwardOffset = 28},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 28},
		["n7_female_sit02"] = {forwardOffset = 28},
		["n7_female_sit03"] = {forwardOffset = 28},
		["n7_female_sit04"] = {forwardOffset = 28},
		["n7_female_sit05"] = {forwardOffset = 28},
		["n7_female_sit06"] = {forwardOffset = 28},
		["n7_female_sit07"] = {forwardOffset = 28},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props/cs_office/sofa_chair.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 32, upOffset = 2},
		["willard_male_male_sit02"] = {forwardOffset = 32, upOffset = 2},
		["willard_male_male_sit03"] = {forwardOffset = 32, upOffset = 2},
		["willard_male_male_sit04"] = {forwardOffset = 32, upOffset = 2},
		["willard_male_male_sit05"] = {forwardOffset = 32, upOffset = 2},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 32, upOffset = 2},
		["willard_female_sit02"] = {forwardOffset = 32, upOffset = 2},
		["willard_female_sit03"] = {forwardOffset = 32, upOffset = 2},
		["willard_female_sit04"] = {forwardOffset = 32, upOffset = 2},
		["willard_female_sit05"] = {forwardOffset = 32, upOffset = 2},
		["willard_female_sit06"] = {forwardOffset = 32, upOffset = 2},
		["willard_female_sit07"] = {forwardOffset = 32, upOffset = 2},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 32, upOffset = 2},
		["n7_male_sit02"] = {forwardOffset = 32, upOffset = 2},
		["n7_male_sit03"] = {forwardOffset = 32, upOffset = 2},
		["n7_male_sit04"] = {forwardOffset = 32, upOffset = 2},
		["n7_male_sit05"] = {forwardOffset = 32, upOffset = 2},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 32, upOffset = 2},
		["n7_female_sit02"] = {forwardOffset = 32, upOffset = 2},
		["n7_female_sit03"] = {forwardOffset = 32, upOffset = 2},
		["n7_female_sit04"] = {forwardOffset = 32, upOffset = 2},
		["n7_female_sit05"] = {forwardOffset = 32, upOffset = 2},
		["n7_female_sit06"] = {forwardOffset = 32, upOffset = 2},
		["n7_female_sit07"] = {forwardOffset = 32, upOffset = 2},
	}
}

-- de_tides
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props/de_tides/patio_chair.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 25, upOffset = 2},
		["willard_male_male_sit02"] = {forwardOffset = 25, upOffset = 2},
		["willard_male_male_sit03"] = {forwardOffset = 25, upOffset = 2},
		["willard_male_male_sit04"] = {forwardOffset = 25, upOffset = 2},
		["willard_male_male_sit05"] = {forwardOffset = 25, upOffset = 2},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 25, upOffset = 2},
		["willard_female_sit02"] = {forwardOffset = 25, upOffset = 2},
		["willard_female_sit03"] = {forwardOffset = 25, upOffset = 2},
		["willard_female_sit04"] = {forwardOffset = 25, upOffset = 2},
		["willard_female_sit05"] = {forwardOffset = 25, upOffset = 2},
		["willard_female_sit06"] = {forwardOffset = 25, upOffset = 2},
		["willard_female_sit07"] = {forwardOffset = 25, upOffset = 2},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 25, upOffset = 2},
		["n7_male_sit02"] = {forwardOffset = 25, upOffset = 2},
		["n7_male_sit03"] = {forwardOffset = 25, upOffset = 2},
		["n7_male_sit04"] = {forwardOffset = 25, upOffset = 2},
		["n7_male_sit05"] = {forwardOffset = 25, upOffset = 2},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 25, upOffset = 2},
		["n7_female_sit02"] = {forwardOffset = 25, upOffset = 2},
		["n7_female_sit03"] = {forwardOffset = 25, upOffset = 2},
		["n7_female_sit04"] = {forwardOffset = 25, upOffset = 2},
		["n7_female_sit05"] = {forwardOffset = 25, upOffset = 2},
		["n7_female_sit06"] = {forwardOffset = 25, upOffset = 2},
		["n7_female_sit07"] = {forwardOffset = 25, upOffset = 2},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props/de_tides/patio_chair2.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["willard_male_male_sit02"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["willard_male_male_sit03"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["willard_male_male_sit04"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["willard_male_male_sit05"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		-- citizen_female
		["willard_female_sit01"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["willard_female_sit02"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["willard_female_sit03"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["willard_female_sit04"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["willard_female_sit05"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["willard_female_sit06"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["willard_female_sit07"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		-- metropolice
		["n7_male_sit01"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["n7_male_sit02"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["n7_male_sit03"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["n7_male_sit04"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["n7_male_sit05"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		-- metropolice_female
		["n7_female_sit01"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["n7_female_sit02"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["n7_female_sit03"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["n7_female_sit04"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["n7_female_sit05"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["n7_female_sit06"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
		["n7_female_sit07"] = {angleYawOffset = -90, rightOffset = 25, forwardOffset = -1, upOffset = 2},
	}
}

-- de_inferno
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props/de_inferno/hr_i/inferno_chair/inferno_chair.mdl"] = { -- non_existent
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 21, upOffset = 4},
		["willard_male_male_sit02"] = {forwardOffset = 21, upOffset = 4},
		["willard_male_male_sit03"] = {forwardOffset = 21, upOffset = 4},
		["willard_male_male_sit04"] = {forwardOffset = 21, upOffset = 4},
		["willard_male_male_sit05"] = {forwardOffset = 21, upOffset = 4},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 21, upOffset = 4},
		["willard_female_sit02"] = {forwardOffset = 21, upOffset = 4},
		["willard_female_sit03"] = {forwardOffset = 21, upOffset = 4},
		["willard_female_sit04"] = {forwardOffset = 21, upOffset = 4},
		["willard_female_sit05"] = {forwardOffset = 21, upOffset = 4},
		["willard_female_sit06"] = {forwardOffset = 21, upOffset = 4},
		["willard_female_sit07"] = {forwardOffset = 21, upOffset = 4},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 21, upOffset = 4},
		["n7_male_sit02"] = {forwardOffset = 21, upOffset = 4},
		["n7_male_sit03"] = {forwardOffset = 21, upOffset = 4},
		["n7_male_sit04"] = {forwardOffset = 21, upOffset = 4},
		["n7_male_sit05"] = {forwardOffset = 21, upOffset = 4},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 21, upOffset = 4},
		["n7_female_sit02"] = {forwardOffset = 21, upOffset = 4},
		["n7_female_sit03"] = {forwardOffset = 21, upOffset = 4},
		["n7_female_sit04"] = {forwardOffset = 21, upOffset = 4},
		["n7_female_sit05"] = {forwardOffset = 21, upOffset = 4},
		["n7_female_sit06"] = {forwardOffset = 21, upOffset = 4},
		["n7_female_sit07"] = {forwardOffset = 21, upOffset = 4},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props/de_inferno/chairantique.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 25, upOffset = -2},
		["willard_male_male_sit02"] = {forwardOffset = 25, upOffset = -2},
		["willard_male_male_sit03"] = {forwardOffset = 25, upOffset = -2},
		["willard_male_male_sit04"] = {forwardOffset = 25, upOffset = -2},
		["willard_male_male_sit05"] = {forwardOffset = 25, upOffset = -2},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 25, upOffset = -2},
		["willard_female_sit02"] = {forwardOffset = 25, upOffset = -2},
		["willard_female_sit03"] = {forwardOffset = 25, upOffset = -2},
		["willard_female_sit04"] = {forwardOffset = 25, upOffset = -2},
		["willard_female_sit05"] = {forwardOffset = 25, upOffset = -2},
		["willard_female_sit06"] = {forwardOffset = 25, upOffset = -2},
		["willard_female_sit07"] = {forwardOffset = 25, upOffset = -2},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 25, upOffset = -2},
		["n7_male_sit02"] = {forwardOffset = 25, upOffset = -2},
		["n7_male_sit03"] = {forwardOffset = 25, upOffset = -2},
		["n7_male_sit04"] = {forwardOffset = 25, upOffset = -2},
		["n7_male_sit05"] = {forwardOffset = 25, upOffset = -2},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 25, upOffset = -2},
		["n7_female_sit02"] = {forwardOffset = 25, upOffset = -2},
		["n7_female_sit03"] = {forwardOffset = 25, upOffset = -2},
		["n7_female_sit04"] = {forwardOffset = 25, upOffset = -2},
		["n7_female_sit05"] = {forwardOffset = 25, upOffset = -2},
		["n7_female_sit06"] = {forwardOffset = 25, upOffset = -2},
		["n7_female_sit07"] = {forwardOffset = 25, upOffset = -2},
	}
}
PLUGIN.restingEntities["models/props/de_inferno/chairantique_static.mdl"] = PLUGIN.restingEntities["models/props/de_inferno/chairantique.mdl"]
PLUGIN.restingEntities["models/props/de_inferno/bed.mdl"] = {
	class = "ix_chair",
	validActName = "Down",
	energyRestorationRate = 0.012,
	sequences = {
		-- citizen_male
		["willard_male_male_down01"] = {rightOffset = 5, forwardOffset = 5, upOffset = 16},
		["willard_male_male_down02"] = {rightOffset = 0, forwardOffset = -2, upOffset = 16},
		["willard_male_male_down03"] = {rightOffset = 0, forwardOffset = -2, upOffset = 16},
		-- citizen_female
		["willard_female_down01"] = {rightOffset = 2, forwardOffset = -2, upOffset = 16},
		["willard_female_down02"] = {rightOffset = 0, forwardOffset = -2, upOffset = 16},
		["willard_female_down03"] = {rightOffset = 0, forwardOffset = -2, upOffset = 16},
		-- metropolice
		["n7_male_down01"] = {rightOffset = 5, forwardOffset = 5, upOffset = 16},
		["n7_male_down02"] = {rightOffset = 0, forwardOffset = -2, upOffset = 16},
		["n7_male_down03"] = {rightOffset = 0, forwardOffset = -2, upOffset = 16},
		-- metropolice_female
		["n7_female_down01"] = {rightOffset = 2, forwardOffset = -2, upOffset = 16},
		["n7_female_down02"] = {rightOffset = 0, forwardOffset = -2, upOffset = 16},
		["n7_female_down03"] = {rightOffset = 0, forwardOffset = -2, upOffset = 16},
	}
}

-- no group
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_wasteland/controlroom_chair001a.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 26, upOffset = -19},
		["willard_male_male_sit02"] = {forwardOffset = 26, upOffset = -19},
		["willard_male_male_sit03"] = {forwardOffset = 26, upOffset = -19},
		["willard_male_male_sit04"] = {forwardOffset = 26, upOffset = -19},
		["willard_male_male_sit05"] = {forwardOffset = 26, upOffset = -19},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 26, upOffset = -19},
		["willard_female_sit02"] = {forwardOffset = 26, upOffset = -19},
		["willard_female_sit03"] = {forwardOffset = 26, upOffset = -19},
		["willard_female_sit04"] = {forwardOffset = 26, upOffset = -19},
		["willard_female_sit05"] = {forwardOffset = 26, upOffset = -19},
		["willard_female_sit06"] = {forwardOffset = 26, upOffset = -19},
		["willard_female_sit07"] = {forwardOffset = 26, upOffset = -19},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 26, upOffset = -19},
		["n7_male_sit02"] = {forwardOffset = 26, upOffset = -19},
		["n7_male_sit03"] = {forwardOffset = 26, upOffset = -19},
		["n7_male_sit04"] = {forwardOffset = 26, upOffset = -19},
		["n7_male_sit05"] = {forwardOffset = 26, upOffset = -19},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 26, upOffset = -19},
		["n7_female_sit02"] = {forwardOffset = 26, upOffset = -19},
		["n7_female_sit03"] = {forwardOffset = 26, upOffset = -19},
		["n7_female_sit04"] = {forwardOffset = 26, upOffset = -19},
		["n7_female_sit05"] = {forwardOffset = 26, upOffset = -19},
		["n7_female_sit06"] = {forwardOffset = 26, upOffset = -19},
		["n7_female_sit07"] = {forwardOffset = 26, upOffset = -19},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_combine/breenchair.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 28},
		["willard_male_male_sit02"] = {forwardOffset = 28},
		["willard_male_male_sit03"] = {forwardOffset = 28},
		["willard_male_male_sit04"] = {forwardOffset = 28},
		["willard_male_male_sit05"] = {forwardOffset = 28},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 28},
		["willard_female_sit02"] = {forwardOffset = 28},
		["willard_female_sit03"] = {forwardOffset = 28},
		["willard_female_sit04"] = {forwardOffset = 28},
		["willard_female_sit05"] = {forwardOffset = 28},
		["willard_female_sit06"] = {forwardOffset = 28},
		["willard_female_sit07"] = {forwardOffset = 28},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 28},
		["n7_male_sit02"] = {forwardOffset = 28},
		["n7_male_sit03"] = {forwardOffset = 28},
		["n7_male_sit04"] = {forwardOffset = 28},
		["n7_male_sit05"] = {forwardOffset = 28},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 28},
		["n7_female_sit02"] = {forwardOffset = 28},
		["n7_female_sit03"] = {forwardOffset = 28},
		["n7_female_sit04"] = {forwardOffset = 28},
		["n7_female_sit05"] = {forwardOffset = 28},
		["n7_female_sit06"] = {forwardOffset = 28},
		["n7_female_sit07"] = {forwardOffset = 28},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props/cs_militia/barstool01.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 23, upOffset = 17},
		["willard_male_male_sit02"] = {forwardOffset = 23, upOffset = 17},
		["willard_male_male_sit03"] = {forwardOffset = 23, upOffset = 17},
		["willard_male_male_sit04"] = {forwardOffset = 23, upOffset = 17},
		["willard_male_male_sit05"] = {forwardOffset = 23, upOffset = 17},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 23, upOffset = 17},
		["willard_female_sit02"] = {forwardOffset = 23, upOffset = 17},
		["willard_female_sit03"] = {forwardOffset = 23, upOffset = 17},
		["willard_female_sit04"] = {forwardOffset = 23, upOffset = 17},
		["willard_female_sit05"] = {forwardOffset = 23, upOffset = 17},
		["willard_female_sit06"] = {forwardOffset = 23, upOffset = 17},
		["willard_female_sit07"] = {forwardOffset = 23, upOffset = 17},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 23, upOffset = 17},
		["n7_male_sit02"] = {forwardOffset = 23, upOffset = 17},
		["n7_male_sit03"] = {forwardOffset = 23, upOffset = 17},
		["n7_male_sit04"] = {forwardOffset = 23, upOffset = 17},
		["n7_male_sit05"] = {forwardOffset = 23, upOffset = 17},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 23, upOffset = 17},
		["n7_female_sit02"] = {forwardOffset = 23, upOffset = 17},
		["n7_female_sit03"] = {forwardOffset = 23, upOffset = 17},
		["n7_female_sit04"] = {forwardOffset = 23, upOffset = 17},
		["n7_female_sit05"] = {forwardOffset = 23, upOffset = 17},
		["n7_female_sit06"] = {forwardOffset = 23, upOffset = 17},
		["n7_female_sit07"] = {forwardOffset = 23, upOffset = 17},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props/de_dust/hr_dust/dust_patio_set/dust_patio_chair.mdl"] = { -- non-existent
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["willard_male_male_sit02"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["willard_male_male_sit03"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["willard_male_male_sit04"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["willard_male_male_sit05"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		-- citizen_female
		["willard_female_sit01"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["willard_female_sit02"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["willard_female_sit03"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["willard_female_sit04"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["willard_female_sit05"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["willard_female_sit06"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["willard_female_sit07"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		-- metropolice
		["n7_male_sit01"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["n7_male_sit02"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["n7_male_sit03"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["n7_male_sit04"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["n7_male_sit05"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		-- metropolice_female
		["n7_female_sit01"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["n7_female_sit02"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["n7_female_sit03"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["n7_female_sit04"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["n7_female_sit05"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["n7_female_sit06"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
		["n7_female_sit07"] = {angleYawOffset = 90, rightOffset = -25, upOffset = 5},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props/coop_cementplant/furniture/coop_folding_chair.mdl"] = { -- non-existent
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["willard_male_male_sit02"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["willard_male_male_sit03"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["willard_male_male_sit04"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["willard_male_male_sit05"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		-- citizen_female
		["willard_female_sit01"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["willard_female_sit02"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["willard_female_sit03"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["willard_female_sit04"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["willard_female_sit05"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["willard_female_sit06"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["willard_female_sit07"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		-- metropolice
		["n7_male_sit01"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["n7_male_sit02"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["n7_male_sit03"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["n7_male_sit04"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["n7_male_sit05"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		-- metropolice_female
		["n7_female_sit01"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["n7_female_sit02"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["n7_female_sit03"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["n7_female_sit04"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["n7_female_sit05"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["n7_female_sit06"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
		["n7_female_sit07"] = {angleYawOffset = 180, forwardOffset = -26, upOffset = 4},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props/gg_tibet/modernchair.mdl"] = { -- non-existent
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 25, upOffset = 8},
		["willard_male_male_sit02"] = {forwardOffset = 25, upOffset = 8},
		["willard_male_male_sit03"] = {forwardOffset = 25, upOffset = 8},
		["willard_male_male_sit04"] = {forwardOffset = 25, upOffset = 8},
		["willard_male_male_sit05"] = {forwardOffset = 25, upOffset = 8},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 25, upOffset = 8},
		["willard_female_sit02"] = {forwardOffset = 25, upOffset = 8},
		["willard_female_sit03"] = {forwardOffset = 25, upOffset = 8},
		["willard_female_sit04"] = {forwardOffset = 25, upOffset = 8},
		["willard_female_sit05"] = {forwardOffset = 25, upOffset = 8},
		["willard_female_sit06"] = {forwardOffset = 25, upOffset = 8},
		["willard_female_sit07"] = {forwardOffset = 25, upOffset = 8},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 25, upOffset = 8},
		["n7_male_sit02"] = {forwardOffset = 25, upOffset = 8},
		["n7_male_sit03"] = {forwardOffset = 25, upOffset = 8},
		["n7_male_sit04"] = {forwardOffset = 25, upOffset = 8},
		["n7_male_sit05"] = {forwardOffset = 25, upOffset = 8},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 25, upOffset = 8},
		["n7_female_sit02"] = {forwardOffset = 25, upOffset = 8},
		["n7_female_sit03"] = {forwardOffset = 25, upOffset = 8},
		["n7_female_sit04"] = {forwardOffset = 25, upOffset = 8},
		["n7_female_sit05"] = {forwardOffset = 25, upOffset = 8},
		["n7_female_sit06"] = {forwardOffset = 25, upOffset = 8},
		["n7_female_sit07"] = {forwardOffset = 25, upOffset = 8},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/vj_hlr/decay/wheelchair.mdl"] = {
	class = "ix_chair",
	validActName = "Sit",
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {forwardOffset = 25, upOffset = 7},
		["willard_male_male_sit02"] = {forwardOffset = 25, upOffset = 7},
		["willard_male_male_sit03"] = {forwardOffset = 25, upOffset = 7},
		["willard_male_male_sit04"] = {forwardOffset = 25, upOffset = 7},
		["willard_male_male_sit05"] = {forwardOffset = 25, upOffset = 7},
		-- citizen_female
		["willard_female_sit01"] = {forwardOffset = 25, upOffset = 7},
		["willard_female_sit02"] = {forwardOffset = 25, upOffset = 7},
		["willard_female_sit03"] = {forwardOffset = 25, upOffset = 7},
		["willard_female_sit04"] = {forwardOffset = 25, upOffset = 7},
		["willard_female_sit05"] = {forwardOffset = 25, upOffset = 7},
		["willard_female_sit06"] = {forwardOffset = 25, upOffset = 7},
		["willard_female_sit07"] = {forwardOffset = 25, upOffset = 7},
		-- metropolice
		["n7_male_sit01"] = {forwardOffset = 25, upOffset = 7},
		["n7_male_sit02"] = {forwardOffset = 25, upOffset = 7},
		["n7_male_sit03"] = {forwardOffset = 25, upOffset = 7},
		["n7_male_sit04"] = {forwardOffset = 25, upOffset = 7},
		["n7_male_sit05"] = {forwardOffset = 25, upOffset = 7},
		-- metropolice_female
		["n7_female_sit01"] = {forwardOffset = 25, upOffset = 7},
		["n7_female_sit02"] = {forwardOffset = 25, upOffset = 7},
		["n7_female_sit03"] = {forwardOffset = 25, upOffset = 7},
		["n7_female_sit04"] = {forwardOffset = 25, upOffset = 7},
		["n7_female_sit05"] = {forwardOffset = 25, upOffset = 7},
		["n7_female_sit06"] = {forwardOffset = 25, upOffset = 7},
		["n7_female_sit07"] = {forwardOffset = 25, upOffset = 7},
	}
}

--[[ COUCHES ]]--
-- props_c17
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_c17/furniturecouch001a.mdl"] = {
	class = "ix_couch",
	secondOffsets = {rightOffset = -0.8},
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["willard_male_male_sit02"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["willard_male_male_sit03"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["willard_male_male_sit04"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["willard_male_male_sit05"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		-- citizen_female
		["willard_female_sit01"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["willard_female_sit02"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["willard_female_sit03"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["willard_female_sit04"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["willard_female_sit05"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["willard_female_sit06"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["willard_female_sit07"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		-- metropolice
		["n7_male_sit01"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["n7_male_sit02"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["n7_male_sit03"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["n7_male_sit04"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["n7_male_sit05"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		-- metropolice_female
		["n7_female_sit01"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["n7_female_sit02"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["n7_female_sit03"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["n7_female_sit04"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["n7_female_sit05"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
		["n7_female_sit06"] = {rightOffset = 15, forwardOffset = 30, upOffset = -17},
	}
}
PLUGIN.restingEntities["models/props/de_inferno/furniturecouch001a.mdl"] = PLUGIN.restingEntities["models/props_c17/furniturecouch001a.mdl"]
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_c17/furniturecouch002a.mdl"] = {
	class = "ix_couch",
	secondOffsets = {rightOffset = -0.9},
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		["willard_male_male_sit02"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		["willard_male_male_sit04"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		["willard_male_male_sit05"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		-- citizen_female
		["willard_female_sit01"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		["willard_female_sit02"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		["willard_female_sit03"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		["willard_female_sit04"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		["willard_female_sit05"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		["willard_female_sit06"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		["willard_female_sit07"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		-- metropolice
		["n7_male_sit01"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		["n7_male_sit02"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		["n7_male_sit04"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		["n7_male_sit05"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		-- metropolice_female
		["n7_female_sit01"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		["n7_female_sit02"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		["n7_female_sit03"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		["n7_female_sit04"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		["n7_female_sit05"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
		["n7_female_sit06"] = {rightOffset = 10, forwardOffset = 30, upOffset = -21},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_interiors/furniture_couch01a.mdl"] = {
	class = "ix_couch",
	secondOffsets = {rightOffset = -1},
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["willard_male_male_sit02"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["willard_male_male_sit03"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["willard_male_male_sit04"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["willard_male_male_sit05"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["willard_male_male_down03"] = {angleYawOffset = 90, rightOffset = -0.5, forwardOffset = 11, upOffset = -6},
		-- citizen_female
		["willard_female_sit01"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["willard_female_sit02"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["willard_female_sit03"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["willard_female_sit04"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["willard_female_sit05"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["willard_female_sit06"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["willard_female_sit07"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["willard_female_down03"] = {angleYawOffset = 90, rightOffset = -0.5, forwardOffset = 11, upOffset = -6},
		-- metropolice
		["n7_male_sit01"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["n7_male_sit02"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["n7_male_sit03"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["n7_male_sit04"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["n7_male_sit05"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["n7_male_down03"] = {angleYawOffset = 90, rightOffset = -0.5, forwardOffset = 11, upOffset = -6},
		-- metropolice_female
		["n7_female_sit01"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["n7_female_sit02"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["n7_female_sit03"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["n7_female_sit04"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["n7_female_sit05"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["n7_female_sit06"] = {rightOffset = 16, forwardOffset = 30, upOffset = -21},
		["n7_female_down03"] = {angleYawOffset = 90, rightOffset = -0.5, forwardOffset = 11, upOffset = -6},
	}
}
PLUGIN.restingEntities["models/props/de_inferno/furniture_couch01a.mdl"] = PLUGIN.restingEntities["models/props_interiors/furniture_couch01a.mdl"]

-- no group
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props/cs_militia/couch.mdl"] = {
	class = "ix_couch",
	secondOffsets = {forwardOffset = -1},
	energyRestorationRate = 0.008,
	sequences = {
		-- citizen_male
		["willard_male_male_sit01"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["willard_male_male_sit02"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["willard_male_male_sit03"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["willard_male_male_sit04"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["willard_male_male_sit05"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["willard_male_male_down01"] = {rightOffset = 2, forwardOffset = 0, upOffset = 20},
		["willard_male_male_down02"] = {rightOffset = -6, forwardOffset = -6, upOffset = 19},
		["willard_male_male_down03"] = {rightOffset = -6, forwardOffset = -6, upOffset = 19},
		-- citizen_female
		["willard_female_sit01"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["willard_female_sit02"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["willard_female_sit03"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["willard_female_sit04"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["willard_female_sit05"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["willard_female_sit06"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["willard_female_sit07"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["willard_female_down01"] = {rightOffset = 2, forwardOffset = 0, upOffset = 20},
		["willard_female_down02"] = {rightOffset = -6, forwardOffset = -6, upOffset = 19},
		["willard_female_down03"] = {rightOffset = -6, forwardOffset = -6, upOffset = 19},
		-- metropolice
		["n7_male_sit01"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["n7_male_sit02"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["n7_male_sit03"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["n7_male_sit04"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["n7_male_sit05"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["n7_male_down01"] = {rightOffset = 2, forwardOffset = 0, upOffset = 20},
		["n7_male_down02"] = {rightOffset = -6, forwardOffset = -6, upOffset = 19},
		["n7_male_down03"] = {rightOffset = -6, forwardOffset = -6, upOffset = 19},
		-- metropolice_female
		["n7_female_sit01"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["n7_female_sit02"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["n7_female_sit03"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["n7_female_sit04"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["n7_female_sit05"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["n7_female_sit06"] = {angleYawOffset = 90, rightOffset = -30, forwardOffset = 16, upOffset = 0},
		["n7_female_down01"] = {rightOffset = 2, forwardOffset = 0, upOffset = 20},
		["n7_female_down02"] = {rightOffset = -6, forwardOffset = -6, upOffset = 19},
		["n7_female_down03"] = {rightOffset = -6, forwardOffset = -6, upOffset = 19},
	}
}

--[[ BEDS ]]--
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_interiors/bed_houseboat.mdl"] = {
	class = "ix_bed",
	secondOffsets = {forwardOffset = -1},
	maxEnergyBonus = 20,
	energyRestorationRate = 0.018,
	sequences = {
		-- citizen_male
		["willard_male_male_down01"] = {angleYawOffset = -90, rightOffset = 6, forwardOffset = 12, upOffset = 12},
		["willard_male_male_down02"] = {angleYawOffset = -90, rightOffset = 2, forwardOffset = 16, upOffset = 12},
		["willard_male_male_down03"] = {angleYawOffset = -90, rightOffset = 2, forwardOffset = 16, upOffset = 12},
		-- citizen_female
		["willard_female_down01"] = {angleYawOffset = -90, rightOffset = 3, forwardOffset = 13, upOffset = 12},
		["willard_female_down02"] = {angleYawOffset = -90, rightOffset = 2, forwardOffset = 18, upOffset = 12},
		["willard_female_down03"] = {angleYawOffset = -90, rightOffset = 1, forwardOffset = 18, upOffset = 12},
		-- metropolice
		["n7_male_down01"] = {angleYawOffset = -90, rightOffset = 9, forwardOffset = 13, upOffset = 12},
		["n7_male_down02"] = {angleYawOffset = -90, rightOffset = 2, forwardOffset = 16, upOffset = 12},
		["n7_male_down03"] = {angleYawOffset = -90, rightOffset = 2, forwardOffset = 16, upOffset = 12},
		-- metropolice_female
		["n7_female_down01"] = {angleYawOffset = -90, rightOffset = 3, forwardOffset = 13, upOffset = 12},
		["n7_female_down02"] = {angleYawOffset = -90, rightOffset = 2, forwardOffset = 18, upOffset = 12},
		["n7_female_down03"] = {angleYawOffset = -90, rightOffset = 1, forwardOffset = 18, upOffset = 12},
	}
}
-- TODO: find custom offset for every and each sequence
PLUGIN.restingEntities["models/props_forest/bunkbed2.mdl"] = {
	class = "ix_bed",
	secondOffsets = {upOffset = 2.8},
	maxEnergyBonus = 10,
	energyRestorationRate = 0.018,
	sequences = {
		-- citizen_male
		["willard_male_male_down01"] = {angleYawOffset = 90, rightOffset = -4, forwardOffset = 4, upOffset = 24},
		["willard_male_male_down02"] = {angleYawOffset = 90, rightOffset = -4, forwardOffset = -0.5, upOffset = 24},
		["willard_male_male_down03"] = {angleYawOffset = 90, rightOffset = -4, forwardOffset = -0.5, upOffset = 24},
		-- citizen_female
		["willard_female_down01"] = {angleYawOffset = 90, rightOffset = -4, forwardOffset = 4, upOffset = 25},
		["willard_female_down02"] = {angleYawOffset = 90, rightOffset = -8, forwardOffset = -0.5, upOffset = 24},
		["willard_female_down03"] = {angleYawOffset = 90, rightOffset = -2, forwardOffset = -0.5, upOffset = 24},
		-- metropolice
		["n7_male_down01"] = {angleYawOffset = 90, rightOffset = -4, forwardOffset = 4, upOffset = 24},
		["n7_male_down02"] = {angleYawOffset = 90, rightOffset = -4, forwardOffset = -0.5, upOffset = 24},
		["n7_male_down03"] = {angleYawOffset = 90, rightOffset = -4, forwardOffset = -0.5, upOffset = 24},
		-- metropolice_female
		["n7_female_down01"] = {angleYawOffset = 90, rightOffset = -4, forwardOffset = 4, upOffset = 26},
		["n7_female_down02"] = {angleYawOffset = 90, rightOffset = -8, forwardOffset = -0.5, upOffset = 24},
		["n7_female_down03"] = {angleYawOffset = 90, rightOffset = -2, forwardOffset = -0.5, upOffset = 24},
	}
}
PLUGIN.restingEntities["models/props/cs_militia/bunkbed2.mdl"] = PLUGIN.restingEntities["models/props_forest/bunkbed2.mdl"]

-- hack in order to move all resting entities here, and at the same time save retain the same way of spawning them
local usableentitiesPlugin = ix.plugin.list["usableentities"]

for k, v in pairs(PLUGIN.restingEntities) do
	usableentitiesPlugin.usableEntityLookup[k] = {class = v.class}
end
