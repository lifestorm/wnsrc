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
	normalToOneWayContainer = "Transformez en conteneur à sens unique",
	oneWayToNormalContainer = "Transformer en conteneur normal",
})

ix.lang.AddTable("french", {
	normalToOneWayContainer = "Transformez en conteneur à sens unique",
	oneWayToNormalContainer = "Transformer en conteneur normal",
})

ix.lang.AddTable("spanish", {
	normalToOneWayContainer = "Transformez en conteneur à sens unique",
	oneWayToNormalContainer = "Transformer en conteneur normal",
})

properties.Add("ixContainerToOneWay", {
	MenuLabel = "Transformer en conteneur à sens unique",
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
	MenuLabel = "Transformer en conteneur normal",
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
