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

include("shared.lua")

include("common/ai_translations.lua")
include("common/anims.lua")
include("common/autodetection.lua")
include("common/utils.lua")
include("common/stat.lua")
include("common/attachments.lua")
include("common/bullet.lua")
include("common/effects.lua")
include("common/calc.lua")
include("common/akimbo.lua")
include("common/events.lua")
include("common/nzombies.lua")
include("common/ttt.lua")
include("common/viewmodel.lua")
include("common/skins.lua")

include("client/effects.lua")
include("client/viewbob.lua")
include("client/viewmodel.lua")
include("client/bobcode.lua")
include("client/hud.lua")
include("client/mods.lua")
include("client/laser.lua")
include("client/fov.lua")
include("client/flashlight.lua")

TFA.FillMissingMetaValues(SWEP)
