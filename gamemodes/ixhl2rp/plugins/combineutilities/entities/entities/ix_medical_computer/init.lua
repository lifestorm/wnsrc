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

AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.

include('shared.lua')

util.AddNetworkString( "TypeSound" )
util.AddNetworkString( "ClickSound" )

function ENT:Initialize()
    self:SetModel("models/willardnetworks/props/willard_computer.mdl")
    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:PhysicsInit( SOLID_VPHYSICS )
    self:DrawShadow(false)
    self:SetUseType(SIMPLE_USE)
    self:SetDisplay(1)

    local physics = self:GetPhysicsObject()
    physics:EnableMotion(true)
    physics:Wake()

    timer.Simple(1, function()
        if IsValid(self) and physics then
            physics:EnableMotion(false)
        end
    end)

    self.canUse = true
    self.users = {}
    self.notes = {}

    self:SaveMedicalComputers()
    -- self:SpawnProps()
    self:SetProperSkin()

	self.hasDiskInserted = false
end

function ENT:SetProperSkin()
    self:SetSkin(1)
end

function ENT:SaveMedicalComputers()
	ix.saveEnts:SaveEntity(self)
end

function ENT:CloseMedicalComputer()
	self:SetDisplay(3)
	self:EmitSound("ambient/machines/combine_terminal_idle1.wav")

	timer.Remove("computer_"..self:EntIndex().."_charcheck")

	timer.Simple(2, function()
		if IsValid(self) then
			self:SetDisplay(1)
			self.canUse = true
		end
	end)
end

-- function ENT:SpawnProps()
-- 	local rightFrom = Vector(-20 * self:GetRight(), 0, 0)
-- 	local leftFrom = Vector(20 * self:GetRight(), 0, 0)
-- 	local forwardFrom = Vector(20 * self:GetForward(), 0, 0)
-- 	local aBitDown = Vector(0, 0, 3)

-- 	local cabinet = ents.Create("prop_dynamic")
-- 	cabinet:SetPos(self:GetPos() + leftFrom - aBitDown)
-- 	cabinet:SetAngles(self:GetAngles())
-- 	cabinet:SetModel("models/props_lab/harddrive02.mdl")
-- 	cabinet:Activate()
-- 	cabinet:SetParent(self)
-- 	cabinet:Spawn()
-- 	cabinet:DeleteOnRemove(self)

-- 	local keyboard = ents.Create("prop_dynamic")
-- 	keyboard:SetPos(self:GetPos() + forwardFrom - (aBitDown * 4.5))
-- 	keyboard:SetAngles(self:GetAngles())
-- 	keyboard:SetModel("models/props_c17/computer01_keyboard.mdl")
-- 	keyboard:Activate()
-- 	keyboard:SetParent(self)
-- 	keyboard:Spawn()
-- 	keyboard:DeleteOnRemove(self)

-- 	local mouse = ents.Create("prop_dynamic")
-- 	mouse:SetPos(self:GetPos() + forwardFrom + rightFrom - (aBitDown * 4.3))
-- 	mouse:SetAngles(self:GetAngles() + Angle(20, -80, 0))
-- 	mouse:SetModel("models/gibs/shield_scanner_gib1.mdl")
-- 	mouse:SetMaterial("phoenix_storms/dome")
-- 	mouse:Activate()
-- 	mouse:SetParent(self)
-- 	mouse:Spawn()
-- 	mouse:DeleteOnRemove(self)
-- end

function ENT:GetGroupInformation(client, character, bNormal)
	self.groupmessages = {}
	self.groupmessages["messages"] = {}
	self.groupmessages["replies"] = {}

	local messageQuery = mysql:Select("ix_comgroupmessages")
	messageQuery:Select("message_id")
	messageQuery:Select("message_text")
	messageQuery:Select("message_date")
	messageQuery:Select("message_poster")
	messageQuery:Select("message_groupid")
	messageQuery:Where("message_groupid", character:GetGroupID())
	messageQuery:Callback(function(result)
		self.groupmessages["messages"] = result or {}

		local replyQuery = mysql:Select("ix_comgroupreplies")
		replyQuery:Select("reply_id")
		replyQuery:Select("reply_text")
		replyQuery:Select("reply_date")
		replyQuery:Select("reply_poster")
		replyQuery:Select("reply_parent")
		replyQuery:Select("reply_groupid")
		replyQuery:Where("reply_groupid", character:GetGroupID())

		replyQuery:Callback(function(result2)
			self.groupmessages["replies"] = result2 or {}

			if !bNormal then
				netstream.Start(client, "OpenMedicalComputer", self, self.users, self.notes, self.groupmessages, self.hasDiskInserted)
			else
				netstream.Start(client, "OpenComputer", self, self.users, self.notes, self.groupmessages, self.hasDiskInserted)
			end
		end)

		replyQuery:Execute()
	end)

	messageQuery:Execute()
end

function ENT:Use(client)
	if (client.CantPlace) then
		client:NotifyLocalized("Musisz poczekać, zanim będziesz mógł tego użyć!")
		return false
	end

	client.CantPlace = true
	timer.Simple(3, function()
		if (client) then
			client.CantPlace = false
		end
	end)

	local character = client:GetCharacter()
	if (self:GetNWInt("owner") == nil) then
		self:SetNWInt("owner", character:GetID())
	end

	if !self.canUse then
		return
	end

	self:EmitSound( "buttons/button1.wav" )
	self.canUse = false

	if (character:GetGroup()) then
		self:GetGroupInformation(client, character, false)
	else
		netstream.Start(client, "OpenMedicalComputer", self, self.users, self.notes, false, self.hasDiskInserted)
	end

	self:SetDisplay(2)

	local uniqueID = "computer_"..self:EntIndex().."_charcheck"
	timer.Create(uniqueID, 10, 0, function()
		if (!IsValid(self)) then
			timer.Remove(uniqueID)
			return
		elseif (!IsValid(client) or !client:GetCharacter()) then
			self.canUse = true
			self:SetDisplay(1)

			timer.Remove(uniqueID)
		end
	end)
end

function ENT:AddUser(cid)
	if (self.users) then
		if (istable(self.users)) then
			table.insert(self.users, cid)
		end
	end
end

function ENT:AddNote(name, text, headline)
	self.notes[#self.notes + 1] = {
		text = text,
		headline = headline,
		date = ix.date.GetFormatted("%d/%m/%Y"),
		poster = name
	}
end

function ENT:UpdateNote(name, text, headline, key)
	if !text then self.notes[key] = nil return end

	self.notes[key] = {
		text = text,
		headline = headline,
		date = ix.date.GetFormatted("%d/%m/%Y"),
		poster = name
	}
end

function ENT:OnRemove()
	if timer.Exists("MedicalAmbientSound_"..self:EntIndex()) then
		timer.Remove("MedicalAmbientSound_"..self:EntIndex())
	end
end

function ENT:CheckIfUserHasAccess(client)
	if client:HasActiveCombineSuit() then return true end

	local character = client:GetCharacter()
	local inventory = character:GetInventory()
	local invItems = inventory:GetItems()

	for _, v in pairs(self.users) do
		for _, v2 in pairs(invItems) do
			if v2.uniqueID != "id_card" then
				continue
			end

			if tostring(v) == tostring(v2:GetData("cid")) then
				return true
			end
		end
	end

	client:Notify("You do not have access or you are not wearing a combine suit.")
	return false
end

netstream.Hook("AddComputerUser", function(client, activeComputer, cid)
	if table.IsEmpty(activeComputer.users) then activeComputer:AddUser(cid) return end

	if activeComputer:CheckIfUserHasAccess(client) then
		activeComputer:AddUser(cid)
	else
		return false
	end
end)

netstream.Hook("searchMedicalFile", function(client, searchname, activeComputer)
	if !activeComputer:CheckIfUserHasAccess(client) then
		return false
	end

	local curTime = CurTime()
	if (client.nextSearchMedicalFile and client.nextSearchMedicalFile > curTime) then
		return
	end

	client.nextSearchMedicalFile = curTime + 2

	local query = mysql:Select("ix_characters")
	query:Select("id")
	query:Select("name")
	query:Select("cid")
	query:WhereLike(((tonumber(searchname) != nil and string.utf8len( searchname ) <= 5) and "cid" or "name"), searchname)
	query:Where("schema", Schema and Schema.folder or "helix")
	query:Limit(1)
	query:Callback(function(result)
		if (!istable(result)) then
			netstream.Start(client, "createMedicalRecords", false, false, false, false)
			return
		end

		if not result[1] then
			netstream.Start(client, "createMedicalRecords", false, false, false, false)
			return
		end

		local dataQuery = mysql:Select("ix_characters_data")
		dataQuery:Select("data")
		dataQuery:Where("id", result[1].id)
		dataQuery:Where("key", "datafilemedicalrecords")
		dataQuery:Callback(function(dataResult)
			if (!istable(dataResult)) then
				netstream.Start(client, "createMedicalRecords", false, false, false, false)
				return
			end

			if not dataResult[1] then
				netstream.Start(client, "createMedicalRecords", false, false, false, false)
				return
			end

			local medicalrecords = util.JSONToTable(dataResult[1].data or "")

			timer.Simple(0.05, function()
				netstream.Start(client, "createMedicalRecords", medicalrecords, result[1].name, searchname, result[1].id)
			end)
		end)
		dataQuery:Execute()
	end)
	query:Execute()
end)

netstream.Hook("MedicalComputerAddRecord", function(client, id, posterName, text, activeComputer)
	if !activeComputer:CheckIfUserHasAccess(client) then
		return false
	end

	id = tonumber(id)

	local dataQuery = mysql:Select("ix_characters_data")
		dataQuery:Select("data")
		dataQuery:Where("id", id)
		dataQuery:Where("key", "datafilemedicalrecords")
		dataQuery:Callback(function(dataResult)
			if (!istable(dataResult)) then
				return
			end

			if not dataResult[1] then
				return
			end

			local medicalrecords = util.JSONToTable(dataResult[1].data or "")
			medicalrecords[#medicalrecords + 1] = {
				text = text,
				date = os.date("%d/%m/%Y"),
				poster = posterName
			}

			if (ix.char.loaded[id]) then
				ix.char.loaded[id]:SetDatafilemedicalrecords(medicalrecords)
				ix.char.loaded[id]:Save()
			else
				local updateQuery = mysql:Update("ix_characters_data")
					updateQuery:Update("data", util.TableToJSON(medicalrecords))
					updateQuery:Where("id", id)
					updateQuery:Where("key", "datafilemedicalrecords")
				updateQuery:Execute()
			end
		end)
	dataQuery:Execute()
end)

netstream.Hook("MedicalComputerAddNote", function(client, activeComputer, posterName, text, headline)
	if !activeComputer:CheckIfUserHasAccess(client) then
		return false
	end

	activeComputer:AddNote(posterName, text, headline)
end)

netstream.Hook("MedicalComputerUpdateNote", function(client, activeComputer, posterName, text, headline, key)
	if !activeComputer:CheckIfUserHasAccess(client) then
		return false
	end

	activeComputer:UpdateNote(posterName, text, headline, key)
end)

net.Receive( "TypeSound", function( length, client )
	client:EmitSound(string.format( "ambient/machines/keyboard%d_clicks.wav", math.random( 6 ) ),75)
end )

net.Receive( "ClickSound", function( length, client )
	client:EmitSound("willardnetworks/datapad/mouseclick.wav", 75)
end )

netstream.Hook("CloseMedicalComputer", function(client, activeComputer)
	if activeComputer then
		activeComputer:CloseMedicalComputer()
	end
end)

netstream.Hook("SyncStoredNewspapers", function(client)
	local writingPlugin = ix.plugin.list["writing"]
	local storedNewspapers = writingPlugin.storedNewspapers

	netstream.Start(client, "SyncStoredNewspapersClient", storedNewspapers)
end)