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

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/freeman/arcade_pong.mdl")
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()
end

function ENT:Use(ply)

	local tr = ply:GetEyeTrace().HitPos
	local pos = self:WorldToLocal(tr)

	if pos.x < -22.174904 and pos.x > -23.252708 and pos.y < 9.953964 and pos.y > 8.003653 and pos.z < -2.079835 and pos.z > -6.987538 then
		if ix.config.Get("arcadeDisableTokenSystem") then
			net.Start("arcade_open_pong")
			net.Send(ply)
		else
			net.Start("arcade_request_pong")
			net.Send(ply)
		end
	end
	
	net.Receive("arcade_accept_pong", function(_, client)
		PLUGIN:PayArcade(client, function()
			timer.Simple(1.5, function()
				net.Start("arcade_open_pong")
				net.Send(client)
			end)
		end)
	end)
end

function ENT:Think()
end
