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

ATTACHMENT.Name = "Foregrip"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["+"], "30% lower H-recoil", TFA.Attachments.Colors["+"], "10% lower V-recoil", TFA.Attachments.Colors["-"], "10% higher spread recovery" }
ATTACHMENT.Icon = "entities/tfa_si_eotech.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "FGRIP"
ATTACHMENT.TFADataVersion = TFA.LatestDataVersion

local defaultbl = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }

local function LerpBoneMods( t, b1, b2 )
	local tbl = table.Copy(b1)
	for k,v in pairs(b2) do
		if not tbl[k] then
			tbl[k] = table.Copy(defaultbl)
		end
		tbl[k].scale = LerpVector( t, tbl[k].scale, v.scale )
		tbl[k].pos = LerpVector( t, tbl[k].pos, v.pos )
		tbl[k].angle = LerpAngle( t, tbl[k].angle, v.angle )
	end
	return tbl
end

ATTACHMENT.WeaponTable = {
	["ViewModelElements"] = {
		["foregrip"] = {
			["active"] = true
		}
	},
	["WorldModelElements"] = {
		["foregrip"] = {
			["active"] = true
		}
	},
	["Primary"] = {
		["SpreadRecovery"] = function(wep,stat) return stat * 1.1 end,
		["KickUp"] = function(wep,stat) return stat * 0.9 end,
		["KickDown"] = function(wep,stat) return stat * 0.9 end,
		["KickHorizontal"] = function(wep,stat) return stat * 0.7 end,
	},
	["ViewModelBoneMods"] = function(wep,tbl)
		if wep.GripBoneMods then
			wep.GripFactor = wep.GripFactor or 0
			local CanGrip = true
			if wep.GripBadActivities and wep.GripBadActivities[ wep:GetLastActivity() ] and wep:VMIV() then
				local cyc = wep.OwnerViewModel:GetCycle()
				if cyc > wep.GripBadActivities[ wep:GetLastActivity() ][1] and cyc < wep.GripBadActivities[ wep:GetLastActivity() ][2] then
					CanGrip = false
				end
			end
			wep.GripFactor = math.Approach( wep.GripFactor, CanGrip and 1 or 0, ( ( CanGrip and 1 or 0 ) - wep.GripFactor ) * TFA.FrameTime() * ( wep.GripLerpSpeed or 20 ) )
			return LerpBoneMods( wep.GripFactor, tbl, wep.GripBoneMods )
		end
	end
}

function ATTACHMENT:Attach(wep)
	wep.GripFactor = 0
end

function ATTACHMENT:Detach(wep)
	wep.GripFactor = 0
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
