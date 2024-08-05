--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PANEL = {}
local PLUGIN = PLUGIN

function PANEL:Init()
    self.exit.DoClick = function()
        surface.PlaySound("helix/ui/press.wav")
        self:Remove()
    end

    self.titleText:SetText("Select Trash Items")
    self.titleText:SizeToContents()

    self:CreateItems()
end

function PANEL:CreateItems()
    local character = LocalPlayer():GetCharacter()
    if !character then return end
    
    local inventory = character:GetInventory()
    if !inventory then return end

	local scrollPanel = self.innerContent:Add("DScrollPanel")
	scrollPanel:Dock(TOP)
	scrollPanel:SetSize(self.innerContent:GetWide(), self.innerContent:GetTall() - SScaleMin(50 / 3))

    for _, item in pairs(inventory:GetItemsByBase("base_junk")) do
        if table.HasValue(PLUGIN.disAllowedJunk, item.uniqueID) then continue end

        local frame, modelPanel, textPanel, amountPanel = self:CreateItem(scrollPanel, item.uniqueID)
        local button = self:CreateInvisibleButton(frame, modelPanel, textPanel, amountPanel)
        button.DoClick = function()
            surface.PlaySound("helix/ui/press.wav")

            if self.junkAmount == 5 then
                LocalPlayer():Notify("This machine is filled with junk!")
                return
            end

            self.junkAmount = self.junkAmount + 1

            frame:Remove()
            netstream.Start("ixTrashCollectorPlaceJunk", item.id, self.entIndex)
        end
    end
end

vgui.Register("ixTrashCollectorSelector", PANEL, "PickupDispenser")