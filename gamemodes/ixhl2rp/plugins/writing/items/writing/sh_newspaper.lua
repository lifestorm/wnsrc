--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Newspaper"
ITEM.model = "models/props_junk/garbage_newspaper001a.mdl"
ITEM.identifier = "newspaper"
ITEM.holdData = {
    vectorOffset = {
        right = -1,
        up = 2,
        forward = 1
    },
    angleOffset = {
        right = 0,
        up = 90,
        forward = -90
    },
}   

function ITEM:OnInstanced()
    if self.data and self.data.data then
        if self.data.data.writingID then self:SetData("writingID", self.data.data.writingID) end
        if self.data.data.title then self:SetData("title", self.data.data.title) end
        if self.data.data.cracked then self:SetData("cracked", self.data.data.cracked) end
    end
end