--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


properties.Add("wncontainer_checkowner", {
	MenuLabel = "Check Owner",
	Order = 399,
	MenuIcon = "icon16/user.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "ix_wncontainer") then return false end
		if (!gamemode.Call("CanProperty", client, "wncontainer_checkowner", entity)) then return false end

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

		local contType = entity:GetType()
		if (contType == entity.PUBLIC) then
			client:NotifyLocalized("containerTypePublic")
			return
		elseif (contType == entity.GROUP) then
			client:NotifyLocalized("containerTypeGroup")
			return
		elseif (contType == entity.CLEANUP or contType == entity.MANCLEANUP) then
			client:NotifyLocalized("containerTypeCleanup", os.date("%Y-%m-%d %X", entity:GetCleanup()))
			return
		elseif (contType == entity.PKHOLD) then
			client:NotifyLocalized("containerTypePKHold", os.date("%Y-%m-%d %X", entity:GetCleanup()))
			return
		end

		local steamID = entity.owner
		local ownerEnt = player.GetBySteamID64(steamID) or false
		if (ownerEnt and IsValid(ownerEnt)) then
			client:NotifyLocalized("containerTypePrivateOnline", ownerEnt:SteamName(), util.SteamIDFrom64(steamID))
		else
			client:NotifyLocalized("containerTypePrivateOffline", entity.owner, util.SteamIDFrom64(steamID), os.date("%Y-%m-%d", entity.ownerLastSeen))
		end
	end
})

properties.Add("wncontainer_view", {
	MenuLabel = "#View Container",
	Order = 11,
	MenuIcon = "icon16/eye.png",

	Filter = function(self, target, client)
		return (target:GetClass() == "ix_container" or target:GetClass() == "ix_wncontainer")
            and CAMI.PlayerHasAccess(client or LocalPlayer(), "Helix - View Inventory")
            and hook.Run("CanProperty", client or LocalPlayer(), "wncontainer_view", target) != false
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

		local inventory = target:GetInventory()
		if (inventory) then
			local name = target:GetDisplayName()

			ix.storage.Open(client, inventory, {
				name = name,
				entity = target,
				bMultipleUsers = true,
				searchTime = 0,
				data = {money = target:GetMoney()},
				OnPlayerClose = function()
					ix.log.Add(client, "containerAClose", name, inventory:GetID())
				end
			})

			ix.log.Add(client, "containerAOpen", name, inventory:GetID())
		end
	end
})

properties.Add("wncontainer_create", {
	MenuLabel = "Make Container (new)",
	Order = 404,
	MenuIcon = "icon16/tag_blue_edit.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "prop_physics" and entity:GetClass() != "ix_container") then return false end
		if (!gamemode.Call("CanProperty", client, "ixContainerCreate", entity)) then return false end
		local model = string.lower(entity:GetModel())
		if (!ix.container.stored[model]) then return false end

		return CAMI.PlayerHasAccess(client, "Helix - Manage Containers")
	end,

	Action = function(self, entity)
		if !entity or entity and !IsValid(entity) then return end

		if (entity:GetClass() == "ix_container" and entity:GetLocked()) then
			Derma_Query("Do you wish to make this a private container?", "Make private container", "Yes", function()
				local characters = {}
				local pos = LocalPlayer():GetPos()
				for k, v in ipairs(player.GetAll()) do
					if (v:GetCharacter()) then
						characters[#characters + 1] = {text = v:Name(), value = v, dist = v:GetPos():DistToSqr(pos)}
					end
				end

				table.SortByMember(characters, "dist", true)
				for k, v in ipairs(characters) do
					characters[k].text = Schema:ZeroNumber(k, 2)..". "..v.text
				end

				Derma_Select(L("containerOwner"), L("containerOwnerTitle"), characters, L("containerSelectOwner"),
				"Confirm", function(value, text)
					if (!value) then return end
					self:MsgStart()
						net.WriteEntity(entity)
						net.WriteBool(true)
						net.WriteEntity(value)
					self:MsgEnd()
				end,
				"Cancel")
			end, "No", function()
				Derma_Query("Do you wish to make this a group/faction container?", "Make group/faction container", "Yes", function()
					Derma_StringRequest("Group/Faction Name", "Please enter the group/faction name:", "", function(text)
						if (text and text != "") then
							self:MsgStart()
								net.WriteEntity(entity)
								net.WriteBool(false)
								net.WriteBool(true)
								net.WriteString(text)
							self:MsgEnd()
						end
					end, function()

					end)
				end, "No", function()
					self:MsgStart()
					net.WriteEntity(entity)
					net.WriteBool(false)
					net.WriteBool(false)
				self:MsgEnd()
				end)
			end)
		else
			self:MsgStart()
				net.WriteEntity(entity)
			self:MsgEnd()
		end
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()

		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end

		local model = string.lower(entity:GetModel())
		local data = ix.container.stored[model]

		local container = ents.Create("ix_wncontainer")
		container:SetPos(entity:GetPos())
		container:SetAngles(entity:GetAngles())
		container:SetModel(model)
		container:Spawn()

		local physObj = container:GetPhysicsObject()
		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end

		if (entity:GetClass() == "ix_container") then
			local inventory = entity:GetInventory()
			container:SetInventory(inventory)
			container:SetDisplayName(entity:GetDisplayName())
			container:SetMoney(entity:GetMoney())

			if (net.ReadBool()) then
				local target = net.ReadEntity()
				container:ChangeType(container.PRIVATE, target)
				container:SetPassword(entity:GetPassword())
			elseif (net.ReadBool()) then
				local text = net.ReadString()
				if (text != "") then
					container:ChangeType(container.GROUP, text)
					container:SetPassword(entity:GetPassword())
				end
			end

			if (ix.saveEnts) then
				ix.saveEnts:SaveEntity(container)
			end

			entity:SetID(0)
		else
			ix.inventory.New(0, "container:" .. model, function(inventory)
				-- we'll technically call this a bag since we don't want other bags to go inside
				inventory.vars.isBag = true
				inventory.vars.isContainer = true
				inventory.vars.entity = container

				if (IsValid(container)) then
					container:SetInventory(inventory)
					if (ix.saveEnts) then
						ix.saveEnts:SaveEntity(container)
					end
				end
			end)
		end

		entity:Remove()

		ix.log.Add(client, "containerSpawned", data.name)
	end
})

properties.Add("wncontainer_setname", {
	MenuLabel = "Set Name",
	Order = 400,
	MenuIcon = "icon16/tag_blue_edit.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "ix_wncontainer") then return false end
		if (!gamemode.Call("CanProperty", client, "wncontainer_setname", entity)) then return false end

		return CAMI.PlayerHasAccess(client, "Helix - Manage Containers")
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
		local oldName = entity:GetDisplayName()
		if (name:len() != 0) then
			entity:SetDisplayName(name)

			client:NotifyLocalized("containerName", name)
		else
			local definition = ix.container.stored[entity:GetModel():lower()]
			entity:SetDisplayName(definition.name)

			client:NotifyLocalized("containerNameRemove")
		end

		if (ix.saveEnts) then
			ix.saveEnts:SaveEntity(self)
		end

		local inventory = entity:GetInventory()
		ix.log.Add(client, "containerNameNew", oldName, inventory:GetID(), name)
	end
})

properties.Add("wncontainer_setpassword", {
	MenuLabel = "Set Password",
	Order = 401,
	MenuIcon = "icon16/lock_edit.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "ix_wncontainer" or !entity:CanHavePassword()) then return false end
		if (!gamemode.Call("CanProperty", client, "wncontainer_setpassword", entity)) then return false end

		return CAMI.PlayerHasAccess(client, "Helix - Manage Containers")
	end,

	Action = function(self, entity)
		Derma_StringRequest(L("containerPasswordWrite"), "", "", function(text)
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

		local password = net.ReadString()
		entity:SetPassword(password)
		if (password:len() != 0) then
			client:NotifyLocalized("containerPassword", password)
		else
			client:NotifyLocalized("containerPasswordRemove")
		end

		local name = entity:GetDisplayName()
		local inventory = entity:GetInventory()
		ix.log.Add(client, "containerPasswordNew", name, inventory:GetID(), password:len() != 0)
	end
})

properties.Add("wncontainer_changepassword_private", {
	MenuLabel = "Change Password",
	Order = 402,
	MenuIcon = "icon16/lock_edit.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "ix_wncontainer" or entity:GetType() != entity.PRIVATE or !entity:GetLocked()) then return false end
		if (!gamemode.Call("CanProperty", client, "wncontainer_setpassword", entity)) then return false end

		local character = client:GetCharacter()
		if (!character) then return false end
		if (character:GetID() != entity:GetCharID()) then return false end

		return true
	end,

	Action = function(self, entity)
		Derma_StringRequest(L("containerPasswordWrite"), "", "", function(text)
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

		local password = net.ReadString()
		entity:SetPassword(password)
		if (password:len() != 0) then
			client:NotifyLocalized("containerPassword", password)
		else
			client:NotifyLocalized("containerPasswordRemove")
		end

		local name = entity:GetDisplayName()
		local inventory = entity:GetInventory()
		ix.log.Add(client, "containerPasswordNew", name, inventory:GetID(), password:len() != 0)
	end
})

properties.Add("wncontainer_setprivate", {
	MenuLabel = "Set Type: Private",
	Order = 410,
	MenuIcon = "icon16/tag_blue_edit.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "ix_wncontainer" or entity:GetType() == entity.PRIVATE) then return false end
		if (!gamemode.Call("CanProperty", client, "wncontainer_setprivate", entity)) then return false end

		return CAMI.PlayerHasAccess(client, "Helix - Manage Containers")
	end,

	Action = function(self, entity)
		local characters = {}
		local pos = LocalPlayer():GetPos()
		for k, v in ipairs(player.GetAll()) do
			if (v:GetCharacter()) then
				characters[#characters + 1] = {text = v:Name(), value = v, dist = v:GetPos():DistToSqr(pos)}
			end
		end

		table.SortByMember(characters, "dist", true)
		for k, v in ipairs(characters) do
			characters[k].text = Schema:ZeroNumber(k, 2)..". "..v.text
		end

		Derma_Select(L("containerOwner"), L("containerOwnerTitle"), characters, L("containerSelectOwner"),
		"confirm", function(value, text)
			if (!value) then return end
			self:MsgStart()
				net.WriteEntity(entity)
				net.WriteEntity(value)
			self:MsgEnd()
		end,
		"cancel")
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()
		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end

		local target = net.ReadEntity()
		entity:ChangeType(entity.PRIVATE, target)

		local name = entity:GetDisplayName()
		local inventory = entity:GetInventory()
		ix.log.Add(client, "containerSetPrivate", name, inventory:GetID(), target:GetCharacter())
	end
})

properties.Add("wncontainer_togglepremium", {
	MenuLabel = "Toggle Premium",
	Order = 404,
	MenuIcon = "icon16/tag_blue_edit.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "ix_wncontainer" or entity:GetType() != entity.PRIVATE) then return false end
		if (!gamemode.Call("CanProperty", client, "wncontainer_togglepremium", entity)) then return false end

		return CAMI.PlayerHasAccess(client, "Helix - Manage Containers")
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

		entity:TogglePremium()

		local name = entity:GetDisplayName()
		local inventory = entity:GetInventory()
		ix.log.Add(client, "containerSetPremium", name, inventory:GetID(), entity:GetPremium())
	end
})

properties.Add("wncontainer_setgroup", {
	MenuLabel = "Set Type: Group/Faction",
	Order = 411,
	MenuIcon = "icon16/tag_blue_edit.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "ix_wncontainer" or entity:GetType() == entity.GROUP) then return false end
		if (!gamemode.Call("CanProperty", client, "wncontainer_setgroup", entity)) then return false end

		return CAMI.PlayerHasAccess(client, "Helix - Manage Containers")
	end,

	Action = function(self, entity)
		Derma_StringRequest(L("containerGroupTitle"), L("containerGroup"), "", function(text)
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

		local text = net.ReadString()
		if (text == "") then return end
		entity:ChangeType(entity.GROUP, text)

		local name = entity:GetDisplayName()
		local inventory = entity:GetInventory()
		ix.log.Add(client, "containerSetGroup", name, inventory:GetID(), text)
	end
})

properties.Add("wncontainer_setpublic", {
	MenuLabel = "Set Type: Public",
	Order = 412,
	MenuIcon = "icon16/tag_blue_edit.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "ix_wncontainer" or entity:GetType() == entity.PUBLIC) then return false end
		if (!gamemode.Call("CanProperty", client, "wncontainer_setpublic", entity)) then return false end

		return CAMI.PlayerHasAccess(client, "Helix - Manage Containers")
	end,

	Action = function(self, entity)
		Derma_Query(L("containerPublicAreYouSure"), L("containerPublicTitle"), L("yes"), function(text)
			self:MsgStart()
				net.WriteEntity(entity)
			self:MsgEnd()
		end, L("no"))
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()

		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end

		entity:ChangeType(entity.PUBLIC)

		local name = entity:GetDisplayName()
		local inventory = entity:GetInventory()
		ix.log.Add(client, "containerSetPublic", name, inventory:GetID())
	end
})

properties.Add("wncontainer_setadmintext", {
	MenuLabel = "Set Admin Text",
	Order = 403,
	MenuIcon = "icon16/tag_blue_edit.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "ix_wncontainer" or entity:GetClass() != entity.PUBLIC) then return false end
		if (!gamemode.Call("CanProperty", client, "wncontainer_setadmintext", entity)) then return false end

		return CAMI.PlayerHasAccess(client, "Helix - Manage Containers")
	end,

	Action = function(self, entity)
		Derma_StringRequest(L("containerAdminTextTitle"), L("containerAdminText"), entity:GetAdminText(), function(text)
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

		local text = net.ReadString()
		container:UpdateAdminText(text)

		local name = entity:GetDisplayName()
		local inventory = entity:GetInventory()
		ix.log.Add(client, "containerSetAdminText", name, inventory:GetID(), text)
	end
})

properties.Add("wncontainer_setpublic", {
	MenuLabel = "Set Type: Cleanup",
	Order = 413,
	MenuIcon = "icon16/tag_blue_edit.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "ix_wncontainer" or entity:GetType() == entity.MANCLEANUP) then return false end
		if (!gamemode.Call("CanProperty", client, "wncontainer_setpublic", entity)) then return false end

		return CAMI.PlayerHasAccess(client, "Helix - Manage Containers")
	end,

	Action = function(self, entity)
		Derma_Query(L("containerCleanupAreYouSure"), L("containerCleanupTitle"), L("yes"), function(text)
			self:MsgStart()
				net.WriteEntity(entity)
			self:MsgEnd()
		end, L("no"))
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()

		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end

		entity:ChangeType(entity.MANCLEANUP)

		local name = entity:GetDisplayName()
		local inventory = entity:GetInventory()
		ix.log.Add(client, "containerSetManCleanup", name, inventory:GetID())
	end
})