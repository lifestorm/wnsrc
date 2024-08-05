--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


FACTION.name = "Vortigaunt"
FACTION.description = "A free Vortigaunt."
FACTION.color = Color(138, 181, 40)
FACTION.isDefault = false

FACTION.noBeard = true
FACTION.noGender = true
FACTION.factionImage = "materials/willardnetworks/faction_imgs/vort.png"
FACTION.selectImage = "materials/willardnetworks/charselect/vort.png"
FACTION.inventoryImage = "materials/willardnetworks/tabmenu/inventory/backgrounds/xen.png"

FACTION.isGloballyRecognized = false

FACTION.noHair = true
FACTION.noGas = true
FACTION.bDrinkUnfilteredWater = true
FACTION.canEatRaw = true

FACTION.maxHealth = 150

FACTION.models = {
	"models/willardnetworks/vortigaunt.mdl"
};

FACTION.weapons = {"ix_vortheal", "ix_vortbeam", "ix_nightvision", "ix_vshield", "ix_vortsweep"}

function FACTION:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()
	local background = character:GetBackground()
	local vortPlugin = ix.plugin.Get("vortigaunts")
	client:Give("ix_vortsweep") -- i dont see any reason not to give all the vorts the sweep swep tbh

	if (background == "Biotic" or background == "Liberated" or background == "Collaborator") then
		timer.Simple(5, function()
			if (background == "Liberated") then
				client:Give("ix_vshield")
				client:Give("ix_nightvision")
				client:Give("ix_vortbeam")
				client:Give("ix_vortheal")
				client:Give("ix_vortslam")
				if character:GetSkillLevel("vort") >= 50 then
					client:Give("ix_vortpyro")
					client:Give("ix_vortadvancedbeam")
				end
				if character:GetSkillLevel("vort") >= 30 and character:GetSkillLevel("melee") >= 30 then
					client:Give("ix_vmelee")
				end
			elseif (background == "Collaborator") then
				client:Give("ix_vshield")
				client:Give("ix_nightvision")
				client:Give("ix_vortbeam")
				client:Give("ix_vortheal")
			end
		end)

		if background == "Collaborator" then
			character:CreateIDCard(100)
			inventory:Add("vortigaunt_trousers_brown", 1)
			timer.Simple(3, function()
				if IsValid(character) then
					local genericdata = character:GetGenericdata()

					if (genericdata) then
						genericdata.socialCredits = (genericdata.socialCredits or 0) + 50
						character:SetGenericdata(genericdata)
						character:Save()
					end
				end
			end)
			character:SetData("equipBgClothes", true)
		end

		if (background == "Biotic") then
			local uniqueID = tostring(vortPlugin:GenerateCollarID(character.id))

			inventory:Add("vortigaunt_slave_hooks", 1)
			inventory:Add("vortigaunt_slave_shackles", 1)
			inventory:Add("vortigaunt_slave_collar", 1, {
				collarID = uniqueID,
				sterilizedCredits = 0
			})

			character:SetData("equipBgClothes", true)

			timer.Simple(5, function()
				if client then
					if client:HasWeapon("ix_nightvision") then
						client:StripWeapon("ix_nightvision")
					end

					if client:HasWeapon("ix_vortbeam") then
						client:StripWeapon("ix_vortbeam")
					end

					if client:HasWeapon("ix_vortheal") then
						client:StripWeapon("ix_vortheal")
					end

					if client:HasWeapon("ix_vshield") then
						client:StripWeapon("ix_vshield")
					end

					if client:HasWeapon("ix_vmelee") then
						client:StripWeapon("ix_vmelee")
					end

					if client:HasWeapon("ix_vortslam") then
						client:StripWeapon("ix_vortslam")
					end

					if client:HasWeapon("ix_vortpyro") then
						client:StripWeapon("ix_vortpyro")
					end

					if client:HasWeapon("ix_vortadvancedbeam") then
						client:StripWeapon("ix_vortadvancedbeam")
					end
				end
			end)
		end
	else -- freed
		timer.Simple(5, function()
			client:Give("ix_vshield")
			client:Give("ix_nightvision")
			client:Give("ix_vortbeam")
			client:Give("ix_vortheal")
			client:Give("ix_vortslam")
			if character:GetSkillLevel("vort") >= 50 then
				client:Give("ix_vortpyro")
				client:Give("ix_vortadvancedbeam")
			end
			if character:GetSkillLevel("vort") >= 30 and character:GetSkillLevel("melee") >= 30 then
				client:Give("ix_vmelee")
			end
		end)
	end
end

function FACTION:OnSpawn(client)
	client:SetLocalVar("vortalVision", false)

	timer.Simple(0.1, function()
		client:SetRunSpeed(ix.config.Get("runSpeed") * 1.25)
		client:SetJumpPower(ix.config.Get("jumpPower") * 1.25)
	end)
end

FACTION_VORT = FACTION.index
