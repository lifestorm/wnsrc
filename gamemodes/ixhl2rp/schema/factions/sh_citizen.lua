--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

FACTION.name = "Citizen"
FACTION.description = "A regular human citizen enslaved by the Universal Union."
FACTION.color = Color(63, 142, 164, 255)
FACTION.isDefault = true

FACTION.factionImage = "materials/willardnetworks/faction_imgs/citizen.png"
FACTION.selectImage = "materials/willardnetworks/charselect/citizen2.png"
FACTION.inventoryImage = "materials/willardnetworks/tabmenu/inventory/backgrounds/street.png"

FACTION.humanVoices = true
FACTION.allowRebelForcefieldPassage = true

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

	if (background == "Relocated Citizen") then
		inventory:Add("suitcase", 1)
		inventory:Add("flashlight", 1)
		inventory:Add("armband_grey", 1)
	elseif (background == "Local Citizen") then
		inventory:Add("flashlight", 1)
		inventory:Add("armband_grey", 1)
	elseif (background == "Outcast") then
		ix.config.Get("defaultOutcastChips")
		inventory:Add("flashlight", 1)
		inventory:Add("armband_black", 1)
	else
		inventory:Add("armband_grey", 1)
	end

	local credits = ix.config.Get("defaultCredits", 10)
	if (background == "Outcast") then
		credits = math.floor(credits / 2)
	end
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

FACTION_CITIZEN = FACTION.index
