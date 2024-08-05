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

local sp = game.SinglePlayer()

SWEP.Locomotion_Data_Queued = nil

local ServersideLooped = {
	[ACT_VM_FIDGET] = true,
	[ACT_VM_FIDGET_EMPTY] = true
}

--[ACT_VM_IDLE] = true,
--[ACT_VM_IDLE_EMPTY] = true,
--[ACT_VM_IDLE_SILENCED] = true
local d, pbr

-- Override this after SWEP:Initialize, for example, in attachments
SWEP.BaseAnimations = {
	["draw_first"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_DRAW_DEPLOYED,
		["enabled"] = nil --Manually force a sequence to be enabled
	},
	["draw"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_DRAW
	},
	["draw_empty"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_DRAW_EMPTY
	},
	["draw_silenced"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_DRAW_SILENCED
	},
	["shoot1"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_PRIMARYATTACK
	},
	["shoot1_last"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_PRIMARYATTACK_EMPTY
	},
	["shoot1_empty"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_DRYFIRE
	},
	["shoot1_silenced"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_PRIMARYATTACK_SILENCED
	},
	["shoot1_silenced_empty"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_DRYFIRE_SILENCED or 0
	},
	["shoot1_is"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_PRIMARYATTACK_1
	},
	["shoot2"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_SECONDARYATTACK
	},
	["shoot2_last"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "shoot2_last"
	},
	["shoot2_empty"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_DRYFIRE
	},
	["shoot2_silenced"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "shoot2_silenced"
	},
	["shoot2_is"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_ISHOOT_M203
	},
	["idle"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_IDLE
	},
	["idle_empty"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_IDLE_EMPTY
	},
	["idle_silenced"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_IDLE_SILENCED
	},
	["reload"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_RELOAD
	},
	["reload_empty"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_RELOAD_EMPTY
	},
	["reload_silenced"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_RELOAD_SILENCED
	},
	["reload_shotgun_start"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_SHOTGUN_RELOAD_START
	},
	["reload_shotgun_finish"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_SHOTGUN_RELOAD_FINISH
	},
	["reload_is"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_VM_RELOAD_ADS
	},
	["reload_empty_is"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_VM_RELOAD_EMPTY_ADS
	},
	["reload_silenced_is"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_VM_RELOAD_SILENCED_ADS
	},
	["reload_shotgun_start_is"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_SHOTGUN_RELOAD_START_ADS
	},
	["reload_shotgun_finish_is"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_SHOTGUN_RELOAD_FINISH_ADS
	},
	["holster"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_HOLSTER
	},
	["holster_empty"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_HOLSTER_EMPTY
	},
	["holster_silenced"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_HOLSTER_SILENCED
	},
	["silencer_attach"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_ATTACH_SILENCER
	},
	["silencer_detach"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_DETACH_SILENCER
	},
	["rof"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_FIREMODE
	},
	["rof_is"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_IFIREMODE
	},
	["bash"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_HITCENTER
	},
	["bash_silenced"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_HITCENTER2
	},
	["bash_empty"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_MISSCENTER
	},
	["bash_empty_silenced"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_MISSCENTER2
	},
	["inspect"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_FIDGET
	},
	["inspect_empty"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_FIDGET_EMPTY
	},
	["inspect_silenced"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_FIDGET_SILENCED
	}
}

SWEP.Animations = {}

function SWEP:InitializeAnims()
	local self2 = self:GetTable()

	setmetatable(self2.Animations, {
		__index = function(t, k) return self2.BaseAnimations[k] end
	})
end

function SWEP:BuildAnimActivities()
	local self2 = self:GetTable()
	self2.AnimationActivities = self2.AnimationActivities or {}

	for k, v in pairs(self2.BaseAnimations) do
		if v.value then
			self2.AnimationActivities[v.value] = k
		end

		local kvt = self2.GetStatL(self, "Animations." .. k)

		if kvt.value then
			self2.AnimationActivities[kvt.value] = k
		end
	end

	for k, _ in pairs(self2.Animations) do
		local kvt = self2.GetStatL(self, "Animations." .. k)

		if kvt.value then
			self2.AnimationActivities[kvt.value] = k
		end
	end
end

function SWEP:GetActivityEnabled(act)
	local self2 = self:GetTable()
	local stat = self2.GetStatL(self, "SequenceEnabled." .. act)
	if stat then return stat end

	if not self2.AnimationActivities then
		self:BuildAnimActivities()
	end

	local keysel = self2.AnimationActivities[act] or ""
	local kv = self2.GetStatL(self, "Animations." .. keysel)
	if not kv then return false end

	if kv["enabled"] then
		return kv["enabled"]
	else
		return false
	end
end

function SWEP:ChooseAnimation(keyOrData)
	local self2 = self:GetTable()

	local data

	if isstring(keyOrData) then
		data = self2.GetStatL(self, "Animations." .. keyOrData)
	elseif istable(keyOrData) then
		data = keyOrData
	else
		error("Unknown value type " .. type(keyOrData) .. " passed!")
	end

	if not data then return 0, 0 end
	if not data["type"] then return 0, 0 end
	if not data["value"] then return 0, 0 end

	local retType, retValue = data["type"], data["value"]

	if self:Clip1() <= 0 and self2.GetStatL(self, "Primary.ClipSize") >= 0 then
		if data.value_empty then
			retValue = data.value_empty
			retType = data.type_empty or retType
		end
	end

	if self:Clip1() == 1 and self2.GetStatL(self, "Primary.ClipSize") >= 0 then
		if data.value_last then
			retValue = data.value_last
			retType = data.type_last or retType
		end
	end

	if self2.GetSilenced(self) then
		local previousRetType = retType

		if data.value_sil then
			retValue = data.value_sil
			retType = data.type_sil or previousRetType
		end

		if self:Clip1() <= 0 and self2.GetStatL(self, "Primary.ClipSize") >= 0 then
			if data.value_sil_empty then
				retValue = data.value_sil_empty
				retType = data.type_sil_empty or previousRetType
			end
		end
	end

	if self:GetIronSights() then
		local previousRetType = retType

		if data.value_is then
			retValue = data.value_is
			retType = data.type_is or previousRetType
		end

		if self:Clip1() <= 0 and self2.GetStatL(self, "Primary.ClipSize") >= 0 then
			if data.value_is_empty then
				retValue = data.value_is_empty
				retType = data.type_is_empty or previousRetType
			end
		end

		if self:Clip1() == 1 and self2.GetStatL(self, "Primary.ClipSize") >= 0 then
			if data.value_is_last then
				retValue = data.value_is_last
				retType = data.type_is_last or previousRetType
			end
		end

		if self2.GetSilenced(self) then
			if data.value_is_sil then
				retValue = data.value_is_sil
				retType = data.type_is_sil or previousRetType
			end

			if self:Clip1() <= 0 and self2.GetStatL(self, "Primary.ClipSize") >= 0 then
				if data.value_is_sil_empty then
					retValue = data.value_is_sil_empty
					retType = data.type_is_sil_empty or previousRetType
				end
			end

			if self:Clip1() == 1 and self2.GetStatL(self, "Primary.ClipSize") >= 0 then
				if data.value_is_sil_last then
					retValue = data.value_is_sil_last
					retType = data.type_is_sil_last or previousRetType
				end
			end
		end
	end

	if retType == TFA.Enum.ANIMATION_ACT and isstring(retValue) then
		retValue = tonumber(retValue) or -1
	elseif retType == TFA.Enum.ANIMATION_SEQ and isstring(retValue) then
		retValue = self2.OwnerViewModel:LookupSequence(retValue)
	end

	return retType, retValue
end

function SWEP:GetAnimationRate(ani, animationType)
	local self2 = self:GetTable()
	local rate = 1
	if not ani or ani < 0 or not self:VMIV() then return rate end

	local nm

	if animationType == TFA.Enum.ANIMATION_ACT or animationType == nil then
		nm = self2.OwnerViewModel:GetSequenceName(self2.OwnerViewModel:SelectWeightedSequence(ani))
	elseif isnumber(ani) then
		nm = self2.OwnerViewModel:GetSequenceName(ani)
	elseif isstring(ani) then
		nm = ani
	else
		error("ani argument is typeof " .. type(ani))
	end

	local sqto = self2.GetStatL(self, "SequenceTimeOverride." .. nm) or self2.GetStatL(self, "SequenceTimeOverride." .. (ani or "0"))
	local sqro = self2.GetStatL(self, "SequenceRateOverride." .. nm) or self2.GetStatL(self, "SequenceRateOverride." .. (ani or "0"))

	if sqro then
		rate = rate * sqro
	elseif sqto then
		local t = self:GetActivityLengthRaw(ani, false)

		if t then
			rate = rate * t / sqto
		end
	end

	rate = hook.Run("TFA_AnimationRate", self, ani, rate) or rate

	return rate
end

function SWEP:SendViewModelAnim(act, rate, targ, blend)
	local self2 = self:GetTable()
	local vm = self2.OwnerViewModel

	if rate and not targ then
		rate = math.max(rate, 0.0001)
	end

	if not rate then
		rate = 1
	end

	if targ then
		rate = rate / self:GetAnimationRate(act)
	else
		rate = rate * self:GetAnimationRate(act)
	end

	if act < 0 then return false, act end
	if not self:VMIV() then return false, act end
	local seq = vm:SelectWeightedSequenceSeeded(act, self:GetSeedIrradical())

	if seq < 0 then
		if act == ACT_VM_IDLE_EMPTY then
			seq = vm:SelectWeightedSequenceSeeded(ACT_VM_IDLE, self:GetSeedIrradical())
		elseif act == ACT_VM_PRIMARYATTACK_EMPTY then
			seq = vm:SelectWeightedSequenceSeeded(ACT_VM_PRIMARYATTACK, self:GetSeedIrradical())
		else
			return false, 0
		end

		if seq < 0 then return false, act end
	end

	local preLastActivity = self:GetLastActivity()
	--local preLastSequence = self:GetLastActivity()
	self:SetLastActivity(act)
	self:SetLastSequence(seq)
	self:ResetEvents()

	if preLastActivity == act and ServersideLooped[act] then
		self:ChooseIdleAnim()
		d = vm:SequenceDuration(seq)
		pbr = targ and (d / (rate or 1)) or (rate or 1)

		if IsValid(self) then
			if blend == nil then
				blend = self2.Idle_Smooth
			end

			self:SetNextIdleAnim(CurTime() + d / pbr - blend)
		end

		if IsFirstTimePredicted() then
			timer.Simple(0, function()
				vm:SendViewModelMatchingSequence(seq)
				d = vm:SequenceDuration()
				pbr = targ and (d / (rate or 1)) or (rate or 1)
				vm:SetPlaybackRate(pbr)

				if IsValid(self) then
					if blend == nil then
						blend = self2.Idle_Smooth
					end

					self:SetNextIdleAnim(CurTime() + d / pbr - blend)
					self:SetLastActivity(act)
				end
			end)
		end
	else
		if seq >= 0 then
			vm:SendViewModelMatchingSequence(seq)
		end

		d = vm:SequenceDuration()
		pbr = targ and (d / (rate or 1)) or (rate or 1)
		vm:SetPlaybackRate(pbr)

		if blend == nil then
			blend = self2.Idle_Smooth
		end

		self:SetNextIdleAnim(CurTime() + math.max(d / pbr - blend, self2.Idle_Smooth))
	end

	return true, act
end

function SWEP:SendViewModelSeq(seq, rate, targ, blend)
	local self2 = self:GetTable()
	local seqold = seq

	if not self:VMIV() then return false, 0 end
	local vm = self2.OwnerViewModel

	if isstring(seq) then
		seq = vm:LookupSequence(seq) or 0
	end

	local act = vm:GetSequenceActivity(seq)

	if self2.SequenceRateOverride[seqold] then
		rate = self2.SequenceRateOverride[seqold]
		targ = false
	elseif self2.SequenceRateOverride[act] then
		rate = self2.SequenceRateOverride[act]
		targ = false
	elseif self2.SequenceTimeOverride[seqold] then
		rate = self2.SequenceTimeOverride[seqold]
		targ = true
	elseif self2.SequenceTimeOverride[act] then
		rate = self2.SequenceTimeOverride[act]
		targ = true
	end

	if not rate then
		rate = 1
	end

	if targ then
		rate = rate / self:GetAnimationRate(seq, TFA.Enum.ANIMATION_SEQ)
	else
		rate = rate * self:GetAnimationRate(seq, TFA.Enum.ANIMATION_SEQ)
	end

	if seq < 0 then return false, seq end

	local preLastActivity = self:GetLastActivity()
	--local preLastSequence = self:GetLastSequence()
	self:SetLastActivity(act)
	self:SetLastSequence(seq)
	self:ResetEvents()

	if preLastActivity == act and ServersideLooped[act] then
		vm:SendViewModelMatchingSequence(act == 0 and 1 or 0)
		vm:SetPlaybackRate(0)
		vm:SetCycle(0)
		self:SetNextIdleAnim(CurTime() + 0.03)

		if IsFirstTimePredicted() then
			timer.Simple(0, function()
				vm:SendViewModelMatchingSequence(seq)
				d = vm:SequenceDuration()
				pbr = targ and (d / (rate or 1)) or (rate or 1)
				vm:SetPlaybackRate(pbr)

				if IsValid(self) then
					if blend == nil then
						blend = self2.Idle_Smooth
					end

					self:SetNextIdleAnim(CurTime() + d / pbr - blend)
					self:SetLastActivity(act)
				end
			end)
		end
	else
		if seq >= 0 then
			vm:SendViewModelMatchingSequence(seq)
		end

		d = vm:SequenceDuration()
		pbr = targ and (d / (rate or 1)) or (rate or 1)
		vm:SetPlaybackRate(pbr)

		if IsValid(self) then
			if blend == nil then
				blend = self2.Idle_Smooth
			end

			self:SetNextIdleAnim(CurTime() + d / pbr - blend)
		end
	end

	return true, seq
end

function SWEP:PlayAnimation(data, fade, rate, targ)
	local self2 = self:GetTable()
	if not self:VMIV() then return end
	if not data then return false, -1 end

	local ttype, tval = self:ChooseAnimation(data)

	if ttype == TFA.Enum.ANIMATION_SEQ then
		local success, activityID = self:SendViewModelSeq(tval, rate or 1, targ, fade or (data.transition and self2.Idle_Blend or self2.Idle_Smooth))
		return success, activityID, TFA.Enum.ANIMATION_SEQ
	end

	local success, activityID = self:SendViewModelAnim(tval, rate or 1, targ, fade or (data.transition and self2.Idle_Blend or self2.Idle_Smooth))
	return success, activityID, TFA.Enum.ANIMATION_ACT
end

--[[
Function Name:  Locomote
Syntax: self:Locomote( flip ironsights, new is, flip sprint, new sprint, flip walk, new walk).
Returns:
Notes:
Purpose:  Animation / Utility
]]
local tldata

function SWEP:Locomote(flipis, is, flipsp, spr, flipwalk, walk, flipcust, cust)
	local self2 = self:GetTable()
	if not (flipis or flipsp or flipwalk or flipcust) then return end
	if not (self:GetStatus() == TFA.Enum.STATUS_IDLE or (self:GetStatus() == TFA.Enum.STATUS_SHOOTING and self:CanInterruptShooting())) then return end
	tldata = nil

	if flipis then
		if is and self2.GetStatL(self, "IronAnimation.in") then
			tldata = self2.GetStatL(self, "IronAnimation.in", tldata)
		elseif self2.GetStatL(self, "IronAnimation.out") and not flipsp then
			tldata = self2.GetStatL(self, "IronAnimation.out", tldata)
		end
	end

	if flipsp then
		if spr and self2.GetStatL(self, "SprintAnimation.in") then
			tldata = self2.GetStatL(self, "SprintAnimation.in", tldata)
		elseif self2.GetStatL(self, "SprintAnimation.out") and not flipis and not spr then
			tldata = self2.GetStatL(self, "SprintAnimation.out", tldata)
		end
	end

	if flipwalk and not is then
		if walk and self2.GetStatL(self, "WalkAnimation.in") then
			tldata = self2.GetStatL(self, "WalkAnimation.in", tldata)
		elseif self2.GetStatL(self, "WalkAnimation.out") and (not flipis and not flipsp and not flipcust) and not walk then
			tldata = self2.GetStatL(self, "WalkAnimation.out", tldata)
		end
	end

	if flipcust then
		if cust and self2.GetStatL(self, "CustomizeAnimation.in") then
			tldata = self2.GetStatL(self, "CustomizeAnimation.in", tldata)
		elseif self2.GetStatL(self, "CustomizeAnimation.out") and (not flipis and not flipsp and not flipwalk) and not cust then
			tldata = self2.GetStatL(self, "CustomizeAnimation.out", tldata)
		end
	end

	if tldata then
		return self:PlayAnimation(tldata)
	end

	return false, -1, TFA.Enum.ANIMATION_SEQ
end

function SWEP:LocomoteOrIdle(...)
	local success, animID, animType = self:Locomote(...)

	if not success then
		return self:SetNextIdleAnim(-1)
	end

	return success, animID, animType
end

--[[
Function Name:  ChooseDrawAnim
Syntax: self:ChooseDrawAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.
Purpose:  Animation / Utility
]]
SWEP.IsFirstDeploy = true

local function PlayChosenAnimation(self, typev, tanim, ...)
	local fnName = typev == TFA.Enum.ANIMATION_SEQ and "SendViewModelSeq" or "SendViewModelAnim"
	local a, b = self[fnName](self, tanim, ...)
	return a, b, typev
end

SWEP.PlayChosenAnimation = PlayChosenAnimation

local success, tanim, typev

function SWEP:ChooseDrawAnim()
	local self2 = self:GetTable()
	if not self:VMIV() then return end
	--self:ResetEvents()
	tanim = ACT_VM_DRAW
	success = true

	if self2.IsFirstDeploy and CurTime() > (self2.LastDeployAnim or CurTime()) + 0.1 then
		self2.IsFirstDeploy = false
	end

	if self:GetActivityEnabled(ACT_VM_DRAW_EMPTY) and self:IsEmpty1() then
		typev, tanim = self:ChooseAnimation("draw_empty")
	elseif (self:GetActivityEnabled(ACT_VM_DRAW_DEPLOYED) or self2.FirstDeployEnabled) and self2.IsFirstDeploy then
		typev, tanim = self:ChooseAnimation("draw_first")
	elseif self:GetActivityEnabled(ACT_VM_DRAW_SILENCED) and self2.GetSilenced(self) then
		typev, tanim = self:ChooseAnimation("draw_silenced")
	else
		typev, tanim = self:ChooseAnimation("draw")
	end

	self2.LastDeployAnim = CurTime()

	return PlayChosenAnimation(self, typev, tanim)
end

function SWEP:ResetFirstDeploy()
	local self2 = self:GetTable()
	self2.IsFirstDeploy = true
	self2.LastDeployAnim = math.huge
end

--[[
Function Name:  ChooseInspectAnim
Syntax: self:ChooseInspectAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.
Purpose:  Animation / Utility
]]
--

function SWEP:ChooseInspectAnim()
	local self2 = self:GetTable()
	if not self:VMIV() then return end

	if self:GetActivityEnabled(ACT_VM_FIDGET_SILENCED) and self2.GetSilenced(self) then
		typev, tanim = self:ChooseAnimation("inspect_silenced")
	elseif self:GetActivityEnabled(ACT_VM_FIDGET_EMPTY) and self:IsEmpty1() then
		typev, tanim = self:ChooseAnimation("inspect_empty")
	elseif self2.InspectionActions then
		tanim = self2.InspectionActions[self:SharedRandom(1, #self2.InspectionActions, "Inspect")]
	elseif self:GetActivityEnabled(ACT_VM_FIDGET) then
		typev, tanim = self:ChooseAnimation("inspect")
	else
		typev, tanim = self:ChooseAnimation("idle")
		success = false
	end

	return PlayChosenAnimation(self, typev, tanim)
end

--[[
Function Name:  ChooseHolsterAnim
Syntax: self:ChooseHolsterAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.
Purpose:  Animation / Utility
]]
--
function SWEP:ChooseHolsterAnim()
	local self2 = self:GetTable()
	if not self:VMIV() then return end

	if self:GetActivityEnabled(ACT_VM_HOLSTER_SILENCED) and self2.GetSilenced(self) then
		typev, tanim = self:ChooseAnimation("holster_silenced")
	elseif self:GetActivityEnabled(ACT_VM_HOLSTER_EMPTY) and self:IsEmpty1() then
		typev, tanim = self:ChooseAnimation("holster_empty")
	elseif self:GetActivityEnabled(ACT_VM_HOLSTER) then
		typev, tanim = self:ChooseAnimation("holster")
	else
		return false, select(2, self:ChooseIdleAnim())
	end

	return PlayChosenAnimation(self, typev, tanim)
end

--[[
Function Name:  ChooseProceduralReloadAnim
Syntax: self:ChooseProceduralReloadAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Uses some holster code
Purpose:  Animation / Utility
]]
--
function SWEP:ChooseProceduralReloadAnim()
	local self2 = self:GetTable()
	if not self:VMIV() then return end

	if not self2.DisableIdleAnimations then
		self:SendViewModelAnim(ACT_VM_IDLE)
	end

	return true, ACT_VM_IDLE
end

--[[
Function Name:  ChooseReloadAnim
Syntax: self:ChooseReloadAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.
Purpose:  Animation / Utility
]]
--
function SWEP:ChooseReloadAnim()
	local self2 = self:GetTable()
	if not self:VMIV() then return false, 0 end
	if self2.GetStatL(self, "IsProceduralReloadBased") then return false, 0 end

	local ads = self:GetStatL("IronSightsReloadEnabled") and self:GetIronSightsDirect()

	if self:GetActivityEnabled(ACT_VM_RELOAD_SILENCED) and self2.GetSilenced(self) then
		typev, tanim = self:ChooseAnimation((ads and self:GetActivityEnabled(ACT_VM_RELOAD_SILENCED_ADS)) and "reload_silenced_is" or "reload_silenced")
	elseif self:GetActivityEnabled(ACT_VM_RELOAD_EMPTY) and (self:Clip1() == 0 or self:IsJammed()) and not self:GetStatL("LoopedReload") then
		typev, tanim = self:ChooseAnimation((ads and self:GetActivityEnabled(ACT_VM_RELOAD_EMPTY_ADS)) and "reload_empty_is" or "reload_empty")
	else
		typev, tanim = self:ChooseAnimation((ads and self:GetActivityEnabled(ACT_VM_RELOAD_ADS)) and "reload_is" or "reload")
	end

	local fac = 1

	if self:GetStatL("LoopedReload") and self:GetStatL("LoopedReloadInsertTime") then
		fac = self:GetStatL("LoopedReloadInsertTime")
	end

	self:SetAnimCycle(self2.ViewModelFlip and 0 or 1)
	self2.AnimCycle = self:GetAnimCycle()

	return PlayChosenAnimation(self, typev, tanim, fac, fac ~= 1)
end

--[[
Function Name:  ChooseReloadAnim
Syntax: self:ChooseReloadAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.
Purpose:  Animation / Utility
]]
--
function SWEP:ChooseShotgunReloadAnim()
	local self2 = self:GetTable()
	if not self:VMIV() then return end

	local ads = self:GetStatL("IronSightsReloadEnabled") and self:GetIronSightsDirect()

	if self:GetActivityEnabled(ACT_VM_RELOAD_SILENCED) and self2.GetSilenced(self) then
		typev, tanim = self:ChooseAnimation((ads and self:GetActivityEnabled(ACT_VM_RELOAD_SILENCED_ADS)) and "reload_silenced_is" or "reload_silenced")
	elseif self:GetActivityEnabled(ACT_VM_RELOAD_EMPTY) and self2.ShotgunEmptyAnim and (self:Clip1() == 0 or self:IsJammed()) then
		typev, tanim = self:ChooseAnimation((ads and self:GetActivityEnabled(ACT_VM_RELOAD_EMPTY_ADS)) and "reload_empty_is" or "reload_empty")
	elseif self:GetActivityEnabled(ACT_SHOTGUN_RELOAD_START) then
		typev, tanim = self:ChooseAnimation((ads and self:GetActivityEnabled(ACT_SHOTGUN_RELOAD_START_ADS)) and "reload_shotgun_start_is" or "reload_shotgun_start")
	else
		return false, select(2, self:ChooseIdleAnim())
	end

	return PlayChosenAnimation(self, typev, tanim)
end

function SWEP:ChooseShotgunPumpAnim()
	if not self:VMIV() then return end

	typev, tanim = self:ChooseAnimation(
		(self:GetStatL("IronSightsReloadEnabled") and
		self:GetIronSightsDirect() and
		self:GetActivityEnabled(ACT_SHOTGUN_RELOAD_START_ADS)) and "reload_shotgun_finish_is" or "reload_shotgun_finish")

	return PlayChosenAnimation(self, typev, tanim)
end

--[[
Function Name:  ChooseIdleAnim
Syntax: self:ChooseIdleAnim().
Returns:  True,  Which action?
Notes:  Requires autodetection for full features.
Purpose:  Animation / Utility
]]
--
function SWEP:ChooseIdleAnim()
	local self2 = self:GetTable()
	if not self:VMIV() then return end
	--if self2.Idle_WithHeld then
	--  self2.Idle_WithHeld = nil
	--  return
	--end

	if TFA.Enum.ShootLoopingStatus[self:GetShootStatus()] then
		return self:ChooseLoopShootAnim()
	end

	if self2.Idle_Mode ~= TFA.Enum.IDLE_BOTH and self2.Idle_Mode ~= TFA.Enum.IDLE_ANI then return end

	--self:ResetEvents()
	if self:GetIronSights() then
		if self2.Sights_Mode == TFA.Enum.LOCOMOTION_LUA then
			return self:ChooseFlatAnim()
		else
			return self:ChooseADSAnim()
		end
	elseif self:GetSprinting() and self2.Sprint_Mode ~= TFA.Enum.LOCOMOTION_LUA then
		return self:ChooseSprintAnim()
	elseif self:GetWalking() and self2.Walk_Mode ~= TFA.Enum.LOCOMOTION_LUA then
		return self:ChooseWalkAnim()
	elseif self:GetCustomizing() and self2.Customize_Mode ~= TFA.Enum.LOCOMOTION_LUA then
		return self:ChooseCustomizeAnim()
	end

	if self:GetActivityEnabled(ACT_VM_IDLE_SILENCED) and self2.GetSilenced(self) then
		typev, tanim = self:ChooseAnimation("idle_silenced")
	elseif self:IsEmpty1() then
		--self:GetActivityEnabled( ACT_VM_IDLE_EMPTY ) and (self:Clip1() == 0) then
		if self:GetActivityEnabled(ACT_VM_IDLE_EMPTY) then
			typev, tanim = self:ChooseAnimation("idle_empty")
		else --if not self:GetActivityEnabled( ACT_VM_PRIMARYATTACK_EMPTY ) then
			typev, tanim = self:ChooseAnimation("idle")
		end
	else
		typev, tanim = self:ChooseAnimation("idle")
	end

	--else
	--  return
	--end
	return PlayChosenAnimation(self, typev, tanim)
end

function SWEP:ChooseFlatAnim()
	local self2 = self:GetTable()
	if not self:VMIV() then return end
	--self:ResetEvents()
	typev, tanim = self:ChooseAnimation("idle")

	if self:GetActivityEnabled(ACT_VM_IDLE_SILENCED) and self2.GetSilenced(self) then
		typev, tanim = self:ChooseAnimation("idle_silenced")
	elseif self:GetActivityEnabled(ACT_VM_IDLE_EMPTY) and self:IsEmpty1() then
		typev, tanim = self:ChooseAnimation("idle_empty")
	end

	return PlayChosenAnimation(self, typev, tanim, 0.000001)
end

function SWEP:ChooseADSAnim()
	local self2 = self:GetTable()
	local a, b, c = self:PlayAnimation(self2.GetStatL(self, "IronAnimation.loop"))

	--self:SetNextIdleAnim(CurTime() + 1)
	if not a then
		local _
		_, b, c = self:ChooseFlatAnim()
		a = false
	end

	return a, b, c
end

function SWEP:ChooseSprintAnim()
	return self:PlayAnimation(self:GetStatL("SprintAnimation.loop"))
end

function SWEP:ChooseWalkAnim()
	return self:PlayAnimation(self:GetStatL("WalkAnimation.loop"))
end

function SWEP:ChooseLoopShootAnim()
	return self:PlayAnimation(self:GetStatL("ShootAnimation.loop"))
end

function SWEP:ChooseCustomizeAnim()
	return self:PlayAnimation(self:GetStatL("CustomizeAnimation.loop"))
end

--[[
Function Name:  ChooseShootAnim
Syntax: self:ChooseShootAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.
Purpose:  Animation / Utility
]]
--
local shouldAnim, shouldBlowback
function SWEP:ChooseShootAnim(ifp)
	local self2 = self:GetTable()
	if ifp == nil then ifp = IsFirstTimePredicted() end
	if not self:VMIV() then return end

	if self2.GetStatL(self, "ShootAnimation.loop") and self2.Primary_TFA.Automatic then
		if self2.LuaShellEject and ifp then
			self:EventShell()
		end

		if TFA.Enum.ShootReadyStatus[self:GetShootStatus()] then
			self:SetShootStatus(TFA.Enum.SHOOT_START)

			local inan = self2.GetStatL(self, "ShootAnimation.in")

			if not inan then
				inan = self2.GetStatL(self, "ShootAnimation.loop")
			end

			return self:PlayAnimation(inan)
		end

		return
	end

	if self:GetIronSights() and (self2.Sights_Mode == TFA.Enum.LOCOMOTION_ANI or self2.Sights_Mode == TFA.Enum.LOCOMOTION_HYBRID) and self2.GetStatL(self, "IronAnimation.shoot") then
		if self2.LuaShellEject and ifp then
			self:EventShell()
		end

		return self:PlayAnimation(self2.GetStatL(self, "IronAnimation.shoot"))
	end

	shouldBlowback = self2.GetStatL(self, "BlowbackEnabled") and (not self2.GetStatL(self, "Blowback_Only_Iron") or self:GetIronSights())
	shouldAnim = not shouldBlowback or self2.GetStatL(self, "BlowbackAllowAnimation")

	if shouldBlowback then
		if sp and SERVER then
			self:CallOnClient("BlowbackFull", "")
		end

		if ifp then
			self:BlowbackFull(ifp)
		end

		if self2.GetStatL(self, "Blowback_Shell_Enabled") and (ifp or sp) then
			self:EventShell()
		end
	end

	if shouldAnim then
		success = true

		if self2.LuaShellEject and (ifp or sp) then
			self:EventShell()
		end

		if self:GetActivityEnabled(ACT_VM_PRIMARYATTACK_SILENCED) and self2.GetSilenced(self) then
			typev, tanim = self:ChooseAnimation("shoot1_silenced")
		elseif self:Clip1() <= self2.Primary_TFA.AmmoConsumption and self:GetActivityEnabled(ACT_VM_PRIMARYATTACK_EMPTY) and self2.Primary_TFA.ClipSize >= 1 and not self2.ForceEmptyFireOff then
			typev, tanim = self:ChooseAnimation("shoot1_last")
		elseif self:Ammo1() <= self2.Primary_TFA.AmmoConsumption and self:GetActivityEnabled(ACT_VM_PRIMARYATTACK_EMPTY) and self2.Primary_TFA.ClipSize < 1 and not self2.ForceEmptyFireOff then
			typev, tanim = self:ChooseAnimation("shoot1_last")
		elseif self:Clip1() == 0 and self:GetActivityEnabled(ACT_VM_DRYFIRE) and not self2.ForceDryFireOff then
			typev, tanim = self:ChooseAnimation("shoot1_empty")
		elseif self2.GetStatL(self, "IsAkimbo") and self:GetActivityEnabled(ACT_VM_SECONDARYATTACK) and ((self:GetAnimCycle() == 0 and not self2.Akimbo_Inverted) or (self:GetAnimCycle() == 1 and self2.Akimbo_Inverted)) then
			typev, tanim = self:ChooseAnimation((self:GetIronSights() and self:GetActivityEnabled(ACT_VM_ISHOOT_M203)) and "shoot2_is" or "shoot2")
		elseif self:GetIronSights() and self:GetActivityEnabled(ACT_VM_PRIMARYATTACK_1) then
			typev, tanim = self:ChooseAnimation("shoot1_is")
		else
			typev, tanim = self:ChooseAnimation("shoot1")
		end

		return PlayChosenAnimation(self, typev, tanim)
	end

	self:SendViewModelAnim(ACT_VM_BLOWBACK)

	return true, ACT_VM_IDLE
end

SWEP.BlowbackRandomAngleMin = Angle(.1, -.5, -1)
SWEP.BlowbackRandomAngleMax = Angle(.2, .5, 1)

local minang, maxang

function SWEP:BlowbackFull()
	local self2 = self:GetTable()

	if IsValid(self) then
		self2.BlowbackCurrent = 1
		self2.BlowbackCurrentRoot = 1

		if CLIENT then
			minang, maxang = self2.GetStatL(self, "BlowbackRandomAngleMin"), self2.GetStatL(self, "BlowbackRandomAngleMax")

			self2.BlowbackRandomAngle = Angle(math.Rand(minang.p, maxang.p), math.Rand(minang.y, maxang.y), math.Rand(minang.r, maxang.r))
		end
	end
end

--[[
Function Name:  ChooseSilenceAnim
Syntax: self:ChooseSilenceAnim( true if we're silencing, false for detaching the silencer).
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.  This is played when you silence or unsilence a gun.
Purpose:  Animation / Utility
]]
--
function SWEP:ChooseSilenceAnim(val)
	if not self:VMIV() then return end
	--self:ResetEvents()
	typev, tanim = self:ChooseAnimation("idle_silenced")
	success = false

	if val then
		if self:GetActivityEnabled(ACT_VM_ATTACH_SILENCER) then
			typev, tanim = self:ChooseAnimation("silencer_attach")
			success = true
		end
	elseif self:GetActivityEnabled(ACT_VM_DETACH_SILENCER) then
		typev, tanim = self:ChooseAnimation("silencer_detach")
		success = true
	end

	if not success then
		return false, select(2, self:ChooseIdleAnim())
	end

	return PlayChosenAnimation(self, typev, tanim)
end

--[[
Function Name:  ChooseDryFireAnim
Syntax: self:ChooseDryFireAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.  set SWEP.ForceDryFireOff to false to properly use.
Purpose:  Animation / Utility
]]
--
function SWEP:ChooseDryFireAnim()
	local self2 = self:GetTable()
	if not self:VMIV() then return end
	--self:ResetEvents()
	typev, tanim = self:ChooseAnimation("shoot1_empty")
	success = true

	if self:GetActivityEnabled(ACT_VM_DRYFIRE_SILENCED) and self2.GetSilenced(self) and not self2.ForceDryFireOff then
		typev, tanim = self:ChooseAnimation("shoot1_silenced_empty")
		--self:ChooseIdleAnim()
	else
		if self:GetActivityEnabled(ACT_VM_DRYFIRE) and not self2.ForceDryFireOff then
			typev, tanim = self:ChooseAnimation("shoot1_empty")
		else
			success = false
			local _
			_, tanim = nil, nil

			return success, tanim -- ???
		end
	end

	return PlayChosenAnimation(self, typev, tanim)
end

--[[
Function Name:  ChooseROFAnim
Syntax: self:ChooseROFAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.  Called when we change the firemode.
Purpose:  Animation / Utility
]]
--
function SWEP:ChooseROFAnim()
	local self2 = self:GetTable()
	if not self:VMIV() then return end

	--self:ResetEvents()
	if self:GetIronSights() and self:GetActivityEnabled(ACT_VM_IFIREMODE) then
		typev, tanim = self2.ChooseAnimation(self, "rof_is")
		success = true
	elseif self:GetActivityEnabled(ACT_VM_FIREMODE) then
		typev, tanim = self2.ChooseAnimation(self, "rof")
		success = true
	else
		success = false
		local _
		_, tanim = nil, nil

		return success, tanim -- ???
	end

	return PlayChosenAnimation(self, typev, tanim)
end

--[[
Function Name:  ChooseBashAnim
Syntax: self:ChooseBashAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.  Called when we bash.
Purpose:  Animation / Utility
]]
--
function SWEP:ChooseBashAnim()
	local self2 = self:GetTable()
	if not self:VMIV() then return end

	typev, tanim = nil, nil
	success = false

	local isempty = self2.GetStatL(self, "Primary.ClipSize") > 0 and self:Clip1() == 0

	if self2.GetSilenced(self) and self:GetActivityEnabled(ACT_VM_HITCENTER2) then
		if self:GetActivityEnabled(ACT_VM_MISSCENTER2) and isempty then
			typev, tanim = self:ChooseAnimation("bash_empty_silenced")
			success = true
		else
			typev, tanim = self:ChooseAnimation("bash_silenced")
			success = true
		end
	elseif self:GetActivityEnabled(ACT_VM_MISSCENTER) and isempty then
		typev, tanim = self:ChooseAnimation("bash_empty")
		success = true
	elseif self:GetActivityEnabled(ACT_VM_HITCENTER) then
		typev, tanim = self:ChooseAnimation("bash")
		success = true
	end

	if not success then
		return success, tanim
	end

	return PlayChosenAnimation(self, typev, tanim)
end

--[[THIRDPERSON]]
--These holdtypes are used in ironsights.  Syntax:  DefaultHoldType=NewHoldType
SWEP.IronSightHoldTypes = {
	pistol = "revolver",
	smg = "rpg",
	grenade = "melee",
	ar2 = "rpg",
	shotgun = "ar2",
	rpg = "rpg",
	physgun = "physgun",
	crossbow = "ar2",
	melee = "melee2",
	slam = "camera",
	normal = "fist",
	melee2 = "magic",
	knife = "fist",
	duel = "duel",
	camera = "camera",
	magic = "magic",
	revolver = "revolver"
}

--These holdtypes are used while sprinting.  Syntax:  DefaultHoldType=NewHoldType
SWEP.SprintHoldTypes = {
	pistol = "normal",
	smg = "passive",
	grenade = "normal",
	ar2 = "passive",
	shotgun = "passive",
	rpg = "passive",
	physgun = "normal",
	crossbow = "passive",
	melee = "normal",
	slam = "normal",
	normal = "normal",
	melee2 = "melee",
	knife = "fist",
	duel = "normal",
	camera = "slam",
	magic = "normal",
	revolver = "normal"
}

--These holdtypes are used in reloading.  Syntax:  DefaultHoldType=NewHoldType
SWEP.ReloadHoldTypes = {
	pistol = "pistol",
	smg = "smg",
	grenade = "melee",
	ar2 = "ar2",
	shotgun = "shotgun",
	rpg = "ar2",
	physgun = "physgun",
	crossbow = "crossbow",
	melee = "pistol",
	slam = "smg",
	normal = "pistol",
	melee2 = "pistol",
	knife = "pistol",
	duel = "duel",
	camera = "pistol",
	magic = "pistol",
	revolver = "revolver"
}

--These holdtypes are used in reloading.  Syntax:  DefaultHoldType=NewHoldType
SWEP.CrouchHoldTypes = {
	ar2 = "ar2",
	smg = "smg",
	rpg = "ar2"
}

SWEP.IronSightHoldTypeOverride = "" --This variable overrides the ironsights holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
SWEP.SprintHoldTypeOverride = "" --This variable overrides the sprint holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
SWEP.ReloadHoldTypeOverride = "" --This variable overrides the reload holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
local dynholdtypecvar = GetConVar("sv_tfa_holdtype_dynamic")
SWEP.mht_old = ""
local mht

function SWEP:IsOwnerCrouching()
	local ply = self:GetOwner()

	if not ply:IsPlayer() then return false end

	return (ply:Crouching() or self:KeyDown(IN_DUCK)) and ply:OnGround() and not ply:InVehicle()
end

function SWEP:ProcessHoldType()
	local self2 = self:GetTable()
	mht = self2.GetStatL(self, "HoldType", "ar2")

	if mht ~= self2.mht_old or not self2.DefaultHoldType then
		self2.DefaultHoldType = mht
		self2.SprintHoldType = nil
		self2.IronHoldType = nil
		self2.ReloadHoldType = nil
		self2.CrouchHoldType = nil
	end

	self2.mht_old = mht

	if not self2.SprintHoldType then
		self2.SprintHoldType = self2.SprintHoldTypes[self2.DefaultHoldType] or "passive"

		if self2.SprintHoldTypeOverride and self2.SprintHoldTypeOverride ~= "" then
			self2.SprintHoldType = self2.SprintHoldTypeOverride
		end
	end

	if not self2.IronHoldType then
		self2.IronHoldType = self2.IronSightHoldTypes[self2.DefaultHoldType] or "rpg"

		if self2.IronSightHoldTypeOverride and self2.IronSightHoldTypeOverride ~= "" then
			self2.IronHoldType = self2.IronSightHoldTypeOverride
		end
	end

	if not self2.ReloadHoldType then
		self2.ReloadHoldType = self2.ReloadHoldTypes[self2.DefaultHoldType] or "ar2"

		if self2.ReloadHoldTypeOverride and self2.ReloadHoldTypeOverride ~= "" then
			self2.ReloadHoldType = self2.ReloadHoldTypeOverride
		end
	end

	if not self2.SetCrouchHoldType then
		self2.SetCrouchHoldType = true
		self2.CrouchHoldType = self2.CrouchHoldTypes[self2.DefaultHoldType]

		if self2.CrouchHoldTypeOverride and self2.CrouchHoldTypeOverride ~= "" then
			self2.CrouchHoldType = self2.CrouchHoldTypeOverride
		end
	end

	local curhold, targhold, stat
	curhold = self:GetHoldType()
	targhold = self2.DefaultHoldType
	stat = self:GetStatus()

	if dynholdtypecvar:GetBool() then
		if self:OwnerIsValid() and self:IsOwnerCrouching() and self2.CrouchHoldType then
			targhold = self2.CrouchHoldType
		else
			if self:GetIronSights() then
				targhold = self2.IronHoldType
			end

			if TFA.Enum.ReloadStatus[stat] then
				targhold = self2.ReloadHoldType
			end
		end
	end

	if self:GetSprinting() or TFA.Enum.HolsterStatus[stat] or self:IsSafety() then
		targhold = self2.SprintHoldType
	end

	if targhold ~= curhold then
		self:SetHoldType(targhold)
	end
end