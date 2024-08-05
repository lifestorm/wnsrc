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

util.AddNetworkString("RequestMainMenuInfo")
util.AddNetworkString("AddMainMenuBackground")
util.AddNetworkString("RemoveMainMenuBackground")
util.AddNetworkString("SetMainMenuLogo")
util.AddNetworkString("SetMainMenuButtonColors")

function PLUGIN:UpdateMainMenu(client)
	net.Start("RequestMainMenuInfo")
	net.WriteTable(PLUGIN.menuBackgrounds)
	net.WriteTable(PLUGIN.logoData)
	net.WriteTable(PLUGIN.buttonColors)
	net.Send(client)
end

net.Receive("RequestMainMenuInfo", function(_, client)
	PLUGIN:UpdateMainMenu(client)
end)

net.Receive("AddMainMenuBackground", function(_, client)
	if (!client:IsAdmin()) then return end

	local backgroundName = net.ReadString()

	PLUGIN.menuBackgrounds[#PLUGIN.menuBackgrounds + 1] = backgroundName

	PLUGIN:SaveData()
	PLUGIN:UpdateMainMenu(client)
end)

net.Receive("RemoveMainMenuBackground", function(_, client)
	if (!client:IsAdmin()) then return end

	local toRemove = net.ReadString()

	for key, name in pairs(PLUGIN.menuBackgrounds) do
		if name == toRemove then
			table.remove(PLUGIN.menuBackgrounds, key)
			break
		end
	end

	PLUGIN:SaveData()
	PLUGIN:UpdateMainMenu(client)
end)

net.Receive("SetMainMenuLogo", function(_, client)
	if (!client:IsAdmin()) then return end

	local newLogo = net.ReadTable()
	if #newLogo == 0 then
		PLUGIN.logoData = {bDefault = true}
		return
	end

	local path = newLogo[1]
	local width = tonumber(newLogo[2])
	local height = tonumber(newLogo[3])
	if !isnumber(width) then return end
	if !isnumber(height) then return end
	if !isstring(path) then return end

	PLUGIN.logoData = {path = path, width = width, height = height}
	PLUGIN:SaveData()
end)

net.Receive("SetMainMenuButtonColors", function(_, client)
	if (!client:IsAdmin()) then return end

	local newColors = net.ReadTable()
	PLUGIN.buttonColors = newColors

	PrintTable(PLUGIN.buttonColors)

	PLUGIN:SaveData()
end)