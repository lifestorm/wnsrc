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

-- luacheck: globals ACT_VM_FIDGET_EMPTY ACT_VM_FIDGET_SILENCED ACT_VM_BLOWBACK ACT_VM_HOLSTER_SILENCED
TFA.Enum.ANIMATION_ACT = 0
TFA.Enum.ANIMATION_SEQ = 1
ACT_VM_FIDGET_EMPTY = ACT_VM_FIDGET_EMPTY or ACT_CROSSBOW_FIDGET_UNLOADED
ACT_VM_FIDGET_SILENCED = ACT_VM_FIDGET_SILENCED or ACT_RPG_FIDGET_UNLOADED
ACT_VM_HOLSTER_SILENCED = ACT_VM_HOLSTER_SILENCED or ACT_CROSSBOW_HOLSTER_UNLOADED
ACT_VM_BLOWBACK = ACT_VM_BLOWBACK or -2

-- luacheck: globals ACT_VM_RELOAD_ADS ACT_VM_RELOAD_EMPTY_ADS ACT_VM_RELOAD_SILENCED_ADS ACT_SHOTGUN_RELOAD_START_ADS ACT_SHOTGUN_RELOAD_FINISH_ADS
ACT_VM_RELOAD_ADS = ACT_VM_RELOAD_ADS or ACT_IDLE_AIM_RIFLE_STIMULATED
ACT_VM_RELOAD_EMPTY_ADS = ACT_VM_RELOAD_EMPTY_ADS or ACT_WALK_AIM_RIFLE_STIMULATED
ACT_VM_RELOAD_SILENCED_ADS = ACT_VM_RELOAD_SILENCED_ADS or ACT_RUN_AIM_RIFLE_STIMULATED
ACT_SHOTGUN_RELOAD_START_ADS = ACT_SHOTGUN_RELOAD_START_ADS or ACT_IDLE_SHOTGUN_RELAXED
ACT_SHOTGUN_RELOAD_FINISH_ADS = ACT_SHOTGUN_RELOAD_FINISH_ADS or ACT_IDLE_SHOTGUN_STIMULATED
