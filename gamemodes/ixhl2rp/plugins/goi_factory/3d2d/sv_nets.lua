--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- one day i definitely should re-do the networking here..

util.AddNetworkString("ix.terminal.turnOn")
util.AddNetworkString("ix.terminal.turnOff")
util.AddNetworkString("ix.terminal.AuthError")
util.AddNetworkString("ix.terminal.CWUBroadcast")
util.AddNetworkString("ix.terminal.CWUWorkshiftBegin")
util.AddNetworkString("ix.terminal.CWUWorkshiftEnd")
util.AddNetworkString("ix.terminal.CWUWorkshiftPause")
util.AddNetworkString("ix.terminal.CWUWorkshiftRewardUpdate")
util.AddNetworkString("ix.terminal.CWUWorkshiftSound")
util.AddNetworkString("ix.terminal.CWUWorkshiftData")
util.AddNetworkString("ix.terminal.CWUCardInserted")
util.AddNetworkString("ix.terminal.CWUCardRemoved")
util.AddNetworkString("ix.terminal.SendCIDInfo")
util.AddNetworkString("ix.terminal.SendCIDRemoved")
util.AddNetworkString("ix.terminal.GetCityStock")
util.AddNetworkString("ix.terminal.RequestMainCityInfo")
util.AddNetworkString("ix.terminal.RequestCities")
util.AddNetworkString("ix.terminal.UpdateCWUTerminals")
util.AddNetworkString("ix.terminal.DiscAttach")
util.AddNetworkString("ix.terminal.DiscDetach")
util.AddNetworkString("ix.terminal.Scan")
util.AddNetworkString("ix.terminal.Fabricate")
util.AddNetworkString("ix.terminal.Recycle")
util.AddNetworkString("ix.terminal.Bioprocess")
util.AddNetworkString("ix.terminal.ToggleDepot")

local workshifts = ix.plugin.Get("combineutilities")

net.Receive("ix.terminal.CWUWorkshiftPause", function(_, client)
	local ent = net.ReadEntity()
    local wActive = GetNetVar("WorkshiftStarted", false)

	if (client:EyePos():DistToSqr(ent:GetPos()) > 62500) then return end
	if (!ix.city:IsAuthorized(client, ent)) then return end
    if (!wActive) then return end

    local workshiftTerminals = ents.FindByClass("ix_workshiftterminal")
    local pauseBool

    if #workshiftTerminals > 0 then
        for _, wTerminal in pairs(workshiftTerminals) do
            if !wTerminal.workshiftStarted then continue end

            workshifts:PauseWorkshift(wTerminal, client, !wTerminal.workshiftPaused)
            if !pauseBool then
                pauseBool = wTerminal.workshiftPaused
            end
        end
    end

    if isbool(pauseBool) then
        client:NotifyLocalized("Registration pause is set to: " .. tostring(pauseBool))

        ix.combineNotify:AddNotification(pauseBool and "NTC:// Work-Cycle registration paused by " .. client:GetCombineTag() or "NTC:// Work-Cycle registration resumed by " .. client:GetCombineTag(), nil, client)
    end
end)

net.Receive("ix.terminal.CWUWorkshiftBegin", function(_, client)
	local ent = net.ReadEntity()
    local wActive = GetNetVar("WorkshiftStarted", false)

	if (client:EyePos():DistToSqr(ent:GetPos()) > 62500) then return end
	if (!ix.city:IsAuthorized(client, ent)) then return end
    if (wActive) then return end

    local workshiftTerminals = ents.FindByClass("ix_workshiftterminal")
    if #workshiftTerminals > 0 then
        for _, wTerminal in pairs(workshiftTerminals) do
            wTerminal:StartWorkshift(client)
        end
    else
        return client:NotifyLocalized("There's no workshift terminals!")
    end
    ix.combineNotify:AddNotification("NTC:// Work-Cycle initiated by " .. client:GetCombineTag(), nil, client)

    local idCard = ix.item.instances[ent:GetCID()]
    workshifts:AddToWorkshift(client, idCard, ent.curGenData, workshiftTerminals[1])
    workshifts:StartWorkshift()
    client:NotifyLocalized("Workshift started!")
end)

net.Receive("ix.terminal.CWUWorkshiftEnd", function(_, client)
	local ent = net.ReadEntity()
    local wActive = GetNetVar("WorkshiftStarted", false)

	if (client:EyePos():DistToSqr(ent:GetPos()) > 62500) then return end
	if (!ix.city:IsAuthorized(client, ent)) then return end
    if (!wActive) then return end
    local rewards = {}
    local workshiftDataExtracted = false

    local workshiftTerminals = ents.FindByClass("ix_workshiftterminal")
    if #workshiftTerminals > 0 then
        for _, wTerminal in pairs(workshiftTerminals) do
            if !wTerminal.workshiftStarted then continue end

            if wTerminal.workshiftStarted and !workshiftDataExtracted then
                rewards = wTerminal.savedInfo
                workshiftDataExtracted = true
            end
            wTerminal:StopWorkshift(client)
        end
    else
        return client:NotifyLocalized("There's no workshift terminals!")
    end
    ix.combineNotify:AddNotification("NTC:// Work-Cycle terminated by " .. client:GetCombineTag(), nil, client)

    workshifts:EndWorkshift(rewards, client)
    client:NotifyLocalized("Workshift ended!")
end)

net.Receive("ix.terminal.CWUWorkshiftRewardUpdate", function(_, client)
	local ent = net.ReadEntity()
    local data = util.JSONToTable(net.ReadString())
    local wActive = GetNetVar("WorkshiftStarted", false)

	if (client:EyePos():DistToSqr(ent:GetPos()) > 62500) then return end
	if (!ix.city:IsAuthorized(client, ent)) then return end
    if (!wActive) then return end

    local workshiftTerminals = ents.FindByClass("ix_workshiftterminal")
    if #workshiftTerminals > 0 then
        for _, wTerminal in pairs(workshiftTerminals) do
            if !wTerminal.workshiftStarted then continue end
            workshifts:SaveWorkshift(data, wTerminal)
        end
    else
        return client:NotifyLocalized("There's no workshift terminals!")
    end
end)

net.Receive("ix.terminal.CWUWorkshiftData", function(_, client)
	local ent = net.ReadEntity()

	if (client:EyePos():DistToSqr(ent:GetPos()) > 62500) then return end
	if (!ix.city:IsAuthorized(client, ent)) then return end

    local wActive = GetNetVar("WorkshiftStarted", false)
    local workshiftTerminals = ents.FindByClass("ix_workshiftterminal")
    local dataToSend = {}
	if wActive and #workshiftTerminals > 0 then
        dataToSend["participants"] = {}
        dataToSend["rewards"] = {}

        for _, wTerminal in pairs(workshiftTerminals) do
            if !wTerminal.workshiftStarted then continue end

            if (wTerminal.participants and istable(wTerminal.participants) and !table.IsEmpty(wTerminal.participants)) then
                for id, participant in pairs(wTerminal.participants) do
                    dataToSend["participants"][id] = participant
                end
            end

            if (wTerminal.savedInfo and istable(wTerminal.savedInfo) and !table.IsEmpty(wTerminal.savedInfo)) then
                for id, reward in pairs(wTerminal.savedInfo) do
                    dataToSend["rewards"][id] = reward
                end
            end
        end
    end

    net.Start("ix.terminal.CWUWorkshiftData")
        net.WriteEntity(ent)
        net.WriteString(util.TableToJSON(dataToSend))
    net.Send(client)
end)

net.Receive("ix.terminal.CWUBroadcast", function(_, client)
	local ent = net.ReadEntity()
	if (!ent or !ent:IsValid() or ent:GetClass() != "ix_cwuterminal") then return end

	if ((ent.nextBroadcast or 0) >= CurTime()) then return end
	if (client:EyePos():DistToSqr(ent:GetPos()) > 62500) then return end
	if (!ix.city:IsAuthorized(client, ent)) then return end

	local broadcast = !ent:GetNetVar("broadcasting", false)
    client:SetNetVar("broadcastAuth", broadcast and broadcast or nil)
	ent:ToggleBroadcast()
end)

net.Receive("ix.terminal.Bioprocess", function(len, client)
    local ent = net.ReadEntity()
    local itemID = net.ReadString()
    local isBulk = net.ReadBool()
    local amount = net.ReadInt(5)

    if (client:EyePos():DistToSqr(ent:GetPos()) > 62500) then
        return
    end

    local bioprocess = ent:SynthesizeFabrication(client, itemID, isBulk, amount)
    if bioprocess then
        client:NotifyLocalized(bioprocess)
    end
end)

net.Receive("ix.terminal.ToggleDepot", function(len, client)
    local ent = net.ReadEntity()

    if (client:EyePos():DistToSqr(ent:GetPos()) > 62500) then
        return
    end

    local depotToggle = ent:ToggleDepot()
    if depotToggle then
        client:NotifyLocalized(depotToggle)
    end
end)

net.Receive("ix.terminal.Recycle", function(len, client)
    local ent = net.ReadEntity()

    if (client:EyePos():DistToSqr(ent:GetPos()) > 62500) then
        return
    end

    local recycle = ent:Recycle(client)
    if recycle then
        client:NotifyLocalized(recycle)
    end
end)

net.Receive("ix.terminal.Fabricate", function(len, client)
    local ent = net.ReadEntity()
    local isBulk = net.ReadBool()
    local amount = net.ReadInt(5)

    if (client:EyePos():DistToSqr(ent:GetPos()) > 62500) then
        return
    end

    local fabrication = ent:SynthesizeFabrication(client, ent:GetDiscItemID(), isBulk, amount)
    if fabrication then
        client:NotifyLocalized(fabrication)
    end
end)

net.Receive("ix.terminal.Scan", function(len, client)
    local ent = net.ReadEntity()

    if (client:EyePos():DistToSqr(ent:GetPos()) > 62500) then
        return
    end

    local scan = ent:Scan(client)
    if scan then
        client:NotifyLocalized(scan)
    end
end)

net.Receive("ix.terminal.RequestCities", function(len, client)
    local ent = net.ReadEntity()

    if (client:EyePos():DistToSqr(ent:GetPos()) > 62500) then
        return
    end

    local cities = {}
    for cityID, city in pairs(ix.city.list) do
        cities[cityID] = city
    end
    cities["1"] = table.Copy(ix.city.main)
    cities = util.TableToJSON(cities)

    net.Start("ix.terminal.RequestCities")
        net.WriteString(cities)
        net.WriteEntity(ent)
    net.Send(client)
end)

net.Receive("ix.terminal.RequestMainCityInfo", function(len, client)
    local ent = net.ReadEntity()
    local option = net.ReadString()

    if (client:EyePos():DistToSqr(ent:GetPos()) > 62500) then
        return
    end

    local city = util.TableToJSON(ix.city:GetMainCity())
    local budgets = util.TableToJSON(ix.factionBudget.list)

    net.Start("ix.terminal.RequestMainCityInfo")
        net.WriteString(city)
        net.WriteString(budgets)
        net.WriteEntity(ent)
        net.WriteString(option)
    net.Send(client)
end)

net.Receive("ix.terminal.GetCityStock", function(len, client)
    local ent = net.ReadEntity()

    if (client:EyePos():DistToSqr(ent:GetPos()) > 62500) then
        return
    end

    local city = ix.city:GetMainCity()
    local items = util.TableToJSON(city:GetItems())

    net.Start("ix.terminal.GetCityStock")
        net.WriteString(items)
        net.WriteEntity(ent)
    net.Send(client)
end)

net.Receive("ix.terminal.turnOn", function(len, client)
    local ent = net.ReadEntity()

    if (client:EyePos():DistToSqr(ent:GetPos()) > 62500) then
        return
    end

    local dataToSend = {}

    if ent:GetClass() == "ix_cwuterminal" then
        if ent.curGenData then
            dataToSend[1] = ent.curGenData
        end

        if ent:GetCWUCard() and ent:GetCWUCard() != -1 then
            dataToSend[2] = ent:GetCWUCard()
        end

        if ent:HasCWUCard() and ent:HasCID() or ent.curGenData and ent.curGenData.combine then
            dataToSend[3] = !ent:IsFullyAuthed()
        end
    end

    if ent.dItemID then
        dataToSend = {ent.dItemID}
    end

    ent:SetUsedBy(client)
    ent:CreateUserTimer()
    net.Start("ix.terminal.turnOn")
        net.WriteEntity(ent)
        net.WriteEntity(client)
        net.WriteString(util.TableToJSON(dataToSend))
    net.Broadcast()
end)

net.Receive("ix.terminal.turnOff", function(len, client)
    local ent = net.ReadEntity()

    if (client:EyePos():DistToSqr(ent:GetPos()) > 62500) then
        return
    end

    if (IsValid(ent:GetUsedBy()) and ent:GetUsedBy() != client) then
        return client:NotifyLocalized("This terminal is being used by someone else.")
    end

    ent:SetUsedBy(ent)

    if ent:GetClass() == "ix_cwuterminal" and ent:GetNetVar("broadcasting", false) then
        if client:GetNetVar("broadcastAuth", false) then
            client:SetNetVar("broadcastAuth", nil)
        end
		ent:ToggleBroadcast()
	end

    net.Start("ix.terminal.turnOff")
        net.WriteEntity(ent)
    net.Broadcast()
end)