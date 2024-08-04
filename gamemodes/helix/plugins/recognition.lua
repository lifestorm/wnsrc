--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Recognition"
PLUGIN.author = "Chessnut"
PLUGIN.description = "Adds the ability to recognize people."

ix.command.Add("Recognize", {
	description = "Ask player in front of you about recognition",
	OnRun = function(self, client, arguments)
		local data = {}
		data.start = client:GetShootPos()
		data.endpos = data.start + client:GetAimVector() * 96
		data.filter = client
		local trace = util.TraceLine(data)
		local entity = trace.Entity

		if entity:IsPlayer() then
			client:Notify("You've asked player about recognition")
		else
			client:Notify("Player not found")
			return
		end
		net.Start("ixRecognizeMenuAsk")
			net.WriteEntity(client)
		net.Send(entity)
	end
})

do
	local character = ix.meta.character

	if (SERVER) then

		function character:Recognize(id)
			if (!isnumber(id) and id.GetID) then
				id = id:GetID()
			end

			local recognized = self:GetData("rgn", "")

			if (recognized != "" and recognized:find(","..id..",")) then
				return false
			end

			self:SetData("rgn", recognized..","..id..",")

			return true
		end

		function character:RecognizeTemp(id)
			if (!isnumber(id) and id.GetID) then
				id = id:GetID()
			end

			local recognized = self:GetData("temprgn", "")

			--[[if (recognized != nil and recognized[id] != nil) then
				return false
			end--]]

			if recognized == "" then
				recognized = {}
				recognized[id] = 24
			elseif recognized[id] then
				recognized[id] = 24
			else
				recognized[id] = 24
			end

			self:SetData("temprgn", recognized)

			return true
		end

		local playerMeta = FindMetaTable("Player")

		function playerMeta:Recognize(level)
			local targets = {}

			if (level < 1) then
				local entity = self:GetEyeTraceNoCursor().Entity

				if (IsValid(entity) and entity:IsPlayer() and entity:GetCharacter()
				and ix.chat.classes.ic:CanHear(self, entity)) then
					targets[1] = entity
				end
			else
				local class = "w"

				if (level == 2) then
					class = "ic"
				elseif (level == 3) then
					class = "y"
				end

				class = ix.chat.classes[class]

				for _, v in ipairs(player.GetAll()) do
					if (self != v and v:GetCharacter() and class:CanHear(self, v)) then
						targets[#targets + 1] = v
					end
				end
			end

			if (#targets > 0) then
				local id = self:GetCharacter():GetID()
				local i = 0

				for _, v in ipairs(targets) do
					if (v:GetCharacter():Recognize(id)) then
						i = i + 1
					end
				end

				if (i > 0) then
					net.Start("ixRecognizeDone")
					net.Send(self)
				end

				hook.Run("CharacterRecognized", self, id, targets)
			end
		end

		function playerMeta:RecognizeTemp(level)
			local targets = {}

			if (level < 1) then
				local entity = self:GetEyeTraceNoCursor().Entity

				if (IsValid(entity) and entity:IsPlayer() and entity:GetCharacter()
				and ix.chat.classes.ic:CanHear(self, entity)) then
					targets[1] = entity
				end
			else
				local class = "w"

				if (level == 2) then
					class = "ic"
				elseif (level == 3) then
					class = "y"
				end

				class = ix.chat.classes[class]

				for _, v in ipairs(player.GetAll()) do
					if (self != v and v:GetCharacter() and class:CanHear(self, v)) then
						targets[#targets + 1] = v
					end
				end
			end

			if (#targets > 0) then
				local id = self:GetCharacter():GetID()
				local i = 0

				for _, v in ipairs(targets) do
					if (v:GetCharacter():RecognizeTemp(id)) then
						i = i + 1
					end
				end

				if (i > 0) then
					net.Start("ixRecognizeDone")
					net.Send(self)
				end

				hook.Run("CharacterRecognized", self, id, targets)
			end
		end
	end

	function character:DoesRecognize(id)
		if (!isnumber(id) and id.GetID) then
			id = id:GetID()
		end

		return hook.Run("IsCharacterRecognized", self, id)
	end

	function PLUGIN:IsCharacterRecognized(char, id)
		if (char.id == id) then
			return true
		end

		local other = ix.char.loaded[id]

		if (other) then
			local faction = ix.faction.indices[other:GetFaction()]

			if (faction and faction.isGloballyRecognized) then
				return true
			end
		end

		local recognized = char:GetData("rgn", "")

		if (recognized != "" and recognized:find(","..id..",")) then
			return true
		end

		local recognized = char:GetData("temprgn", "")

		if recognized == "" then
			return false
		end

		if recognized[id] then
			return true
		end
	end
end

if (CLIENT) then
	CHAT_RECOGNIZED = CHAT_RECOGNIZED or {}
	CHAT_RECOGNIZED["ic"] = true
	CHAT_RECOGNIZED["y"] = true
	CHAT_RECOGNIZED["w"] = true
	CHAT_RECOGNIZED["me"] = true

	local function doubleCalling(char)
		timer.Simple(3600, function()
			net.Start("ixRecognizeTempHour")
			net.SendToServer()
			doubleCalling(char)
		end)
	end


	function PLUGIN:CharacterLoaded(character)
		doubleCalling(character)
	end

	function PLUGIN:IsRecognizedChatType(chatType)
		if (CHAT_RECOGNIZED[chatType]) then
			return true
		end
	end

	function PLUGIN:GetCharacterDescription(client)
		if (client:GetCharacter() and client != LocalPlayer() and LocalPlayer():GetCharacter() and
			!LocalPlayer():GetCharacter():DoesRecognize(client:GetCharacter()) and !hook.Run("IsPlayerRecognized", client)) then
			return L"noRecog"
		end
	end

	function PLUGIN:ShouldAllowScoreboardOverride(client)
		if (ix.config.Get("scoreboardRecognition")) then
			return true
		end
	end

	function PLUGIN:GetCharacterName(client, chatType)
		if (client != LocalPlayer() and IsValid(client)) then
			local character = client:GetCharacter()
			local ourCharacter = LocalPlayer():GetCharacter()

			if (ourCharacter and character and !ourCharacter:DoesRecognize(character) and !hook.Run("IsPlayerRecognized", client)) then
				if (chatType and hook.Run("IsRecognizedChatType", chatType)) then
					local description = character:GetDescription()

					if (#description > 40) then
						description = description:utf8sub(1, 37).."..."
					end

					return "["..description.."]"
				elseif (!chatType) then
					return L"unknown"
				end
			end
		end
	end

	local function Recognize(level)
		net.Start("ixRecognize")
			net.WriteUInt(level, 2)
		net.SendToServer()
	end

	local function RecognizeTemporary(level)
		net.Start("ixRecognizeTemp")
			net.WriteUInt(level, 2)
		net.SendToServer()
	end

	net.Receive("ixRecognizeMenu", function(length)
		local menu = DermaMenu()
			menu:AddOption(L"rgnLookingAt", function()
				Recognize(0)
			end)
			menu:AddOption(L"rgnWhisper", function()
				Recognize(1)
			end)
			menu:AddOption(L"rgnTalk", function()
				Recognize(2)
			end)
			menu:AddOption(L"rgnYell", function()
				Recognize(3)
			end)
			menu:AddOption(L"rgnLookingAtTemp", function()
				RecognizeTemporary(0)
			end)
			menu:AddOption(L"rgnWhisperTemp", function()
				RecognizeTemporary(1)
			end)
			menu:AddOption(L"rgnTalkTemp", function()
				RecognizeTemporary(2)
			end)
			menu:AddOption(L"rgnYellTemp", function()
				RecognizeTemporary(3)
			end)
		menu:Open()
		for _, v in pairs(menu:GetChildren()[1]:GetChildren()) do
			v:SetFont("MenuFontNoClamp")
		end

		menu:MakePopup()
		menu:Center()

		ix.gui.recognize = menu

		hook.Run("RecognizeMenuOpened", menu)
	end)

	net.Receive("ixRecognizeMenuAsk", function(length)
		local ent = net.ReadEntity()
		local scrh = ScrH()

		local mainContainer = vgui.Create("EditablePanel")
		mainContainer:SetSize(ScrW(), ScrH())
		mainContainer:SetAlpha(0)
		mainContainer:AlphaTo(255, 0.5, 0)
		mainContainer.Paint = function(self, pw, ph)
			surface.SetDrawColor(Color(63, 58, 115, 220))
			surface.DrawRect(0, 0, pw, ph)
		
			Derma_DrawBackgroundBlur(self, 1)
		end

		local mainPanel = vgui.Create("DPanel")
		mainPanel:MakePopup()
		mainPanel:SetPos( ScrW() * 0.31, scrh * 0.4)
		mainPanel:SetSize(scrh * 0.6, scrh * 0.2)
		mainPanel:SetBackgroundColor(Color(0, 0, 0, 130))
		--[[mainPanel.PaintOver = function(self, w, h)
			surface.SetDrawColor(Color(228, 71, 63, 150))
			surface.DrawOutlinedRect(0, 0, w, h, 5)
		end--]]

		local topBar = mainPanel:Add("Panel")
		topBar:Dock(TOP)
		topBar:SetHeight(scrh * 0.05)
		topBar.Paint = function(self, width, height)
			surface.SetDrawColor(0, 0, 0, 130)
			surface.DrawRect(0, 0, width, height)
		end

		local label = topBar:Add("DLabel")
		label:Dock(FILL)
		label:Center()
		label:SetContentAlignment(5)
		label:SetFont("ixMenuButtonFontSmall")
		label:SetHeight(scrh * 0.05)
		label:SetText("Person in front of you is asking you about recognizing you")

		local buttons = mainPanel:Add("Panel")
		buttons.Paint = nil
		buttons:Dock(BOTTOM)
		buttons:DockMargin(scrh * 0.13, 0, 0, scrh * 0.02)
		buttons:SetHeight(scrh * 0.05)

		local allowPerm = buttons:Add("DButton")
		allowPerm:SetText("PERM")
		allowPerm:Dock(LEFT)
		allowPerm:SetWide(scrh * 0.1)
		allowPerm:SetFont("ixGenericFont")
		allowPerm:SetColor(ix.config.Get("color", Color(255, 255, 255)))
		allowPerm.DoClick = function()
			net.Start("ixRecognizeMenuAnswer")
				net.WriteEntity(ent)
				net.WriteUInt(0, 2)
			net.SendToServer()
			mainPanel:Remove()
			mainContainer:Remove()
		end

		local allowPerm = buttons:Add("DButton")
		allowPerm:SetText("TEMP")
		allowPerm:Dock(LEFT)
		allowPerm:DockMargin(scrh * 0.01, 0, 0, 0)
		allowPerm:SetWide(scrh * 0.1)
		allowPerm:SetFont("ixGenericFont")
		allowPerm:SetColor(ix.config.Get("color", Color(255, 255, 255)))
		allowPerm.DoClick = function()
			net.Start("ixRecognizeMenuAnswer")
				net.WriteEntity(ent)
				net.WriteUInt(1, 2)
			net.SendToServer()
			mainPanel:Remove()
			mainContainer:Remove()
		end

		local allowPerm = buttons:Add("DButton")
		allowPerm:SetText("DENY")
		allowPerm:Dock(LEFT)
		allowPerm:DockMargin(scrh * 0.01, 0, 0, 0)
		allowPerm:SetWide(scrh * 0.1)
		allowPerm:SetFont("ixGenericFont")
		allowPerm:SetColor(ix.config.Get("color", Color(255, 255, 255)))
		allowPerm.DoClick = function()
			mainPanel:Remove()
			mainContainer:Remove()
		end
	end)

	net.Receive("ixRecognizeDone", function(length)
		hook.Run("CharacterRecognized")
	end)

	function PLUGIN:CharacterRecognized(client, recogCharID)
		surface.PlaySound("buttons/button17.wav")
	end
else
	util.AddNetworkString("ixRecognize")
	util.AddNetworkString("ixRecognizeTemp")
	util.AddNetworkString("ixRecognizeTempHour")
	util.AddNetworkString("ixRecognizeMenu")
	util.AddNetworkString("ixRecognizeMenuAsk")
	util.AddNetworkString("ixRecognizeMenuAnswer")
	util.AddNetworkString("ixRecognizeDone")

	function PLUGIN:ShowSpare1(client)
		if (client:GetCharacter()) then
			net.Start("ixRecognizeMenu")
			net.Send(client)
		end
	end

	net.Receive("ixRecognize", function(length, client)
		local level = net.ReadUInt(2)

		if (isnumber(level)) then
			client:Recognize(level)
		end
	end)

	net.Receive("ixRecognizeMenuAnswer", function(length, client)
		local ent = net.ReadEntity()
		local level = net.ReadUInt(2)

		local char = ent:GetCharacter()

		local char2 = client:GetCharacter():GetID()

		if not char then return end

		if level == 1 then
			char:RecognizeTemp(char2)
		elseif level == 0 then
			char:Recognize(char2)
		end

	end)


	net.Receive("ixRecognizeTemp", function(length, client)
		local level = net.ReadUInt(2)

		if (isnumber(level)) then
			client:RecognizeTemp(level)
		end
	end)

	net.Receive("ixRecognizeTempHour", function(length, client)
		local char = client:GetCharacter()
		if not char then return end

		local tempRecog = char:GetData("temprgn", "")

		if tempRecog != "" then
			for k, v in pairs(tempRecog) do
				tempRecog[k] = v - 1

				if v == 0 then
					v = nil
				end
			end

			char:SetData("temprgn", tempRecog)
		end
	end)
end