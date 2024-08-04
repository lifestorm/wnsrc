--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()

ENT.Base                      = "arccw_ammo"

ENT.PrintName                 = "Sniper Ammo"
ENT.Category                  = "ArcCW - Ammo"

ENT.Spawnable                 = true
ENT.Model                     = "models/items/arccw/sniper_ammo.mdl"

ENT.AmmoType = "SniperPenetratedRound"
ENT.AmmoCount = 10
ENT.MaxHealth = 20
if engine.ActiveGamemode() == "terrortown" then
    ENT.AmmoType = "357"
end

ENT.DetonationDamage = 80
ENT.DetonationRadius = 128
ENT.DetonationSound = "npc/sniper/echo1.wav"