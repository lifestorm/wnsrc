--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

FACTION.name = "The Resistance"
FACTION.description = "A regular human living amongst Combine Rule- but all is not what it seems."
FACTION.color = Color(63, 142, 164, 255)
FACTION.isDefault = false

FACTION.factionImage = "materials/willardnetworks/faction_imgs/rebel.png"
FACTION.selectImage = "materials/willardnetworks/charselect/rebel.png"
FACTION.inventoryImage = "materials/willardnetworks/tabmenu/inventory/backgrounds/factory.png"

FACTION.humanVoices = true
FACTION.allowRebelForcefieldPassage = true

FACTION.idInspectionText = "Citizen"

FACTION.models = {
	female = {
		"models/willardnetworks/citizens/female_01.mdl",
		"models/willardnetworks/citizens/female_02.mdl",
		"models/willardnetworks/citizens/female_03.mdl",
		"models/willardnetworks/citizens/female_04.mdl",
		"models/willardnetworks/citizens/female_06.mdl",
		"models/willardnetworks/citizens/female_05.mdl"
	};
	male = {
		"models/willardnetworks/citizens/male_01.mdl",
		"models/willardnetworks/citizens/male_02.mdl",
		"models/willardnetworks/citizens/male_03.mdl",
		"models/willardnetworks/citizens/male_04.mdl",
		"models/willardnetworks/citizens/male_05.mdl",
		"models/willardnetworks/citizens/male_06.mdl",
		"models/willardnetworks/citizens/male_07.mdl",
		"models/willardnetworks/citizens/male_08.mdl",
		"models/willardnetworks/citizens/male_09.mdl",
		"models/willardnetworks/citizens/male_10.mdl"
	};
};

function FACTION:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()
	local background = character:GetBackground()

	character:CreateIDCard(credits)

	-- Give clothing chosen upon char creation
	local chosenClothes = character:GetData("chosenClothes")
	if (istable(chosenClothes) and !table.IsEmpty(chosenClothes)) then
		if chosenClothes.torso then
			inventory:Add(chosenClothes.torso, 1)
		end

		if chosenClothes.legs then
			inventory:Add(chosenClothes.legs, 1)
		end

		if chosenClothes.shoes then
			inventory:Add(chosenClothes.shoes, 1)
		end

		if chosenClothes["8"] then
			inventory:Add("glasses", 1)
		end

		character:SetData("equipBgClothes", true)
	end

	character:SetData("chosenClothes", nil)
end

function FACTION:OnTransferred(character)
	local genericData = character:GetGenericdata()
	genericData.combine = false
	character:SetGenericdata(genericData)
end

FACTION_RESISTANCE = FACTION.index
