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

util.AddNetworkString("ixSapphireDrug")

net.Receive("ixSapphireDrug", function(len, client)
	PLUGIN:Clear(client)
end)

function PLUGIN:Apply(client)
	net.Start("ixSapphireDrug")
		net.WriteBool(true)
	net.Send(client)
	client:GetCharacter():SetSpecialBoost("strength", -3, true)
	client:GetCharacter():SetSpecialBoost("perception", 6, true)
	client:GetCharacter():SetSpecialBoost("intelligence", 5, true)
	if (!client:GetNetVar("ixSapphire")) then
		client:SetNetVar("ixSapphire", true)
	end
end

function PLUGIN:Clear(client)
	net.Start("ixSapphireDrug")
		net.WriteBool(false)
	net.Send(client)
	if (client:GetNetVar("ixSapphire")) then
		client:SetNetVar("ixSapphire", false)
	end
end