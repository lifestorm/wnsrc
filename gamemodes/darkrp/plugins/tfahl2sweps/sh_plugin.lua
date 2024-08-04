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

PLUGIN.name = "TFA weapons and attachments";
PLUGIN.description = "Adds the weapons and attachments from that TFA mod.";
PLUGIN.author = "Fruity";

weapons.OnLoaded()

ix.util.Include("sh_atts.lua")
ix.util.Include("sv_plugin.lua")
ix.util.Include("sv_hooks.lua")

-- All grenade entities used on the server must be declared here
PLUGIN.grenades = {
	npc_grenade_frag = true,
	mmod_frag = true,
	tfa_rustalpha_flare_thrown = true,
	tfa_csgo_throwndecoy = true,
	tfa_csgo_thrownflash = true,
	tfa_csgo_thrownfrag = true,
	tfa_csgo_thrownincen = true,
	tfa_csgo_thrownmolotov = true,
	tfa_csgo_thrownsmoke = true,
	tfa_csgo_thrownsonar = true
}

hook.Remove("TFA_GetStat", "TFA_IronsightsConVarToggle")

local stunstick = weapons.GetStored("tfa_mmod_stunstick") or {}
stunstick.PrintName = "Stunstick"

function stunstick:OnRaised()
	self:GetOwner():EmitSound("Weapon_StunStick.Activate")
	self:GetOwner():ForceSequence("activatebaton", nil, nil, true)
end

function stunstick:OnLowered()
	self:GetOwner():EmitSound("Weapon_StunStick.Deactivate")
	self:GetOwner():ForceSequence("deactivatebaton", nil, nil, true)
end

local ar2 = weapons.GetStored("tfa_mmod_ar2") or {Primary = {}}
ar2.Primary.Ammo = "StriderMinigun"

if (CLIENT) then
	hook.Remove("HUDPaint", "tfaDrawHitmarker")

	function PLUGIN:TFA_PreCanPrimaryAttack(weapon)
		if (weapon:GetNetVar("BioLocked")) then
			return false
		end
	end

	function PLUGIN:TFA_SecondaryAttack(weapon)
		if (weapon:GetNetVar("BioLocked")) then
			return true -- signal we 'handled' the attack
		end
	end
end

function PLUGIN:TFA_PreCanAttach(weapon, attn)
	if (attn == "") then return end

	for _, v in ipairs(weapon:GetNetVar("ixItemAtts", {})) do
		if (v == attn) then return true end
	end

	if (weapon.ixItem) then
		for _, v in pairs(weapon.ixItem:GetData("tfa_atts", {})) do
			if (v.att == attn) then return true end
		end
	end

	local character = weapon.Owner:GetCharacter()
	if (character) then
		local inventory = character:GetInventory()
		if (self.attnTranslate[attn]) then
			if (!inventory:HasItem(self.attnTranslate[attn])) then
				return false
			end
		elseif (!inventory:HasItem(attn)) then
			return false
		end
	end
end

TFA.AddAmmo("csgo_decoy", "Decoy")
TFA.AddAmmo("csgo_frag", "Fragmentation Grenade")
TFA.AddAmmo("csgo_flash", "Flashbang")
TFA.AddAmmo("csgo_incend", "Incendiary Grenade")
TFA.AddAmmo("csgo_molly", "Molotov")
TFA.AddAmmo("csgo_smoke", "Smoke Grenade")
TFA.AddAmmo("csgo_sonarbomb", "Tactical Awareness Grenade")

local csgo_flashtime = 10
local csgo_flashfade = 4
local csgo_flashdistance = 2048
local csgo_flashdistancefade = 2048 - 1024

local tab = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = 0.0,
	["$pp_colour_contrast"] = 1.0,
	["$pp_colour_colour"] = 1.0,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}

function TFA_CSGO_FlashIntensity(ply)
	local flashtime = ply:GetNWFloat("TFACSGO_LastFlash", -999)
	local flashdistance = ply:GetNWFloat("TFACSGO_FlashDistance", 0)
	local flashfac = ply:GetNWFloat("TFACSGO_FlashFactor", 1)
	local distancefac = 1 - math.Clamp((flashdistance - csgo_flashdistance + csgo_flashdistancefade) / csgo_flashdistancefade, 0, 1)
	local intensity = 1 - math.Clamp(((CurTime() - flashtime) / distancefac - csgo_flashtime + csgo_flashfade) / csgo_flashfade, 0, 1)
	intensity = intensity * distancefac
	intensity = intensity * math.Clamp(flashfac + 0.1, 0.35, 1)

	return intensity
end

if (CLIENT) then
	hook.Add("RenderScreenspaceEffects", "TFA_CSGO_FLASHBANG", function()
		local client = LocalPlayer()
		if (!IsValid(client)) then return end
		local intensity = TFA_CSGO_FlashIntensity(client)

		if (intensity > 0.01) then
			tab["$pp_colour_brightness"] = math.pow(intensity, 3)
			tab["$pp_colour_colour"] = 1 - intensity * 0.33
			DrawColorModify(tab) --Draws Color Modify effect
			DrawMotionBlur(0.2, intensity, 0.03)
		end
	end)
end

function CSGOSmokeBlind()
	local ply = LocalPlayer()

	local IsInSmoke = false

	local SmokeAmount = 0

	for k,v in pairs(ents.FindByClass("tfa_csgo_thrownsmoke")) do
		local Distance = ply:GetPos():Distance(v:GetPos())
		if Distance <= 144 and v:GetNWBool("IsDetonated",false) then
			IsInSmoke = true
			SmokeAmount = SmokeAmount + (144 - Distance)*2
		end
	end

	if IsInSmoke then
		local ModAmount = math.Clamp(SmokeAmount / 100,0,1)
		local smokeMat = Material( "tfa_csgo/particle/particle_smokegrenade_view" )

		surface.SetDrawColor( Color(99, 99, 99,ModAmount*255) )
		surface.SetMaterial( smokeMat )
		surface.DrawRect( 0, 0, ScrW(), ScrH() )

	end
end
hook.Add("RenderScreenspaceEffects","CSGOSmokeBlind",CSGOSmokeBlind)

TFA.CSGO = TFA.CSGO or {}
TFA.CSGO.HandsTbl = TFA.CSGO.HandsTbl or {}

function TFA.CSGO.AddHandsModel(id, mdl, name)
	assert(type(id) == "string", "Invalid hands variant ID specified: " .. tostring(id))
	assert(type(mdl) == "string", "Invalid hands model path specified: " .. tostring(mdl))

	if (!file.Exists(mdl, "GAME")) then
		print("[TFA CS:GO] Unable to add hands with id " .. id .. ", model " .. mdl .. " not found.")

		return
	end

	TFA.CSGO.HandsTbl[id] = {}
	TFA.CSGO.HandsTbl[id].mdl = mdl
	TFA.CSGO.HandsTbl[id].name = type(name) == "string" and name or "#tfa_csgo_hands_" .. id
end

if (SERVER) then return end

local cv_hands = CreateClientConVar("cl_tfa_csgo_hands_override", "none", true, false)

if IsValid(TFA.CSGO.HandsEnt) then
	TFA.CSGO.HandsEnt:Remove()
	TFA.CSGO.HandsEnt = nil
end

local handsFallback = "models/weapons/tfa_csgo/c_hands_translator.mdl"
local handsOverride, handsID, handsMDL = false, "", ""

function TFA.CSGO.ParentHands(hands, vm, ply, wep)
	if (!IsValid(hands) or !IsValid(vm) or !IsValid(wep)) then
		if IsValid(TFA.CSGO.HandsEnt) then
			TFA.CSGO.HandsEnt:RemoveEffects(EF_BONEMERGE)
			TFA.CSGO.HandsEnt:RemoveEffects(EF_BONEMERGE_FASTCULL)
			TFA.CSGO.HandsEnt:SetParent(NULL)

			TFA.CSGO.HandsEnt:Remove()
		end

		return
	end

	if (!wep.IsTFAWeapon or !wep.IsTFACSGOWeapon) then return end

	handsID = cv_hands:GetString()
	handsOverride = handsID ~= "none" and TFA.CSGO.HandsTbl[handsID]

	handsMDL = handsOverride and TFA.CSGO.HandsTbl[handsID].mdl or handsFallback

	if (!IsValid(TFA.CSGO.HandsEnt)) then
		TFA.CSGO.HandsEnt = ClientsideModel(handsMDL)

		TFA.CSGO.HandsEnt:SetupBones()
		TFA.CSGO.HandsEnt:SetNoDraw(true)
	elseif (TFA.CSGO.HandsEnt:GetModel() ~= handsMDL) then
		TFA.CSGO.HandsEnt:SetModel(handsMDL)
		TFA.CSGO.HandsEnt:SetupBones()
	end

	if (!vm:LookupBone("ValveBiped.Bip01_R_Hand")) then
		local newhands = TFA.CSGO.HandsEnt

		newhands:SetParent(vm)
		newhands:SetPos(vm:GetPos())
		newhands:SetAngles(vm:GetAngles())

		if (!newhands:IsEffectActive(EF_BONEMERGE)) then
			newhands:AddEffects(EF_BONEMERGE)
			newhands:AddEffects(EF_BONEMERGE_FASTCULL)
		end

		if handsOverride then
			newhands:DrawModel()
		else
			hands:SetParent(newhands)
		end
	end
end

hook.Add("PreDrawPlayerHands", "TFA_CSGO_PreDrawPlayerHands", TFA.CSGO.ParentHands)

do
	local CSGOParticleFiles = {}
	table.insert(CSGOParticleFiles, #CSGOParticleFiles, "cs_weapon_fx")
	table.insert(CSGOParticleFiles, #CSGOParticleFiles, "explosions_fx")
	table.insert(CSGOParticleFiles, #CSGOParticleFiles, "inferno_fx")

	local CSGOParticleEffects = {}
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "weapon_muzzle_smoke")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "weapon_muzzle_smoke_long")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "weapon_sensorgren_beeplight")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "weapon_sensorgren_detonate")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "weapon_decoy_ground_effect")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "weapon_decoy_ground_effect_shot")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "weapon_molotov_fp")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "weapon_molotov_thrown")
	--EXPLOSION_FX
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "explosion_basic")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "explosion_hegrenade_interior")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "explosion_hegrenade_brief")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "explosion_smoke_disperse")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "explosion_smokegrenade")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "explosion_smokegrenade_fallback")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "explosion_smokegrenade_CT")
	--INFERNO FX
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "molotov_explosion")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "molotov_fire01")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "molotov_groundfire")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "molotov_fire_main_gm")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "molotov_fire_child_gm")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "molotov_groundfire_00HIGH")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "molotov_groundfire_00MEDIUM")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "extinguish_fire")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "explosion_molotov_air")
	table.insert(CSGOParticleEffects, #CSGOParticleEffects, "incgrenade_thrown_trail")

	for k, v in pairs(CSGOParticleFiles) do
		game.AddParticles("particles/" .. v .. ".pcf")
	end

	for k, v in pairs(CSGOParticleEffects) do
		PrecacheParticleSystem(v)
	end
end

sound.Add(
{
	name = "csgo_Weapon.WeaponMove1",
	channel = CHAN_ITEM,
	level = 65,
	volume = 0.15,
	sound = "weapons/tfa_csgo/movement1.wav"
})

sound.Add(
{
	name = "csgo_Weapon.WeaponMove2",
	channel = CHAN_ITEM,
	level = 65,
	volume = 0.15,
	sound = "weapons/tfa_csgo/movement2.wav"
})

sound.Add(
{
	name = "csgo_Weapon.WeaponMove3",
	channel = CHAN_ITEM,
	level = 65,
	volume = 0.15,
	sound = "weapons/tfa_csgo/movement3.wav"
})
