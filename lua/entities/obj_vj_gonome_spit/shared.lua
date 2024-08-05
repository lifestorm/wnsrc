--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Corrosive Projectie"
ENT.Author 			= "Random72638"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "It's a projectile type weapon"
ENT.Category		= "Yo Mama"

if (CLIENT) then
	local Name = "Corrosive Projectile"
	local LangName = "obj_vj_corrosive_proj"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end