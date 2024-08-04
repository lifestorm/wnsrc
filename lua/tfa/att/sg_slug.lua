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

ATTACHMENT.Name = "Slug Ammunition"
ATTACHMENT.ShortName = "Slug" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["+"], "Much lower spread", TFA.Attachments.Colors["+"], "100m higher range", TFA.Attachments.Colors["-"], "30% less damage", "One pellet"  }
ATTACHMENT.Icon = "entities/tfa_ammo_slug.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.TFADataVersion = TFA.LatestDataVersion

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return wep.Primary_TFA.NumShots * stat * 0.7 end,
		["NumShots"] = function( wep, stat ) return 1, true end,
		["Spread"] = function( wep, stat ) return math.max( stat - 0.015, stat * 0.5 ) end,
		["IronAccuracy"] = function( wep, stat ) return math.max( stat - 0.03, stat * 0.25 ) end,
		["Range"] = function( wep, stat ) return stat + 100 * 39.370 end
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
