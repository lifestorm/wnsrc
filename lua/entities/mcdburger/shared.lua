--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "McDonalds Cheeseburger"
ENT.Author = "SaDow4100"
ENT.Contact = "Steam"
ENT.Purpose = "A cheeseburger from McDonalds"
ENT.Instructions = "E" 
ENT.Category = "Food"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

function ENT:SetupModel()

	self.Entity:SetModel("models/FoodNHouseholdItems/burgersims2.mdl")
	
end