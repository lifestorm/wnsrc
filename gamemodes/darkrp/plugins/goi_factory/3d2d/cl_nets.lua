--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

net.Receive("ix.terminal.CWUWorkshiftData", function(len, client)
    local ent = net.ReadEntity()
	local data = util.JSONToTable(net.ReadString())

    local terminalPanel = ent.terminalPanel

    if terminalPanel then
        if !IsValid(terminalPanel.shiftPanel) then
            terminalPanel:ProceedShiftBuilding(data)
        else
            terminalPanel:PopulateWorkshift(data)
        end
    end
end)

net.Receive("ix.terminal.CWUWorkshiftSound", function()
	surface.PlaySound(ix.config.Get("broadcastSound", "ambience/3d-sounds/alarms/workshiftalarm.ogg"))
end)

net.Receive("ix.terminal.AuthError", function(len, client)
    local ent = net.ReadEntity()

    local terminalPanel = ent.terminalPanel

    if terminalPanel then
        terminalPanel:AuthError()
    end
end)

net.Receive("ix.terminal.DiscAttach", function(len, client)
    local ent = net.ReadEntity()
    local disc = net.ReadString()

    local terminalPanel = ent.terminalPanel
    if terminalPanel then
        terminalPanel:SetDisc(disc)
        terminalPanel:OnDiscAttach()
    end
end)

net.Receive("ix.terminal.DiscDetach", function(len, client)
    local ent = net.ReadEntity()
    local terminalPanel = ent.terminalPanel

    if terminalPanel then
        terminalPanel:SetDisc(nil)
        terminalPanel:OnDiscDetach()
    end
end)

net.Receive("ix.terminal.Scan", function(len, client)
    local ent = net.ReadEntity()
    local terminalPanel = ent.terminalPanel

    if terminalPanel then
        terminalPanel:Encode()
    end
end)

net.Receive("ix.terminal.UpdateCWUTerminals", function(len)
    local cityTbl = util.JSONToTable(net.ReadString())

    local ent = net.ReadEntity()
    local terminalPanel = ent.terminalPanel
    if terminalPanel then
        terminalPanel:Populate(cityTbl)
    end
end)

net.Receive("ix.terminal.RequestCities", function(len)
    local cities = util.JSONToTable(net.ReadString())
    local ent = net.ReadEntity()
    local terminalPanel = ent.terminalPanel

    if terminalPanel then
        terminalPanel:CreateMarketPanel(cities)
    end
end)

net.Receive("ix.terminal.RequestMainCityInfo", function(len)
    local cityInfo = util.JSONToTable(net.ReadString())
    local budgets = util.JSONToTable(net.ReadString())
    local ent = net.ReadEntity()
    local option = net.ReadString()
    local terminalPanel = ent.terminalPanel

    if terminalPanel then
        if option == "status" then
            terminalPanel:CreateStatusPanel(cityInfo, budgets)
        elseif option == "cart" then
            terminalPanel:BuildCart(terminalPanel.cartPanel, cityInfo)
        end
    end
end)

net.Receive("ix.terminal.GetCityStock", function(len)
    local items = util.JSONToTable(net.ReadString())
    local ent = net.ReadEntity()
    local terminalPanel = ent.terminalPanel

    if terminalPanel then
        terminalPanel:CreateStock(items)
    end
end)

net.Receive("ix.terminal.turnOn", function(len)
    local ent = net.ReadEntity()
    local client = net.ReadEntity()
    local data = net.ReadString()
    data = util.JSONToTable(data)

    if IsValid(ent) then
        ent:CreateStartScreen(client, data)
    end
end)

net.Receive("ix.terminal.turnOff", function(len)
    local ent = net.ReadEntity()

    if IsValid(ent) then
        ent:PurgeScreenPanels()
    end
end)

net.Receive("ix.terminal.CWUCardInserted", function(len)
    local ent = net.ReadEntity()

    local terminalPanel = ent.terminalPanel

    if terminalPanel then
        terminalPanel:OnCWUCardInserted()
    end
end)

net.Receive("ix.terminal.CWUCardRemoved", function(len)
    local ent = net.ReadEntity()

    local terminalPanel = ent.terminalPanel

    if terminalPanel then
        terminalPanel:OnCWUCardRemoved()
    end
end)

net.Receive("ix.terminal.SendCIDInfo", function(len)
    local genData = util.JSONToTable(net.ReadString())
    local ent = net.ReadEntity()

    local terminalPanel = ent.terminalPanel

    if terminalPanel then
        terminalPanel:OnCIDInserted(genData)
    end
end)

net.Receive("ix.terminal.SendCIDRemoved", function(len)
    local ent = net.ReadEntity()

    local terminalPanel = ent.terminalPanel

    if terminalPanel then
        terminalPanel:OnCIDRemoved()
    end
end)