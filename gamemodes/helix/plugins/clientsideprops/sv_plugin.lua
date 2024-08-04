--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


util.AddNetworkString("ixClientProps.NetworkProp")
util.AddNetworkString("ixClientProps.RecreateProp")
util.AddNetworkString("ixClientProps.RequestProps")
util.AddNetworkString("ixClientProps.MassRemoveProps")

function PLUGIN:NetworkProp(propData)
	net.Start("ixClientProps.NetworkProp")
		net.WriteTable(propData)
	net.Broadcast()
end
