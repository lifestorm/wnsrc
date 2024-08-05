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

PLUGIN.name = "Staff QOL"
PLUGIN.author = "Fruity"
PLUGIN.description = "PlyGetInfo, toolgun stuff, logging and other misc."

ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_plugin.lua")

ix.lang.AddTable("english", {
	cmdPlyGetInfo = "Displays character list, individual languages, flags (perm and temp) and other misc info.",
	qolPlyInfo = "Player Information",
	qolCharacters = "Characters",
	qolCopiedSteamID = "You have copied the SteamID.",
	qolCopySteamID = "Copy SteamID",
	qolHP = "HP",
	qolArmor = "Armor",
	qolPlayerFlags = "Playerflags",
	qolName = "Name",
	qolLanguages = "Languages",
	qolFlags = "Flags",
	qolTempFlags = "TempFlags",
	qolGroupName = "Group Name",
	qolSeeWhitelists = "See Whitelists",
	qolFindItem = "Find item by name on map/in inventory/in db",
	qolItemsInfo = "Items found",
	qolItemsInfoData = "Data",
	qolItemsInfoInvID = "Inventory ID",
	qolItemsInfoName = "Name of Item",
	qolItemsInfoOwner = "Owner",
	qolItemsInfoOrigin = "Origin",
	qolItemsInfoWPosition = "World Position",
	qolExcludeItems = "Include/Exclude Items",
	qolSorting = "Sorting",
	qolFindItemById = "Find item by name on map/in inventory/in db using an ID",
})

ix.command.Add("PlyGetInfo", {
	description = "@cmdPlyGetInfo",
	adminOnly = true,
	arguments = ix.type.player,
	OnRun = function(self, client, target)
		if (target and IsValid(target)) then
			local tempFlags = target:GetLocalVar("tempFlags") or {}
			local characters = target.ixCharList or {}
			local info = {}

			for _, character in pairs(characters) do
				local charInfo = ix.char.loaded[character]

				if !charInfo.vars then continue end

				local vars = charInfo.vars
				local name = vars.name or "N/A"
				local languages = vars.languages or {}
				local flags = vars.data["f"] or ""
				local group = charInfo.GetGroup and charInfo:GetGroup() or {}
				local groupname = group.name or "N/A"
				local miscInfo = {
					curHp = target:Health(),
					curArmor = target:Armor(),
					steamID = target:SteamID(),
					steamID64 = target:SteamID64(),
					playerFlags = target:GetData("playerFlags", "N/A"),
					whitelists = target:GetData("whitelists", {})
				}

				info[character] = {
					[1] = name,
					[2] = languages,
					[3] = flags,
					[4] = tempFlags,
					[5] = groupname
				}

				info.player = miscInfo
			end

			net.Start( "ixPlyGetInfo" )
				net.WriteTable(info)
			net.Send(client)
		end
	end
})

--[[
ix.command.Add("FindItem", {
	description = "@qolFindItem",
	adminOnly = true,
	arguments = ix.type.text,
	OnRun = function(self, client, sSearch)
		PLUGIN:FindItem(client, sSearch)
	end
})
--]]

ix.command.Add("FindItemById", {
	description = "@qolFindItemById",
	adminOnly = true,
	arguments = ix.type.number,
	OnRun = function(self, client, id)
		PLUGIN:FindItem(client, tonumber(id))
	end
})

properties.Add("ixFloppyDiscSeePassword", {
	MenuLabel = "See password",
	Order = 401,
	MenuIcon = "icon16/eye.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "ix_item") then return false end
		if (!CAMI.PlayerHasAccess(client, "Helix - Basic Admin Commands")) then return false end
		local itemTable = entity:GetItemTable()
		if !itemTable or itemTable and !istable(itemTable) then return false end
		if !itemTable.uniqueID then return false end
		if itemTable.uniqueID != "floppydisk" then return false end

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

		if !entity.ixItemID then return false end

		if !ix.item.instances[entity.ixItemID] then return false end
		if !ix.item.instances[entity.ixItemID].data then return false end

		local password = ix.item.instances[entity.ixItemID].data["password"] or "N/A"

		client:Notify(password)

		ix.log.Add(client, "getFloppyDiskPassword", entity:EntIndex(), password)
	end
})

ix.command.Add("CharBan", {
	description = "@cmdCharBan",
	privilege = "Ban Character",
	arguments = {
		ix.type.string,
		bit.bor(ix.type.number, ix.type.optional)
	},
	adminOnly = true,
	OnRun = function(self, client, sTarget, minutes)
		PLUGIN:BanSomeone(client, sTarget, minutes)
	end
})

ix.command.Add("CharPK", {
	description = "Permanently ban a character.",
	privilege = "Ban Character",
	arguments = {
		ix.type.string
	},
	adminOnly = true,
	OnRun = function(self, client, sTarget)
		PLUGIN:BanSomeone(client, sTarget)
	end
})

ix.command.Add("BringContainer", {
	description = "Bring a container.",
	arguments = {
		ix.type.number
	},
	adminOnly = true,
	OnRun = function(self, client, nEntIndex)
		if !nEntIndex or nEntIndex and !isnumber(nEntIndex) then
			client:Notify("Invalid ID")
			return false
		end

		local entity = Entity(nEntIndex)
		if entity and IsValid(entity) then
			local inv = entity.GetInventory and entity:GetInventory()
			local isContainer = inv and inv.vars and inv.vars.isContainer
			local data = ix.container.stored[entity:GetModel():lower()]

			if !isContainer or !data then
				client:Notify("Not a container")
				return false
			end

			entity:SetPos(client:GetPos())
			client:Notify("You have brought a "..data.name.." with the index #"..nEntIndex)

			ix.log.Add(client, "ixBringContainer", data.name or "N/A", nEntIndex)
		else
			client:Notify("Invalid entity")
		end
	end
})

ix.command.Add("ForceCharFallover", {
	description = "Forcefully 'fallover' a character.",
	arguments = {
		ix.type.player,
		bit.bor(ix.type.number, ix.type.optional)
	},
	adminOnly = true,
	OnRun = function(self, client, target, time)
		if (!target:Alive() or target:GetMoveType() == MOVETYPE_NOCLIP) then
			return "@notNow"
		end

		if (time and time > 0) then
			time = math.Clamp(time, 1, 60)
		end

		if (!IsValid(target.ixRagdoll)) then
			target:SetRagdolled(true, time)
		end
	end
})

ix.command.Add("Play3DSoundTestOrigin", {
	description = "Set the origin of the sound played when running the Test3DSound command.",
	adminOnly = true,
	OnRun = function(self, client)
		local trace = client:GetEyeTraceNoCursor()
		if !trace then return end
		local hitPos = trace.HitPos
		if !hitPos then return end
		local vector = Vector(hitPos)
		if !isvector(vector) then return end

		net.Start("ixSync3dSoundTestOrigin")
		net.WriteVector(vector)
		net.Send(client)
	end
})

ix.command.Add("Play3DSound", {
	description = "Play a sound from your location based on the range (20-150) given.",
	arguments = {
		ix.type.string,
		bit.bor(ix.type.number, ix.type.optional)
	},
	privilege = "Basic Admin Commands",
	OnRun = function(self, client, sound, range)
		range = math.Clamp(range or 75, 20, 150)
		local players = player.GetAll()

		net.Start("ixPlay3DSound")
			net.WriteString(sound)
			net.WriteUInt(range, 8)
			net.WriteVector(client:GetPos())
		net.Send(players)
	end,
	indicator = "chatPerforming"
})

ix.command.Add("Play3DSoundTest", {
	description = "Test playing a sound from Play3DSoundTestOrigin location based on the range (20-150) given.",
	arguments = {
		ix.type.string,
		bit.bor(ix.type.number, ix.type.optional)
	},
	privilege = "Basic Admin Commands",
	OnRun = function(self, client, sound, range)
		range = math.Clamp(range or 75, 20, 150)

		net.Start("ixPlay3DSound")
			net.WriteString(sound)
			net.WriteUInt(range, 8)
		net.Send(client)
	end,
	indicator = "chatPerforming"
})

local CHAR = ix.meta.character
function CHAR:Ban(time)
	time = tonumber(time)

	hook.Run("OnCharacterBanned", self, time or true)

	if (time) then
		-- If time is provided, adjust it so it becomes the un-ban time.
		time = os.time() + math.max(math.ceil(time), 60)
	end

	-- Mark the character as banned and kick the character back to menu.
	self:SetData("banned", time or true)

	for _, v in pairs(player.GetAll()) do
		local char = v:GetCharacter()
		if !char then continue end

		local id = char:GetID()
		if id and id != self:GetID() then continue end
		self:Kick()
	end
end