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

local LocalPlayer = LocalPlayer
local math = math

local function GetScreenAspectRatio()
	return ScrW() / ScrH()
end

local function ScaleFOVByWidthRatio(fovDegrees, ratio)
	local halfAngleRadians = fovDegrees * (0.5 * math.pi / 180.0)
	local t = math.tan(halfAngleRadians)
	t = t * ratio
	local retDegrees = (180.0 / math.pi) * math.atan(t)

	return retDegrees * 2.0
end

local default_fov_cv = GetConVar("default_fov")

function SWEP:GetTrueFOV()
	local fov = TFADUSKFOV or default_fov_cv:GetFloat()
	local ply = LocalPlayer()

	if not ply:IsValid() then return fov end

	if ply:GetFOV() < ply:GetDefaultFOV() - 1 then
		fov = ply:GetFOV()
	end

	if TFADUSKFOV_FINAL then
		fov = TFADUSKFOV_FINAL
	end

	return fov
end

function SWEP:GetViewModelFinalFOV()
	local fov_default = default_fov_cv:GetFloat()
	local fov = self:GetTrueFOV()
	local flFOVOffset = fov_default - fov
	local fov_vm = self.ViewModelFOV - flFOVOffset
	local aspectRatio = GetScreenAspectRatio() * 0.75 -- (4/3)
	--local final_fov = ScaleFOVByWidthRatio( fov,  aspectRatio )
	local final_fovViewmodel = ScaleFOVByWidthRatio(fov_vm, aspectRatio)

	return final_fovViewmodel
end
