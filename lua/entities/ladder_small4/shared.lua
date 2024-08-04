--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if (SERVER) then
	AddCSLuaFile();
end;

ENT.Type 			= "anim";
ENT.Base 			= "ladder_base";
ENT.PrintName		= "Ladder (Small - Wood)"
ENT.Category		= "Ladders"
ENT.Spawnable		= true
ENT.AdminOnly		= false
ENT.Model			= Model("models/props/cs_militia/ladderwood.mdl");
ENT.RenderGroup 	= RENDERGROUP_BOTH;