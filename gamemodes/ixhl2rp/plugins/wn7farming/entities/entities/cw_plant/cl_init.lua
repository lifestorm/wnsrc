--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


include("shared.lua")

function ENT:OnPopulateEntityInfo(container)
    local GrowthPercent = self:GetNWFloat("GrowthPercent")
    local hydration = math.floor(self:GetNWFloat("Hydration"))
    local fertilizer = math.floor(self:GetNWFloat("Fertilizer"))

    local maturity = container:AddRow("maturity")
    maturity:SetImportant()
    maturity:SetText("Maturity: " .. GrowthPercent .. "%")
    maturity:SizeToContents()

    local fertilization = container:AddRow("fertilizer")  
    fertilization:SetImportant()
    fertilization:SetText("Fertilizer: " .. tostring(fertilizer) .. "%")
    fertilization:SizeToContents()

    local water = container:AddRow("hydration")  
    water:SetImportant()
    water:SetText("Hydration: " .. tostring(hydration) .. "%")
    water:SizeToContents()
end


function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()

end

function ENT:Think()

end