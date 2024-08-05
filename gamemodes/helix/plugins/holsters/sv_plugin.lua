--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

--[[
   __  ___        __      __
  /  |/  /__ ____/ /__   / /  __ __
 / /|_/ / _ `/ _  / -_) / _ \/ // /
/_/  /_/\_,_/\_,_/\__/ /_.__/\_, /
   ___       __             /___/         ___           __
  / _ \___  / /_ _____ ___ / /____ ____  / _ \__ ______/ /__
 / ___/ _ \/ / // / -_|_-</ __/ -_) __/ / // / // / __/  '_/
/_/   \___/_/\_, /\__/___/\__/\__/_/   /____/\_,_/\__/_/\_\
            /___/
https://steamcommunity.com/profiles/76561198057599363
]]
WepHolster.wepInfo = WepHolster.wepInfo or {}
util.AddNetworkString("ixSendWeaponHolster")
util.AddNetworkString("ixSendAllWeaponHolster")
util.AddNetworkString("ixApplyWeaponHolster")
util.AddNetworkString("ixReloadWeaponHolster")
util.AddNetworkString("ixDeleteWeaponHolster")
util.AddNetworkString("ixReloadWholeWeaponHolster")
util.AddNetworkString("ixResetWeaponHolster")
util.AddNetworkString("ixResetWholeWeaponHolster")
util.AddNetworkString("WepHolsters_Settings")

function PLUGIN:LoadData()
    local data = ix.data.Get("weaponHolsters", {}, true)
	table.Merge(table.Copy(self.defaultData or {}), data)

	self.weaponInfo = {}
	for k, v in pairs(data) do
		local swep = weapons.Get(k)
		if swep  then
			self.weaponInfo[k] = v
		end
	end
end

function PLUGIN:SaveWeaponData()
    ix.data.Set("weaponHolsters", self.weaponInfo, true)
end

function PLUGIN:SendAllWeaponHolsterData(client)
	net.Start("ixSendAllWeaponHolster")
	net.WriteTable(self.weaponInfo)
	net.Send(client)
end

function PLUGIN:PlayerInitialSpawn(client)
    timer.Simple(1, function()
		self:SendAllWeaponHolsterData(client)
	end)
end

net.Receive("ixResetWholeWeaponHolster", function(len, client)
	if (CAMI.PlayerHasAccess(client, "Helix - Manage Weapon Holsters")) then
		ix.data.Set("weaponHolsters", {}, true)

		PLUGIN:LoadData()

		net.Start("ixSendAllWeaponHolster")
		net.WriteTable(PLUGIN.weaponInfo)
		net.Broadcast()
	end
end)

net.Receive("ixResetWeaponHolster", function(len, client)
	if (CAMI.PlayerHasAccess(client, "Helix - Manage Weapon Holsters")) then
		local class = net.ReadString()

		if (PLUGIN.defaultData[class]) then
			net.Start("ixSendWeaponHolster")
			net.WriteString(class)
			net.WriteTable(PLUGIN.defaultData[class])
			net.Send(client)
		end
	end
end)

net.Receive("ixReloadWholeWeaponHolster", function(len, client)
	PLUGIN:SendAllWeaponHolsterData(client)
end)

net.Receive("ixApplyWeaponHolster", function(len, client)
	if (CAMI.PlayerHasAccess(client, "Helix - Manage Weapon Holsters")) then
		local class = net.ReadString()
		local weaponTable = net.ReadTable()
		weaponTable.notSavedYet = nil
		weaponTable.isEditing = nil

		PLUGIN.weaponInfo[class] = weaponTable
		PLUGIN:SaveWeaponData()

		net.Start("ixSendWeaponHolster")
		net.WriteString(class)
		net.WriteTable(PLUGIN.weaponInfo[class])
		net.Broadcast()
	end
end)

net.Receive("ixReloadWeaponHolster", function(len, client)
	if (CAMI.PlayerHasAccess(client, "Helix - Manage Weapon Holsters")) then
		local class = net.ReadString()

		if (PLUGIN.weaponInfo[class]) then
			net.Start("ixSendWeaponHolster")
			net.WriteString(class)
			net.WriteTable(PLUGIN.weaponInfo[class])
			net.Send(client)
		end
	end
end)

net.Receive("ixDeleteWeaponHolster", function(len, client)
	if (CAMI.PlayerHasAccess(client, "Helix - Manage Weapon Holsters")) then
		local class = net.ReadString()
		PLUGIN.weaponInfo[class] = nil

		PLUGIN:SaveWeaponData()

		net.Start("ixSendWeaponHolster")
		net.WriteString(class)
		net.WriteTable({})
		net.Broadcast()
	end
end)