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

PLUGIN.name = "Containers, Willard Edition"
PLUGIN.author = "Chessnut & Gr4Ss"
PLUGIN.description = "Provides the ability to store items, customized for Willard Networks."

ix.util.Include("sh_properties.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Containers",
	MinAccess = "admin"
})

CAMI.RegisterPrivilege({
	Name = "Helix - Premium Container",
	MinAccess = "superadmin"
})


ix.lang.AddTable("english", {
	wncontOwnDifferentChar = "You cannot use this container as you own it on a different character!",
	wncontCleanup = "This container has gone inactive and will be removed on %s. Items can only be taken out.",
	containerOwnerTitle = "Select Container Owner",
	containerOwner = "Please select the character that owns this private container:",
	containerSelectOwner = "Select Owner",
	containerGroupTitle = "Set Group/Faction",
	containerGroup = "Please enter the name of the group/faction owning this container",
	containerPublicTitle = "Set Public",
	containerPublicAreYouSure = "Are you sure you wish to make this container public?",
	containerCleanupTitle = "Mark for Cleanup",
	containerCleanupAreYouSure = "Are you sure you want to mark this container for cleanup?",
	containerListName = "%s's container list:",
	containerPremiumAmount = "%d premium containers are included in the above list.",
	containerAdminTextTitle = "Set Admin Text",
	containerAdminText = "Please enter the admin-text for this container:",
	containerPKHold = "This container is on PK hold. If the PK is not overturned, this container will unlock on %s.",
	containerNoOwner = "This container is not passworded and can be used by anyone.",
	containerTypePublic = "This container is public and belongs to no-one.",
	containerTypeGroup = "This container belongs to a group. Reach out to the admins if you need more info.",
	containerTypeCleanup = "This container is no longer being used and will get deleted on %s.",
	containerTypePKHold = "The owner of this container was PK'ed. It cannot be used until %s, when it will unlock if the PK wasn't overturned.",
	containerTypePrivateOnline = "The owner of this container is %s (%s). They are currently online.",
	containerTypePrivateOffline = "The owner of this container is %s (%s). Their character was last online on %s.",
	containerInactiveNoFound = "No inactive containers were found for %s!",
	containerInactiveListName = "Inactive container list for %s:",
	containerRestoreNotFound = "Could not find an inactive container with inventory ID '%d'!",
	containerModelNoLongerExists = "This container model no longer exists in the container definition! It was temporarily recreated with a 10x10 inventory size, but will not load after the next map restart. Please setup a new container and move the items over!",
	containerRestoredPrivate = "The container was successfully restored to its owner! A new password must be set.",
	containerRestoredPublic = "The container was successfully restored, but the owner is not online. The container is set as public!",
	containerUseOld = "You are using an old container! These will be deleted on the 1st of September. If you (or your group) own this container, please ask an admin to convert this container to the new container type.",
})

ix.config.Add("containerInactivityDays", 30, "How many days without use until a container is considered inactive", nil, {
	data = {min = 0, max = 200},
	category = "Containers"
})

ix.config.Add("containerPKGrace", 7, "Grace time after the owner of a private container is PK'ed", nil, {
	data = {min = 0, max = 30},
	category = "Containers"
})

ix.config.Add("containerRemoveGrace", 7, "Grace time after a container became unlocked before it is removed", nil, {
	data = {min = 0, max = 30},
	category = "Containers"
})

ix.config.Add("containerSetupGrace", 3, "Grace time after a (group) container was setup before it can be considered inactive", nil, {
	data = {min = 0, max = 10},
	category = "Containers"
})

ix.config.Add("notifyOldcontainer", true, "Notify players when using an old container.", nil, {
	category = "Containers"
})

ix.command.Add("PlyGetContainers", {
	description = "Gets all private containers for a player",
	adminOnly = true,
	arguments = {
		ix.type.player
	},
	OnRun = function(self, client, target)
		local containers = {}
		local premiums = 0
		local steamId = target:SteamID64()
		for k, v in ipairs(ents.FindByClass("ix_wncontainer")) do
			if (v:GetType() == v.PRIVATE and v.owner == steamId) then
				containers[v.ownerCharID] = containers[v.ownerCharID] or {}
				local def = ix.container.stored[v:GetModel():lower()]
				local sizeText = "large"
				local size = def.width * def.height
				if (def.sizeClass) then
					sizeText = def.sizeClass
				elseif (size <= 15) then
					sizeText = "small"
				elseif (size <= 40) then
					sizeText = "medium"
				end
				containers[v.ownerCharID][sizeText] = (containers[v.ownerCharID][sizeText] or 0) + 1

				if (v:GetPremium()) then
					premiums = premiums + 1
				end
			end
		end

		client:ChatNotifyLocalized("containerListName", target:SteamName())
		for k, v in pairs(containers) do
			local charName = ix.char.loaded[k] and ix.char.loaded[k]:GetName() or k
			local contList = {}
			for size, amount in pairs(v) do
				contList[#contList + 1] = amount.."x "..size
			end
			table.sort(contList)
			client:ChatNotifyLocalized(charName..": "..table.concat(contList, ", "))
		end
		client:ChatNotifyLocalized("containerPremiumAmount", premiums)
	end
})

ix.command.Add("PlyGetInactveContainers", {
	description = "Gets all private containers for a player that were removed due to inactivity",
	adminOnly = true,
	arguments = {
		ix.type.player
	},
	OnRun = function(self, client, target)
		local steamId = target:SteamID64()
		local name = target:SteamName()
		local query = mysql:Select("ix_container_inactive")
			query:Select("inv_id")
			query:Select("character_id")
			query:Where("steamid", steamId)
			query:Callback(function(result)
				if (IsValid(client) and IsValid(target) and result and istable(result) and #result > 0) then
					local containers = {}
					for k, v in ipairs(result) do
						containers[v.character_id] = containers[v.character_id] or {}
						containers[v.character_id][#containers[v.character_id] + 1] = v.inv_id
					end

					client:ChatNotifyLocalized("containerInactiveListName", target:SteamName())
					for k, v in pairs(containers) do
						local charName = ix.char.loaded[k] and ix.char.loaded[k]:GetName() or k
						client:ChatNotifyLocalized(charName..": "..table.concat(v, ", "))
					end
				elseif (IsValid(client)) then
					client:NotifyLocalized("containerInactiveNoFound", name)
				end
			end)
		query:Execute()
	end
})

ix.command.Add("PlyContainerUnban", {
	description = "Lifts a player's container ban.",
	adminOnly = true,
	arguments = {
		ix.type.player
	},
	OnRun = function(self, client, target)
		if (!playerPasswordAttempts) then
			playerPasswordAttempts = {}
		end

		playerPasswordAttempts[target:SteamID()] = nil

		client:Notify("You have lifted " .. target:Name() .. "'s container ban.")
	end
})

ix.command.Add("PlyRestoreInactiveContainer", {
	description = "Restores an inactive container for a player",
	adminOnly = true,
	arguments = {
		ix.type.number
	},
	OnRun = function(self, client, invID)
		local query = mysql:Select("ix_container_inactive")
			query:Where("inv_id", invID)
			query:Callback(function(result)
				if (IsValid(client) and result and istable(result) and #result > 0) then
					local data = {}
					data.start = client:GetShootPos()
					data.endpos = data.start + client:GetAimVector() * 96
					data.filter = {client:GetActiveWeapon(), client}
					local trace = util.TraceLine(data)

					local data2 = ix.container.stored[result[1].model]
					if (!data2) then
						client:ChatNotifyLocalized("containerModelNoLongerExists")
					end

					local container = ents.Create("ix_wncontainer")
					container:SetPos(trace.HitPos)
					container:SetModel(result[1].model)
					container:Spawn()

					container:SetMoney(result[1].money)

					local physObj = container:GetPhysicsObject()
					if (IsValid(physObj)) then
						physObj:EnableMotion(false)
						physObj:Sleep()
					end

					ix.inventory.Restore(result[1].inv_id, data2 and data2.width or 10, data2 and data2.height or 10, function(inventory)
						inventory.vars.isBag = true
						inventory.vars.isContainer = true
						inventory.vars.entity = container

						if (IsValid(container)) then
							container:SetInventory(inventory)

							if (ix.char.loaded[result[1].character_id]) then
								local character = ix.char.loaded[result[1].character_id]
								if (IsValid(character:GetPlayer())) then
									container:ChangeType(container.PRIVATE, character:GetPlayer())
									client:NotifyLocalized("containerRestoredPrivate")
									return
								end
							end

							client:NotifyLocalized("containerRestoredPublic")
						end
					end)
				elseif (IsValid(client)) then
					client:NotifyLocalized("containerRestoreNotFound", invID)
				end
			end)
		query:Execute()
	end
})

if (CLIENT) then
	local colors = {
		Color(255, 255, 255),
		Color(138,200,97),
		Color(255,204,0),
		Color(255,78,69),
		Color(255,78,69),
		Color(255,78,69)
	}
	local minAlpha = {
		[1] = 0
	}
	local function containerESP(client, entity, x, y, factor, distance)
		local color = colors[entity:GetType()] or Color(255, 255, 255)
		local alpha = math.Remap(math.Clamp(distance, 500, 1000), 500, 1000, 255, minAlpha[entity:GetType()] or 30)
		color.a = alpha

		ix.util.DrawText("Container - "..entity:GetDisplayName().." #"..entity:EntIndex(), x, y - math.max(10, 32 * factor), color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, alpha)
	end
	ix.observer:RegisterESPType("ix_wncontainer", containerESP, "container (new)")

	net.Receive("ixWNContainerPassword", function(length)
		local entity = net.ReadEntity()

		Derma_StringRequest(
			L("containerPasswordWrite"),
			L("containerPasswordWrite"),
			"",
			function(val)
				net.Start("ixWNContainerPassword")
					net.WriteEntity(entity)
					net.WriteString(val)
				net.SendToServer()
			end
		)
	end)
end
