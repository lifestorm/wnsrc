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

DEFINE_BASECLASS( "base_anim" )

ENT.Base = "base_entity"
ENT.Type = "anim"

ENT.PrintName = "Cigarette"
ENT.Author = "Fruity"
ENT.Information = "A cigarette that smokes."
ENT.Category = "HL2 RP"

ENT.Editable = true
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.AdminOnly = true

ENT.smokeDelay = 0

ENT.flexIndexAshes = 1
ENT.addValueAshes = 0.05
ENT.minValueAshes = 0
ENT.maxValueAshes = 0.5

ENT.flexIndexLength = 0
ENT.addValueLength = 0.01
ENT.minValueLength = 0
ENT.maxValueLength = 1

ENT.AutomaticFrameAdvance = true -- Must be set on client

function ENT:SpawnFunction( client, tr, ClassName )
	if (!client:Alive()) then return false end

	local base = ents.Create( ClassName )
	base:SetParent(client)
	base:SetOwner(client)

	return base
end

function ENT:Initialize()
end

function ENT:ChangeSkinStateTimer()
	PLUGIN:ChangeSkinStateTimer(self)
end

function ENT:CreateJetLengthTimer()
	PLUGIN:CreateJetLengthTimer(self)
end

-- Cigarette gets smaller over time and ashes effect
function ENT:GetAshesValue()
	return PLUGIN:GetAshesValue(self)
end

function ENT:GetLengthValue(currentLength)
	return PLUGIN:GetLengthValue(self, currentLength)
end

function ENT:Think()
	if (SERVER) then
		PLUGIN:CigaretteThink(self)
	end
end

function ENT:Draw()
	if (!IsValid(self) or !IsValid(self:GetParent())) then return false end

	if (self:GetParent():GetMoveType() == 8) then
		return false
	end

	if (LocalPlayer() == self:GetParent() and !ix.option.Get("firstPersonCigarette", true)) then
		if ix.config.Get("thirdperson") then
			if !ix.option.Get("thirdpersonEnabled", false) then
				return false
			end
		else
			return false
		end
	end

    self:DrawModel()
end
