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
local ix = ix
local pairs = pairs

PLUGIN.name = "Autowalk"
PLUGIN.author = "AleXXX_007"
PLUGIN.description = "Allows players to enable autowalk."

ix.option.Add("enableAutoWalkBind", ix.type.bool, true, {
	bNetworked = true,
	category = "General",
})

ix.lang.AddTable("english", {
    optEnableAutoWalkBind = "Enable Auto Walk Bind",
    optdEnableAutoWalkBind = "Enable auto walking forward by pressing the 'n' key.",
})

PLUGIN.bind = KEY_N

local exitKeys = {
	IN_FORWARD,
	IN_BACK,
	IN_MOVELEFT,
	IN_MOVERIGHT
}

function PLUGIN:GetOption(client)
	if (CLIENT) then
		return ix.option.Get("enableAutoWalkBind")
	else
		return ix.option.Get(client, "enableAutoWalkBind")
	end
end

function PLUGIN:SetupMove(client, moveData, cmdData)
	if (!client.autowalk) then return end

	if (ix.fights and client:GetFight()) then
		client.autowalk = nil
		return
	end

	moveData:SetForwardSpeed(moveData:GetMaxSpeed())

	for _, v in pairs(exitKeys) do
		if (cmdData:KeyDown(v)) then
			client.autowalk = nil
		end
	end
end

function PLUGIN:PlayerButtonDown(client, button)
	if (!self:GetOption(client)) then
		client.autowalk = false
		return
	end
	local curTime = CurTime()

	if (button == self.bind and (!client.nextBind or client.nextBind <= curTime)) then
		client.autowalk = !client.autowalk
		client.nextBind = curTime + 0.1
	end
end
