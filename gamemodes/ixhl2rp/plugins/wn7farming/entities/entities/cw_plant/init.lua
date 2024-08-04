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

include("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

function ENT:Initialize()
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_WORLD)
    self:DrawShadow(false)

    local phys = self:GetPhysicsObject()

    if (IsValid(phys)) then
        phys:EnableMotion(false)
        phys:Sleep()
    end

    self:SetModelScale(0.25)

    timer.Create("PlantGrowthTimer_" .. self:EntIndex(), 1, 0, function()
        local hydration = self.Hydration
        local fertilizerFactor = self.Fertilizer
        local growTime = self.GrowTime 

        fertilizerFactor = math.max(0, math.min(fertilizerFactor, 100))
        growTime = math.max(math.floor(growTime - (1 * (1 + fertilizerFactor / 100))), 0)
        hydration = math.max(hydration - 0.0111, 0) 

        local initialGrowTime = self.InitialGrowTime

        if growTime > 0 and self.isRuined != true then
            local growthPercent = 100 * (1 - (growTime / initialGrowTime))

            if hydration <= 0 or self.HasSun then 
                self:Wither(0.15)
            end 
            
            self.GrowTime = growTime 
            self.Hydration = hydration
            self.GrowthPercent  = math.Round(growthPercent)

            self:SetNWFloat("GrowTime", growTime)
            self:SetNWFloat("Hydration", hydration)
            self:SetNWFloat("GrowthPercent", math.Round(growthPercent))

            self:SetModelScale(0.25 + (1.0 - 0.25) * (growthPercent / 100), 0.1)
        else 
            timer.Remove("PlantGrowthTimer_" .. self:EntIndex())
        end 
    end)
end

function ENT:Wither(amount) 
    if amount and not self.isRuined then 
        self.witherchance = self.witherchance or 0 + amount

        if self.witherchance > 60 then 
            if math.random(1, 50) == 50 then 
                self:SetColor(Color(74,73,0))
                self.isRuined = true  
            end 
        elseif self.witherchance >= 80 then  
            self:SetColor(Color(74,73,0))
            self.isRuined = true
        end 
    end 
end 

function ENT:OnTakeDamage(dmg)
    local player = dmg:GetAttacker()

    if (player:IsPlayer()) then
        self:Remove()
    end
end

function ENT:Use(activator)
    if !(activator:GetCharacter():GetFaction() == FACTION_VORT) && self.vortOnly then
        activator:Notify("You have no idea how to work with this strange plant.")
        return false
    end

    if self.isRuined == true and not self.isGathering then 
        self.isGathering = true
        activator:Freeze(true)

        activator:SetAction("Harvesting...", 5, function()
            self.isGathering = false
            activator:Freeze(false)

            activator:ChatNotify("It was too much for the plant...")
            if (self.returnSeed) then
                activator:GetCharacter():GetInventory():Add(self.usedSeed)
            end
            self:Remove()
        end)
    end 

    if self.GrowthPercent >= 99 and not self.isGathering then
        if not activator:Crouching() then
            activator:Notify("You need to be crouching to harvest this plant!")
            return false
        end

        self.isGathering = true
        activator:Freeze(true)
        activator:SetAction("Harvesting...", 5, function()
            local seed = self.Harvest
            self.isGathering = false
            activator:Freeze(false)

            character = activator:GetCharacter()
            cookingSkill = 0 
          
            local extraHarvest = (cookingSkill / 10) or 0 
            local plusHarvest = math.floor(extraHarvest)
            local totalHarvest = self.baseHarvest + plusHarvest

            for i = 1, totalHarvest do
                activator:GetCharacter():GetInventory():Add(seed)
            end

            if (self.returnSeed) then
                activator:GetCharacter():GetInventory():Add(self.usedSeed)
            end
            
            activator:GetCharacter():DoAction("harvest_plant")
            activator:ChatNotify("You've gained:" ..totalHarvest.. " total fruits from this plant!")
           
            activator:ChatNotify("The harvest is bountiful.")
        
            self:Remove()
        end)
    else
        activator:Notify("This plant has not yet matured. You need to wait a while longer!")
    end
end

function ENT:OnRemove()
    timer.Remove("PlantGrowthTimer_" .. self:EntIndex())
end