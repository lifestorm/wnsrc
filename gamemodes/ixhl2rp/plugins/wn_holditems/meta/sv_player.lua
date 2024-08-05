--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local playerMeta = FindMetaTable("Player")

function playerMeta:TakeHoldableItem(item, itemHoldData, holdTypeData)
    if (self.ixHoldingItemEnt) then
        if !IsValid(self.ixHoldingItemEnt) then
            self.ixHoldingItemEnt = nil
        else
            return
        end
    end

    local inv = self:GetCharacter():GetInventory()

    local holdableItem = ents.Create("prop_physics")
    holdableItem:SetModel(item:GetModel())

    local pos = self:GetAttachment(self:LookupAttachment(holdTypeData["attachment"])).Pos
    pos = pos + (self:GetUp() * -1)
    pos = pos + (self:GetForward() * itemHoldData.vectorOffset.forward) + (self:GetUp() * itemHoldData.vectorOffset.up) + (self:GetRight() * itemHoldData.vectorOffset.right)

    local ang = self:GetAttachment(self:LookupAttachment(holdTypeData["attachment"])).Ang
    ang:RotateAroundAxis( ang:Forward(), itemHoldData.angleOffset.forward)
    ang:RotateAroundAxis( ang:Right(), itemHoldData.angleOffset.right)
    ang:RotateAroundAxis( ang:Up(), itemHoldData.angleOffset.up)

    holdableItem:SetPos(pos)
    holdableItem:SetAngles(ang)
    holdableItem:Spawn()
    holdableItem:Activate()
    holdableItem:SetSolid(SOLID_NONE)
    holdableItem:PhysicsInit(SOLID_NONE)
    holdableItem:SetParent(self, self:LookupAttachment(holdTypeData["attachment"]))
    holdableItem.item = item
    holdableItem:CallOnRemove("ixHoldable", function(s)
        s:GetParent().ixHoldingItemEnt = nil
        s:GetParent():SetLocalVar("ixHoldableItem", nil)

        if s.item.GetID and ix.item.instances[s.item:GetID()] then
            s.item:SetData("holdBy", nil)
        end
    end)

    self:SetLocalVar("ixHoldableItem", holdableItem)

    local timerID = "ixHoldablesCheckItem" .. holdableItem:EntIndex()

    timer.Create(timerID, 1, 0, function()
        if !IsValid(holdableItem) then
            timer.Remove(timerID)

            return
        end

        if !holdableItem:GetParent():Alive() then
            holdableItem:Remove()

            timer.Remove(timerID)
            return
        end

        local lookingFor = inv:GetItemsByUniqueID(item.uniqueID)
        local found = false
        for _, lItem in pairs(lookingFor) do
            if lItem:GetData("holdBy", false) then
                found = true
                continue
            end
        end

        if !found then
            holdableItem:Remove()

            timer.Remove(timerID)
        end
    end)

    self.ixHoldingItemEnt = holdableItem
    item:SetData("holdBy", self)
end

function playerMeta:PutHoldableItemBack(item)
    if (self.ixHoldingItemEnt and IsValid(self.ixHoldingItemEnt)) then
        self.ixHoldingItemEnt:Remove()
        item:SetData("holdBy", nil)
    else
        item:SetData("holdBy", nil)
    end
end
