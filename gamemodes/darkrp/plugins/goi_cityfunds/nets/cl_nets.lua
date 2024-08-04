--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

net.Receive("ix.city.CreateCFEditor", function()
    vgui.Create("ixFundManager")
end)

net.Receive("ix.city.SyncCityStock", function()
    local items = util.JSONToTable(net.ReadString())

    if !istable(ix.city.main) then
        ix.city.main = {}
    end

    ix.city.main.items = items

    if ix.gui.barteringpanel then
        if !ix.gui.barteringpanel.built then
            ix.gui.barteringpanel:Proceed()
        end
    end
end)

net.Receive("ix.city.RequestTypes", function()
    local parent = ix.gui.fundManager

    if !parent then return end

    local typeTbl = util.JSONToTable(net.ReadString())
    parent.types = typeTbl

end)

net.Receive("ix.city.PopulateFunds", function()
    local parent = ix.gui.fundManager

    if !parent then return end

    local cityTbl = util.JSONToTable(net.ReadString())
    parent:Populate(cityTbl)

end)

net.Receive("ix.city.RequestUpdateTypes", function()
    local parent = ix.gui.ctEditor

    if !parent then return end

    local typeTbl = util.JSONToTable(net.ReadString())
    parent:UpdateTypes(typeTbl)

end)

net.Receive("ix.city.RequestUpdateCities", function()
    local parent = ix.gui.fundManager

    if !parent then return end

    local cityTbl = util.JSONToTable(net.ReadString())
    parent:UpdateCities(cityTbl)

end)