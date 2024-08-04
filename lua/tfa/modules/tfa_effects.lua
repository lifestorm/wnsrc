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

TFA.Effects = TFA.Effects or {}
local Effects = TFA.Effects

Effects.Overrides = Effects.Overrides or {}
local Overrides = Effects.Overrides

function Effects.AddOverride(target, override)
	assert(type(target) == "string", "No target effect name or not a string")
	assert(type(override) == "string", "No override effect name or not a string")

	Overrides[target] = override
end

function Effects.GetOverride(target)
	if Overrides[target] then
		return Overrides[target]
	end

	return target
end

local util_Effect = util.Effect

function Effects.Create(effectName, effectData, allowOverride, ignorePredictionOrRecipientFilter)
	effectName = Effects.GetOverride(effectName)

	util_Effect(effectName, effectData, allowOverride, ignorePredictionOrRecipientFilter)
end

if SERVER then
	AddCSLuaFile("tfa/muzzleflash_base.lua")
end
