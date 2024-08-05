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

TFA.ENUM_COUNTER = TFA.ENUM_COUNTER or 0

TFA.Enum.InverseStatus = TFA.Enum.InverseStatus or {}
local upper = string.upper

local function gen(input)
	return "STATUS_" .. upper(input)
end

function TFA.AddStatus(input)
	local key = gen(input)
	local getkey = TFA.Enum[key]

	if not getkey then
		getkey = TFA.ENUM_COUNTER
		TFA.ENUM_COUNTER = TFA.ENUM_COUNTER + 1
		TFA.Enum[key] = getkey
	end

	TFA.Enum.InverseStatus[getkey] = key

	return getkey
end

function TFA.GetStatus(input)
	local key = gen(input)
	local getkey = TFA.Enum[key]

	if not getkey then
		return TFA.AddStatus(input) -- DANGEROUS:
		-- Race condition:
		-- If something go terribly wrong and order of addition of new statuses fuck up
		-- everything will fail horribly!
	end

	return getkey
end

TFA.AddStatus("idle")
TFA.AddStatus("draw")
TFA.AddStatus("holster")
TFA.AddStatus("holster_final")
TFA.AddStatus("holster_ready")
TFA.AddStatus("reloading")
TFA.AddStatus("reloading_wait")

TFA.AddStatus("reloading_loop_start")
TFA.AddStatus("reloading_loop_start_empty")
TFA.AddStatus("reloading_loop")
TFA.AddStatus("reloading_loop_end")

TFA.Enum.STATUS_RELOADING_SHOTGUN_START = TFA.Enum.STATUS_RELOADING_LOOP_START
TFA.Enum.STATUS_RELOADING_SHOTGUN_START_SHELL = TFA.Enum.STATUS_RELOADING_LOOP_START_EMPTY
TFA.Enum.STATUS_RELOADING_SHOTGUN_LOOP = TFA.Enum.STATUS_RELOADING_LOOP
TFA.Enum.STATUS_RELOADING_SHOTGUN_END = TFA.Enum.STATUS_RELOADING_LOOP_END

TFA.AddStatus("shooting")
TFA.AddStatus("silencer_toggle")
TFA.AddStatus("bashing")
TFA.AddStatus("bashing_wait")
TFA.AddStatus("inspecting")
TFA.AddStatus("fidget")
TFA.AddStatus("firemode")

TFA.AddStatus("pump")

TFA.AddStatus("grenade_pull")
TFA.AddStatus("grenade_ready")
TFA.AddStatus("grenade_throw")

TFA.AddStatus("blocking")
TFA.AddStatus("blocking_end")

TFA.AddStatus("bow_shoot")
TFA.AddStatus("bow_cancel")

TFA.AddStatus("grenade_pull")
TFA.AddStatus("grenade_throw")
TFA.AddStatus("grenade_ready")
TFA.AddStatus("grenade_throw_wait")

TFA.Enum.HolsterStatus = {
	[TFA.Enum.STATUS_HOLSTER] = true,
	[TFA.Enum.STATUS_HOLSTER_FINAL] = true,
	[TFA.Enum.STATUS_HOLSTER_READY] = true
}

TFA.Enum.HolsterStatusFinal = {
	[TFA.Enum.STATUS_HOLSTER_FINAL] = true,
	[TFA.Enum.STATUS_HOLSTER_READY] = true
}

TFA.Enum.ReloadStatus = {
	[TFA.Enum.STATUS_RELOADING] = true,
	[TFA.Enum.STATUS_RELOADING_WAIT] = true,
	[TFA.Enum.STATUS_RELOADING_LOOP_START] = true,
	[TFA.Enum.STATUS_RELOADING_LOOP_START_EMPTY] = true,
	[TFA.Enum.STATUS_RELOADING_LOOP] = true,
	[TFA.Enum.STATUS_RELOADING_LOOP_END] = true
}

TFA.Enum.ReadyStatus = {
	[TFA.Enum.STATUS_IDLE] = true,
	[TFA.Enum.STATUS_INSPECTING] = true,
	[TFA.Enum.STATUS_FIDGET] = true
}

TFA.Enum.IronStatus = {
	[TFA.Enum.STATUS_IDLE] = true,
	[TFA.Enum.STATUS_SHOOTING] = true,
	[TFA.Enum.STATUS_PUMP] = true,
	[TFA.Enum.STATUS_FIREMODE] = true--,
	--[TFA.Enum.STATUS_FIDGET] = true
}

TFA.Enum.HUDDisabledStatus = {
	[TFA.Enum.STATUS_IDLE] = true,
	[TFA.Enum.STATUS_SHOOTING] = true,
	[TFA.Enum.STATUS_FIREMODE] = true,
	[TFA.Enum.STATUS_BASHING] = true,
	[TFA.Enum.STATUS_BASHING_WAIT] = true,
	[TFA.Enum.STATUS_HOLSTER] = true,
	[TFA.Enum.STATUS_HOLSTER_FINAL] = true,
	[TFA.Enum.STATUS_HOLSTER_READY] = true,
	[TFA.Enum.STATUS_GRENADE_PULL] = true,
	[TFA.Enum.STATUS_GRENADE_READY] = true,
	[TFA.Enum.STATUS_GRENADE_THROW] = true,
	[TFA.Enum.STATUS_BLOCKING] = true,
	[TFA.Enum.STATUS_BLOCKING_END] = true,
	[TFA.Enum.STATUS_PUMP] = true
}

TFA.Enum.SHOOT_IDLE = 0
TFA.Enum.SHOOT_START = 1
TFA.Enum.SHOOT_LOOP = 2
TFA.Enum.SHOOT_CHECK = 3
TFA.Enum.SHOOT_END = 4

TFA.Enum.ShootReadyStatus = {
	[TFA.Enum.SHOOT_IDLE] = true,
	[TFA.Enum.SHOOT_END] = true
}

TFA.Enum.ShootLoopingStatus = {
	[TFA.Enum.SHOOT_START] = true,
	[TFA.Enum.SHOOT_LOOP] = true,
	[TFA.Enum.SHOOT_CHECK] = true
}
