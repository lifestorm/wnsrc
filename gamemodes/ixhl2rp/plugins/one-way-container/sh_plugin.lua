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

PLUGIN.name = "One-way-container"
PLUGIN.author = "Whitehole"
PLUGIN.description = "Adds one way containers."

ix.lang.AddTable("english", {
	normalToOneWayContainer = "Turn into a one-way container",
	oneWayToNormalContainer = "Turn into a normal container",
})

ix.lang.AddTable("spanish", {
	normalToOneWayContainer = "Convertir en un contenedor de una sola via",
	oneWayToNormalContainer = "Convertir en un contenedor normal",
})

properties.Add("ixContainerToOneWay", {
	MenuLabel = "Turn into a one-way container",
	Order = 402,
	MenuIcon = "icon16/arrow_switch.png",
	Filter = function(self, entity, client)
		if (ix.config.Get("AllowContainerSpawn")) then return false end
		if (entity:GetClass() != "ix_container") then return false end
		if (!gamemode.Call("CanProperty", client, "ixContainerCreate", entity)) then return false end
		if (!ix.container.stored[entity:GetModel():lower()]) then return false end
		if (entity:GetNetVar("isOneWay", false)) then return false end

		return true
	end,
	Action = function(self, entity)
		self:MsgStart()
			net.WriteEntity(entity)
		self:MsgEnd()
	end,
	Receive = function(self, length, client)
		local entity = net.ReadEntity()
		entity:SetNetVar("isOneWay", true)
	end
})

properties.Add("ixOneWayToContainer", {
	MenuLabel = "Turn into a normal container",
	Order = 402,
	MenuIcon = "icon16/arrow_switch.png",
	Filter = function(self, entity, client)
		if (ix.config.Get("AllowContainerSpawn")) then return false end
		if (entity:GetClass() != "ix_container") then return false end
		if (!gamemode.Call("CanProperty", client, "ixContainerCreate", entity)) then return false end
		if (!ix.container.stored[entity:GetModel():lower()]) then return false end
		if (!entity:GetNetVar("isOneWay", false)) then return false end

		return true
	end,
	Action = function(self, entity)
		self:MsgStart()
			net.WriteEntity(entity)
		self:MsgEnd()
	end,
	Receive = function(self, length, client)
		local entity = net.ReadEntity()
		entity:SetNetVar("isOneWay", false)
	end
})

ix.util.Include("sv_hooks.lua")
