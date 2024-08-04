--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include("shared.lua")

function SWEP:DropMag()
	net.Start("TFA_CSGO_DropMag", true)
	net.WriteEntity(self)

	if sp then
		net.Broadcast()
	else
		net.SendOmit(self:GetOwner())
	end
end