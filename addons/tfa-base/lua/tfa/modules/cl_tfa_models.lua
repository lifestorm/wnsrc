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

TFA.ClientsideModels = TFA.ClientsideModels or {}

timer.Create("TFA_UpdateClientsideModels", 0.1, 0, function()
	local i = 1

	while i <= #TFA.ClientsideModels do
		local t = TFA.ClientsideModels[i]

		if not t then
			table.remove(TFA.ClientsideModels, i)
		elseif not IsValid(t.wep) then
			t.mdl:Remove()
			table.remove(TFA.ClientsideModels, i)
		elseif IsValid(t.wep:GetOwner()) and t.wep:GetOwner().GetActiveWeapon and t.wep ~= t.wep:GetOwner():GetActiveWeapon() then
			t.mdl:Remove()
			table.remove(TFA.ClientsideModels, i)
		elseif t.wep.IsHidden and t.wep:IsHidden() then
			t.mdl:Remove()
			table.remove(TFA.ClientsideModels, i)
		else
			i = i + 1
		end
	end

	if #TFA.ClientsideModels == 0 then
		timer.Stop("TFA_UpdateClientsideModels")
	end
end)

if #TFA.ClientsideModels == 0 then
	timer.Stop("TFA_UpdateClientsideModels")
end

function TFA.RegisterClientsideModel(cmdl, wepv) -- DEPRECATED
	-- don't use please
	-- pleaz
	TFA.ClientsideModels[#TFA.ClientsideModels + 1] = {
		["mdl"] = cmdl,
		["wep"] = wepv
	}

	timer.Start("TFA_UpdateClientsideModels")
end

local function NotifyShouldTransmit(ent, notdormant)
	if notdormant or not ent.IsTFAWeapon then return end
	if ent:GetOwner() == LocalPlayer() then return end

	ent:CleanModels(ent:GetStatRaw("ViewModelElements", TFA.LatestDataVersion))
	ent:CleanModels(ent:GetStatRaw("WorldModelElements", TFA.LatestDataVersion))
end

local function EntityRemoved(ent)
	if not ent.IsTFAWeapon then return end

	ent:CleanModels(ent:GetStatRaw("ViewModelElements", TFA.LatestDataVersion))
	ent:CleanModels(ent:GetStatRaw("WorldModelElements", TFA.LatestDataVersion))
end

hook.Add("NotifyShouldTransmit", "TFA_ClientsideModels", NotifyShouldTransmit)
hook.Add("EntityRemoved", "TFA_ClientsideModels", EntityRemoved)
