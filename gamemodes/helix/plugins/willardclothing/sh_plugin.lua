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

PLUGIN.name = "Willard Clothing System"
PLUGIN.author = "Fruity"
PLUGIN.description = "Allows for items/clothing to be able to set bodygroups."

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")

PLUGIN.baseList = {}

ix.command.Add("clothingcreator", {
	description = "Open the clothing creator.",
	adminOnly = true,
	OnRun = function(self, client)
        net.Start("ixOpenClothingCreator")
        net.Send(client)
	end
})

if (SERVER) then return end

function PLUGIN:GetClothingCreator()
	if ix.gui.clothingCreator and IsValid(ix.gui.clothingCreator) then
		return ix.gui.clothingCreator
	end

	return false
end

function PLUGIN:GetChoicesInBaseFromVar(base, var)
	local clothingCreator = self:GetClothingCreator()
	if !clothingCreator then return end

	return clothingCreator:GetChoicesInBaseFromVar(base, var)
end

function PLUGIN:GetChoicesInBaseFromVarTable(base, var)
	local clothingCreator = self:GetClothingCreator()
	if !clothingCreator then return end

	return clothingCreator:GetChoicesInBaseFromVarTable(base, var)
end

function PLUGIN:OpenItemModelChoices()
	local clothingCreator = PLUGIN:GetClothingCreator()
	if !clothingCreator then return end
	clothingCreator:OpenItemModelChoices()
end

function PLUGIN:OpenIconEditor()
	local clothingCreator = PLUGIN:GetClothingCreator()
	if !clothingCreator then return end
	clothingCreator:OpenIconEditor()
end

function PLUGIN:GetProxyList()
	local charCreationPlugin = ix.plugin.list["charcreation"]
	if charCreationPlugin then
		local list = charCreationPlugin.proxyList or {}
		if list[2] then list[2] = nil end -- hair color proxy removal

		return list
	end

	return {}
end

function PLUGIN:OpenColorAppendixMenu()
	local clothingCreator = PLUGIN:GetClothingCreator()
	if !clothingCreator then return end
	clothingCreator:OpenColorAppendixMenu()
end

function PLUGIN:GetModelsByBase(base)
	local models = {
		male = "models/props_junk/watermelon01.mdl",
		female = "models/props_junk/watermelon01.mdl"
	}

	if (base == "base_bgclothes" or base == "base_mask") then
		models.male = "models/willardnetworks/citizens/male_01.mdl"
		models.female = "models/willardnetworks/citizens/female_01.mdl"
	end

	if (base == "base_combinesuit" or base == "base_maskcp") then
		models.male = "models/wn7new/metropolice/male_01.mdl"
		models.female = "models/wn7new/metropolice/female_01.mdl"
	end

	return models
end

function PLUGIN:OpenBodygroupChooser(base)
	local clothingCreator = PLUGIN:GetClothingCreator()
	if !clothingCreator then return end

	local models = self:GetModelsByBase(base)

	clothingCreator:OpenBodygroupChooser(models)
end

function PLUGIN:OpenItemPicker()
	local clothingCreator = PLUGIN:GetClothingCreator()
	if !clothingCreator then return end

	clothingCreator:OpenItemPicker()
end

function PLUGIN:OpenMultipleChoice(list, var)
	local clothingCreator = PLUGIN:GetClothingCreator()
	if !clothingCreator then return end

	clothingCreator:OpenMultipleChoice(list, var)
end

function PLUGIN:OpenProxyChooser()
	local clothingCreator = PLUGIN:GetClothingCreator()
	if !clothingCreator then return end

	clothingCreator:OpenProxyChooser()
end

PLUGIN.baseList = {
	base_bgclothes = {
		explainer = "This base contains all our primary models outfits (with no gas deterrent nor combine compatibility).",
		vars = {
			name = {type = "", description = "Name of the item."},
			description = {type = "", description = "Description of the item."},
			category = {
				type = "",
				description = "Category of the item.",
				altChoices = function()
					return PLUGIN:GetChoicesInBaseFromVar("base_bgclothes", "category")
				end
			},
			model = {
				type = "",
				description = "Model path of the item.",
				altMenu = function()
					PLUGIN:OpenItemModelChoices()
				end
			},
			proxy = {
				type = {},
				description = "Material proxy type for clothing color",
				altMenu = function()
					PLUGIN:OpenProxyChooser()
				end
			},
			outfitCategory = {
				type = "",
				description = "Category of outfit that this item goes on in the equip slots.",
				altChoices = function()
					return {"Head", "Glasses", "Hands", "Face", "Shoes", "Legs", "Torso", "Model"}
				end
			},
			charCreation = {type = false, description = "Does this clothing appear as chooseable in char creation?"},
			glasses = {type = false, description = "Mostly for blur effect that makes the glasses blur disappear when equipped."},
			KeepOnDeath = {type = false, description = "Death drop or not?"},
			width = {type = 0, description = "", min = 1, max = 1},
			height = {type = 0, description = "", min = 1, max = 1},
			maxArmor = {type = 0, description = "Armor for this item when fully armored.", min = 0, max = 300},
			outlineColor = {type = {}, description = "Outline on the UI of the item itself."},
			colorAppendix = {
				type = {},
				description = "A colored text that appears on the item tooltip.",
				altMenu = function()
					PLUGIN:OpenColorAppendixMenu()
				end
			},
			bodyGroups = {
				type = {},
				description = "Bodygroups the item should enable on the player when equipped.",
				altMenu = function()
					PLUGIN:OpenBodygroupChooser("base_bgclothes")
				end
			},
			iconCam = {
				type = {},
				description = "How the icon of the item is positioned.",
				altMenu = function()
					PLUGIN:OpenIconEditor()
				end
			}
		}
	},

	base_mask = {
		explainer = "This base contains gas deterrent clothing that is not combine related.",
		parent = "base_bgclothes",
		vars = {
			filterQuality = {type = 0, description = "Something about gasmasks, ask Gr4Ss", min = 0, max = 1, decimals = true},
			maxFilterValue = {type = 0, description = "Something about gasmasks, ask Gr4Ss", min = 0, max = 200},
			filterDecayStart = {type = 0, description = "Something about gasmasks, ask Gr4Ss", min = 0, max = 0.2, decimals = true},
			refillItem = {
				type = "",
				description = "Item to refill the mask capability with.",
				altMenu = function()
					PLUGIN:OpenItemPicker()
				end
			}
		}
	},

	base_maskcp = {
		explainer = "This base contains gas deterrent clothing that is combine related.",
		parent = "base_bgclothes",
		vars = {
			isGasmask = {type = false, description = "Is this item a gasmask?"},
			isCombineMask = {type = false, description = "Is this item a combine mask?"},
			isMask = {type = false, description = "Is this item a mask in general?"},
			bodyGroups = {
				type = {},
				description = "Bodygroups the item should enable on the player when equipped.",
				altMenu = function()
					PLUGIN:OpenBodygroupChooser("base_maskcp")
				end
			}
		}
	},

	base_combinesuit = { -- outfit base left out as parent because we don't want to use outfit base other than for these suits
		explainer = "This base contains all combine model replacing clothing.",
		vars = {
			name = {type = "", description = "Name of the item."},
			model = {
				type = "",
				description = "Model path of the item.",
				altMenu = function()
					PLUGIN:OpenItemModelChoices()
				end
			},
			description = {type = "", description = "Description of the item."},
			category = {
				type = "",
				description = "Category of the item.",
				altChoices = function()
					return PLUGIN:GetChoicesInBaseFromVar("base_combinesuit", "category")
				end
			},
			width = {type = 0, description = "", min = 1, max = 1},
			height = {type = 0, description = "", min = 1, max = 1},
			maxArmor = {type = 0, description = "Armor for this item when fully armored.", min = 0, max = 300},
			outfitCategory = {
				type = "",
				description = "Category of outfit that this item goes on in the equip slots.",
				altChoices = function()
					return {"Model"}
				end
			},
			replacementString = {
				type = "",
				description = "Use helper, correct the replacing model depending on whether one uses male_01, male_02 and so forth.",
				altChoices = function()
					return PLUGIN:GetChoicesInBaseFromVar("base_combinesuit", "replacementString")
				end
			},
			replaceOnDeath = {
				type = "",
				description = "Item to replace this item with on death.",
				altMenu = function()
					PLUGIN:OpenItemPicker()
				end
			},
			repairItem = {
				type = "",
				description = "Item to repair this item with.",
				altMenu = function()
					PLUGIN:OpenItemPicker()
				end
			},
			isCP = {type = false, description = "Is this item a CP item."},
			isRadio = {type = false, description = "Is this item something that should enable radio."},
			channels = {
				type = {},
				description = "Which radio channels?",
				altMenu = function()
					local var = "channels"
					PLUGIN:OpenMultipleChoice(PLUGIN:GetChoicesInBaseFromVarTable("base_combinesuit", var), var)
				end
			},
			iconCam = {
				type = {},
				description = "How the icon of the item is positioned.",
				altMenu = function()
					PLUGIN:OpenIconEditor()
				end
			},
			bodyGroups = {
				type = {},
				description = "Bodygroups the item should enable on the player when equipped.",
				altMenu = function()
					PLUGIN:OpenBodygroupChooser("base_combinesuit")
				end
			}
		}
	}
}