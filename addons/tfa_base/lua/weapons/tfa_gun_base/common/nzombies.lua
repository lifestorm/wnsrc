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

SWEP.OldPaP = false
SWEP.OldSpCola = false
SWEP.SpeedColaFactor = 2 --Amount to speed up by when u get dat speed cola
SWEP.SpeedColaActivities = {
	[ACT_VM_DRAW] = true,
	[ACT_VM_DRAW_EMPTY] = true,
	[ACT_VM_DRAW_SILENCED] = true,
	[ACT_VM_DRAW_DEPLOYED or 0] = true,
	[ACT_VM_RELOAD] = true,
	[ACT_VM_RELOAD_EMPTY] = true,
	[ACT_VM_RELOAD_SILENCED] = true,
	[ACT_VM_HOLSTER] = true,
	[ACT_VM_HOLSTER_EMPTY] = true,
	[ACT_VM_HOLSTER_SILENCED] = true,
	[ACT_SHOTGUN_RELOAD_START] = true,
	[ACT_SHOTGUN_RELOAD_FINISH] = true
}
SWEP.DTapActivities = {
	[ACT_VM_PRIMARYATTACK] = true,
	[ACT_VM_PRIMARYATTACK_EMPTY] = true,
	[ACT_VM_PRIMARYATTACK_SILENCED] = true,
	[ACT_VM_PRIMARYATTACK_1] = true,
	[ACT_VM_SECONDARYATTACK] = true,
	[ACT_VM_HITCENTER] = true,
	[ACT_SHOTGUN_PUMP] = true
}
SWEP.DTapSpeed = 1 / 0.8
SWEP.DTap2Speed = 1 / 0.8

local nzombies

local count, upperclamp

function SWEP:NZMaxAmmo()
	if nzombies == nil then
		nzombies = engine.ActiveGamemode() == "nzombies"
	end
	local at = self:GetPrimaryAmmoType()
	local at2 = self.GetSecondaryAmmoType and self:GetSecondaryAmmoType() or self.Secondary_TFA.Ammo

	if IsValid(self:GetOwner()) then
		if self:GetStatL("Primary.ClipSize") <= 0 then
			count = math.Clamp(10, 300 / (self:GetStatL("Primary.Damage") / 30), 10, 300)
			if self.Primary_TFA.NZMaxAmmo and self.Primary_TFA.NZMaxAmmo > 0 then
				count = self.Primary_TFA.NZMaxAmmo
				if self:GetPaP() then
					count = count * 5 / 3
				end
			end
			self:GetOwner():SetAmmo(count, at)
		else
			upperclamp = self:GetPaP() and 600 or 300
			count = math.Clamp(math.abs(self:GetStatL("Primary.ClipSize")) * 10, 10, upperclamp)
			count = count + self:GetStatL("Primary.ClipSize") - self:Clip1()
			if self.Primary_TFA.NZMaxAmmo and self.Primary_TFA.NZMaxAmmo > 0 then
				count = self.Primary_TFA.NZMaxAmmo
				if self:GetPaP() then
					count = count * 5 / 3
				end
			end
			self:GetOwner():SetAmmo(count, at)
		end
		if self:GetStatL("Secondary.ClipSize") > 0 or self:GetSecondaryAmmoType() >= 0 then
			if self:GetStatL("Secondary.ClipSize") <= 0 then
				count = math.ceil( math.Clamp(10, 300 / math.pow( ( self:GetStatL("Secondary.Damage") or 100 ) / 30, 2 ), 10, 300) / 5 ) * 5
				if self.Secondary_TFA.NZMaxAmmo and self.Secondary_TFA.NZMaxAmmo > 0 then
					count = self.Secondary_TFA.NZMaxAmmo
					if self:GetPaP() then
						count = count * 5 / 3
					end
				end
				self:GetOwner():SetAmmo(count, at2)
			else
				upperclamp = self:GetPaP() and 600 or 300
				count = math.Clamp(math.abs(self:GetStatL("Secondary.ClipSize")) * 10, 10, upperclamp)
				count = count + self:GetStatL("Secondary.ClipSize") - self:Clip2()
				if self.Secondary_TFA.NZMaxAmmo and self.Secondary_TFA.NZMaxAmmo > 0 then
					count = self.Secondary_TFA.NZMaxAmmo
					if self:GetPaP() then
						count = count * 5 / 3
					end
				end
				self:GetOwner():SetAmmo(count, at2)
			end
		end
	end
end

function SWEP:GetPaP()
	return ( self.HasNZModifier and self:HasNZModifier("pap") ) or self.pap or false
end

function SWEP:IsPaP()
	return self:GetPaP()
end