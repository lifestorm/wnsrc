--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


FACTION.name = "Event"
FACTION.description = "An event character, sshhhh."
FACTION.color = Color(63, 142, 164, 255)
FACTION.isDefault = false
FACTION.factionImage = "materials/willardnetworks/faction_imgs/event.png"
FACTION.selectImage = "materials/willardnetworks/faction_imgs/event.png"
FACTION.inventoryImage = "materials/willardnetworks/tabmenu/inventory/backgrounds/street.png"

FACTION.seeAll = true
FACTION.hidden = true

FACTION.humanVoices = true
FACTION.noNeeds = true
FACTION.noGas = true
FACTION.saveItemsAfterDeath = true
FACTION.noBackground = true
FACTION.isGloballyRecognized = false
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

    character:CreateIDCard()

	inventory:Add("flashlight")
	inventory:Add("smallbag")
    inventory:Add("largebag")

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

FACTION_EVENT = FACTION.index
