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

function ENT:Initialize()
	self:SetModel(self.model)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:DrawShadow(false)
	self:SetUseType(SIMPLE_USE)
	self:SetDisplay(1)

	local physics = self:GetPhysicsObject()

	if (physics) then
		physics:EnableMotion(false)
		physics:Wake()
	end

	self.canUse = true
	self:SaveTerminalLocations()

	self:OnInitialize()
end

function ENT:OnInitialize()
end

function ENT:SaveTerminalLocations()
	ix.saveEnts:SaveEntity(self)
end

function ENT:CheckGlobalUse(client)
	if client.CantPlace then
		client:NotifyLocalized("Musisz poczekać, zanim będziesz mógł tego użyć!")
		return false
	end

	client.CantPlace = true

	timer.Simple(3, function()
		if client then
			client.CantPlace = false
		end
	end)

	return true
end

function ENT:CheckLocalUse(client)
	if (!self.canUse and IsValid(self.activePlayer) and self.activePlayer:GetCharacter() == self.activeCharacter) then
		return false
	else
		self.canUse = false
		self.activePlayer = client
		self.activeCharacter = client:GetCharacter()
		return true
	end
end

function ENT:Use(client)
	if !self:CheckGlobalUse(client) then
		return false
	end

	if !self:CheckLocalUse(client) then
		return false
	end

	self:OnUse(client)
end

function ENT:OnUse(client)
	self:CheckForCID(client)
end

function ENT:SetGroups(bUse)
	if bUse then
		self:SetBodygroup(2, 1)
		self:SetSkin(1)
	else
		self:SetBodygroup(2, 0)
		self:SetSkin(0)
	end
end

function ENT:CheckForCID(client)
	if (ix.config.Get("creditsNoConnection")) then
		self.canUse = false
		self:SetGroups(true)
		self:SetDisplay(2)
		self:EmitSound("buttons/button4.wav")
		timer.Simple(10, function()
			if (!IsValid(self)) then return end
			self:SetDisplay(5)
			self:EmitSound("hl1/fvox/buzz.wav", 60, 100, 0.5)
			timer.Simple(5, function()
				if (!IsValid(self)) then return end
				self.canUse = true
				self:SetDisplay(1)
				self:SetGroups(false)
			end)
		end)
		return
	end

	local idCards = self.activeCharacter:GetInventory():GetItemsByUniqueID("id_card")

	if (#idCards > 1) then
		self:OpenCIDSelector(client)
		return
	end

	if (#idCards == 1) then
		self:SetGroups(true)
		idCards[1]:LoadOwnerGenericData(self.OpenTerminal, self.OpenTerminalFail, client, self)
	else
		self.canUse = false
		self:EmitSound("buttons/button2.wav")
		timer.Simple(1, function()
			if (IsValid(self)) then
				self.canUse = true
			end
		end)
	end
end

function ENT:OpenCIDSelector(client)
	netstream.Start(client, "OpenCIDSelectorTerminal", self)
end

netstream.Hook("SelectCIDTerminal", function(client, idCardID, _, _, activeTerminal)
	if (IsValid(activeTerminal)) then
		local idCard = ix.item.instances[idCardID]
		if (!idCard) then
			activeTerminal.OpenTerminalFail(nil, client, activeTerminal)
		else
			idCard:LoadOwnerGenericData(activeTerminal.OpenTerminal, activeTerminal.OpenTerminalFail, client, activeTerminal)
		end
	end
end)

netstream.Hook("ClosePanelsTerminal", function(client, activeTerminal)
	if (IsValid(activeTerminal)) then
		activeTerminal.OpenTerminalFail(nil, client, activeTerminal)
	end

	activeTerminal.genericDataCredits = nil
	activeTerminal.genericDataCommunion = nil
	activeTerminal.activeCID = nil
end)

function ENT.OpenTerminalFail(idCard, client, activeTerminal)
	if (!IsValid(activeTerminal)) then return end

	activeTerminal:SetDisplay(4)
	activeTerminal:EmitSound("ambient/machines/combine_terminal_idle1.wav")
	activeTerminal:SetGroups(false)
	timer.Simple(2, function()
		if IsValid(activeTerminal) then
			activeTerminal:SetDisplay(1)
			activeTerminal.canUse = true
		end
	end)
end

function ENT.OpenTerminal(idCard, genericData, client, activeTerminal)
	if (!IsValid(activeTerminal)) then return end

	activeTerminal:SetGroups(true)
	activeTerminal:EmitSound("buttons/button4.wav")


	activeTerminal:SetDisplay(2)
	if (activeTerminal:CheckForVerdicts(client, idCard, genericData)) then
		timer.Simple(2, function()
			if table.IsEmpty(genericData) then
				activeTerminal:SetDisplay(8)
				activeTerminal:EmitSound("buttons/button2.wav")
				timer.Simple(2, function()
					if IsValid(activeTerminal) then
						activeTerminal:SetDisplay(1)
						activeTerminal.canUse = true
					end
				end)
			else
				activeTerminal:OnSuccess(idCard, genericData, client)
			end
		end)
	end
end

function ENT:IsSocialOrCohesion(character, genericData)
	if (character:IsVortigaunt()) then
		if (genericData.cohesionPoints) then
			return genericData.cohesionPoints
		else
			return genericData.socialCredits
		end
	else
		return genericData.socialCredits
	end
end

function ENT:OnSuccess(idCard, genericData, client)
	local character = client:GetCharacter()

	self:SetDisplay(7)
	self:EmitSound("ambient/machines/combine_terminal_idle3.wav")

	self.genericDataCommunion = genericData.bypassCommunion
	self.activeCID = idCard:GetData("cid")
	genericData.socialCredits = !genericData.combine and math.Clamp(tonumber(self:IsSocialOrCohesion(character, genericData)), 0, 200) or tonumber(self:IsSocialOrCohesion(character, genericData))
	self.genericDataCredits = genericData.socialCredits

	local query = mysql:Select("ix_camessaging")
	query:Select("message_cid")
	query:Select("message_text")
	query:Select("message_date")
	query:Select("message_poster")
	query:Select("message_reply")
	query:Where("message_cid", idCard:GetData("cid"))
	query:Callback(function(result)
		if (character:IsVortigaunt()) then
			if (genericData.cid or character:GetBackground() == "Kolaborator") then
				ix.combineNotify:AddNotification("LOG:// Podmiot " .. string.upper("identyfikator zasobu biotyczynego:") .. " #" .. genericData.cid .. " użył Terminala Obywatelskiego", nil, client)
			else
				ix.combineNotify:AddNotification("LOG:// Podmiot " .. string.upper("obroża zasobu biotycznego:") .. " #" .. character:GetCollarID() .. " użył Terminala Obywatelskiego", nil, client)
			end
		else
			ix.combineNotify:AddNotification("LOG:// Podmiot '" .. genericData.name .. "' użył Terminala Obywatelskiego", nil, client)
		end

		if (!istable(result)) then
			netstream.Start(client, "OpenTerminal", idCard:GetID(), genericData, idCard:GetData("cid"), idCard:GetCredits(), self)
			return
		end

		netstream.Start(client, "OpenTerminal", idCard:GetID(), genericData, idCard:GetData("cid"), idCard:GetCredits(), self, result)
	end)

	query:Execute()
end

function ENT:CheckForVerdicts(client, idCard, genericData)
	if (idCard:GetData("active", false) == false) then
		self:CreateCombineAlert(client, "WRN:// Wykryto próbę użycia nieaktywnego CID #" .. idCard:GetData("cid", 00000))
		self:SetDisplay(8)
		timer.Simple(1.5, function()
			if self then
				self.OpenTerminalFail(nil, client, self)
			end
		end)
		return
	end

	local isBOL = genericData.bol
	local isAC = genericData.anticitizen
	if (isBOL or isAC) then
		local text = isBOL and "Podejrzanego BOL" or "Antyobywatela"
		self:CreateCombineAlert(client, "WRN:// Wykryto aktywność identyfikatora " .. text)

		if isAC then
			self:SetDisplay(8)
			timer.Simple(1.5, function()
				if self then
					self.OpenTerminalFail(nil, client, self)
				end
			end)
		end

		return !isAC -- stop if isAC, continue for isBOL
	end

	return true
end

function ENT:CreateCombineAlert(client, message)
	ix.combineNotify:AddImportantNotification(message, nil, client, self:GetPos())
end

function ENT.CheckIdCardCoupon(idCard, genericData, client, entity, couponAmount)
	local character = client:GetCharacter()

	if entity:IDCardCheck(idCard, genericData, client, entity) then
		entity:EmitSound("ambient/levels/labs/coinslot1.wav")
		if (ix.config.Get("creditsNoConnection")) then
			entity:SetDisplay(2)
			entity.canUse = false
			timer.Simple(10, function()
				if (!IsValid(entity)) then return end
				entity:SetDisplay(5)
				entity:EmitSound("buttons/combine_button_locked.wav")
				timer.Simple(5, function()
					if (!IsValid(entity)) then return end
					entity:SetDisplay(1)
					entity.canUse = true
				end)
				timer.Simple(2, function()
					if (!IsValid(entity)) then return end
					entity:EmitSound("ambient/levels/labs/coinslot1.wav")
				end)
			end)
			return
		end

		timer.Simple(1, function()
			if IsValid(entity) then
				entity:EmitSound("Friends/friend_online.wav")
			end
		end)

		entity:SetDisplay(2)
		entity.canUse = false

		timer.Simple(2, function()
			if IsValid(entity) then
				if ix.city.main:HasCredits(couponAmount) then
					entity:EmitSound("Friends/friend_join.wav")
					entity:SetDisplay(4)

					idCard:GiveCredits(couponAmount, "Rations", "Ration Coupon")
					ix.city.main:TakeCredits(couponAmount)
				else
					entity:SetDisplay(2)
					entity.canUse = false
					timer.Simple(10, function()
						if (!IsValid(entity)) then return end
						entity:SetDisplay(5)
						entity:EmitSound("buttons/combine_button_locked.wav")
						timer.Simple(5, function()
							if (!IsValid(entity)) then return end
							entity:SetDisplay(1)
							entity.canUse = true
						end)
						timer.Simple(2, function()
							if (!IsValid(entity)) then return end
							entity:EmitSound("ambient/levels/labs/coinslot1.wav")
						end)
					end)
					return
				end

				if ix.item.instances[client.ixCouponUsed] then
					ix.item.instances[client.ixCouponUsed]:Remove()
				end

				client.ixCouponUsed = nil

				ix.log.Add(client, "rationsCoupon", couponAmount)

				timer.Simple(2, function()
					if IsValid(entity) then
						entity:SetDisplay(1)
						entity.canUse = true
					end
				end)
			end
		end)
	end
end

function ENT.CheckIdError(idCard, client, entity)
	entity:DisplayError(INVALID_CID)
	client.ixCouponUsed = nil
end

function ENT:IDCardCheck(idCard, genericData, client, entity)
	if (idCard:GetData("active", false) == false) then
		entity:CreateCombineAlert(client, "WRN:// Wykryto próbę użycia nieaktywnego CID #" .. idCard:GetData("cid", 00000), FREQ_LIMIT)

		return false
	end

	local isBOL = genericData.bol
	local isAC = genericData.anticitizen
	if (isBOL or isAC) then
		local text = isBOL and "Podejrzanego BOL" or "Antyobywatela"
		entity:CreateCombineAlert(client, "WRN:// Wykryto aktywność identyfikatora " .. text, isAC and FREQ_LIMIT)

		-- only halt if isAC, allow it to continue for BOL
		if (isAC) then
			return false
		end
	end

	return true
end

netstream.Hook("AddCAMessage", function(client, name, cid, text, activeTerminal)
	if !text or !name or !cid then return false end

	if cid != activeTerminal.activeCID then
		return false
	end

	if activeTerminal.genericDataCredits < ix.config.Get("communionSCRequirement", 150) and !activeTerminal.genericDataCommunion then
		return false
	end

	local timestamp = os.date( "%d.%m.%Y" )
	local queryObj = mysql:Insert("ix_camessaging")
		queryObj:Insert("message_poster", name)
		queryObj:Insert("message_text", text)
		queryObj:Insert("message_date", timestamp)
		queryObj:Insert("message_cid", cid)
	queryObj:Execute()

	ix.combineNotify:AddNotification("LOG:// Podmiot '" .. name .. "' wysłał wiadomość za pomocą terminala komunikacyjnego", nil, client)

	for _, v in pairs(player.GetAll()) do
		if !IsValid(v) then continue end
		local character = v:GetCharacter()
		if !character then continue end
		local inventory = character:GetInventory()
		if !inventory:HasItem("capda") then continue end

		v:Notify("Ktoś właśnie wysłał wiadomość przez terminal komunikacyjny!")
	end
end)

netstream.Hook("RemoveCAMessage", function(client, id)
	if !id then return false end
	if !client:GetCharacter():GetFaction() != FACTION_ADMIN then return false end

	local queryObj = mysql:Delete("ix_camessaging")
		queryObj:Where("message_id", id)
	queryObj:Execute()
end)

netstream.Hook("BreakAttemptSpottedTerminal", function(client, name, cid, activeTerminal)
	if cid != activeTerminal.activeCID then
		return false
	end

	ix.combineNotify:AddImportantNotification("WRN:// Próba 51b; Uszkodzenie mienia publicznego", nil, client, client:GetPos())
end)