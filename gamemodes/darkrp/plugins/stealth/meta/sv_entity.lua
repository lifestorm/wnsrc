--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local entityMeta = FindMetaTable("Entity")

function entityMeta:StealthOpenDoor()
    if (!self.stealthOpen) then
        self.stealthOpen = true

        self.oldSpeed = self:GetInternalVariable("Speed")
        self:SetSaveValue("Speed", self.oldSpeed / 2)

        local uniqueID = self:EntIndex() and self:EntIndex() or tostring(self:GetPos())

        timer.Create("resetDoorStealthValue" .. uniqueID, 5 * (self:GetInternalVariable("speed") / (self:GetClass() == "prop_door_rotating" and self:GetInternalVariable("distance") or self:GetInternalVariable("m_flMoveDistance"))), 1, function()
            if (self:GetSaveTable().m_eDoorState != 1 and self:GetSaveTable().m_eDoorState != 3) then
                timer.Simple(5, function()
                    self:SetSaveValue("Speed", self.oldSpeed)
                    self.stealthOpen = false
                end)
            else
                timer.Create("checkForDoorReset" .. self:EntIndex(), 0.1, 0, function()
                    if (self:GetSaveTable().m_eDoorState != 1 and self:GetSaveTable().m_eDoorState != 3) then
                        timer.Simple(5, function()
                            self:SetSaveValue("Speed", self.oldSpeed)
                            self.stealthOpen = false
                        end)

                        timer.Remove("checkForDoorReset" .. self:EntIndex())
                    end
                end)
            end
        end)
    end
end
