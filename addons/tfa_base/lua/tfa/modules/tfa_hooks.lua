--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

TFA.INSPECTION_IMPULSE = 148
TFA.BASH_IMPULSE = 149
TFA.CYCLE_FIREMODE_IMPULSE = 150
TFA.CYCLE_SAFETY_IMPULSE = 151

TFA.INSPECTION_IMPULSE_STRING = "148"
TFA.BASH_IMPULSE_STRING = "149"
TFA.CYCLE_FIREMODE_IMPULSE_STRING = "150"
TFA.CYCLE_SAFETY_IMPULSE_STRING = "151"

local sp = game.SinglePlayer()
local CurTime = CurTime
local RealTime = RealTime

--[[
Hook: PlayerFootstep
Function: Weapon Logic
Used For: Walk Cycle
]]
hook.Add("PlayerFootstep", "TFAWalkcycle", function(plyv)
	if sp and SERVER then
		BroadcastLua("Entity(" .. plyv:EntIndex() .. ").lastFootstep = " .. CurTime())
	elseif IsValid(plyv) then
		plyv.lastFootstep = CurTime()
	end
end)

--[[
Hook: PlayerPostThink
Function: Weapon Logic
Used For: Main weapon "think" logic
]]
--
hook.Add("PlayerPostThink", "PlayerTickTFA", function(plyv)
	local wepv = plyv:GetActiveWeapon()

	if IsValid(wepv) and wepv.PlayerThink and wepv.IsTFAWeapon then
		wepv:PlayerThink(plyv, plyv.last_tfa_think == engine.TickCount())
		plyv.last_tfa_think = engine.TickCount()
	end
end)

if SERVER or not sp then
	hook.Add("FinishMove", "PlayerTickTFA", function(plyv)
		local wepv = plyv:GetActiveWeapon()

		if IsValid(wepv) and wepv.IsTFAWeapon and wepv.PlayerThink then
			wepv:PlayerThink(plyv, not IsFirstTimePredicted())
		end
	end)

	hook.Remove("PlayerPostThink", "PlayerTickTFA")
end

--[[
Hook: Think
Function: Weapon Logic for NPC
User For: Calling SWEP:Think for NPCs manually
]]
--
if SERVER then
	hook.Add("Think", "NPCTickTFA", function()
		hook.Run("TFA_NPCWeaponThink")
	end)
end

--[[
Hook: Tick
Function: Inspection mouse support
Used For: Enables and disables screen clicker
]]
--
if CLIENT then
	local tfablurintensity
	local its_old = 0
	local ScreenClicker = false
	local cl_tfa_inspect_hide = GetConVar("cl_tfa_inspect_hide")
	local cl_drawhud = GetConVar("cl_drawhud")

	hook.Add("Tick", "TFAInspectionScreenClicker", function()
		tfablurintensity = 0

		if LocalPlayer():IsValid() and LocalPlayer():GetActiveWeapon():IsValid() then
			local w = LocalPlayer():GetActiveWeapon()

			if w.IsTFAWeapon then
				tfablurintensity = w:GetCustomizing() and 1 or 0
			end
		end

		if tfablurintensity > its_old and not ScreenClicker and not cl_tfa_inspect_hide:GetBool() and cl_drawhud:GetBool() then
			gui.EnableScreenClicker(true)
			ScreenClicker = true
		elseif tfablurintensity < its_old and ScreenClicker then
			gui.EnableScreenClicker(false)
			ScreenClicker = false
		end

		its_old = tfablurintensity
	end)

	hook.Add("Think", "TFABase_PlayerThinkCL", function()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		local weapon = ply:GetActiveWeapon()

		if IsValid(weapon) and weapon.IsTFAWeapon then
			if weapon.PlayerThinkCL then
				weapon:PlayerThinkCL(ply)
			end

			if sp then
				net.Start("tfaSDLP", true)
				net.WriteBool(ply:ShouldDrawLocalPlayer())
				net.SendToServer()
			end
		end
	end)
end

--[[
Hook: AllowPlayerPickup
Function: Prop holding
Used For: Records last held object
]]
--
hook.Add("AllowPlayerPickup", "TFAPickupDisable", function(plyv, ent)
	plyv:SetNW2Entity("LastHeldEntity", ent)
end)

--[[
Hook: PlayerBindPress
Function: Intercept Keybinds
Used For:  Alternate attack, inspection, shotgun interrupts, and more
]]
--
local cv_cm = GetConVar("sv_tfa_cmenu")
local cv_cm_key = GetConVar("sv_tfa_cmenu_key")
local keyv

local function GetInspectionKey()
	if cv_cm_key and cv_cm_key:GetInt() >= 0 then
		keyv = cv_cm_key:GetInt()
	else
		keyv = TFA.BindToKey(input.LookupBinding("+menu_context", true) or "c", KEY_C)
	end

	return keyv
end

local function TFAContextBlock()
	local plyv = LocalPlayer()

	if not plyv:IsValid() or GetViewEntity() ~= plyv then return end

	if plyv:InVehicle() and not plyv:GetAllowWeaponsInVehicle() then return end

	local wepv = plyv:GetActiveWeapon()
	if not IsValid(wepv) then return end

	if plyv:GetInfoNum("cl_tfa_keys_customize", 0) > 0 then return end

	if GetInspectionKey() == TFA.BindToKey(input.LookupBinding("+menu_context", true) or "c", KEY_C) and wepv.ToggleInspect and cv_cm:GetBool() and not plyv:KeyDown(IN_USE) then return false end
end

hook.Add("ContextMenuOpen", "TFAContextBlock", TFAContextBlock)

if CLIENT then
	local kd_old = false

	local cl_tfa_keys_customize

	local function TFAKPThink()
		local plyv = LocalPlayer()
		if not plyv:IsValid() then return end
		local wepv = plyv:GetActiveWeapon()
		if not IsValid(wepv) then return end

		if not cl_tfa_keys_customize then
			cl_tfa_keys_customize = GetConVar("cl_tfa_keys_customize")
		end

		if cl_tfa_keys_customize:GetBool() then return end

		local key = GetInspectionKey()
		local kd = input.IsKeyDown(key)

		if IsValid(vgui.GetKeyboardFocus()) then
			kd = false
		end

		if kd ~= kd_old and kd and cv_cm:GetBool() and not plyv:KeyDown(IN_USE) then
			RunConsoleCommand("impulse", tostring(TFA.INSPECTION_IMPULSE))
		end

		kd_old = kd
	end

	hook.Add("Think", "TFAInspectionMenu", TFAKPThink)
end

local cv_lr = GetConVar("sv_tfa_reloads_legacy")
local reload_threshold = 0.3

local sv_cheats = GetConVar("sv_cheats")
local host_timescale = GetConVar("host_timescale")

local band = bit.band
local bxor = bit.bxor
local bnot = bit.bnot
local GetTimeScale = game.GetTimeScale
local IN_ATTACK2 = IN_ATTACK2
local IN_RELOAD = IN_RELOAD

local function FinishMove(ply, cmovedata)
	if ply:InVehicle() and not ply:GetAllowWeaponsInVehicle() then return end

	local wepv = ply:GetActiveWeapon()
	if not IsValid(wepv) or not wepv.IsTFAWeapon then return end

	wepv:TFAFinishMove(ply, cmovedata:GetVelocity(), cmovedata)

	local impulse = cmovedata:GetImpulseCommand()

	if impulse == TFA.INSPECTION_IMPULSE then
		wepv:ToggleInspect()
	elseif impulse == TFA.CYCLE_FIREMODE_IMPULSE and wepv:GetStatus() == TFA.Enum.STATUS_IDLE and wepv:GetStatL("SelectiveFire") then
		wepv:CycleFireMode()
	elseif impulse == TFA.CYCLE_SAFETY_IMPULSE and wepv:GetStatus() == TFA.Enum.STATUS_IDLE then
		wepv:CycleSafety()
	end

	local BashImpulse = cmovedata:GetImpulseCommand() == TFA.BASH_IMPULSE
	ply:TFA_SetZoomKeyDown(BashImpulse) -- this may or may not work

	if wepv.SetBashImpulse then
		wepv:SetBashImpulse(BashImpulse)
	end

	if cmovedata:GetImpulseCommand() == 100 and (wepv:GetStatL("FlashlightAttachmentName") ~= nil or wepv:GetStatL("FlashlightAttachment", 0) > 0) then
		wepv:ToggleFlashlight()
	end

	local lastButtons = wepv:GetDownButtons()
	local buttons = cmovedata:GetButtons()
	local stillPressed = band(lastButtons, buttons)
	local changed = bxor(lastButtons, buttons)
	local pressed = band(changed, bnot(lastButtons), buttons)
	local depressed = band(changed, lastButtons, bnot(buttons))

	wepv:SetDownButtons(buttons)
	wepv:SetLastPressedButtons(pressed)

	local time = CurTime()

	local cl_tfa_ironsights_toggle = (ply:GetInfoNum("cl_tfa_ironsights_toggle", 0) or 0) >= 1
	local cl_tfa_ironsights_resight = (ply:GetInfoNum("cl_tfa_ironsights_resight", 0) or 0) >= 1
	local cl_tfa_ironsights_responsive = (ply:GetInfoNum("cl_tfa_ironsights_responsive", 0) or 0) >= 1
	local cl_tfa_ironsights_responsive_timer = ply:GetInfoNum("cl_tfa_ironsights_responsive_timer", 0.175) or 0.175

	local scale_dividier = GetTimeScale() * (sv_cheats:GetBool() and host_timescale:GetFloat() or 1)

	if wepv:GetStatL("Secondary.IronSightsEnabled", false) and not wepv:IsSafety() then
		if band(changed, IN_ATTACK2) == IN_ATTACK2 then
			local deltaPress = (time - wepv:GetLastIronSightsPressed()) / scale_dividier

			-- pressing for first time
			if not wepv:GetIronSightsRaw() and band(pressed, IN_ATTACK2) == IN_ATTACK2 then
				wepv:SetIronSightsRaw(true)
				wepv:SetLastIronSightsPressed(time)
			elseif wepv:GetIronSightsRaw() and
				((cl_tfa_ironsights_toggle or cl_tfa_ironsights_responsive) and band(pressed, IN_ATTACK2) == IN_ATTACK2 or
				not cl_tfa_ironsights_toggle and not cl_tfa_ironsights_responsive and band(depressed, IN_ATTACK2) == IN_ATTACK2)
			then
				-- get out of iron sights
				wepv:SetIronSightsRaw(false)
				wepv:SetLastIronSightsPressed(-1)
			elseif wepv:GetIronSightsRaw() and cl_tfa_ironsights_responsive and band(depressed, IN_ATTACK2) == IN_ATTACK2 and deltaPress > cl_tfa_ironsights_responsive_timer then
				-- we depressed IN_ATTACK2 with it were being held down
				wepv:SetIronSightsRaw(false)
				wepv:SetLastIronSightsPressed(-1)
			end
		elseif wepv:GetIronSightsRaw() and not cl_tfa_ironsights_resight and (not TFA.Enum.IronStatus[wepv:GetStatus()] or wepv:GetSprinting()) then
			wepv:SetIronSightsRaw(false)
			wepv:SetLastIronSightsPressed(-1)
		end
	end

	if
		band(depressed, IN_RELOAD) == IN_RELOAD and
		not cv_lr:GetBool()
		and band(buttons, IN_USE) == 0
		and time <= (wepv:GetLastReloadPressed() + reload_threshold * scale_dividier)
	then
		wepv:SetLastReloadPressed(-1)
		wepv:Reload(true)
	elseif band(pressed, IN_RELOAD) == IN_RELOAD then
		wepv:SetLastReloadPressed(time)
	elseif band(buttons, IN_RELOAD) ~= 0 and band(buttons, IN_USE) == 0 and time > (wepv:GetLastReloadPressed() + reload_threshold * scale_dividier) then
		wepv:CheckAmmo()
	end

	if BashImpulse then
		if wepv.AltAttack then
			wepv:AltAttack()
		end
	end
end

hook.Add("FinishMove", "TFAFinishMove", FinishMove)

local function TFABashZoom(plyv, cusercmd)
	if plyv:InVehicle() and not plyv:GetAllowWeaponsInVehicle() then return end

	if plyv:GetInfoNum("cl_tfa_keys_bash", 0) ~= 0 then
		if (sp or CLIENT) and plyv.tfa_bash_hack then
			cusercmd:SetImpulse(TFA.BASH_IMPULSE)
		end

		return
	end

	local zoom = cusercmd:KeyDown(IN_ZOOM)

	if zoom then
		local wepv = plyv:GetActiveWeapon()

		if IsValid(wepv) and wepv.IsTFAWeapon and wepv.AltAttack then
			cusercmd:RemoveKey(IN_ZOOM)
			cusercmd:SetImpulse(TFA.BASH_IMPULSE)
		end
	end
end

hook.Add("StartCommand", "TFABashZoom", TFABashZoom)

--[[
Hook: PlayerSpawn
Function: Extinguishes players, zoom cleanup
Used For:  Fixes incendiary bullets post-respawn
]]
--
hook.Add("PlayerSpawn", "TFAExtinguishQOL", function(plyv)
	if IsValid(plyv) and plyv:IsOnFire() then
		plyv:Extinguish()
	end
end)

local sv_tfa_weapon_weight = GetConVar("sv_tfa_weapon_weight")

--[[
Hook: SetupMove
Function: Modify movement speed
Used For:  Weapon slowdown, ironsights slowdown
]]
--
hook.Add("SetupMove", "tfa_setupmove", function(plyv, movedata, commanddata)
	local wepv = plyv:GetActiveWeapon()

	if IsValid(wepv) and wepv.IsTFAWeapon then
		local speedmult = Lerp(wepv:GetIronSightsProgress(), sv_tfa_weapon_weight:GetBool() and wepv:GetStatL("RegularMoveSpeedMultiplier", 1), wepv:GetStatL("AimingDownSightsSpeedMultiplier", 1))
		movedata:SetMaxClientSpeed(movedata:GetMaxClientSpeed() * speedmult)
		commanddata:SetForwardMove(commanddata:GetForwardMove() * speedmult)
		commanddata:SetSideMove(commanddata:GetSideMove() * speedmult)
	end
end)

--[[
Hook: HUDShouldDraw
Function: Weapon HUD
Used For:  Hides default HUD
]]
--
local cv_he = GetConVar("cl_tfa_hud_enabled")

if CLIENT then
	local TFAHudHide = {
		CHudAmmo = true,
		CHudSecondaryAmmo = true
	}

	hook.Add("HUDShouldDraw", "tfa_hidehud", function(name)
		if (TFAHudHide[name] and cv_he:GetBool()) then
			local ictfa = TFA.PlayerCarryingTFAWeapon()
			if ictfa then return false end
		end
	end)
end

--[[
Hook: InitPostEntity
Function: Patches or removes other hooks that breaking or changing behavior of our weapons in a negative way
Used For: Fixing our stuff
]]
--

local function FixInvalidPMHook()
	if not CLIENT then return end

	local hookTable = hook.GetTable()

	if hookTable["PostDrawViewModel"] and hookTable["PostDrawViewModel"]["Set player hand skin"] then
		local targetFunc = hookTable["PostDrawViewModel"]["Set player hand skin"]
		if not targetFunc then return end

		local cv_shouldfix = GetConVar("cl_tfa_fix_pmhands_hook") or CreateClientConVar("cl_tfa_fix_pmhands_hook", "1", true, false, "Fix hands skin hook for CaptainBigButt's (and others) playermodels (Change requires map restart)")

		if not cv_shouldfix:GetBool() then return end

		print("[TFA Base] The playermodels you have installed breaks the automatic rig parenting for Insurgency and CS:GO weapons. The fix is applied but it's more of a band-aid, the solution would be to either fix this properly on author's side or to uninstall the addon.")

		if CLIENT and debug and debug.getinfo then
			local funcPath = debug.getinfo(targetFunc).short_src

			print("Type whereis " .. funcPath .. " in console to see the conflicting addon.")
		end

		hook.Remove("PostDrawViewModel", "Set player hand skin")
		hook.Add("PreDrawPlayerHands", "Set player hand skin BUT FIXED", function(hands, vm, ply, weapon)
			if hands:SkinCount() == ply:SkinCount() then
				hands:SetSkin(ply:GetSkin())
			end
		end)
	end
end

local function PatchSiminovSniperHook()
	if not CLIENT then return end -- that hook is clientside only

	local hookTable = hook.GetTable()

	if hookTable["CreateMove"] and hookTable["CreateMove"]["SniperCreateMove"] then
		local SniperCreateMove = hookTable["CreateMove"]["SniperCreateMove"] -- getting the original function
		if not SniperCreateMove then return end

		local cv_shouldfix = GetConVar("cl_tfa_fix_siminov_scopes") or CreateClientConVar("cl_tfa_fix_siminov_scopes", "1", true, false, "Patch Siminov's sniper overlay hook with weapon base check (Change requires map restart)")

		if not cv_shouldfix:GetBool() then return end

		local PatchedSniperCreateMove = function(cmd) -- wrapping their function with our check
			local ply = LocalPlayer()

			if IsValid(ply) and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon().IsTFAWeapon then
				return
			end

			SniperCreateMove(cmd)
		end

		hook.Remove("CreateMove", "SniperCreateMove") -- removing original hook
		hook.Add("CreateMove", "SniperCreateMove_PatchedByTFABase", PatchedSniperCreateMove) -- creating new hook with wrap
	end
end

hook.Add("InitPostEntity", "tfa_unfuckeverything", function()
	FixInvalidPMHook()
	PatchSiminovSniperHook()
end)

--[[
Hook: PlayerSwitchFlashlight
Function: Flashlight toggle
Used For: Switching flashlight on weapon and blocking HEV flashlight
]]
--
hook.Add("PlayerSwitchFlashlight", "tfa_toggleflashlight", function(plyv, toEnable)
	if CLIENT then return end -- this is serverside hook GO AWAY
	-- fuck you source
	-- where is fucking prediction??!??!?!?/

	if not IsValid(plyv) or not toEnable then return end -- allow disabling HEV flashlight

	local wepv = plyv:GetActiveWeapon()

	if IsValid(wepv) and wepv.IsTFAWeapon and (wepv:GetStatL("FlashlightAttachmentName") ~= nil or wepv:GetStatL("FlashlightAttachment", 0) > 0) then
		-- wepv:ToggleFlashlight()

		return false
	end
end)

--[[
Hook: SetupMove
Function: Update players NW2 variable
Used For: Walking animation NW2 var
]]
--
hook.Add("SetupMove", "tfa_checkforplayerwalking", function(plyv, mvdatav, cmdv)
	if not IsValid(plyv) or not mvdatav then return end

	if mvdatav:GetForwardSpeed() ~= 0 or mvdatav:GetSideSpeed() ~= 0 then
		if not plyv:GetNW2Bool("TFA_IsWalking") then
			plyv:SetNW2Bool("TFA_IsWalking", true)
		end
	elseif plyv:GetNW2Bool("TFA_IsWalking") then
		plyv:SetNW2Bool("TFA_IsWalking", false)
	end
end)

--[[
Hook: PreDrawOpaqueRenderables
Function: Calls SWEP:PreDrawOpaqueRenderables()
Used For: whatever draw stuff you need lol
]]
--
hook.Add("PreDrawOpaqueRenderables", "tfaweaponspredrawopaque", function()
	for _, v in ipairs(player.GetAll()) do
		local wepv = v:GetActiveWeapon()

		if IsValid(wepv) and wepv.IsTFAWeapon and wepv.PreDrawOpaqueRenderables then
			wepv:PreDrawOpaqueRenderables()
		end
	end
end)

--[[
Hook: PlayerSay
Function: Simple chat command
Used For: Allowing users to open TFA's Steam group with a chat command
]]
--
if SERVER then
	hook.Add("PlayerSay", "TFAJoinGroupChat", function(plyv, text, tc)
		if string.Trim(text) == "!jointfa" then
			net.Start("TFAJoinGroupPopup")
			net.Send(plyv)
		end
	end)
end

--[[
Hook: PreDrawViewModel
Function: Calculating viewmodel offsets
Used For: Viewmodel sway, offset and flip
]]
--
if CLIENT then
	local st_old, host_ts, cheats, vec, ang
	host_ts = GetConVar("host_timescale")
	cheats = GetConVar("sv_cheats")
	vec = Vector()
	ang = Angle()

	local IsGameUIVisible = gui and gui.IsGameUIVisible

	hook.Add("PreDrawViewModel", "TFACalculateViewmodel", function(vm, plyv, wepv)
		if not IsValid(wepv) or not wepv.IsTFAWeapon then return end

		wepv:UpdateEngineBob()

		local st = SysTime()
		st_old = st_old or st

		local delta = st - st_old
		st_old = st

		if sp and IsGameUIVisible and IsGameUIVisible() then return end

		delta = delta * game.GetTimeScale() * (cheats:GetBool() and host_ts:GetFloat() or 1)

		wepv:Sway(vec, ang, delta)
		wepv:CalculateViewModelOffset(delta)
		wepv:CalculateViewModelFlip()

		wepv:UpdateProjectedTextures(true)
	end)
end

--[[
Hook: EntityTakeDamage
Function: Applies physics damage to Combine Turrets
Used For: Knocking up Combine Turrets with TFA Base weapons
]]
--
hook.Add("EntityTakeDamage", "TFA_TurretPhysics", function(entv, dmg)
	if entv:GetClass() == "npc_turret_floor" then
		entv:TakePhysicsDamage(dmg)
	end
end)

--[[
Hook: HUDPaint
Function: Calls another hook
Used For: Hook that notifies when player is fully loaded.
]]
--
hook.Add("HUDPaint", "TFA_TRIGGERCLIENTLOAD", function()
	if LocalPlayer():IsValid() then
		hook.Remove("HUDPaint", "TFA_TRIGGERCLIENTLOAD")

		hook.Run("TFA_ClientLoad")
	end
end)

--[[
Hook: InitPostEntity
Function: Wraps SWEP:Think functions
Used For: Patching old, broken weapons that override SWEP:Think without calling baseclass
]]
--
local PatchClassBlacklisted = {
	tfa_gun_base = true,
	tfa_melee_base = true,
	tfa_bash_base = true,
	tfa_bow_base = true,
	tfa_knife_base = true,
	tfa_nade_base = true,
	tfa_sword_advanced_base = true,
	tfa_cssnade_base = true,
	tfa_shotty_base = true,
	tfa_akimbo_base = true,
	tfa_3dbash_base = true,
	tfa_3dscoped_base = true,
	tfa_scoped_base = true,
}

local cv_shouldpatchthink = GetConVar("sv_tfa_backcompat_patchswepthink") or CreateConVar("sv_tfa_backcompat_patchswepthink", "1", CLIENT and {FCVAR_REPLICATED} or {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Enable patching of old weapons that override SWEP:Think function to work with newer version of the base?\n\tDISABLING THIS IS NOT RECOMMENDED AND MAY LEAD TO NON-FUNCTIONING WEAPONS!")

hook.Add("InitPostEntity", "TFA_PatchThinkOverride", function()
	if not cv_shouldpatchthink:GetBool() then return end
	if not debug or not debug.getinfo then return end

	for _, wepRefTable in ipairs(weapons.GetList()) do
		local class = wepRefTable.ClassName

		if PatchClassBlacklisted[class] or not weapons.IsBasedOn(class, "tfa_gun_base") then
			goto THINK1FOUND
		end

		local wepRealTbl = weapons.GetStored(class)

		if wepRealTbl.Think then
			local info = debug.getinfo(wepRealTbl.Think, "S")
			if not info or not info.linedefined or not info.lastlinedefined then goto THINK1FOUND end

			local src = info.short_src

			if src:StartWith("addons/") then
				src = src:gsub("^addons/[^%0:/]+/", "")
			end

			local luafile = file.Read(src:sub(5), "LUA")
			if not luafile or luafile == "" then goto THINK1FOUND end

			local lua = luafile:gsub("\r\n","\n"):gsub("\r","\n"):Split("\n")

			for i = info.linedefined, info.lastlinedefined do
				local line = lua[i]

				if not line or line:find("BaseClass%s*.%s*Think%s*%(") then
					goto THINK1FOUND
				end
			end

			print(("[TFA Base] Weapon %s (%s) is overriding SWEP:Think() function without calling baseclass!"):format(wepRefTable.ClassName, info.short_src))

			local BaseClass = baseclass.Get(wepRealTbl.Base)

			wepRealTbl.ThinkFuncUnwrapped = wepRealTbl.ThinkFuncUnwrapped or wepRealTbl.Think
			function wepRealTbl:Think(...)
				self:ThinkFuncUnwrapped(...)

				return BaseClass.Think(self, ...)
			end
		end

		::THINK1FOUND::
	end
end)