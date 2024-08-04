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

local lshift = bit.lshift
local band = bit.band
local bor = bit.bor

local sp = game.SinglePlayer()
local l_CT = CurTime

local is, spr, wlk, cst

--[[
Function Name:  ResetEvents
Syntax: self:ResetEvents()
Returns:  Nothing.
Purpose:  Cleans up events table.
]]--
function SWEP:ResetEvents()
	self:SetEventStatus1(0x00000000)
	self:SetEventStatus2(0x00000000)
	self:SetEventStatus3(0x00000000)
	self:SetEventStatus4(0x00000000)
	self:SetEventStatus5(0x00000000)
	self:SetEventStatus6(0x00000000)
	self:SetEventStatus7(0x00000000)
	self:SetEventStatus8(0x00000000)

	self:SetEventTimer(l_CT())
	-- self:SetFirstDeployEvent(false)

	if self.EventTable then
		for _, eventtable in pairs(self.EventTable) do
			for i = 1, #eventtable do
				eventtable[i].called = false
			end
		end
	end

	if self.event_table_overflow then
		local editcts = self.EventTableEdict

		if editcts[0] then
			editcts[0].called = false

			for i = 1, #editcts do
				editcts[i].called = false
			end
		end
	end

	if sp then
		self:CallOnClient("ResetEvents", "")
	end
end

function SWEP:GetEventPlayed(event_slot)
	if self.event_table_overflow then
		return assert(self.EventTableEdict[event_slot], string.format("Unknown event %d", event_slot)).called
	end

	local inner_index = event_slot % 32
	local outer_index = (event_slot - inner_index) / 32 + 1
	local lindex = lshift(1, inner_index)
	return band(self.get_event_status_lut[outer_index](self), lindex) ~= 0, inner_index, outer_index, lindex
end

function SWEP:SetEventPlayed(event_slot)
	if self.event_table_overflow then
		assert(self.EventTableEdict[event_slot], string.format("Unknown event %d", event_slot)).called = true
		return
	end

	local inner_index = event_slot % 32
	local outer_index = (event_slot - inner_index) / 32 + 1
	local lindex = lshift(1, inner_index)

	self.set_event_status_lut[outer_index](self, bor(self.get_event_status_lut[outer_index](self), lindex))
	return inner_index, outer_index, lindex
end

--[[
Function Name:  ProcessEvents
Syntax: self:ProcessEvents().
Returns:  Nothing.
Notes: Critical for the event table to function.
Purpose:  Main SWEP function
]]--

SWEP._EventSlotCount = 0
SWEP.EventTableEdict = {}

function SWEP:DispatchLuaEvent(arg)
	if not self.event_table_built then
		self:RebuildEventEdictTable()
	end

	local fn = assert(assert(self.EventTableEdict[tonumber(arg)], "No such event with edict " .. arg).value, "Event is missing a function to call")
	assert(isfunction(fn), "Event " .. arg .. " is not a Lua event")
	fn(self, self:VMIV(), true)
end

function SWEP:DispatchBodygroupEvent(arg)
	if not self.event_table_built then
		self:RebuildEventEdictTable()
	end

	local event = assert(self.EventTableEdict[tonumber(arg)], "No such event with edict " .. arg)
	assert(isstring(event.name), "Event " .. arg .. " is missing bodygroup name to set")
	assert(isstring(event.value), "Event " .. arg .. " is missing bodygroup value to set")

	if event.view then
		self.ViewModelBodygroups[event.name] = event.value
	end

	if event.world then
		self.WorldModelBodygroups[event.name] = event.value
	end
end

local isstring = isstring

local function eventtablesorter(a, b)
	local sa, sb = isstring(a), isstring(b)

	if sa and not sb or not sa and sb then
		if sa then
			return false
		end

		return true
	end

	return a < b
end

function SWEP:RebuildEventEdictTable()
	local self2 = self:GetTable()
	local slot = 0

	for i = #self2.EventTableEdict, 0, -1 do
		self2.EventTableEdict[i] = nil
	end

	self:ResetEvents()

	local eventtable = self2.EventTable
	local keys = table.GetKeys(eventtable)
	table.sort(keys, eventtablesorter)

	for _, key in ipairs(keys) do
		local value = eventtable[key]

		if istable(value) then
			for _, event in SortedPairs(value) do
				if istable(event) then
					event.slot = slot
					slot = slot + 1

					if not event.autodetect then
						if event.type == "lua" then
							if event.server == nil then
								event.server = true
							end
						elseif event.type == "snd" or event.type == "sound" then
							if event.server == nil then
								event.server = false
							end
						elseif event.type == "bg" or event.type == "bodygroup" then
							if event.server == nil then event.server = true end
							if event.view == nil then event.view = true end
							if event.world == nil then event.world = true end
						end

						if event.client == nil then
							event.client = true
						end

						event.autodetect = true
					end

					event.called = false

					if slot > 256 and not self.event_table_warning then
						ErrorNoHalt("[TFA Base] Weapon " .. self:GetClass() .. " got too many events! 256 is maximum! Event table would NOT be properly predicted this time!\n")
						self.event_table_warning = true
					end

					self2.EventTableEdict[event.slot] = event
				end
			end
		end
	end

	self.event_table_overflow = slot > 256
	self._built_event_debug_string_fn = nil

	self._EventSlotCount = math.ceil(slot / 32)
	self._EventSlotNum = slot - 1
	self.event_table_built = true
end

function SWEP:ProcessEvents(firstprediction)
	local viewmodel = self:VMIVNPC()
	if not viewmodel then return end

	if not self.event_table_built then
		self:RebuildEventEdictTable()
	end

	if sp and CLIENT then return end
	if sp and SERVER then return self:ProcessEventsSP() end

	local ply = self:GetOwner()
	local isplayer = ply:IsPlayer()

	local evtbl = self.EventTable[self:GetLastActivity() or -1] or self.EventTable[viewmodel:GetSequenceName(viewmodel:GetSequence())]
	if not evtbl then return end

	local curtime = l_CT()
	local eventtimer = self:GetEventTimer()
	local is_local = CLIENT and ply == LocalPlayer()
	local animrate = self:GetAnimationRate(self:GetLastActivity() or -1)

	self.current_event_iftp = firstprediction
	self.processing_events = true

	for i = 1, #evtbl do
		local event = evtbl[i]
		if self:GetEventPlayed(event.slot) or curtime < eventtimer + event.time / animrate then goto CONTINUE end
		self:SetEventPlayed(event.slot)
		event.called = true

		if not event.autodetect then
			if event.type == "lua" then
				if event.server == nil then
					event.server = true
				end
			elseif event.type == "snd" or event.type == "sound" then
				if event.server == nil then
					event.server = false
				end
			elseif event.type == "bg" or event.type == "bodygroup" then
				if event.server == nil then event.server = true end
				if event.view == nil then event.view = true end
				if event.world == nil then event.world = true end
			end

			if event.client == nil then
				event.client = true
			end

			event.autodetect = true
		end

		if event.type == "lua" then
			if ((event.client and CLIENT and (not event.client_predictedonly or is_local)) or (event.server and SERVER)) and event.value then
				event.value(self, viewmodel, firstprediction)
			end
		elseif event.type == "snd" or event.type == "sound" then
			if SERVER then
				if event.client then
					if not isplayer and player.GetCount() ~= 0 then
						net.Start("tfaSoundEvent", true)
						net.WriteEntity(self)
						net.WriteString(event.value or "")
						net.SendPVS(self:GetPos())
					elseif isplayer then
						net.Start("tfaSoundEvent", true)
						net.WriteEntity(self)
						net.WriteString(event.value or "")
						net.SendOmit(ply)
					end
				elseif event.server and event.value and event.value ~= "" then
					self:EmitSound(event.value)
				end
			elseif event.client and is_local and not sp and event.value and event.value ~= "" then
				if firstprediction or firstprediction == nil then
					if event.time <= 0.01 then
						self:EmitSoundSafe(event.value)
					else
						self:EmitSound(event.value)
					end
				end
			end
		elseif event.type == "bg" or event.type == "bodygroup" then
			if ((event.client and CLIENT and (not event.client_predictedonly or is_local)) or
				(event.server and SERVER)) and (event.name and event.value and event.value ~= "") then

				if event.view then
					self.ViewModelBodygroups[event.name] = event.value
				end

				if event.world then
					self.WorldModelBodygroups[event.name] = event.value
				end
			end
		end

		::CONTINUE::
	end

	self.processing_events = false
	self.current_event_iftp = nil
end

-- This function is exclusively targeting singleplayer
function SWEP:ProcessEventsSP(firstprediction)
	local viewmodel = self:VMIVNPC()
	if not viewmodel then return end

	local evtbl = self.EventTable[self:GetLastActivity() or -1] or self.EventTable[viewmodel:GetSequenceName(viewmodel:GetSequence())]
	if not evtbl then return end

	local curtime = l_CT()
	local eventtimer = self:GetEventTimer()
	local is_local = self:GetOwner() == Entity(1)
	local animrate = self:GetAnimationRate(self:GetLastActivity() or -1)

	self.processing_events = true

	for i = 1, #evtbl do
		local event = evtbl[i]
		if self:GetEventPlayed(event.slot) or curtime < eventtimer + event.time / animrate then goto CONTINUE end
		self:SetEventPlayed(event.slot)
		event.called = true

		if not event.autodetect then
			if event.type == "lua" then
				if event.server == nil then
					event.server = true
				end
			elseif event.type == "snd" or event.type == "sound" then
				if event.server == nil then
					event.server = false
				end
			elseif event.type == "bg" or event.type == "bodygroup" then
				if event.server == nil then event.server = true end
				if event.view == nil then event.view = true end
				if event.world == nil then event.world = true end
			end

			if event.client == nil then
				event.client = true
			end

			event.autodetect = true
		end

		if event.type == "lua" then
			if event.value then
				if event.server then
					event.value(self, viewmodel, true)
				end

				if event.client and (not event.client_predictedonly or is_local) then
					self:CallOnClient("DispatchLuaEvent", tostring(event.slot))
				end
			end
		elseif event.type == "snd" or event.type == "sound" then
			if event.client then
				net.Start("tfaSoundEvent", true)
				net.WriteEntity(self)
				net.WriteString(event.value or "")
				net.Broadcast()
			elseif event.server and event.value and event.value ~= "" then
				self:EmitSound(event.value)
			end
		elseif event.type == "bg" or event.type == "bodygroup" then
			if event.name and event.value and event.value ~= "" then
				if event.server then
					if event.view then
						self.ViewModelBodygroups[event.name] = event.value
					end

					if event.world then
						self.WorldModelBodygroups[event.name] = event.value
					end
				end

				if event.client and (not event.client_predictedonly or is_local) then
					self:CallOnClient("DispatchBodygroupEvent", tostring(event.slot))
				end
			end
		end

		::CONTINUE::
	end

	self.processing_events = false
end

function SWEP:EmitSoundSafe(snd)
	timer.Simple(0, function()
		if IsValid(self) and snd then self:EmitSound(snd) end
	end)
end

local ct, stat, statend, finalstat, waittime, lact

function SWEP:ProcessStatus()
	local self2 = self:GetTable()

	is = self2.GetIronSightsRaw(self)
	spr = self2.GetSprinting(self)
	wlk = self2.GetWalking(self)
	cst = self2.GetCustomizing(self)

	local ply = self:GetOwner()
	local isplayer = ply:IsPlayer()

	if stat == TFA.Enum.STATUS_FIDGET and is then
		self:SetStatusEnd(0)

		self2.Idle_Mode_Old = self2.Idle_Mode
		self2.Idle_Mode = TFA.Enum.IDLE_BOTH
		self2.ChooseIdleAnim(self)

		if sp then
			self:CallOnClient("ChooseIdleAnim", "")
		end

		self2.Idle_Mode = self2.Idle_Mode_Old
		self2.Idle_Mode_Old = nil
		statend = -1
	end

	is = self:GetIronSights()
	stat = self:GetStatus()
	statend = self:GetStatusEnd()

	ct = l_CT()

	if stat ~= TFA.Enum.STATUS_IDLE and ct > statend then
		self:SetFirstDeployEvent(false)
		finalstat = TFA.Enum.STATUS_IDLE

		--Holstering
		if stat == TFA.Enum.STATUS_HOLSTER then
			finalstat = TFA.Enum.STATUS_HOLSTER_READY
			self:SetStatusEnd(ct)
		elseif stat == TFA.Enum.STATUS_HOLSTER_READY then
			self2.FinishHolster(self)
			finalstat = TFA.Enum.STATUS_HOLSTER_FINAL
			self:SetStatusEnd(ct + 0.6)
		elseif stat == TFA.Enum.STATUS_RELOADING_LOOP_START_EMPTY then
			--Shotgun Reloading from empty
			if not self2.IsJammed(self) then
				self2.TakePrimaryAmmo(self, 1, true)
				self2.TakePrimaryAmmo(self, -1)
			end

			if self2.Ammo1(self) <= 0 or self:Clip1() >= self2.GetPrimaryClipSize(self) or self:GetReloadLoopCancel() then
				finalstat = TFA.Enum.STATUS_RELOADING_LOOP_END
				local _, tanim = self2.ChooseShotgunPumpAnim(self)
				self:SetStatusEnd(ct + self:GetActivityLength(tanim))
				self:SetReloadLoopCancel(false)

				if not self:GetReloadLoopCancel() then
					self:SetJammed(false)
				end
			else
				lact = self:GetLastActivity()
				waittime = self2.GetActivityLength(self, lact, false) - self2.GetActivityLength(self, lact, true)

				if waittime > 0.01 then
					finalstat = TFA.Enum.STATUS_RELOADING_WAIT
					self:SetStatusEnd(ct + waittime)
				else
					finalstat = self2.LoadShell(self)
				end

				self:SetJammed(false)
				--finalstat = self:LoadShell()
				--self:SetStatusEnd( self:GetNextPrimaryFire() )
			end
		elseif stat == TFA.Enum.STATUS_RELOADING_LOOP_START then
			--Shotgun Reloading
			finalstat = self2.LoadShell(self)
		elseif stat == TFA.Enum.STATUS_RELOADING_LOOP then
			self2.TakePrimaryAmmo(self, 1, true)
			self2.TakePrimaryAmmo(self, -1)
			lact = self:GetLastActivity()

			if self2.GetActivityLength(self, lact, true) < self2.GetActivityLength(self, lact, false) - 0.01 then
				local sht = self2.GetStatL(self, "LoopedReloadInsertTime")

				if sht then
					sht = sht / self2.GetAnimationRate(self, ACT_VM_RELOAD)
				end

				waittime = (sht or self2.GetActivityLength(self, lact, false)) - self2.GetActivityLength(self, lact, true)
			else
				waittime = 0
			end

			if waittime > 0.01 then
				finalstat = TFA.Enum.STATUS_RELOADING_WAIT
				self:SetStatusEnd(ct + waittime)
			else
				if self2.Ammo1(self) <= 0 or self:Clip1() >= self:GetPrimaryClipSize() or self:GetReloadLoopCancel() then
					finalstat = TFA.Enum.STATUS_RELOADING_LOOP_END
					local _, tanim = self2.ChooseShotgunPumpAnim(self)
					self:SetStatusEnd(ct + self:GetActivityLength(tanim))
					self:SetReloadLoopCancel(false)
				else
					finalstat = self2.LoadShell(self)
				end
			end
		elseif stat == TFA.Enum.STATUS_RELOADING then
			self2.CompleteReload(self)
			lact = self:GetLastActivity()
			waittime = self2.GetActivityLength(self, lact, false) - self2.GetActivityLength(self, lact, true)

			if waittime > 0.01 then
				finalstat = TFA.Enum.STATUS_RELOADING_WAIT
				self:SetStatusEnd(ct + waittime)
			end
		elseif stat == TFA.Enum.STATUS_SILENCER_TOGGLE then
			--self:SetStatusEnd( self:GetNextPrimaryFire() )
			self:SetSilenced(not self:GetSilenced())
			self2.Silenced = self:GetSilenced()
		elseif stat == TFA.Enum.STATUS_RELOADING_WAIT and self:GetStatL("LoopedReload") then
			if self2.Ammo1(self) <= 0 or self:Clip1() >= self:GetPrimaryClipSize() or self:GetReloadLoopCancel() then
				finalstat = TFA.Enum.STATUS_RELOADING_LOOP_END
				local _, tanim = self2.ChooseShotgunPumpAnim(self)
				self:SetStatusEnd(ct + self:GetActivityLength(tanim))
				--self:SetReloadLoopCancel( false )
			else
				finalstat = self2.LoadShell(self)
			end
		elseif stat == TFA.Enum.STATUS_RELOADING_LOOP_END and self:GetStatL("LoopedReload") then
			self:SetReloadLoopCancel(false)
		elseif self2.GetStatL(self, "PumpAction") and stat == TFA.Enum.STATUS_PUMP then
			self:SetReloadLoopCancel(false)
		elseif stat == TFA.Enum.STATUS_SHOOTING and self2.GetStatL(self, "PumpAction") then
			if self:Clip1() == 0 and self2.GetStatL(self, "PumpAction").value_empty then
				--finalstat = TFA.Enum.STATUS_PUMP_READY
				self:SetReloadLoopCancel(true)
			elseif (self2.GetStatL(self, "Primary.ClipSize") < 0 or self:Clip1() > 0) and self2.GetStatL(self, "PumpAction").value then
				--finalstat = TFA.Enum.STATUS_PUMP_READY
				self:SetReloadLoopCancel(true)
			end
		end

		--self:SetStatusEnd( math.huge )
		self:SetStatus(finalstat)
		local smi = self2.Sights_Mode == TFA.Enum.LOCOMOTION_HYBRID or self2.Sights_Mode == TFA.Enum.LOCOMOTION_ANI
		local spi = self2.Sprint_Mode == TFA.Enum.LOCOMOTION_HYBRID or self2.Sprint_Mode == TFA.Enum.LOCOMOTION_ANI
		local wmi = self2.Walk_Mode == TFA.Enum.LOCOMOTION_HYBRID or self2.Walk_Mode == TFA.Enum.LOCOMOTION_ANI
		local cmi = self2.Customize_Mode == TFA.Enum.LOCOMOTION_HYBRID or self2.Customize_Mode == TFA.Enum.LOCOMOTION_ANI

		if
			not TFA.Enum.ReadyStatus[stat] and
			stat ~= TFA.Enum.STATUS_SHOOTING and
			stat ~= TFA.Enum.STATUS_PUMP and
			finalstat == TFA.Enum.STATUS_IDLE and
			((smi or spi) or (cst and cmi))
		then
			is = self2.GetIronSights(self, true)

			if (is and smi) or (spr and spi) or (wlk and wmi) or (cst and cmi) then
				local success, _ = self2.Locomote(self, is and smi, is, spr and spi, spr, wlk and wmi, wlk, cst and cmi, cst)

				if success == false then
					self:SetNextIdleAnim(-1)
				else
					self:SetNextIdleAnim(math.max(self:GetNextIdleAnim(), ct + 0.1))
				end
			end
		end

		self2.LastBoltShoot = nil

		if self:GetBurstCount() > 0 then
			if finalstat ~= TFA.Enum.STATUS_SHOOTING and finalstat ~= TFA.Enum.STATUS_IDLE then
				self:SetBurstCount(0)
			elseif self:GetBurstCount() < self:GetMaxBurst() and self:Clip1() > 0 then
				self:PrimaryAttack()
			else
				self:SetBurstCount(0)
				self:SetNextPrimaryFire(self2.GetNextCorrectedPrimaryFire(self, self2.GetBurstDelay(self)))
			end
		end
	end

	--if stat == TFA.Enum.STATUS_IDLE and self:GetReloadLoopCancel() and (self2.GetStatL(self, "AllowSprintAttack") or self:GetSprintProgress() < 0.1) then
	if stat == TFA.Enum.STATUS_IDLE and self:GetReloadLoopCancel() then
		if self2.GetStatL(self, "PumpAction") then
			if ct > self:GetNextPrimaryFire() and not self:KeyDown(IN_ATTACK) then
				self2.DoPump(self)
			end
		else
			self:SetReloadLoopCancel(false)
		end
	end
end
