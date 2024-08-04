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

local IsSinglePlayer = game.SinglePlayer()

util.AddNetworkString("TFA_SetServerCommand")

local function QueueConVarChange(convarname, convarvalue)
	if not convarname or not convarvalue then return end

	timer.Create("tfa_cvarchange_" .. convarname, 0.1, 1, function()
		if not string.find(convarname, "_tfa") or not GetConVar(convarname) then return end -- affect only TFA convars

		RunConsoleCommand(convarname, convarvalue)
	end)
end

local function ChangeServerOption(_length, _player)
	local _cvarname = net.ReadString()
	local _value = net.ReadString()

	if IsSinglePlayer then return end
	if not IsValid(_player) or not _player:IsAdmin() then return end

	QueueConVarChange(_cvarname, _value)
end

net.Receive("TFA_SetServerCommand", ChangeServerOption)
