--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

PLUGIN.name = "Disable Character Swap"
PLUGIN.author = "Zak"
PLUGIN.description = "Prevents players from switching characters when enabled."
PLUGIN.license = [[
Copyright 2018 Zak
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

ix.config.Add("charSwapDisabled", false, "Should switching characters be disabled?", nil, {
	category = "characters",
	silent = true
})

ix.lang.AddTable("english", {
	cmdToggleCharSwap = "Toggle character swapping.",
	cmdCharSwapBan = "Prevent player from swapping character for declared duration (in minutes). 0 for permanent swap ban."
})

ix.lang.AddTable("spanish", {
	cmdToggleCharSwap = "Alternar el cambio de personaje.",
	cmdCharSwapBan = "Impide al jugador cambiar de personaje por una duración determinada (en minutos). 0 para bloquear el cambio de forma permanente."
})

CAMI.RegisterPrivilege({
	Name = "Helix - Bypass CharSwap Disable",
	MinAccess = "admin"
})

do
	local COMMAND = {
		description = "@cmdToggleCharSwap",
		superAdminOnly = true
	}

	function COMMAND:OnRun(client)
		local newValue = !ix.config.Get("charSwapDisabled")

		ix.config.Set("charSwapDisabled", newValue)

		client:Notify(newValue and "Character swapping is now disabled." or "Character swapping has been re-enabled.")
	end

	ix.command.Add("ToggleCharSwap", COMMAND)

	local COMMAND = {
		description = "@cmdCharSwapBan",
		arguments = {
			ix.type.player,
			ix.type.number
		},
		adminOnly = true
	}

	function COMMAND:OnRun(client, target, duration)
		if (IsValid(target) and target:GetCharacter()) then
			target:SetData("nextCharacterSwap", os.time() + duration * 60)
			target:SetData("allowedCharacter", target:GetCharacter():GetID())

			if (client != target) then
				client:Notify(target:GetName().." has been banned from swapping characters for "..duration.." minute(s)")
			end
		end
	end

	ix.command.Add("CharSwapBan", COMMAND)
end

if (SERVER) then
	function PLUGIN:CanPlayerUseCharacter(client, character)
		local currentCharacter = client:GetCharacter()
		local cantBypass = !CAMI.PlayerHasAccess(client, "Helix - Bypass CharSwap Disable")
		local nextSwap = client:GetData("nextCharacterSwap", -1)
		local timeCheck = nextSwap >= os.time()

		if (nextSwap == 0) then
			timeCheck = true
		end

		if (currentCharacter and cantBypass and (ix.config.Get("charSwapDisabled") == true or timeCheck)) then
			return false, "Character swapping is prohibited at this time"
		end

		if (!currentCharacter and client:GetData("allowedCharacter") and character:GetID() != client:GetData("allowedCharacter") and timeCheck) then
			return false, "Character swapping is prohibited at this time"
		end
	end
end
