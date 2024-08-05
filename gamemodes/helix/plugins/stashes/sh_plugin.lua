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

PLUGIN.name = "Personal Stashes"
PLUGIN.author = "Gr4Ss"
PLUGIN.description = "Adds a new container entities with a personal inventory for every player."

--If you decrease the below, items in the removed slots will disappear
--Preferably do not decrease this without wiping stashes
PLUGIN.STASH_WIDTH = 4
PLUGIN.STASH_HEIGHT = 4


ix.inventory.Register("personalStash", PLUGIN.STASH_WIDTH, PLUGIN.STASH_HEIGHT, true)

ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")

ix.char.RegisterVar("stashInventory", {
	field = "stash",
	fieldType = ix.type.number,
	default = 0,
	bNoDisplay = true,
    bNoNetworking = true
})

ix.char.RegisterVar("stashName", {
	field = "stash_name",
	fieldType = ix.type.string,
	default = "",
	bNoDisplay = true,
    isLocal = true,
	OnSet = function(character, value)
		local oldVar = character.vars["stashName"]
		character.vars["stashName"] = string.utf8lower(value)

		net.Start("ixCharacterVarChanged")
			net.WriteUInt(character:GetID(), 32)
			net.WriteString("stashName")
			net.WriteType(value)
		net.Send(character.player)

		hook.Run("CharacterVarChanged", character, "stashName", oldVar, value)
	end
})

ix.char.RegisterVar("stashMoney", {
    field = "stash_money",
	fieldType = ix.type.number,
	default = 0,
	bNoDisplay = true,
    bNoNetworking = true
})

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Stashes",
	MinAccess = "superadmin"
})

ix.lang.AddTable("english", {
    stashesOtherInUse = "You already have another stash in use.",
	stashStartUsing = "You can start using this stash.",
	stashOtherInUse = "You already have the '%s' in use.",
	stashHasItems = "You have items/chips in this stash."
})

ix.lang.AddTable("spanish", {
	stashOtherInUse = "Ya tienes el '%s' en uso.",
	stashStartUsing = "Puedes empezar a usar este alijo.",
	stashesOtherInUse = "Ya tienes otro alijo en uso.",
	stashHasItems = "Tienes objetos/fichas en este alijo."
})

if (CLIENT) then
	local function stashESP(client, entity, x, y, factor)
		ix.util.DrawText("Stash - "..entity:GetDisplayName(), x, y - math.max(10, 32 * factor), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, factor)
	end
	ix.observer:RegisterESPType("ix_stash", stashESP, "stash")
end

properties.Add("ixStashSetName", {
	MenuLabel = "Set Name",
	Order = 400,
	MenuIcon = "icon16/tag_blue_edit.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "ix_stash") then return false end
		if (!gamemode.Call("CanProperty", client or LocalPlayer(), "ixStashSetName", entity)) then return false end

		return CAMI.PlayerHasAccess(client or LocalPlayer(), "Helix - Manage Stashes")
	end,

	Action = function(self, entity)
		Derma_StringRequest(L("containerNameWrite"), "", "", function(text)
			self:MsgStart()
				net.WriteEntity(entity)
				net.WriteString(text)
			self:MsgEnd()
		end)
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()

		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end

		local name = net.ReadString()

		if (name:len() != 0) then
			local oldName = entity:GetDisplayName()
			if (oldName == name) then return end

			entity:SetDisplayName(name)
			client:NotifyLocalized("containerName", name)

			for _, v in ipairs(player.GetAll()) do
				if (v:GetCharacter() and v:GetCharacter():GetStashName() == oldName) then
					v:GetCharacter():SetStashName(name)
				end
			end
        else
            return
		end

		ix.log.Add(client, "stashName", name)

		ix.saveEnts:SaveEntity(entity)
		PLUGIN:SaveData()
	end
})

properties.Add("ixCreateStash", {
	MenuLabel = "Make Stash",
	Order = 401,
	MenuIcon = "icon16/tag_blue_edit.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "prop_physics") then return false end
		if (!gamemode.Call("CanProperty", client or LocalPlayer(), "ixCreateStash", entity)) then return false end

		return CAMI.PlayerHasAccess(client or LocalPlayer(), "Helix - Manage Stashes")
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

		local container = ents.Create("ix_stash")
		container:SetPos(entity:GetPos())
		container:SetAngles(entity:GetAngles())
		container:SetModel(entity:GetModel())
		container:Spawn()
		container:SetDisplayName("Personal Stash "..container:EntIndex())
		ix.log.Add(client, "stashCreate", entity:GetModel())

		entity:Remove()

		ix.saveEnts:SaveEntity(container)
		PLUGIN:SaveData()
	end
})

properties.Add("ixViewStash", {
	MenuLabel = "#View Stash",
	Order = 11,
	MenuIcon = "icon16/eye.png",

	Filter = function(self, target, client)
		return target:IsPlayer()
            and CAMI.PlayerHasAccess(client or LocalPlayer(), "Helix - View Inventory")
            and hook.Run("CanProperty", client or LocalPlayer(), "ixViewStash", target) != false
	end,

	Action = function(self, target)
		self:MsgStart()
		net.WriteEntity(target)
		self:MsgEnd()
	end,

	Receive = function(self, length, client)
		local target = net.ReadEntity()
		if (!IsValid(target)) then return end
		if (!self:Filter(target, client)) then return end

		if (CAMI.PlayerHasAccess(client, "Helix - View Inventory")) then
			local character = target:GetCharacter()
			if (!character) then
				return
			end

			local invID = target:GetCharacter():GetStashInventory()
			if (invID == 0) then
				return
			end

			local inventory = ix.item.inventories[invID]
			if (!inventory) then
				return
			end

			PLUGIN:OpenInventory(client, target:GetCharacter(), target, inventory, true)
		end
	end
})