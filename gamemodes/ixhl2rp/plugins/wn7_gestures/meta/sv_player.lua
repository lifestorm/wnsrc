--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local playerMeta = FindMetaTable("Player")

function playerMeta:PlayGestureAnimation(animation)
	net.Start("ixGestureAnimation")
		net.WriteEntity(self)
		net.WriteString(animation)
	net.SendPVS( self:GetPos() )
end

net.Receive("ixAskForGestureAnimation", function(len, client)
	local gest = net.ReadString()

	if not client:IsPlayer() or (client.ixGestDelay and client.ixGestDelay > CurTime()) then return end
	client:PlayGestureAnimation(client:LookupSequence(gest))
	client.ixGestDelay = CurTime() + 1
end)