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
local ix = ix
local timer = timer

PLUGIN.conterminousAgendaMessage = PLUGIN.conterminousAgendaMessage or "The Vortigaunt is silent."

util.AddNetworkString("ixVortNotes")

function PLUGIN:DatabaseConnected()
	local query = mysql:Create("ix_vortessence")
	query:Create("note_id", "INT(11) UNSIGNED NOT NULL AUTO_INCREMENT")
	query:Create("note_title", "TEXT")
	query:Create("note_text", "TEXT")
	query:Create("note_date", "TEXT")
	query:Create("note_poster", "TEXT")
	query:Create("note_category", "TEXT")
	query:PrimaryKey("note_id")
	query:Execute()

end

function PLUGIN:RefreshVortessence(client, lastSelected)
	PLUGIN:GetVortessenceUpdates(client, lastSelected)
end

function PLUGIN:SaveData()
	ix.data.Set("VortigauntAgenda", PLUGIN.conterminousAgendaMessage)
end

function PLUGIN:LoadData()
	PLUGIN.conterminousAgendaMessage = ix.data.Get("VortigauntAgenda") or "The Vortigaunt is silent."
end

function PLUGIN:GetVortessenceUpdates(client, lastSelected)
	if (!client:IsVortigaunt() and !CAMI.PlayerHasAccess(client, "Helix - Manage Vortessence Menu")) then
		return false
	end

	local query = mysql:Select("ix_vortessence")
	query:Select("note_id")
	query:Select("note_title")
	query:Select("note_text")
	query:Select("note_date")
	query:Select("note_poster")
	query:Select("note_category")
	query:Callback(function(result)
		if (!istable(result)) then
			self:OpenVortessenceMenu(client)
			return
		end

		if (!table.IsEmpty(PLUGIN.vortnotes)) then
			table.Empty(PLUGIN.vortnotes)
		end

		PLUGIN.vortnotes = result
		self:OpenVortessenceMenu(client, lastSelected)
	end)

	query:Execute()
end

function PLUGIN:PlayerSay(sender, text)
    local allowedTypes = {"/vort", "/wvort", "/yvort", "/r", "/radio", "/w", "/y", "/xen", "/wxen", "/yxen"}
    local anyAllowedTypeFound = false

    if (text[1] == "/") then
        for _, atype in ipairs(allowedTypes) do
            if (string.sub(text, 1, #atype + 1) == atype .. " ") then
                text = string.sub(text, #atype + 2)

                anyAllowedTypeFound = true

                break
            end
        end

        if (!anyAllowedTypeFound) then
            return
        end
    elseif (text[1] == "!" or text[1] == "@" or string.sub(text, 1, 3) == ".//") then
        return
    end

    for _, v in ipairs(player.GetAll()) do
        if (IsValid(v) and ix.option.Get(v, "conterminousSay", false)) then
            local character = v:GetCharacter()

            if (v != sender and v:IsVortigaunt() and character:GetConterminous()) then
                ix.chat.Send(sender, "conterminity", text)
            end
        end
    end
end

function PLUGIN:CreateVortalTimer(client, character, uniqueID)
	timer.Create(uniqueID, ix.config.Get("vortalEnergyTickTime", 1), 0, function()
		if (IsValid(client)) then
			PLUGIN:HandleVortalTimer(client, character)
		else
			timer.Remove(uniqueID)
		end
	end)
end

function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
	if client:GetNetVar("ixVortMeditation") then
		client:SetNetVar("ixVortMeditation", nil)
		client:StopParticles()
	end

	if client:GetNetVar("ixVortExtract") then
		client:SetNetVar("ixVortExtract", nil)
	end

	local uniqueID = "ixVortalEnergy" .. client:SteamID64()
	if (timer.Exists(uniqueID)) then
		timer.Remove(uniqueID)
	end
	if !character:IsVortigaunt() and client.ixNextVortalEnergy then
		client.ixNextVortalEnergy = nil
		return
	elseif !character:IsVortigaunt() then
		return
	end
	client.ixNextVortalEnergy = CurTime()
	PLUGIN:CreateVortalTimer(client, character, uniqueID)
end

function PLUGIN:HandleVortalTimer(client, character)
	if CurTime() > client.ixNextVortalEnergy then
		client.ixNextVortalEnergy = CurTime() + PLUGIN.passiveVortalEnergyTime
		character:AddVortalEnergy(PLUGIN.passiveVortalEnergyIncome)
	end
end

function PLUGIN:OnNPCKilled(npc, attacker, inflictor)
	if !attacker:IsPlayer() then return end
	if attacker.IsVortigaunt and !attacker:IsVortigaunt() then return end
	if npc:GetClass() == "npc_antlion" or npc:GetClass() == "npc_antlion_schizo_fireant" or npc:GetClass() == "npc_antlion_schizo_drone" or npc:GetClass() == "npc_antlion_schizo_soldier" then
		local character = attacker:GetCharacter()
		character:AddVortalEnergy(PLUGIN.vortalEnergyPerAntlion)
		attacker:ScreenFade(SCREENFADE.IN, Color(38, 106, 46, 128), 1, 1)
	end
end

function PLUGIN:ExtractConsume(client, character)
	if client:GetNetVar("ixVortExtract") or timer.Exists("ixVortigauntExtract" .. client:SteamID64()) then return end
	local overpoweredVorts = {}
	local eff = EffectData()
	eff:SetOrigin(client:GetPos())
	util.Effect("extract_use", eff)
	client:EmitSound("ambience/3d-sounds/xen-vorts/vort_09.mp3", 120)
	client:SetSkin(1)
	client:ForceSequence("eat_nectar", function()
		client:EmitSound("ambience/3d-sounds/xen-vorts/vort_06.mp3", 120)
		for _, vort in pairs(ents.FindInSphere(client:GetPos(), 500)) do
			if vort:IsPlayer() and vort:IsVortigaunt() and !vort:GetNetVar("ixVortNulled") then
				vort:SetSkin(1)
				vort:AddVortalEnergy(ix.config.Get("maxVortalEnergy", 100))
				vort:SetNetVar("ixVortExtract", true)
				vort:ScreenFade(SCREENFADE.IN, Color(140, 0, 183, 128), 1, 1)
				overpoweredVorts[#overpoweredVorts + 1] = vort
			end
		end
		timer.Create("ixVortigauntExtract" .. client:SteamID64(), ix.config.Get("extractEffectDuration"), 1, function()
			for _, vort in pairs(overpoweredVorts) do
				if vort:IsVortigaunt() then
					vort:SetSkin(vort:GetCharacter():GetData("skin", 0))
					vort:SetNetVar("ixVortExtract", nil)
				end
			end
		end)
	end, nil, nil)
end

function PLUGIN:HandlePlayerKill(client, vort)
	vort:ScreenFade(SCREENFADE.IN, Color(38, 106, 46, 128), 1, 1)
	vort:AddVortalEnergy(PLUGIN.vortalEnergyPerPlayer)
end

function PLUGIN:EnterVortalMeditation(client)
	local character = client:GetCharacter()
	client:SelectWeapon("ix_hands")
	client:SetNetVar("ixVortMeditation", true)
	client:SetRunSpeed(1)
	client:SetWalkSpeed(1)
	client:SetJumpPower(1)
	ParticleEffectAttach("vort_meditation", PATTACH_ABSORIGIN_FOLLOW, client, 0)
	client:EmitSound("ambience/3d-sounds/xen-vorts/vort_0" .. math.random(1, 5) .. ".mp3")
	local uniqueID = "ixMeditation" .. client:SteamID64()
	timer.Create(uniqueID, 60, 0, function()
		if !IsValid(client) or !client:IsVortigaunt() or !client:GetNetVar("ixVortMeditation") then
			if IsValid(client) then
				client:SetNetVar("ixVortMeditation", nil)
			end
			timer.Remove(uniqueID)
			return
		end
		local percentage = ix.config.Get("maxVortalEnergy") / 100
		local randSound = math.random(1, 10)
		client:EmitSound(randSound <= 9 and "ambience/3d-sounds/xen-vorts/vort_0" .. randSound .. ".mp3" or "ambience/3d-sounds/xen-vorts/vort_" .. randSound .. ".mp3")
		client:ScreenFade(SCREENFADE.IN, Color(38, 106, 46, 128), 1, 1)
		character:AddVortalEnergy(character:GetSkillLevel("vort") != 50 and (percentage * ix.config.Get("maxVortEnergyPerMinuteOfDefaultMeditation", 10)) or (percentage * ix.config.Get("maxVortEnergyPerMinuteOfAdvancedMeditation", 30)))
	end)
end

function PLUGIN:ExitVortalMeditation(client)
	client:SetNetVar("ixVortMeditation", nil)
	client:SetRunSpeed(ix.config.Get("runSpeed") * 1.25)
	client:SetWalkSpeed(ix.config.Get("walkSpeed"))
	client:SetJumpPower(250)
	client:StopParticles()
end

function PLUGIN:PlayerSwitchWeapon( client, oldWeapon, newWeapon )
	if client:GetNetVar("ixVortMeditation") then
		return true
	end
end

function PLUGIN:OpenVortessenceMenu(client, lastSelected)
	if client:IsVortigaunt() or CAMI.PlayerHasAccess(client, "Helix - Manage Vortessence Menu") then
		local count = table.Count(self.vortnotes)
		local send = 1
		for k, v in pairs(self.vortnotes) do
			if (send % PLUGIN.BATCH == 1) then
				if (send > 1) then
					net.Send(client)
				end
				net.Start("ixVortNotes")
				net.WriteUInt(count, 32)
				net.WriteUInt(send, 32)
			end
			net.WriteUInt(k, 32)
			net.WriteTable(v)
			send = send + 1
		end

		net.WriteUInt(lastSelected or 0, 32)
		net.Send(client)
	end
end

function PLUGIN:PlayerDisconnected(client)
	for _, v in pairs(ents.FindByClass("ix_nvlight")) do
		if (v:GetOwner() == client) then
			v:Remove()
		end
	end
end

netstream.Hook("conterminousSetState", function(ply, characterName, bool)
	local targetPlayer = ix.util.FindPlayer(characterName)
	local targetCharacter = targetPlayer:GetCharacter()

	if (!CAMI.PlayerHasAccess(ply, "Helix - Set Vortigaunt Conterminous", nil)) then
		return
	end

	if (IsValid(targetPlayer) and !targetCharacter:IsVortigaunt()) then
		ply:Notify("There character you are targeting is not a Vortigaunt!")

		return
	end

	targetCharacter:SetConterminous(bool)

	ix.log.AddRaw(ply:Name() .. " has set conterminous state for " .. targetCharacter:GetName() .. " to " .. tostring(bool))
end)

netstream.Hook("AddNoteVortessence", function(client, title, text, category)
	if !client:IsVortigaunt() then client:NotifyLocalized("You are not a vortigaunt!") return false end

	local timestamp = os.date( "%d.%m.%Y" )
	local queryObj = mysql:Insert("ix_vortessence")
		queryObj:Insert("note_title", title)
		queryObj:Insert("note_text", text)
		queryObj:Insert("note_date", timestamp)
		queryObj:Insert("note_poster", client:Name())
		queryObj:Insert("note_category", category)
	queryObj:Execute()

	PLUGIN:RefreshVortessence(client, category)
	client:NotifyLocalized("You have added a note!")
	ix.log.Add(client, "vortessenceEntry", "added a vortessence entry")
	client:GetCharacter():DoAction("vort_beam_practice")
end)

netstream.Hook("RemoveNoteVortessence", function(client, id, category)
	if !CAMI.PlayerHasAccess(client, "Helix - Manage Vortessence Menu") then return end
	local queryObj = mysql:Delete("ix_vortessence")
		queryObj:Where("note_id", id)
	queryObj:Execute()

	PLUGIN:RefreshVortessence(client, category)
	ix.log.Add(client, "vortessenceEntry", "removed a vortessence entry")
end)

function PLUGIN:CharacterRecognized(client, recogCharID, targets)
	local fakeName = client:GetCharacter():GetFakeName()

	for _, v in ipairs(targets) do
		if v:IsVortigaunt() then
			local vortrecognition = ix.data.Get("vortrecog", {}, false, true)

			if vortrecognition[recogCharID] == true then
				break
			end

			if (fakeName and fakeName != "") then
				vortrecognition[recogCharID] = fakeName
			else
				vortrecognition[recogCharID] = true
			end

			ix.data.Set("vortrecog", vortrecognition, false, true)
			break
		end
	end
end

function PLUGIN:PostPlayerLoadout(client)
	local background = client:GetCharacter():GetBackground()
	local character = client:GetCharacter()

	if (background == "Liberated" or background == "Free") then
		timer.Simple(1, function()
			if client then
				client:Give("ix_vortsweep")
				client:Give("ix_nightvision")
				client:Give("ix_vortbeam")
				client:Give("ix_vortheal")
				client:Give("ix_vshield")
				client:Give("ix_vortslam")
				if character:GetSkillLevel("vort") >= 50 then
					client:Give("ix_vortpyro")
					client:Give("ix_vortadvancedbeam")
				end
				if character:GetSkillLevel("vort") >= 30 and character:GetSkillLevel("melee") >= 30 then
					client:Give("ix_vmelee")
				end
			end
		end)
	end

	if background == "Biotic" then
		timer.Simple(1, function()
			if client then
				client:Give("ix_vortsweep")
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
end

function PLUGIN:FirefightTurnStart(fight, fightInfo)
	if (fightInfo.bVortShotLastTurn) then
		fightInfo.turn.bNoVortShoot = true
		fightInfo.bVortShotLastTurn = nil
	end
end

local runSounds = {[0] = "NPC_Vortigaunt.FootstepLeft", [1] = "NPC_Vortigaunt.FootstepRight"}
function PLUGIN:PlayerFootstep(client, position, foot, soundName, volume)
	if (client:IsVortigaunt()) then
		client:EmitSound(runSounds[foot])
		return true
	end
end

function PLUGIN:CanButcherWithoutTool(client, entity, drop)
	if (IsValid(client) and client:IsPlayer() and client:IsVortigaunt()) then
		local weapon = client:GetActiveWeapon()

		if (IsValid(weapon) and weapon:GetClass() == "ix_hands") then
			return true
		end
	end
end

ix.log.AddType("vortessenceEntry", function(client, name)
    return string.format("%s just %s in the vortessence menu.", client:SteamName(), name)
end)

function PLUGIN:OnPlayerObserve(client, state)
	local broom = client.broomModel

	if (broom and IsValid(broom)) then
		if (state) then
			broom:SetNoDraw(true)
		else
			broom:SetNoDraw(false)
		end
	end
end

-- CID GENERATION BY GRASS, IMPLEMENTED FOR VORT SHACKLES!!!
local prime = 99787 -- prime % 4 = 3! DO NOT CHANGE EVER
local offset = 320 -- slightly larger than sqrt(prime) is ok. DO NOT CHANGE EVER
local block = 1000
function PLUGIN:GenerateCollarID(id)
	id = (id + offset) % prime

	local cid = 0

	local randomness = math.random(1, 1000)

	for _ = 1, math.floor(id/block) do
		cid = (cid + (id * block) % prime) % prime
	end

	cid = (cid + (id * (id % block) % prime)) % prime

	if (2 * id < prime) then
		return Schema:ZeroNumber(cid - randomness, 5)
	else
		return Schema:ZeroNumber(prime - cid - randomness, 5)
	end
end