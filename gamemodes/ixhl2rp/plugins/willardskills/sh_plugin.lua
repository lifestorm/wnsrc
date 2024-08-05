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

PLUGIN.name = "Willard Skills"
PLUGIN.author = "M!NT, Gr4Ss, Johnny"
PLUGIN.description = "The Skills of Willard Industries."

ix.util.IncludeDir("ixhl2rp/plugins/willardskills/recipes", true)
ix.util.Include("meta/sh_character.lua")
ix.util.Include("cl_hooks.lua")
ix.util.Include("sh_recipe.lua")
ix.util.Include("cl_recipe.lua")
ix.util.Include("sv_recipe.lua")
ix.util.Include("sh_registration.lua")
ix.util.Include("sh_actions.lua") -- load this after registration
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")

ix.config.Add("DeathSkillsReducing", 0, "How much skill experience (in percents) character will lose after death (0 for keep skills unchanged).", nil, {
	data = {min = 0, max = 100, decimals = 0},
	category = "Skills"
})

ix.config.Add("MaxTotalSkill", 120, "The maximum total combined skill level a person can have.", nil, {
	data = {min = 50, max = 300, decimals = 0},
	category = "Skills"
})

ix.lang.AddTable("english", {
	ffLostInitiative = "You have lost initiative! You will play one turn later.",
	ffGainedInitiative = "You have gained initiative! You will play one turn earlier.",
	levelGained = "You have gained a level in your %s skill to level %d.",
	levelPossible = "You can level up in your %s skill to level %d.",
	cmdCharSkillSet = "Set the specified character's level in the given skill.",
	cmdCharSkillAdd = "Add the given amount of levels to a character's skill.",
	cmdCharSkillReset = "Reset a character's skill back to 0.",
	cmdCharSkillResetAll = "Reset all skills of a character back to 0.",
	cmdRefundSkills = "Returns all skill levels player lost after their last death.",
	assembleCant = "You need to wait before you can assemble this!",
	assembleMissingRequirement = "You need a %s to assemble this item!",
	assembleSuccess = "You have assembled a %s.",
	assembleNoSpace = "You need a %sx%s inventory space to assemble this item!"
})

ix.lang.AddTable("spanish", {
	ffLostInitiative = "¡Pierdes iniciativa! Jugarás un turno más tarde.",
	ffGainedInitiative = "¡Has ganado iniciativa! Jugarás un turno antes.",
	cmdCharSkillSet = "Determina el nivel de una habilidad en el personaje especificado.",
	cmdCharSkillAdd = "Añade la cantidad de niveles introducida a la habilidad de un personaje.",
	levelGained = "Has obtenido un nivel en tu habilidad de %s para subir de nivel %d.",
	levelPossible = "Puedes subir de nivel en tu habilidad de %s para subir de nivel %d.",
	cmdRefundSkills = "Devuelve todos los puntos de habilidad que el jugador perdió después de su última muerte.",
	cmdCharSkillResetAll = "Resetea todas las habilidades de un personaje de vuelta a 0.",
	cmdCharSkillReset = "Resetea la habilidad de un personaje de vuelta a 0."
})

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Skills",
	MinAccess = "superadmin"
})

ix.char.RegisterVar("refundSkills", {
	field = "refundSkills",
	default = {},
	bNoNetworking = true,
	bNoDisplay = true
})

ix.char.RegisterVar("refundBoosts", {
	field = "refundBoosts",
	default = {},
	bNoNetworking = true,
	bNoDisplay = true
})

ix.command.Add("CharSkillSet", {
	description = "@cmdCharSkillSet",
	privilege = "Manage Skills",
	arguments = {
		ix.type.character,
		ix.type.string,
		ix.type.number
	},
	alias = "CharLevelSet",
	argumentNames = {"character", "skill", "level"},
	OnRun = function(self, client, character, skillID, level) -- sets up variables with arguements
		local skill = ix.skill:Find(skillID)
		if (!skill) then
			client:Notify("Couldn't find the skill "..skillID.."!")
			return
		else
			character:SetSkill(skill.uniqueID, math.Clamp(level, 0, ix.skill.MAX_SKILL))
			local newLevel = character:GetSkill(skill.uniqueID)
			local charName = character:GetPlayer():Name()
			if (newLevel == -1) then
				client:Notify("You've removed "..charName.." his "..skill.name)
			else
				client:Notify("You've set "..charName.." to level "..newLevel.." in "..skill.name)
			end
		end
	end,
})

ix.command.Add("CharSkillAdd", {
	description = "@cmdCharSkillAdd",
	privilege = "Manage Skills",
	arguments = {
		ix.type.character,
		ix.type.string,
		ix.type.number
	},
	alias = "CharLevelAdd",
	argumentNames = {"character", "skill", "level"},
	OnRun = function(self, client, character, skillID, level) -- sets up variables with arguements
		local skill = ix.skill:Find(skillID)
		if (!skill) then
			client:Notify("Couldn't find the skill "..skillID.."!")
			return
		else
			character:AddSkillLevel(skill.uniqueID, level)

			local newLevel = character:GetSkill(skill.uniqueID)
			local charName = character:GetPlayer():Name()
			if (newLevel == -1) then
				client:Notify("You've removed "..charName.." his "..skill.name)
			else
				client:Notify("You've set "..charName.." to level "..newLevel.." in "..skill.name)
			end
		end
	end,
})


ix.command.Add("CharGetSkills", {
	description = "Returns a character's skill levels",
	privilege = "Manage Skills",
	arguments = {
		ix.type.character,
	},
	alias = "CharGetLevel",
	OnRun = function(self, client, character) -- sets up variables with arguements
		local charName = character:GetPlayer():Name()
		local skills = character:GetSkill()

		if (table.Count(skills) == 0) then
			client:ChatNotify(charName.." has not selected any skills.")
			return
		end

		for skillID, realLevel in pairs(skills) do
			local skill = ix.skill:Find(skillID)
			local boostedLevel = character:GetSkillLevel(skill.uniqueID)
			client:ChatNotify(charName.." has level "..boostedLevel.." in "..skill.name.." (unboosted base level: "..realLevel..")")
		end
	end,
})

ix.command.Add("CharSkillReset", {
	description = "@cmdCharSkillReset",
	privilege = "Manage Skills",
	arguments = {
		ix.type.character,
		ix.type.string
	},
	alias = "CharLevelReset",
	argumentsName = {"character", "skill"},
	OnRun = function(self, client, character, skillID) -- sets up variables with arguements
		local skill = ix.skill:Find(skillID)
		if (!skill) then
			client:Notify(skill.." is not a valid skill!")
		else
			character:SetSkill(skill.uniqueID, 0)
			client:Notify("You've reset "..character:GetPlayer():Name().." their "..skill.name.." skill.")
		end
	end,
})

ix.command.Add("CharSkillResetAll", {
	description = "@cmdCharSkillResetAll",
	privilege = "Manage Skills",
	arguments = {
		ix.type.character,
	},
	alias = "CharLevelResetAll",
	OnRun = function(self, client, character) -- sets up variables with arguements
		local skills = character:GetSkill()
		for k, _ in pairs(skills) do
			character:SetSkill(k, 0)
		end

		client:Notify("Reset all of "..character:GetPlayer():Name().." his skills.")
	end,
})

ix.command.Add("RefundSkills", {
  description = "@cmdRefundSkills",
  privilege = "Manage Skills",
  arguments = {
	ix.type.player
  },
  OnRun = function(self, client, target)
		if (IsValid(target)) then
			local character = target:GetCharacter()
			local refundSkills = character:GetRefundSkills()

			if (!table.IsEmpty(refundSkills)) then
				for k, v in pairs(refundSkills) do
					character:SetSkill(k, math.Clamp(character:GetSkill(k) + v, 0, ix.skill.MAX_SKILL))
				end
				character:SetRefundSkills()

				client:Notify("Lost skills of "..target:GetName().." were successfully refunded.")
				if (target != client) then
					target:Notify("All your lost skills were succesfully refunded.")
				end
			else
				client:NotifyLocalized("This character does not have any lost skills to refunding.")
			end
		else
			client:NotifyLocalized("plyNotValid")
		end
  end
})

ix.command.Add("RefundBoosts", {
  description = "Returns all boosts player lost after they last death.",
  privilege = "Manage Skills",
  arguments = {
	ix.type.player
  },
  OnRun = function(self, client, target)
		if (IsValid(target)) then
			local character = target:GetCharacter()
			local refundBoosts = character:GetRefundBoosts()

			if (!table.IsEmpty(refundBoosts)) then
				character:SetSpecialBoost(refundBoosts)
				character:SetRefundBoosts()

				client:Notify("Lost boosts of "..target:GetName().." were successfully refunded.")

				if (target != client) then
					target:Notify("All your lost boosts were succesfully refunded.")
				end
			else
				client:NotifyLocalized("This character does not have any lost boosts to refunding.")
			end
		else
			client:NotifyLocalized("plyNotValid")
		end
  end
})

ix.command.Add("CharTogglePermit", {
  description = "Toggle character's permits that allow them to do various things.",
  privilege = "Manage Character Flags",
  arguments = {
		ix.type.character,
		ix.type.string
  },
  OnRun = function(self, client, character, permit)
		if (!ix.permits.list[permit]) then
			client:NotifyLocalized("Permit not found. You can find valid permits in the 'Information' menu.")

			return
		end

		if (character) then
			if character:HasPermit(permit) == true then
				character:DisablePermit(permit)
			else
				character:SetPermitUnlimited(permit)
			end

			local hasPermit = character:HasPermit(permit)

			character:GetPlayer():NotifyLocalized("Your permit '"..permit.."' was toggled to "..tostring(hasPermit))

			if (client != character:GetPlayer()) then
				client:NotifyLocalized(character:GetName().."'s permit '"..permit.."' was toggled to "..tostring(hasPermit))
			end
		else
			client:NotifyLocalized("plyNotValid")
		end
  end
})

ix.command.Add("CharGetPermits", {
  description = "Show what permits characters currently has.",
  privilege = "Manage Character Flags",
  arguments = {
		ix.type.character
  },
  OnRun = function(self, client, character)
		if (character) then
			local permits = character:GetPermits()

			if (table.IsEmpty(permits)) then
				client:ChatPrint(character:GetName().." has no permits.")
			else
				client:ChatPrint(character:GetName().." has these permits:")

				for k, v in pairs(permits) do
					if (v) then
						client:ChatPrint(k)
					end
				end
			end
		else
			client:NotifyLocalized("plyNotValid")
		end
  end
})

function PLUGIN:InitializedPlugins()
	local items = ix.item.list
	for uniqueID, ITEM in pairs(items) do
		if (ITEM.action) then
			ix.action:RegisterSkillAction(ITEM.action.skill, "item_"..uniqueID, {
				name = "Use "..ITEM.name,
				description = "Allows you use the '"..ITEM.name.."' item.",
				CanDo = ITEM.action.level,
				DoResult = ITEM.action.experience
			 })
		end
	end

	local recipes = ix.recipe.stored
	for _, RECIPE in pairs(recipes) do
		if (RECIPE.skill == "bartering") then
			ix.action:RegisterSkillAction(RECIPE.skill, "recipe_"..RECIPE.uniqueID, {
				name = "Buy "..RECIPE.name,
				description = "Allows you to buy the '"..RECIPE.name.."' item.",
				CanDo = function(recipe, character, skillLevel, ...)
					return character:HasPermit(RECIPE.category)
				end,
				DoResult = RECIPE.experience
			 })
		elseif (RECIPE.level and !RECIPE.bNoAction) then
			ix.action:RegisterSkillAction(RECIPE.skill, "recipe_"..RECIPE.uniqueID, {
				name = "Craft "..RECIPE.name,
				description = "Allows you to craft the '"..RECIPE.name.."' recipe.",
				CanDo = RECIPE.level,
				DoResult = RECIPE.experience
			 })
		end

		if (RECIPE.cost and RECIPE.skill == "bartering") then
			if !ix.config.Get("BarteringPriceMultiplier"..RECIPE.category) then
				ix.config.Add("BarteringPriceMultiplier"..RECIPE.category, 1, "Bartering - Price multiplier "..RECIPE.category, nil, {
					data = {min = 0, max = 100, decimals = 1},
					category = "Bartering"
				})
			end

			if !ix.config.Get("BarteringMaxStock"..RECIPE.category) then
				ix.config.Add("BarteringMaxStock"..RECIPE.category, 1, "Bartering - Max Stock "..RECIPE.category, nil, {
					data = {min = 1, max = 60, decimals = 0},
					category = "Bartering"
				})
			end

			ix.permits.list[string.utf8lower(RECIPE.category)] = true
		end
	end

	for k, v in pairs(ix.weapons.weaponCatList) do
		ix.skill:RegisterSkillScale("guns", "familiarity_"..k, {
			name = "Gun Familiarity: "..v.name,
			description = "Determines how well you can handle weapons of this category.",
			minLevel = 0,
			maxLevel = 50,
			GetValue = function(scale, character)
				return ix.weapons:GetWeaponSkillMod(character, k, true)
			end,
			multiply = true,
			percentage = true
		})
	end

	--[[
	for _, v in pairs(ix.item.list) do
		if v.category == "Clothing - Citizen" or v.category == "Clothing - Citizen Trousers" then 

			local RECIPE = ix.recipe:New()
			RECIPE.uniqueID = "rec_"..v.uniqueID
			RECIPE.name = "Tear "..v.name
			RECIPE.description = "Tears the "..v.name.." to shreds to obtain some cloth scraps."
			RECIPE.model = v.model
			RECIPE.category = "Breakdown"
			RECIPE.subcategory = "Clothes"
			RECIPE.tool = "tool_scissors"
			RECIPE.ingredients = {[v.uniqueID] = 1}
			RECIPE.result = {["comp_cloth"] = 1} 
			RECIPE.hidden = false
			RECIPE.skill = "crafting"
			RECIPE.level = 0
			RECIPE.experience = {
				{level = 0, exp = 30}, -- full xp
				{level = 10, exp = 15}, -- half xp
				{level = 25, exp = 0} -- no xp
			}

			RECIPE:Register()
		end
    end
	]]--
end

function PLUGIN:GetDefaultAttributePoints(client, payload)
	if (payload.faction == FACTION_VORT) then
		return 10
	end

	return 8
end

function PLUGIN:CanTransferItem(itemTable, curInv, inventory)
	if (itemTable and IsValid(itemTable.entity)) then
		local client = itemTable.player

		if (itemTable:GetData("bolted", false)) then
			if (IsValid(client)) then
				client:Notify("This item is bolted down!")
			end

			return false
		end
	end
end
