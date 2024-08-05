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

util.AddNetworkString("ixRaveDrug")

net.Receive("ixRaveDrug", function(len, client)
	PLUGIN:Clear(client)
end)

ix.log.AddType("drugsRaveRanOut", function(client)
	return string.format("%s raved too hard and could not stand his rave running out.", client:GetName())
end, FLAG_DANGER)

function PLUGIN:Apply(client)
	net.Start("ixRaveDrug")
		net.WriteBool(true)
	net.Send(client)
	client:GetCharacter():SetSpecialBoost("strength", 5, true)
	if (!client:GetNetVar("ixRave")) then
		local oldMaxHealth = client:GetMaxHealth()
		client:SetMaxHealth(client:GetMaxHealth() * 1.5)
		client:SetHealth(math.min(client:GetMaxHealth(), client:Health() + oldMaxHealth))
		client:SetNetVar("ixRave", true)
	end
end

function PLUGIN:Clear(client)
	net.Start("ixRaveDrug")
		net.WriteBool(false)
	net.Send(client)
	if (client:GetNetVar("ixRave")) then
		if (client:Health() < client:GetMaxHealth() / 1.5) then
			client:Kill()
			ix.log.Add(client, "drugsRaveRanOut")
			return
		end
		client:SetHealth(client:Health() - client:GetMaxHealth() / 1.5)
		client:SetMaxHealth(client:GetMaxHealth() / 1.5)
		client:SetNetVar("ixRave", false)
	end
end