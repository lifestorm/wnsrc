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

PLUGIN.name = "Third Person Bind"
PLUGIN.author = "AleXXX_007"
PLUGIN.description = "Adds bind to toggle third person."

PLUGIN.bind = KEY_P

if (CLIENT) then
	function PLUGIN:PlayerButtonDown(client, button)
		if (input.LookupKeyBinding(self.bind) == "ix_togglethirdperson") then
			return
		end

		local curTime = CurTime()

		if (button == self.bind and (!client.nextBind or client.nextBind <= curTime)) then
			client:ConCommand("ix_togglethirdperson")
			client.nextBind = curTime + 0.1
		end
	end
end