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
ENT.PrintName		= "Leste"
ENT.Author 			= "SOMEBODY SAY HO!"
ENT.Contact 		= "http://steamcommunity.com/profiles/76561198180831682/"
ENT.Information		= "Projectiles for my addons"
ENT.Category		= "Projectiles"

if (CLIENT) then
	local Name = "Leste"
	local LangName = "wolf_fr"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,50,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,50,255))
end