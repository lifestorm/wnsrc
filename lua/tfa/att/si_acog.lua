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

if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Base = "si_rt_base"
ATTACHMENT.Name = "ACOG"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["="], "4x zoom", TFA.Attachments.Colors["-"], "20% higher zoom time",  TFA.Attachments.Colors["-"], "10% slower aimed walking" }
ATTACHMENT.Icon = "entities/tfa_si_acog.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "ACOG"
ATTACHMENT.TFADataVersion = TFA.LatestDataVersion

local fov = 90 / 4 / 2 -- Default FOV / Scope Zoom / screenscale

ATTACHMENT.WeaponTable = {
	["ViewModelElements"] = {
		["acog"] = {
			["active"] = true
		},
		["rtcircle_acog"] = {
			["active"] = true
		}
	},
	["WorldModelElements"] = {
		["acog"] = {
			["active"] = true
		}
	},
	["IronSightsPosition"] = function( wep, val ) return wep.IronSightsPos_ACOG or val, true end,
	["IronSightsAngle"] = function( wep, val ) return wep.IronSightsAng_ACOG or val, true end,
	["IronSightsSensitivity"] = function(wep,val) return TFA.CalculateSensitivtyScale( fov, wep:GetStatL("Secondary.OwnerFOV"), wep.ACOGScreenScale ) end ,
	["Secondary"] = {
		["OwnerFOV"] = function( wep, val ) return val * 0.7 end
	},
	["IronSightTime"] = function( wep, val ) return val * 1.20 end,
	["IronSightMoveSpeed"] = function(stat) return stat * 0.9 end,
	["RTOpaque"] = true,
	["RTMaterialOverride"] = -1,

	["RTScopeFOV"] = 90 / 4 / 2, -- Default FOV / Scope Zoom / screenscale

	["RTReticleMaterial"] = Material("scope/gdcw_acog"),
	["RTReticleScale"] = 1,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
