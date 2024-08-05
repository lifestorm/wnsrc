--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local IsValid = IsValid
local Vector = Vector
local ix = ix

local PLUGIN = PLUGIN

function PLUGIN:PrePlayerLoadedCharacter(client, character, currentChar)
	if (IsValid(currentChar) and currentChar:GetFaction() != FACTION_BIRD) then return end

	client:SetMaxHealth(100)
	client:SetViewOffset(Vector(0, 0, 64))
	client:SetViewOffsetDucked(Vector(0, 0, 32))
	client:ResetHull()
	client:SetWalkSpeed(ix.config.Get("walkSpeed"))
	client:SetRunSpeed(ix.config.Get("runSpeed"))
end

local birdSounds = {
	["models/crow.mdl"] = {
		"npc/crow/alert2.wav",
		"npc/crow/idle1.wav",
		"npc/crow/idle3.wav",
		"npc/crow/alert3.wav"
	},
	["models/pigeon.mdl"] = {
		"ambient/creatures/pigeon_idle1.wav",
		"ambient/creatures/pigeon_idle2.wav",
		"ambient/creatures/pigeon_idle3.wav",
		"ambient/creatures/pigeon_idle4.wav"
	},
	["models/seagull.mdl"] = {
		"ambient/creatures/seagull_idle1.wav",
		"ambient/creatures/seagull_idle2.wav",
		"ambient/creatures/seagull_idle3.wav"
	}
}

function PLUGIN:KeyPress(client, key)
	if (client:Team() == FACTION_BIRD) then
		if (key == IN_ATTACK) then
			if (client.isBuildingNest and client:OnGround()) then
				local stickItem = client:GetCharacter():GetInventory():HasItem("woodstick")

				if (stickItem) then
					local nest = ents.Create("ix_birdnest")
					nest:SetPos(client:GetPos() + Angle(0, client:EyeAngles().y, 0):Forward() * 20 + Angle(0, client:EyeAngles().y, 0):Up() * -0.1)
					nest:SetAngles(Angle(0, client:EyeAngles().y + 180, 0):SnapTo("y", 1))
					nest:Spawn()

					nest:SetProgress(1)
					stickItem:Remove()
				end

				client.isBuildingNest = false

				net.Start("toggleBuildingNest")
					net.WriteBool(false)
				net.Send(client)
			else
				if (!client.nextBirdSound or client.nextBirdSound < CurTime()) then
					client.nextBirdSound = CurTime() + 5
					client:EmitSound(birdSounds[client:GetModel()][math.random(1, #birdSounds[client:GetModel()])])
				end
			end
		elseif (key == IN_ATTACK2) then
			if (client.isBuildingNest) then
				client.isBuildingNest = false

				net.Start("toggleBuildingNest")
					net.WriteBool(false)
				net.Send(client)
			else
				if (client:OnGround()) then
					if (!client.lastPeck or client.lastPeck < CurTime()) then
						client.lastPeck = CurTime() + 60

						client:Notify("You begin pecking the ground for hints of crumbs or other edible food...")
						client:ForceSequence("Eat_A", function()
							if (math.random(1, 2) == 1) then
								local character = client:GetCharacter()

								client:Notify("You found some hints of food on the ground.")
								character:SetHunger(math.Clamp(character:GetHunger() - 5, 0, 100))
								character:SetThirst(math.Clamp(character:GetThirst() - 5, 0, 100))
							else
								client:Notify("You did not find anything edible.")
							end
						end)
					else
						client:Notify("You can't peck the ground again for another " .. math.ceil(client.lastPeck - CurTime()) .. " seconds!")
					end
				else
					client:Notify("You must be on the ground in order to look for food!")
				end
			end
		elseif (key == IN_JUMP and client:GetNetVar("ixBirdMounting")) then
			local target = client:GetNetVar("ixBirdMounting")

			self:BirdMountCharacter(client, target, false)
		elseif (key == IN_RELOAD) then
			local character = client:GetCharacter()

			if (character:GetHunger() < 50 and character:GetThirst() < 50) then
				character:SetHunger(character:GetHunger() + 25)
				character:SetThirst(character:GetThirst() + 25)

				util.Decal("BirdPoop", client:GetPos(), client:GetPos() + Vector(0, 0, -2000), client)

				client:EmitSound("weapons/bugbait/bugbait_squeeze" .. math.random(1, 3) .. ".wav")
			else
				client:Notify("You are too hungry or thirsty to defecate.")
			end
		end
	end
end

function PLUGIN:CanPlayerTakeItem(client, entity)
	local item = ix.item.instances[entity.ixItemID]

	if (client:Team() == FACTION_BIRD) then
		if (table.Count(client:GetCharacter():GetInventory():GetItems()) > 0) then
			client:Notify("You can only carry one item at a time!")

			return false
		elseif (item.width > 1 or item.height > 1) then
			client:Notify("That item is too heavy for you to carry!")

			return false
		end
	end
end

function PLUGIN:PlayerDeath(client)
	if (client:Team() == FACTION_BIRD) then
		local character = client:GetCharacter()

		if (character:GetData("babyBird")) then -- Auto-PK non-donator birds on death.
			character:SetData("banned", true)
			character:Kick()
			character:Save()
		end
	else
		local bird = client:GetNetVar("ixBirdMounted")

		if (bird and IsValid(bird)) then
			self:BirdMountCharacter(bird, client, false)
		end
	end
end

-- Don't let the player farm food.
function PLUGIN:PostDropCharacterInventory(client, items, container, inventory)
	if (client:Team() == FACTION_BIRD and client:GetCharacter():GetData("babyBird", 0) < os.time()) then
		local character = client:GetCharacter()

		inventory:Add("ing_bird_meat")
		inventory:HasItem("ing_bird_meat").playerID = client:SteamID64()
		inventory:HasItem("ing_bird_meat").characterID = 0  -- This has to be networked, or it gets stuck in your inv if you take it. ...I think I'll leave it. Punishment for those who try to exploit. :troll:
	end
end

function PLUGIN:PlayerDisconnected(client)
	local bird = client:GetNetVar("ixBirdMounted")

	if (bird and IsValid(bird)) then
		self:BirdMountCharacter(bird, client, false)
	end
end

function PLUGIN:CharacterLoaded(character)
	local client = character:GetPlayer()
	local bird = client:GetNetVar("ixBirdMounted")

	if (bird and IsValid(bird)) then
		self:BirdMountCharacter(bird, client, false)
	end

	if (character:GetFaction() == FACTION_BIRD and character:GetData("babyBird", 0) > os.time() and !character:GetData("firstTimeBirdLoaded")) then
		character:SetData("firstTimeBirdLoaded", true)

		timer.Simple(3, function()
			client:Notify("Please update your description to more accurately describe your character.")

			timer.Simple(2, function()
				client:Notify("Also, please reach out to a member of staff to update your name.")
			end)
		end)
	end
end

function PLUGIN:OnCharacterKicked(character)
	local client = character:GetPlayer()
	local bird = client:GetNetVar("ixBirdMounted")

	if (bird and IsValid(bird)) then
		self:BirdMountCharacter(bird, client, false)
	end
end
