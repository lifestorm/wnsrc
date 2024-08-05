--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local locks = {"ix_combinelock", "ix_combinelock_cwu", "ix_combinelock_cmru", "ix_combinelock_dob", "ix_combinelock_moe"}
function Schema:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("ix_rationdispenser", true, true, true, {
		OnSave = function(entity, data) --OnSave
            data.enabled = entity:GetEnabled()
			data.motion = false
		end,
		OnRestore = function(entity, data) --OnRestore
			entity:SetEnabled(data.enabled)
		end,
	})

	for k, v in ipairs(locks) do
		ix.saveEnts:RegisterEntity(v, true, true, true, {
			OnSave = function(entity, data) --OnSave
				data.id = entity.door:MapCreationID()
				data.localpos = entity.door:WorldToLocal(entity:GetPos())
				data.localangs = entity.door:WorldToLocalAngles(entity:GetAngles())
				data.locked = entity:GetLocked()
				data.accessLvl = entity.accessLevel
			end,
			OnRestore = function(entity, data) --OnRestore
				local door = ents.GetMapCreatedEntity(data.id)
				entity:SetDoor(door, door:LocalToWorld(data.localpos), door:LocalToWorldAngles(data.localangs))
				entity:SetLocked(data.locked)
				entity.accessLevel = data.accessLvl
			end,
			ShouldSave = function(entity) --ShouldSave
				return IsValid(entity.door)
			end,
			ShouldRestore = function(data) --ShouldRestore
				local door = ents.GetMapCreatedEntity(data.id)
				return IsValid(door) and door:IsDoor()
			end
		})
	end

	ix.saveEnts:RegisterEntity("ix_forcefield", true, true, true, {
		OnSave = function(entity, data) --OnSave
            data.mode = entity:GetMode()
		end,
		OnRestore = function(entity, data) --OnRestore
			entity:SetMode(data.mode)

			if (data.mode == 1) then
				entity:SetSkin(3)
				entity.dummy:SetSkin(3)
			else
				local entTable = scripted_ents.Get("ix_forcefield")
				local skin = entTable.MODES
				entity:SetSkin(skin[data.mode][4])
				entity.dummy:SetSkin(skin[data.mode][4])
			end
		end,
	})

	ix.saveEnts:RegisterEntity("ix_rebelfield", true, true, true, {
		OnSave = function(entity, data) --OnSave
			data.mode = entity:GetMode()
		end,
		OnRestore = function(entity, data) --OnRestore
			entity:SetMode(data.mode)

			if (data.mode == 1) then
				entity:SetSkin(3)
				entity.dummy:SetSkin(3)
			else
				local entTable = scripted_ents.Get("ix_rebelfield")
				local skin = entTable.MODES
				entity:SetSkin(skin[data.mode][4])
				entity.dummy:SetSkin(skin[data.mode][4])
			end
		end,
	})
end

function Schema:LoadData()
	Schema.CombineObjectives = ix.data.Get("combineObjectives", {}, false, true)

	if (!ix.config.Get("SaveEntsOldLoadingEnabled")) then return end
	self:LoadRationDispensers()
	self:LoadCombineLocks()
	self:LoadForceFields()
end

function Schema:SaveData()
	self:SaveRationDispensers()
	self:SaveCombineLocks()
	self:SaveForceFields()
	self:SaveRebelForceFields()
end

function Schema:PlayerSwitchFlashlight(client, enabled)
	return true
end

function Schema:CanPlayerOpenCombineLock(client, entity)
	if (client:HasActiveCombineSuit() or ix.faction.Get(client:Team()).allowCombineLock) then
		return true
	end

	if (client:GetCharacter():GetInventory():HasItem("combine_card")) then
		return true
	end

	return false
end

function Schema:PlayerUse(client, entity)
	local weapon = client:GetActiveWeapon()
	if (weapon and IsValid(weapon) and weapon:GetClass() == "weapon_physgun") then return false end

	if (!client:IsRestricted() and entity:IsDoor() and IsValid(entity.ixLock) and client:KeyDown(IN_SPEED)) then
		if (self:CanPlayerOpenCombineLock(client, entity)) then
			entity.ixLock:Toggle(client)

			return false
		else
			local class = entity.ixLock:GetClass()

			if (class == "ix_grouplock" or class == "ix_combinelock_cwu" or class == "ix_combinelock_dob" or class == "ix_combinelock_cmru" or class == "ix_combinelock_moe") then
				entity.ixLock:Toggle(client)

				return false
			end
		end
	end

	local ragdoll = nil

	if (entity:IsRagdoll() and entity.ixPlayer) then
		ragdoll = entity
		entity = entity.ixPlayer
	end
end

function Schema:PlayerUseDoor(client, door)
	if (!door:HasSpawnFlags(256) and !door:HasSpawnFlags(1024)) then
		if (client:HasActiveCombineSuit() or ix.faction.Get(client:Team()).allowCombineDoors) then
			door:Fire("open")
		end
	end
end

function Schema:PostPlayerLoadout(client)
	local factionTable = ix.faction.Get(client:Team())
	if (factionTable.OnNameChanged) then
		factionTable:OnNameChanged(client, "", client:GetCharacter():GetName())
	end

	if (factionTable.maxHealth) then
		client:SetMaxHealth(factionTable.maxHealth)
		client:SetHealth(factionTable.maxHealth)
	end

	local character = client:GetCharacter()
	if (character) then
		client:SetRestricted(character:GetData("tied", false))
	end
end

function Schema:PrePlayerLoadedCharacter(client, character, oldCharacter)
	if (oldCharacter) then
		oldCharacter:SetData("tied", client:IsRestricted())
	end
end

function Schema:PlayerLoadedCharacter(client, character, oldCharacter)
	if (client:IsDispatch()) then
		ix.combineNotify:AddNotification("LOG:// Decrypting incoming node connection from 144.76.222.66")

		timer.Simple(1, function()
			ix.combineNotify:AddNotification("NTC:// Dispatch Artificial Intelligence Node online", Color(255, 255, 0, 255))
		end)
	elseif (oldCharacter and oldCharacter:GetFaction() == FACTION_OVERWATCH) then
		ix.combineNotify:AddNotification("NTC:// Dispatch Artificial Intelligence Node offline", Color(255, 255, 0, 255))
	elseif (client:IsCombine() or (oldCharacter and oldCharacter:IsCombine())) then
		ix.combineNotify:AddNotification("LOG:// Rebuilding Overwatch manifest", Color(50, 100, 175))
	end
end

function Schema:PlayerDisconnected(client)
	if (client:GetCharacter()) then
		client:GetCharacter():SetData("tied", client:IsRestricted())
	end

	if (client:IsDispatch()) then
		ix.combineNotify:AddNotification("NTC:// Dispatch Artificial Intelligence Node offline", Color(255, 255, 0, 255))
	elseif (client:IsCombine()) then
		ix.combineNotify:AddNotification("LOG:// Rebuilding Overwatch manifest", Color(50, 100, 175))
	end
end

function Schema:CharacterVarChanged(character, key, oldValue, value)
	local client = character:GetPlayer()
	if (key == "name") then
		local factionTable = ix.faction.Get(client:Team())

		if (factionTable.OnNameChanged) then
			factionTable:OnNameChanged(client, oldValue, value)
		end
	end
end

function Schema:PlayerFootstep(client, position, foot, soundName, volume)
	local factionTable = ix.faction.Get(client:Team())

	if (factionTable and factionTable.runSounds and client:IsRunning()) then
		client:EmitSound(factionTable.runSounds[foot])
		return true
	end

	client:EmitSound(soundName)
	return true
end

local digitToSound = {
	"one",
	"two",
	"three",
	"four",
	"five",
	"six",
	"seven",
	"eight",
	"nine"
}
function Schema:PlayerDeath(client, inflicter, attacker)
	if (client:HasActiveTracker() or client:IsCombineScanner()) then
		if (ix.config.Get("suitsNoConnection")) then return end

		local suit = ix.item.instances[client:GetCharacter():GetCombineSuit()]

		ix.combineNotify:AddNotification("NTC:// Downloading lost biosignal")
		ix.combineNotify:AddImportantNotification("WRN:// Lost biosignal for unit " .. client:GetCombineTag(), nil, client, client:GetPos())

		local start = "npc/overwatch/radiovoice/die"..math.random(1, 3)..".wav"
		if (suit.isOTA) then
			start = "npc/combine_soldier/die"..math.random(1, 3)..".wav"
		end
		local on = "npc/overwatch/radiovoice/on1.wav"
		local onRand = math.random(1, 2)
		if (onRand == 2) then
			on = "npc/overwatch/radiovoice/on3.wav"
		end

		local sounds = {start, on}

		local tag = client:GetCombineTag()
		local name = {}
		if (string.find(tag,"^%w+%-%d$")) then
			local parts = string.Explode("-", tag, false)
			if (Schema.voices.stored["dispatch radio"][string.lower(parts[1])]) then
				name[1] = Schema.voices.stored["dispatch radio"][string.lower(parts[1])].sound
			end
			if (Schema.voices.stored["dispatch radio"][digitToSound[tonumber(parts[2])]]) then
				name[2] = Schema.voices.stored["dispatch radio"][digitToSound[tonumber(parts[2])]].sound
			end
		end

		local areaSounds = {}
		if (client:IsInArea()) then
			local area = client:GetArea()
			if (area and ix.area.stored[area].properties.dispatchsound) then
				for _, v in pairs(string.Explode(";", ix.area.stored[area].properties.dispatchsound)) do
					areaSounds[#areaSounds + 1] = Schema.voices.stored["dispatch radio"][string.lower(v)].sound
				end
			end
		end

		local rand = math.random(1, table.Count(areaSounds) > 0 and 3 or 2)
		if (rand == 1) then
			sounds[#sounds + 1] = "npc/overwatch/radiovoice/lostbiosignalforunit.wav"
			if (table.Count(name) == 2) then
				table.Add(sounds, name)
			end
		elseif (rand == 2) then
			if (table.Count(name) == 2) then
				table.Add(sounds, name)
			end
			sounds[#sounds + 1] = "npc/overwatch/radiovoice/unitdeserviced.wav"
		elseif (rand == 3) then
			if (table.Count(name) == 2) then
				table.Add(sounds, name)
			end
			sounds[#sounds + 1] = "npc/overwatch/radiovoice/unitdownat.wav"
		end

		if (table.Count(areaSounds) > 0) then
			table.Add(sounds, areaSounds)
		end

		local chance = math.random(1, 7)
		if (chance == 2) then
			sounds[#sounds + 1] = "npc/overwatch/radiovoice/remainingunitscontain.wav"
		elseif (chance == 3) then
			sounds[#sounds + 1] = "npc/overwatch/radiovoice/reinforcementteamscode3.wav"
		end

		if (onRand != 2) then
			sounds[#sounds + 1] = "npc/overwatch/radiovoice/off4.wav"
		else
			sounds[#sounds + 1] = "npc/overwatch/radiovoice/off2.wav"
		end

		for _, v in ipairs(player.GetAll()) do
			if (v:HasActiveCombineSuit()) then
				ix.util.EmitQueuedSounds(v, sounds, 2, nil, v == client and 100 or 80)
			end
		end
	end
end

function Schema:PlayerHurt(client, attacker, health, damage)
	if (health <= 0) then
		return
	end

	if (client:HasActiveTracker() and (client.ixTraumaCooldown or 0) < CurTime()) then
		if (health < 25) then
			ix.combineNotify:AddNotification("WRN:// Vital signs dropping - seek medical attention", Color(255, 0, 0, 255), nil, nil, client)
		else
			local text = damage > 50 and "Severe" or "External"
			ix.combineNotify:AddNotification("WRN:// " .. text .. " trauma detected", Color(255, 0, 0, 255), nil, nil, client)
		end

		client.ixTraumaCooldown = CurTime() + 15
	end
end

local chatTypes = {
	["ic"] = true,
	["w"] = true,
	["wd"] = true,
	["y"] = true,
	["radio"] = true,
	["radio_eavesdrop"] = true,
	["radio_eavesdrop_yell"] = true,
	["dispatch"] = true,
	["dispatch_radio"] = true,
	["overwatch_radio"] = true,
	["dispatchota_radio"] = true,
	["dispatchcp_radio"] = true,
	["scanner_radio"] = true,
	["request"] = true,
	["broadcast"] = true,
	["localbroadcast"] = true
}

local globalBlacklist = {
	["radio_eavesdrop"] = true,
	["radio_eavesdrop_yell"] = true,
}

local validEnds = {
	["."] = true,
	["?"] = true,
	["!"] = true
}

local function fixMarkup(a, b)
	return a.." "..string.utf8upper(b)
end

function Schema:PlayerMessageSend(speaker, chatType, text, anonymous, receivers, rawText, data)
	if (chatTypes[chatType] and speaker) then
		local class = self.voices.GetClass(speaker)

		local textTable = string.Explode("; ?", rawText, true)
		local voiceList = {}

		for k, v in ipairs(textTable) do
			local bFound = false
			local vUpper = string.utf8upper(v)

			local info

			for _, c in ipairs(class) do
				info = self.voices.Get(c, vUpper)

				if (info) then break end
			end

			if (info) then
				bFound = true

				if (info.sound) then
					voiceList[#voiceList + 1] = {
						global = info.global,
						sound = info.sound
					}
				end

				if (k == 1) then
					textTable[k] = info.text
				else
					textTable[k] = string.utf8lower(info.text)
				end

				if (k != #textTable) then
					local endText = string.utf8sub(info.text, -1)

					if (endText == "!" or endText == "?") then
						textTable[k] = string.gsub(textTable[k], "[!?]$", ",")
					end
				end
			end

			if (bFound == false and k != #textTable) then
				textTable[k] = v .. "; "
			end
		end

		local str
		str = table.concat(textTable, " ")
		str = string.gsub(str, " ?([.?!]) (%l?)", fixMarkup)

		if (voiceList[1]) then
			local volume = 80

			if (chatType == "w" or (data.radioType and data.radioType == ix.radio.types.whisper)) then
				volume = 60
			elseif (chatType == "y" or (data.radioType and data.radioType == ix.radio.types.yell)) then
				volume = 150
			end

			local delay = 0

			for _, v in ipairs(voiceList) do
				local sound = v.sound

				if (istable(sound)) then
					local gender = speaker:GetCharacter():GetGender()
					if gender and gender != "" then
						if gender == "male" then
							sound = v.sound[1]
						else
							sound = v.sound[2]
						end
					else
						sound = v.sound[1]
					end
				end

				if sound then
					if (delay == 0) then
						speaker:EmitSound(sound, volume)
					else
						timer.Simple(delay, function()
							speaker:EmitSound(sound, volume)
						end)
					end


					if (v.global and !globalBlacklist[chatType]) then
						if (delay == 0) then
							for _, v1 in ipairs(receivers) do
								if (v1 != speaker) then
									netstream.Start(v1, "PlaySound", sound)
								end
							end
						else
							timer.Simple(delay, function()
								for _, v1 in ipairs(receivers) do
									if (v1 != speaker) then
										netstream.Start(v1, "PlaySound", sound)
									end
								end
							end)
						end
					end

					delay = delay + SoundDuration(sound) + 0.1
				end
			end
		end

		str = string.Trim(str)

		str = str:utf8sub(1, 1):utf8upper() .. str:utf8sub(2)
		if (!validEnds[str:utf8sub(-1)]) then
			str = str .. "."
		end

		if (speaker:HasActiveCombineMask() and !speaker:IsDispatch()) then
			return string.format("<:: %s ::>", str)
		else
			return str
		end
	end
end

function Schema:CanPlayerJoinClass(client, class, info)
	if (client:IsRestricted()) then
		client:Notify("You cannot change classes when you are restrained!")

		return false
	end
end

function Schema:PlayerSpawnObject(client)
	if (client:IsRestricted()) then
		return false
	end
end

function Schema:PlayerSpray(client)
	return true
end

function Schema:ShouldCalculatePlayerNeeds(client, character)
	local factionTable = ix.faction.Get(client:Team())

	if (factionTable.noNeeds) then
		return false
	end
end

netstream.Hook("ViewObjectivesUpdate", function(client, text)
	if (client:GetCharacter() and hook.Run("CanPlayerEditObjectives", client)) then
		local date = ix.date.Get()
		local data = {
			text = text:utf8sub(1, 1000),
			lastEditPlayer = client:GetCharacter():GetName(),
			lastEditDate = date
		}

		ix.data.Set("combineObjectives", data, false, true)
		Schema.CombineObjectives = data
		ix.combineNotify:AddNotification("LOG:// Retrieving updated Overwatch Objective Manifest (REVISION " .. date:spanseconds() .. ")")
		ix.combineNotify:AddObjectiveNotification("OBJECTIVE:// " .. data.text)
	end
end)

netstream.Hook("SearchDecline", function(client)
	if (!IsValid(client.ixSearchRequest)) then return end

	client.ixSearchRequest:NotifyLocalized(hook.Run("GetCharacterName", client, "ic") or client:GetName().." does not allow to search themself.")
	client.ixSearchRequest = nil
end)

netstream.Hook("SearchTimeout", function(client)
	if (!IsValid(client.ixSearchRequest)) then return end

	client.ixSearchRequest:NotifyLocalized(hook.Run("GetCharacterName", client, "ic") or client:GetName().." did not respond to the request.")
	client.ixSearchRequest = nil
end)

netstream.Hook("SearchAllow", function(client)
	if (!IsValid(client.ixSearchRequest)) then return end

	Schema:SearchPlayer(client.ixSearchRequest, client)
	client.ixSearchRequest.ixLastSearchRequest = nil
	client.ixSearchRequest = nil
end)

netstream.Hook("ixSetToolMaxDurability", function(client, itemID, amount)
	amount = math.max(amount, 1)

	local item = ix.item.instances[itemID]
	item:SetData("maxDurability", amount)

	if (item:GetDurability() > amount) then
		item:SetData("durability", amount)
	end
end)

netstream.Hook("ixSetToolDurability", function(client, itemID, amount)
	local item = ix.item.instances[itemID]
	amount = math.Clamp(amount, 1, item:GetMaxDurability())
	item:SetData("durability", amount)
end)

-- This is a TERRIBLE way of doing this, but it works without editing helix.
-- Adds an option to make certain configs silent.
net.Receive("ixConfigSet", function(length, client)
	local key = net.ReadString()
	local value = net.ReadType()

	if (CAMI.PlayerHasAccess(client, "Helix - Manage Config", nil) and
		type(ix.config.stored[key].default) == type(value)) then
		ix.config.Set(key, value)

		if (ix.util.IsColor(value)) then
			value = string.format("[%d, %d, %d]", value.r, value.g, value.b)
		elseif (istable(value)) then
			local value2 = "["
			local count = table.Count(value)
			local i = 1

			for _, v in SortedPairs(value) do
				value2 = value2 .. v .. (i == count and "]" or ", ")
				i = i + 1
			end

			value = value2
		elseif (isstring(value)) then
			value = string.format("\"%s\"", tostring(value))
		elseif (isbool(value)) then
			value = string.format("[%s]", tostring(value))
		end

		if (!ix.config.stored[key].data.silent and !ix.config.Get("silentConfigs")) then -- Don't notify everyone.
			ix.util.NotifyLocalized("cfgSet", nil, client:Name(), key, tostring(value))
		else
			for _, v in ipairs(player.GetAll()) do
				if (v:IsAdmin()) then
					v:NotifyLocalized("cfgSet", client:Name(), key, tostring(value))
				end
			end
		end

		ix.log.Add(client, "cfgSet", key, value)
	end
end)
