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

SWEP.AnimCycle = SWEP.ViewModelFlip and 0 or 1

function SWEP:FixAkimbo()
	if not self:GetStatL("IsAkimbo") or self.Secondary_TFA.ClipSize <= 0 then return end

	self.Primary_TFA.ClipSize = self.Primary_TFA.ClipSize + self.Secondary_TFA.ClipSize
	self.Secondary_TFA.ClipSize = -1
	self.Primary_TFA.RPM = self.Primary_TFA.RPM * 2
	self.Akimbo_Inverted = self.ViewModelFlip
	self.AnimCycle = self.ViewModelFlip and 0 or 1
	self:SetAnimCycle(self.AnimCycle)
	self:ClearStatCache()

	timer.Simple(FrameTime(), function()
		timer.Simple(0.01, function()
			if IsValid(self) and self:OwnerIsValid() then
				self:SetClip1(self.Primary_TFA.ClipSize)
			end
		end)
	end)
end

function SWEP:ToggleAkimbo(arg1)
	if self:GetStatL("IsAkimbo") then
		self:SetAnimCycle(1 - self:GetAnimCycle())
		self.AnimCycle = self:GetAnimCycle()
	end
end
