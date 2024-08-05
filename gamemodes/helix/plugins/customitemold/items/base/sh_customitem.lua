--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Generic Item"
ITEM.description = "Generic Description"
ITEM.model = Model("models/maxofs2d/hover_rings.mdl")

function ITEM:GetName()
    return self:GetData("name", "Custom Item")
end

function ITEM:GetDescription()
    return self:GetData("description", "Custom item description.")
end

function ITEM:GetModel()
    return self:GetData("model", "models/Gibs/HGIBS.mdl")
end

function ITEM:GetMaterial()
    return self:GetData("material", nil)
end
