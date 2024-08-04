--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN;

PLUGIN.name = "ArcCW Base";
PLUGIN.description = "Adds compatibility with ArcCW, integrating the weapons and attachments with helix items. Also links ArcCW SWEPs spread, recoil and sway to characters \"gun\" skill.";
PLUGIN.author = "Gr4Ss & LegAz";

if (!ArcCW) then return end

PLUGIN.attachmentTranslate = {}

for k, v in pairs(ArcCW.AttachmentTable) do
    local ITEM = ix.item.Register(k, nil, false, nil, true)
    ITEM.name = v.PrintName
    ITEM.category = "Attachment"
    ITEM.model = "models/props_lab/box01a.mdl"
    ITEM.description = "A box containing a "..v.PrintName.." attachment."
end

ix.util.Include("sh_config.lua") -- moving config into another plugin just for visuals @offlegaz
ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")

ix.config.Add("forceUseMagazineSystem", true, "Should magazines be mandatory for item weapons, or is it OK to fall back to the Source ammo pool?", nil, {
	category = "general",
})

if (CLIENT) then
	function ArcCW:PlayerTakeAtt(ply, att, amt) end

	function ArcCW:PlayerGiveAtt(ply, att, amt) end
end

ix.config.Add("shootDbLevelReduction", 0, "How many DB to reduce the ARCCW sound levels by (this effects how far away it can be heard).", nil, {
	data = {min = 1, max = 50, decimals = 1},
	category = "general"
})

ix.config.Add("shootOtherDbLevelReduction", 50, "How many DB to reduce the ARCCW sound levels by (non gunshot sound effects).", nil, {
	data = {min = 1, max = 100, decimals = 1},
	category = "general"
})

ix.config.Add("shootOtherVolumeLevelReduction", 0.5, "How much to reduce the ARCCW sound levels by (non gunshot sound effects).", nil, {
	data = {min = 0, max = 1, decimals = 3},
	category = "general"
})

ix.config.Add("shootDbLevelReductionClose", 50, "How many DB to reduce the ARCCW sound levels by (this effects how far away close sounds can be heard).", nil, {
	data = {min = 1, max = 100, decimals = 1},
	category = "general"
})

ix.config.Add("shootVolumeReduction", 0, "How much to reduce the ARCCW sound levels by (this effects how far loud it is).", nil, {
	data = {min = 0, max = 1, decimals = 3},
	category = "general"
})

ix.config.Add("shootSoundDSP", 2, "Which DSP preset to use for close sounds (don't change this unless you know what you're doing!)", nil, {
	data = {min = 0, max = 140, decimals = 0},
	category = "general"
})

ix.config.Add("shootSoundDSPDistant", 31, "Which DSP preset to use for distant sounds (don't change this unless you know what you're doing!)", nil, {
	data = {min = 0, max = 140, decimals = 0},
	category = "general"
})

ix.config.Add("burnTime", 3, "How long someone should be ignited for after they've been lit up by an incendiary grenade", nil, {
	data = {min = 0, max = 60, decimals = 1},
	category = "general"
})

ix.config.Add("shotsBeforeBreakingWeapon", 900, "How many shots can single weapon handle without breaking", nil, {
	data = {min = 0, max = 9999},
	category = "general"
})

function PLUGIN:CanPlayerEquipItem(client, item)
	if (item.isWeapon and item:GetData("broken", false)) then
		return false
	end
end

--[[
	sound overrides for ArcCW
]]

local sndTbl = {} -- a table which we can use to queue up sounds asynchronously
local function networkAllPendingArcSounds()
	while true do
		for i, snd in ipairs(sndTbl) do
			if !snd.ent or !IsValid(snd.ent) then
				continue
			end

			if (!snd.filter) then
				snd.ent:EmitSound(snd.fsound, snd.lvl, 100, snd.vol, CHAN_STATIC, SND_NOFLAGS,
					snd.useDSP and snd.dsp or 0)
			else
				local _snd = CreateSound(snd.ent, snd.fsound, snd.filter)
				_snd:SetSoundLevel(snd.lvl)
				if (snd.useDSP) then
					_snd:SetDSP(snd.dsp or 0)
				end
				_snd:PlayEx(snd.vol, 255)
			end

			table.remove(sndTbl, i)
		end

		coroutine.yield()
	end
end

local function insertArcSound(ent, fsound, filter, lvl, vol, dsp, useDSP)
	sndTbl[#sndTbl + 1] = {
		ent = ent,
		fsound = fsound,
		filter = filter,
		lvl = lvl,
		vol = vol,
		dsp = dsp,
		useDSP = useDSP
	}
end

local sndCO = coroutine.create(networkAllPendingArcSounds)

if (SERVER) then
	timer.Create("ixNetworkArcCWSounds", 0.1, 0, function()
		-- gun sounds are kind of low-priority. improves S2K performance if we don't block the main thread with them
		if (!sndCO or !coroutine.resume(sndCO)) then
			-- there is something wrong with the table.Add
			ErrorNoHalt("ArcCW sound coroutine failed to resume. Attempting to recreate coroutine.\n")
			sndTbl = {}
			sndCO = coroutine.create(networkAllPendingArcSounds)
		end
	end)
end

local function isShootSound(ent, fsound)
	if (fsound == ent.ShootSound or fsound == ent.ShootSoundSilenced or fsound == ent.DistantShootSound) then
		return true
	end

	return false
end

timer.Simple(1, function()
	local tbl = weapons.GetStored("arccw_base") -- baller way of shoving our own shit code into arccw

	-- ^^ make sure we're the last to load so the override actually works
	function tbl:MyEmitSound(fsound, level, pitch, _vol, chan, useWorld)
		if !fsound then return end

		fsound = self:GetBuff_Hook("Hook_TranslateSound", fsound) or fsound
		local client = self:GetOwner()
		local weapon = client:GetActiveWeapon()
		local useDSP = isShootSound(weapon, fsound) -- don't play DSP on reloading and equipping sfx
		if istable(fsound) then fsound = self:TableRandom(fsound) end

		if fsound and fsound != "" then
			local lvl = math.Clamp(level or 150 - ix.config.Get("shootDbLevelReductionClose", 10), 60, 160)
			local vol = _vol or 1 - ix.config.Get("shootVolumeReduction", 0.1)
			local dsp = ix.config.Get("shootSoundDSP", 2)

			local lvl2 = math.Clamp(level or 150 - ix.config.Get("shootDbLevelReduction", 60), 60, 160)
			local vol2 = math.Clamp(_vol or 1 - ix.config.Get("shootVolumeReduction", 0.1) - 0.1, 0, 1)
			local dsp2 = ix.config.Get("shootSoundDSPDistant", 31)

			if (!useDSP) then
				lvl = math.Clamp(lvl - ix.config.Get("shootOtherDbLevelReduction", 50), 60, 160)
				vol = vol - ix.config.Get("shootOtherVolumeLevelReduction", 0.1)
			end

			if (CLIENT and client == LocalPlayer()) then
				-- client plays their own sound
				-- nevermind, we can't do this because i can't use CRecipientFilters to filter out the client serverside
				-- nevermind, apparently they don't duplicate any more ?????????????
				-- TODO: reimplement when that feature makes it to main gmod branch
				weapon:EmitSound(fsound, level, pitch, vol, chan or CHAN_STATIC)

			elseif (client and SERVER) then
				-- filter for distant sounding gunshots
				if (useDSP) then
					local filter = RecipientFilter()
					filter:AddAllPlayers()
					filter:RemovePlayer(client)
					filter:RemovePVS(client:GetPos())

					insertArcSound(weapon, fsound, filter, lvl2, vol2, dsp2, true)
				end

				weapon:EmitSound(fsound, lvl, 100, vol, CHAN_STATIC, SND_NOFLAGS, dsp)
			end
		end
	end
end)

function ArcCW:PlayerGetAtts(client, attachment)
    if (!IsValid(client)) then return 0 end
    if (GetConVar("arccw_attinv_free"):GetBool()) then return 999 end

    if (attachment == "") then return 999 end

    local attachmentData = ArcCW.AttachmentTable[attachment]
    if (!attachmentData) then return 0 end
    if (attachmentData.Free) then return 999 end

	local character = client:GetCharacter()
	if (!character) then return 0 end

    if (!client:IsAdmin() and attachmentData.AdminOnly) then
        return 0
    end

    if (attachmentData.InvAtt) then
		attachment = attachmentData.InvAtt
	end

	local weapon = client:GetActiveWeapon()
	if (SERVER and client.ixAttachAttempt and
		client.ixAttachAttempt.attachment == attachment and
		client.ixAttachAttempt.time + 1 > CurTime()) then
		weapon = client.ixAttachAttempt.weapon
	end

	local amount = character:GetInventory():GetItemCount(PLUGIN.attachmentTranslate[attachment] or attachment)
	for _, v in ipairs(weapon:GetNetVar("ixItemDefaultWeaponAtts", {})) do
		if (v == attachment) then amount = amount + 1 end
	end

	if (SERVER and weapon.ixItem) then
		for _, v in pairs(weapon.ixItem:GetData("WeaponAttachments", {})) do
			if (v.attachment == attachment) then
				amount = amount + 1
				break
			end
		end
	elseif (CLIENT and weapon:GetNetVar("ixItemID")) then
		local item = ix.item.instances[weapon:GetNetVar("ixItemID")]
		if (item) then
			for _, v in pairs(item:GetData("WeaponAttachments", {})) do
				if (v.attachment == attachment) then
					amount = amount + 1
					break
				end
			end
		end
	end

    return amount
end

function PLUGIN:ArcCW_PlayerCanAttach(client, weapon, attachment, slot, detach)
	client.ixAttachAttempt = nil
	client.ixDeattachAttempt = nil

	if (detach) then
		client.ixDeattachAttempt = {
			weapon = weapon,
			attachment = attachment,
			slot = slot
		}
		return
	end
	if (attachment == "") then return end

	local weapon2 = client.ixAttachWeapon or client:GetActiveWeapon()
	if (weapon2 != weapon) then return end

	client.ixAttachAttempt = {
		weapon = weapon,
		attachment = attachment,
		slot = slot,
		time = CurTime()
	}
	for _, v in ipairs(weapon:GetNetVar("ixItemDefaultWeaponAtts", {})) do
		if (v == attachment) then
			client.ixAttachAttempt.mode = "default"
			return true
		end
	end

	if (weapon.ixItem) then
		for _, v in pairs(weapon.ixItem:GetData("WeaponAttachments", {})) do
			if (v.attachment == attachment) then
				client.ixAttachAttempt.mode = "reattach"
				return true
			end
		end
	end

	local character = client:GetCharacter()
	if (character) then
		local inventory = character:GetInventory()
		if (self.attachmentTranslate[attachment]) then
			if (!inventory:HasItem(self.attachmentTranslate[attachment])) then
				return false
			end
		elseif (!inventory:HasItem(attachment)) then
			return false
		end
	end

	client.ixAttachAttempt.mode = "item"
	return true
end

-- Give one ammo otherwise ArcCW doesn't let us reload
function PLUGIN:KeyPress(client, key)
	if (key == IN_RELOAD) then
		local weapon = client:GetActiveWeapon()
		if (IsValid(weapon) and	weapon:GetNetVar("ixItemID") and client:GetAmmoCount(weapon:GetPrimaryAmmoType()) == 0) then
			if (client.ixPreReloadAmmoGiven) then
				-- We still have 1 ammo from some previous attempt, lets remove this first!
				client:SetAmmo(math.max(client:GetAmmoCount(client.ixPreReloadAmmoGiven) - 1, 0), client.ixPreReloadAmmoGiven)
			end
			client:SetAmmo(1, weapon:GetPrimaryAmmoType())
			client.ixPreReloadAmmoGiven = weapon:GetPrimaryAmmoType()
		end
	end
end

-- Take the ammo again if it wasn't used
function PLUGIN:KeyRelease(client, key)
	if (client.ixPreReloadAmmoGiven) then
		client:SetAmmo(client:GetAmmoCount(client.ixPreReloadAmmoGiven) - 1, client.ixPreReloadAmmoGiven)
		client.ixPreReloadAmmoGiven = nil
	end
end

function PLUGIN:PlayerSwitchWeapon(client, oldWeapon, newWeapon)
	if (client.ixPreReloadAmmoGiven) then
		client:SetAmmo(client:GetAmmoCount(client.ixPreReloadAmmoGiven) - 1, client.ixPreReloadAmmoGiven)
		client.ixPreReloadAmmoGiven = nil
	end
end

local sortFunc = function(a, b)
	local aAmmo, bAmmo = a:GetAmmo(), b:GetAmmo()
	if (aAmmo != bAmmo) then
		return aAmmo > bAmmo
	else
		return a:GetID() > b:GetID()
	end
end

function PLUGIN:Hook_PreReload(weapon)
	local client = weapon:GetOwner()
	if (!IsValid(client) or client:IsNPC()) then return end

	-- Take the 1 ammo given to let us get past the 'not zero ammo' check that happens before this hook
	if (client.ixPreReloadAmmoGiven) then
		client:SetAmmo(client:GetAmmoCount(client.ixPreReloadAmmoGiven) - 1, client.ixPreReloadAmmoGiven)
		client.ixPreReloadAmmoGiven = nil
	end

	local character = client:GetCharacter()
	if (!character) then return end

	if (weapon:GetNetVar("ixItemID") == nil) then return end

	local itemID = weapon:GetNetVar("ixItemID")
	local item = ix.item.instances[itemID]
	if (!item) then return end

	local ammoID = weapon:GetPrimaryAmmoType()
	local ammoName = string.lower(game.GetAmmoName(ammoID) or "")
	if (ammoName == "") then return end

	local ammoItems = {}
	for k, v in ipairs(character:GetInventory():GetItemsByBase("base_arccwmag")) do
		if (item.magazines and item.magazines[v.uniqueID] and v:GetAmmo() > 0) then
			ammoItems[#ammoItems + 1] = v
		end
	end

	table.sort(ammoItems, sortFunc)

	local ammoItem = ammoItems[1]
	if (!ammoItem) then return ix.config.Get("forceUseMagazineSystem") end

	local chamber = math.Clamp(weapon:Clip1(), 0, weapon:GetChamberSize())
	if (SERVER) then
		if (weapon.ixItem:GetData("reloadMagazineItem")) then
			self:RefundAmmoItem(weapon, character, weapon.ixItem:GetData("reloadMagazineItem"), weapon:Clip1() + client:GetAmmoCount(ammoID) - chamber, weapon.ixItem:GetData("reloadMagazineInvPos"))
			weapon:SetClip1(chamber)
		end
		weapon.ixItem:SetData("reloadMagazineItem", ammoItem:GetID())
		weapon.ixItem:SetData("reloadMagazineInvPos", {ammoItem.invID, ammoItem.gridX, ammoItem.gridY})
		ammoItem:Transfer(nil, nil, nil, client, nil, true)
	end

	client:SetAmmo(ammoItem:GetAmmo(), ammoID)
end

function PLUGIN:Hook_ModDispersion(weapon, hip)
	local weaponOwner = weapon:GetOwner()

	if (weaponOwner:IsPlayer()) then
		weaponOwner = weaponOwner:GetCharacter()
	else
		return
	end

	local skillLevel = weaponOwner:GetSkillLevel("guns")
	local minSkillLevel, maxSkillLevel = ix.weapons:GetWeaponSkillRequired(weapon:GetClass())

	if (skillLevel < minSkillLevel) then
		return hip + math.ceil(hip * self.spreadMaxIncrease) * (1 - skillLevel / minSkillLevel)
	end

	skillLevel = math.min(skillLevel, maxSkillLevel)
	return hip - math.floor(hip * self.spreadMaxDecrease) * ((skillLevel - minSkillLevel) / (maxSkillLevel - minSkillLevel))
end

function PLUGIN:Hook_ModifyRecoil(weapon, rec)
	local weaponOwner = weapon:GetOwner()

	if (weaponOwner:IsPlayer()) then
		weaponOwner = weaponOwner:GetCharacter()
	else
		return
	end

	local skillLevel = weaponOwner:GetSkillLevel("guns")
	local minSkillLevel, maxSkillLevel = ix.weapons:GetWeaponSkillRequired(weapon:GetClass())
	local modifier

	if (skillLevel < minSkillLevel) then
		modifier = PLUGIN.recoilMaxIncrease * (1 - skillLevel / minSkillLevel)
	else
		skillLevel = math.min(skillLevel, maxSkillLevel)
		modifier = -(PLUGIN.recoilMaxDecrease * ((skillLevel - minSkillLevel) / (maxSkillLevel - minSkillLevel)))
	end

	rec.Recoil = rec.Recoil + (rec.Recoil * modifier)
	rec.RecoilSide = rec.RecoilSide + (rec.RecoilSide * modifier)
	-- rec.VisualRecoilMul = rec.VisualRecoilMul + (rec.VisualRecoilMul * modifier)

	return rec
end

function PLUGIN:O_Hook_Override_CanBash()
	return false
end
