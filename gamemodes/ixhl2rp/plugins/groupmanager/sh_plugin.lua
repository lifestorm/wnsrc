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

PLUGIN.name = "Group Manager"
PLUGIN.author = "AleXXX_007, Fruity"
PLUGIN.description = "Allow players to create their own in-game groups with custom name and roles."

PLUGIN.stored = PLUGIN.stored or {}

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Groups",
	MinAccess = "admin"
})

ix.option.Add("groupESP", ix.type.bool, true, {
	category = "observer",
	hidden = function()
		return !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Observer", nil)
	end
})

ix.char.RegisterVar("groupID", {
	field = "group",
	fieldType = ix.type.number,
	default = -1,
	bNoDisplay = true,
	OnSet = function(self, value)
		local client = self:GetPlayer()

		if (IsValid(client)) then
			self.vars.groupID = value

			net.Start("ixCharacterVarChanged")
				net.WriteUInt(self:GetID(), 32)
				net.WriteString("groupID")
				net.WriteType(self.vars.groupID)
			net.Broadcast()
		end
	end,
	OnGet = function(self, default)
		local groupID = self.vars.groupID

		return groupID or 0
	end,
	OnAdjust = function(self, client, data, value, newData)
		newData.groupID = value
	end
})

ix.util.Include("cl_hooks.lua")
ix.util.Include("sh_commands.lua")
ix.util.Include("sv_hooks.lua")

function PLUGIN:FindGroup(groupID)
	if (isnumber(groupID)) then 
		return groupID != -1 and self.stored[groupID] or nil
	elseif (isstring(groupID)) then
		for k, v in pairs(self.stored) do
			if (string.utf8lower(v:GetName()) == string.utf8lower(groupID)) then
				return v
			end
		end
	end
end

function PLUGIN:GetGroups()
	return self.stored
end

properties.Add("grouplock_checkowner", {
	MenuLabel = "Check Owner",
	Order = 399,
	MenuIcon = "icon16/user.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "ix_grouplock") then return false end
		if (!gamemode.Call("CanProperty", client, "grouplock_checkowner", entity)) then return false end

		return true
	end,

	Action = function(self, entity)
		self:MsgStart()
			net.WriteEntity(entity)
		self:MsgEnd()
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()

		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end

		local groupID = entity:GetGroupID()
		if (!groupID or !PLUGIN:GetGroups()[groupID]) then client:Notify("This lock does not belong to any group.") return end

		client:Notify("This lock belongs to group '" .. PLUGIN:GetGroups()[groupID]:GetName() .. "'.")
	end
})
