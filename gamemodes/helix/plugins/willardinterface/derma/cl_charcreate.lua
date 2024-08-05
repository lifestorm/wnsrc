--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


DEFINE_BASECLASS("ixCharMenuPanel")
local PANEL = {}
local margin = SScaleMin(20 / 3)
local hMargin = margin * 0.5
local factionImageW = SScaleMin(300 / 3)
local backHeight = SScaleMin(30 / 3)
local padding = SScaleMin(10 / 3)

function PANEL:CreateCharacterCreation()
	self.characterPanel = self:AddSubpanel("character")
	self.characterPanel:SetTitle("")
	self.characterPanel:SetSize(self:GetSize())
	self.characterPanel.avoidPadding = true

	self.panelCreation = self.characterPanel:Add("Panel")
	self.panelCreation:SetSize(SScaleMin(1500 / 3), ScrH())
	self.panelCreation:Center()

	self:CreateCharacterModel()
	self:CreateCreationInner()
end

function PANEL:GetClothing()
	self.clothingList = {}
	self.ccaClothingList = {}

	for _, v in pairs(ix.item.list) do
		if v.base != "base_bgclothes" then continue end
		if !v.bodyGroups then continue end
		if !v.adminCreation and !v.charCreation then continue end
		if !v.outfitCategory then continue end

		local proxy = v.proxy or {}
		if v.outfitCategory == "Torso" and !proxy.TorsoColor then
			proxy = {TorsoColor = Vector(255 / 255, 255 / 255, 255 / 255)}
		end

		if v.outfitCategory == "Legs" and !proxy.PantsColor then
			proxy = {PantsColor = Vector(255 / 255, 255 / 255, 255 / 255)}
		end

		if v.outfitCategory == "Shoes" and !proxy.ShoesColor then
			proxy = {ShoesColor = Vector(255 / 255, 255 / 255, 255 / 255)}
		end

		if v.adminCreation then
			self.ccaClothingList[v.name] = {
				outfitCategory = v.outfitCategory,
				bg = v.bodyGroups[table.GetKeys(v.bodyGroups)[1]],
				color = proxy,
				uniqueID = v.uniqueID
			}

			continue
		end

		if v.charCreation then
			self.clothingList[v.name] = {
				outfitCategory = v.outfitCategory,
				bg = v.bodyGroups[table.GetKeys(v.bodyGroups)[1]],
				color = proxy,
				uniqueID = v.uniqueID
			}
		end
	end

	return self.clothingList, self.ccaClothingList
end

function PANEL:CreateCreationInner()
	self.clothingList, self.ccaClothingList = self:GetClothing()

	local innerContent = self.panelCreation:Add("Panel")

	self.rightCreation = innerContent:Add("Panel")
	self.rightCreation:Dock(RIGHT)
	self.rightCreation:SetSize(SScaleMin(460 / 3), self.panelCreation:GetTall())
	self.rightCreation:DockMargin(margin, 0, 0, 0)

	self.leftCreation = innerContent:Add("Panel")
	self.leftCreation:Dock(RIGHT)
	self.leftCreation:SetSize(SScaleMin(160 / 3), self.panelCreation:GetTall())

	innerContent:SetSize(self.rightCreation:GetWide() + self.leftCreation:GetWide() + margin, self.panelCreation:GetTall())
	innerContent:Center()

	local x, _ = innerContent:GetPos()
	innerContent:SetPos(x, ScrH() * 0.5 - SScaleMin(743 / 3) * 0.5 + (SScaleMin(150 / 3) * 0.2))

	self.characterModelList:MoveLeftOf(innerContent)

	self:CreateCreationTitles()

	-- Create Left Menu Buttons
	self:CreateCharacterButton()
	self:CreateAppearancesButton()
	self:CreateHairButton()
	self:CreateFaceButton()
	if (ix.special) then
		self:CreateAttributesButton()
	end
	if (ix.skill) then
		self:CreateSkillsButton()
	end
	self:CreateBackgroundButton()
end

function PANEL:Init()
	self.mainButtonList = {}
	self.parent = self:GetParent()
	self.WhitelistCount = self:GetWhitelistFactions()
	self.randomClickSounds = {
		"willardnetworks/charactercreation/boop1.wav",
		"willardnetworks/charactercreation/boop2.wav",
		"willardnetworks/charactercreation/boop3.wav"
	}

	self:ResetPanel()
	self:CreateFactionSelect()
	self:CreateCharacterCreation()
	self:CreateBlackBars()

	-- creation progress panel
	self.progress = self:Add("ixSegmentedProgress")
	self.progress:SetBarColor(ix.config.Get("color"))
	self.progress:SetSize(self.parent:GetWide(), 0)
	self.progress:SetVisible(false)
	self.progress:SizeToContents()
	self.progress:SetPos(0, self.parent:GetTall() - self.progress:GetTall())

	-- setup payload hooks
	self:AddPayloadHook("model", function(value)
		local faction = ix.faction.indices[self.payload.faction]

		if (faction) then
			local model
			if self.payload.gender == "male" and faction:GetModelsMale(LocalPlayer()) then
				model = faction:GetModelsMale(LocalPlayer())[value]
			elseif self.payload.gender == "female" and faction:GetModelsFemale(LocalPlayer()) then
				model = faction:GetModelsFemale(LocalPlayer())[value]
			else
				model = faction:GetModels(LocalPlayer())[value]
			end

			-- assuming bodygroups
			if (istable(model)) then
				self.characterModel:SetModel(model[1], model[2] or 0, model[3])
			else
				self.characterModel:SetModel(model or faction:GetModelsFemale(LocalPlayer())[1])
			end

			if self.characterModel:GetModel():find("models/willardnetworks/citizens/") then
				if faction.index == FACTION_CP then
					model = self.characterModel:GetModel()
					if model then
						model = string.Replace(model, "models/willardnetworks/citizens/", "models/wn7new/metropolice/")
						if self.payload.gender == "male" then
							model = string.Replace(model, "male", "male_")
						end

						self.characterModel:SetModel(model)
					end
				end
			end
		end
	end)

	-- setup character creation hooks
	net.Receive("ixCharacterAuthed", function()
		timer.Remove("ixCharacterCreateTimeout")
		if (IsValid(self)) then
			self.awaitingResponse = false
		end

		local id = net.ReadUInt(32)
		local indices = net.ReadUInt(6)
		local charList = {}

		for _ = 1, indices do
			charList[#charList + 1] = net.ReadUInt(32)
		end

		ix.characters = charList

		if (IsValid(self)) then
			self:SlideDown()
		end

		ix.panelCreationActive = false
		ix.gui.mapsceneActive = nil

		if (!IsValid(self) or !IsValid(self.parent)) then
			return
		end

		if (id) then
			self.bMenuShouldClose = true

			net.Start("ixCharacterChoose")
				net.WriteUInt(id, 32)
			net.SendToServer()
		else
			self:SlideDown()
		end
	end)

	net.Receive("ixCharacterAuthFailed", function()
		timer.Remove("ixCharacterCreateTimeout")
		self.awaitingResponse = false

		local fault = net.ReadString()
		local args = net.ReadTable()

		self:SlideDown()

		self.parent.mainPanel:Undim()
		self.parent:ShowNotice(3, L(fault, unpack(args)))
	end)
end

function PANEL:SendPayload()
	if (self.awaitingResponse or !self:VerifyProgression()) then
		return
	end

	self.awaitingResponse = true

	timer.Create("ixCharacterCreateTimeout", 10, 1, function()
		if (IsValid(self) and self.awaitingResponse) then
			self.awaitingResponse = false
			self:SlideDown()

			self.parent.mainPanel:Undim()
			self.parent:ShowNotice(3, L("unknownError"))
		end
	end)

	if self.payload.Prepare then
		self.payload:Prepare()
	end

	net.Start("ixCharacterCreate")
	net.WriteUInt(table.Count(self.payload), 8)

	for k, v in pairs(self.payload) do
		net.WriteString(k)
		net.WriteType(v)
	end

	net.SendToServer()
end

function PANEL:GetMaxAttributePoints(bSkill)
	if bSkill then return 10 end
	return hook.Run("GetDefaultAttributePoints", LocalPlayer(), self.payload) or ix.config.Get("maxAttributes", 30)
end

function PANEL:OnSlideUp()
	self:ResetPayload()
	self:Populate()
	self.progress:SetProgress(1)

	-- the faction subpanel will skip to next subpanel if there is only one faction to choose from,
	-- so we don't have to worry about it here
	self:SetActiveSubpanel("faction", 0)
end

function PANEL:OnSlideDown()
end

function PANEL:ResetPayload(bWithHooks)
	if (bWithHooks) then
		self.hooks = {}
	end

	self.payload = {}

	-- TODO: eh..
	function self.payload.Set(payload, key, value)
		self:SetPayload(key, value)
	end

	function self.payload.AddHook(payload, key, callback)
		self:AddPayloadHook(key, callback)
	end

	function self.payload.Prepare(payload)
		self.payload.Set = nil
		self.payload.AddHook = nil
		self.payload.Prepare = nil
	end
end

function PANEL:SetPayload(key, value)
	self.payload[key] = value
	self:RunPayloadHook(key, value)
end

function PANEL:AddPayloadHook(key, callback)
	if (!self.hooks[key]) then
		self.hooks[key] = {}
	end

	self.hooks[key][#self.hooks[key] + 1] = callback
end

function PANEL:RunPayloadHook(key, value)
	local hooks = self.hooks[key] or {}

	for _, v in ipairs(hooks) do
		v(value)
	end
end

function PANEL:AttachCleanup(panel)
	self.repopulatePanels[#self.repopulatePanels + 1] = panel
end

function PANEL:Populate()

	-- remove panels created for character vars
	for i = 1, #self.repopulatePanels do
		self.repopulatePanels[i]:Remove()
	end

	self.repopulatePanels = {}

	-- payload is empty because we attempted to send it - for whatever reason we're back here again so we need to repopulate
	if (!self.payload.faction) then
		self.payload.faction = FACTION_CITIZEN
	end


	if (!self.bInitialPopulate) then
		-- setup progress bar segments
		if self.WhitelistCount > 1 then
			self.progress:AddSegment("@faction")
		end

		self.progress:AddSegment("character")

		self.progress:SetVisible(false)
	end

	self.bInitialPopulate = true
end

function PANEL:VerifyProgression(name)
	for k, v in SortedPairsByMemberValue(ix.char.vars, "index") do
		if (name ~= nil and (v.category or "character") != name) then
			continue
		end

		local value = self.payload[k]

		if (!v.bNoDisplay or v.OnValidate) then
			if (v.OnValidate) then
				local result = {v:OnValidate(value, self.payload, LocalPlayer())}

				if (result[1] == false) then
					self:GetParent():ShowNotice(3, L(unpack(result, 2)))
					return false
				end
			end

			self.payload[k] = value
		end
	end

	return true
end

-- Faction Stuff
function PANEL:CreateFactionSelect()
	self.factionPanel = self:AddSubpanel("faction", true)
	self.factionPanel:SetTitle("")
	self.factionPanel:SetSize(self.parent:GetSize())
	self.factionPanel.avoidPadding = true

	self.panelFaction = self.factionPanel:Add("Panel")
	self:CreateFactionTitles()
	self:CreateFactionsInner()
end

function PANEL:CreateFactionTitles()
	self.titleLabel = self.panelFaction:Add("DLabel")
	self.titleLabel:SetTextColor(color_white)
	self.titleLabel:SetFont("MainMenuNewTitleFont")
	self.titleLabel:SetText(string.utf8upper("Factions"))
	self.titleLabel:SizeToContents()
	self.titleLabel:SetContentAlignment(5)
	self.titleLabel:Dock(TOP)
	self.titleLabel:DockMargin(0, 0, 0, SScaleMin(50 / 3))
end

function PANEL:CreateFactionsInner()
	local listHeight = SScaleMin(500 / 3)
	local textSize = SScaleMin(70 / 3)
	local listAndText = listHeight + textSize
	local prevNextW, prevNextH = SScaleMin(32 / 3), SScaleMin(32 / 3)
	local panelHeight = self.titleLabel:GetTall() + SScaleMin(50 / 3) + (SScaleMin(20 / 3) * 2) + listAndText + backHeight + margin

	local panelLoadWBelowEqual4 = self.WhitelistCount * (factionImageW + margin)
	local panelLoad4 = 4 * (factionImageW + margin)

	if panelLoadWBelowEqual4 < self.titleLabel:GetWide() then panelLoadWBelowEqual4 = self.titleLabel:GetWide() end
	if panelLoad4 < self.titleLabel:GetWide() then panelLoad4 = self.titleLabel:GetWide() end

	if self.WhitelistCount >= 1 and self.WhitelistCount <= 4 then
		self.panelFaction:SetSize(panelLoadWBelowEqual4, panelHeight)
	elseif self.WhitelistCount > 4 then
		self.panelFaction:SetSize(panelLoad4, panelHeight)
	end

	self.panelFaction:Center()

	local factionListContent = self.panelFaction:Add("Panel")
	factionListContent:SetSize(self.panelFaction:GetWide(), listAndText)
	factionListContent:Dock(TOP)

	self.factionList = factionListContent:Add("Panel")
	self.factionList:SetSize(self.WhitelistCount * (factionImageW + margin), listHeight)

	self.textFaction = factionListContent:Add("Panel")
	self.textFaction:SetSize(self.WhitelistCount * (factionImageW + margin), textSize)
	self.textFaction:SetPos(0, self.factionList:GetTall())

	if self.WhitelistCount > 4 then
		local nextBut = self.factionPanel:Add("DImageButton")
		nextBut:SetSize(prevNextW, prevNextH)
		nextBut:SetImage("willardnetworks/charselect/arrow_right.png")

		nextBut:Center()
		local _, y = nextBut:GetPos()
		nextBut:MoveRightOf(self.panelFaction)
		local x2, _ = nextBut:GetPos()

		nextBut:SetPos(x2 + margin, y)

		nextBut.OnCursorEntered = function()
			surface.PlaySound("helix/ui/rollover.wav")
			nextBut:SetColor( Color( 210, 210, 210, 255 ) )
		end

		nextBut.OnCursorExited = function()
			nextBut:SetColor( color_white )
		end

		nextBut.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")

			local x, y2 = self.factionList:GetPos()
			local x3, y3 = self.textFaction:GetPos()

			local pos1, pos2 = math.Round(math.abs( x )), math.Round(((self.WhitelistCount - 5) * (factionImageW + margin)))

			if pos1 == pos2 or math.abs(pos1 - pos2) <= factionImageW - 10 then
				nextBut:SetVisible(false)
			end

			self.factionList:MoveTo( x - (factionImageW + margin), y2, 0.1, 0, 1 )
			self.textFaction:MoveTo( x3 - (factionImageW + margin), y3, 0.1, 0, 1 )

			if IsValid(self.prevBut) then
				return
			else
				self.prevBut = self.factionPanel:Add("DImageButton")


				self.prevBut:SetSize(prevNextW, prevNextH)
				self.prevBut:SetImage("willardnetworks/charselect/arrow_left.png")

				self.prevBut:Center()
				_, y = self.prevBut:GetPos()
				self.prevBut:MoveLeftOf(self.panelFaction)
				x2, y2 = self.prevBut:GetPos()

				self.prevBut:SetPos(x2 - margin, y)

				self.prevBut.OnCursorEntered = function()
					surface.PlaySound("helix/ui/rollover.wav")
					self.prevBut:SetColor( Color( 210, 210, 210, 255 ) )
				end

				self.prevBut.OnCursorExited = function()
					self.prevBut:SetColor( color_white )
				end

				self.prevBut.DoClick = function()
					surface.PlaySound("helix/ui/press.wav")

					x, y = self.factionList:GetPos()
					x2, y2 = self.textFaction:GetPos()

					if IsValid(nextBut) then
						nextBut:SetVisible(true)
					end

					self.factionList:MoveTo( x + (factionImageW + margin), y, 0.1, 0, 1 )
					self.textFaction:MoveTo( x2 + (factionImageW + margin), y2, 0.1, 0, 1 )

					if IsValid(self.prevBut) then
						pos1, pos2 = math.Round(x, 0), math.Round((0 - (factionImageW + margin)), 0)
						if pos1 == pos2 or math.abs(pos1 - pos2) <= factionImageW - 10 then
							self.prevBut:Remove()
						end
					end
				end
			end
		end
	end

	self:CreateActualFactions()
end

function PANEL:CreateActualFactions()
	for _, v in SortedPairs(ix.faction.teams) do
		if (ix.faction.HasWhitelist(v.index)) then
			local factionImage = v.factionImage
			local button = self.factionList:Add("DImageButton")
			button:SetImage(factionImage or "scripted/breen_fakemonitor_1")
			button:Dock(LEFT)
			button:DockMargin(hMargin, 0, hMargin, 0)
			button:SetSize( factionImageW, self.factionList:GetTall() )
			button.faction = v.index

			button.PaintOver = function(_, w, h)
				surface.SetDrawColor(Color(73, 82, 87, 255))
				surface.DrawOutlinedRect(0, 0, w, h)
			end

			button.Paint = function ( _, w, h )
				surface.SetDrawColor(Color(255, 255, 255, 0))

				if button:IsHovered() then
					button:SetColor( Color( 210, 210, 210, 255 ) )
				else
					button:SetColor( color_white )
				end
			end

			button.DoClick = function(panel)
				surface.PlaySound("helix/ui/press.wav")

				self:SetStandardFactionInfo(panel)
				self.progress:IncrementProgress()
				self:Populate()
				self:SetActiveSubpanel("character")
				self:CheckIfFinished()
				self:FadeInBars()

				self.characterButton.DoClick()

				ix.panelCreationActive = true
				ix.gui.mapsceneActive = self.faction.name
			end

			button.OnCursorEntered = function()
				surface.PlaySound("helix/ui/rollover.wav")
			end
		end
	end

	for _, v in SortedPairs(ix.faction.teams) do
		if (ix.faction.HasWhitelist(v.index)) then
			local insidePanel = self.textFaction:Add("Panel")
			insidePanel:Dock(LEFT)
			insidePanel:SetSize(factionImageW, self.textFaction:GetTall())
			insidePanel:DockMargin(hMargin, 0, hMargin, 0)

			local text = insidePanel:Add("DLabel")
			text:SetFont("TitlesFontNoBoldNoClamp")
			text:SetText(string.utf8upper(v.name))
			text:SizeToContents()
			text:Center()
		end
	end

	self:CreateFactionBack()
end

function PANEL:CreateFactionBack()
	local parent = self:GetParent()

	self.aFontColor = parent.mainPanel.aFontColor or Color(196, 196, 196, 255)
	self.aFontHoverColor = parent.mainPanel.aFontHoverColor or Color(255, 255, 255, 255)
	self.aFontLockedButtonColor = parent.mainPanel.aFontLockedButtonColor or Color(90, 90, 90, 255)

	local backPanel = self.panelFaction:Add("Panel")
	backPanel:Dock(TOP)
	backPanel:DockMargin(0, SScaleMin(20 / 3) * 2, 0, 0)
	backPanel:SetSize(self.panelFaction:GetWide(), SScaleMin(30 / 3))

	self.factionBack = backPanel:Add("DButton")
	self.factionBack:SetText(string.utf8upper("Back"))
	self.factionBack:SetContentAlignment(6)
	self.factionBack:SetSize(SScaleMin(90 / 3), SScaleMin(30 / 3))
	self.factionBack:SetTextColor(self.aFontColor)
	self.factionBack:SetFont("MainMenuNewButtonFont")
	self.factionBack:SetTextInset(SScaleMin(10 / 3), 0)
	self.factionBack:Center()

	self.factionBack.Paint = function( this, w, h )
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/mainmenu/back_arrow.png"))
		surface.DrawTexturedRect(SScaleMin(10 / 3), (SScaleMin(30 / 3) * 0.5) - (margin * 0.5), margin, margin)
	end

	self.factionBack.OnCursorEntered = function()
		surface.PlaySound("helix/ui/rollover.wav")
		self.factionBack:SetTextColor(self.aFontHoverColor)
	end

	self.factionBack.OnCursorExited = function()
		self.factionBack:SetTextColor(self.aFontColor)
	end

	self.factionBack.DoClick = function()
		self.progress:DecrementProgress()

		self:SetActiveSubpanel("faction", 0)
		self:SlideDown()

		self.parent.mainPanel:Undim()
	end
end

-- Creation functions
function PANEL:CreateBlackBar(parent, bDockTop)
	parent:SetType( "Rect" )
	parent:SetColor( Color(0, 0, 0, 0) )
	parent:Dock(bDockTop and TOP or BOTTOM)
	parent:SetSize( ScrW(), math.Clamp(VScale(75 / 3), 0, 75) )
end

function PANEL:CreateBlackBars()
	ix.gui.blackBarTop = self.characterPanel:Add("DShape")
	self:CreateBlackBar(ix.gui.blackBarTop, true)

	ix.gui.blackBarBottom = self.characterPanel:Add("DShape")
	self:CreateBlackBar(ix.gui.blackBarBottom)
end

-- Character creation stuff
-- A function to create the background button in the main menu
function PANEL:CreateBackgroundButton()
	self.backgroundButton = self.leftCreation:Add("DButton")
	self:CreateMainButton(self.backgroundButton, "background")
	self.backgroundButton.DoClick = function()
		self:ResetModelCam()

		self:ClearSelectedMainButtons()
		self:SetButtonSelected(self.backgroundButton, "background", true)
		surface.PlaySound(table.Random(self.randomClickSounds))

		self:CreateRightMenuTextPanel("background selection", 60)

		self.backgroundButtonList = {}

		if !table.IsEmpty(self.backgroundButtonList) then
			table.Empty(self.backgroundButtonList)
		end

		if self.faction:GetNoBackground(LocalPlayer()) != true then
			if self.faction.name == "Citizen" then
				self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/relocatedcitizen.png", 45, 61, "Relocated Citizen", "You have just arrived in this new, unfamiliar city. No family, no contacts, just another nobody getting off the train to start a new life.", -5, "Good for new players")
				self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/local.png", 34, 61, "Local Citizen", "You have lived here quite a while, perhaps even since before the occupation. Somehow you got lucky and were never relocated. By now you know the City inside-out.", 0)
				self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/supporter.png", 53, 68, "Supporter Citizen", "For one reason or another, you have accepted the Union's authority, follow their rules and try to live up to their expectations. Some citizens may not take kindly to your collaboration.", 0)
				self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/outcast.png", 55, 55, "Outcast", "Always on the move, always in hiding. Avoiding the eye of the Combine. You live off your own means in the slums, for the better or for the worse.", 5)
			elseif self.faction.name == "Vortigaunt" then
				self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/supporter.png", 53, 68, "Biotic", "Enslaved, freed, and enslaved once again. With a collar on your neck, and the boot of the Combine upon you, you must endure the torture. You, and thousands of others.", 13, "Choose this unless you have permission to use the other backgrounds.")
				self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/local.png", 34, 61, "Liberated", "Once enslaved, free again. You have lived under the boot of the Combine, but no longer. Be wary, for the Combine have tasted your blood before, and will not show leniency should they find you again...", 13, "Hard difficulty - Do not use this unless you have permission.")
				self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/outcast.png", 55, 55, "Free", "You have been one of the lucky few vortigaunts to have never been captured by the Combine. The last chain around your neck was that of the Nihilanth. The Combine does not know you exist.", 15, "Do not use this unless you have permission.", nil, true)
				self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/supporter.png", 53, 68, "Collaborator", "A traitor to Vortkind who permitted itself the luxuries that the Combine have deceitfully offered, thus you have taken up the status of Collaborator.", 13, "Do not use this unless you have permission. This background starts with a CID and 50 Cohesion Points along with a nice pair of pants and no shackles", nil, true)
			elseif self.faction.name == "Civil Workers Union" then
				self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/relocatedcitizen.png", 45, 61, "Worker", "You are a worker for the Civil Workers Union under the Combine occupation. You spend your time cleaning infestation or repairing infrastructure.", -8)
				self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/local.png", 34, 61, "Medic", "You are a medic for Civil Medical Union. Your job is to heal the populace, or if you get lucky, operate on both Vortiguants and Civil Protection. Do your duty.", -10)
			end
		else
			local backgroundPanel = self.rightCreation:Add("Panel")
			backgroundPanel:Dock(TOP)
			backgroundPanel:DockMargin(0, 0 - SScaleMin(1 / 3), 0, 0)
			backgroundPanel:SetTall(SScaleMin(140 / 3))
			backgroundPanel.Paint = function(_, w, h)
				surface.SetDrawColor(Color(0, 0, 0, 100))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
				surface.DrawOutlinedRect(0, 0, w, h)
			end

			local noBackground = backgroundPanel:Add("DLabel")
			noBackground:Dock(FILL)
			noBackground:SetFont("MenuFontNoClamp")
			noBackground:SetText("No Background Selection Available for this faction")
			noBackground:SetContentAlignment(5)
		end

		self:CreateFinishPanel(self.skillsButton, false)
	end
end

-- A function to create a single attribute in the attribute panel
function PANEL:CreateAttribute(icon, wIcon, hIcon, title, desc, attribute, bSkill, minorBoost, majorBoost)
	local attributePanelH = SScaleMin(105 / 3)
	local skillDivider = 1.5
	hIcon = (bSkill and hIcon / skillDivider) or hIcon
	wIcon = (bSkill and wIcon / skillDivider) or wIcon

	local attributePanel = self.rightCreation:Add("Panel")
	attributePanel:Dock(TOP)
	attributePanel:DockMargin(0, 0 - SScaleMin(1 / 3), 0, 0)
	attributePanel:SetTall(bSkill and attributePanelH / skillDivider or attributePanelH)
	attributePanel.Paint = function(_, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(color_white)
		surface.SetMaterial(Material(icon))
		surface.DrawTexturedRect(SScaleMin(90 / 3) * 0.5 - SScaleMin(wIcon / 3) * 0.5, attributePanel:GetTall() * 0.5 - SScaleMin(hIcon / 3) * 0.5, SScaleMin(wIcon / 3), SScaleMin(hIcon / 3))
	end

	local textPanel = attributePanel:Add("Panel")
	textPanel:SetSize(self.rightCreation:GetWide() - (SScaleMin(50 / 3) + SScaleMin(wIcon / 3)) - (SScaleMin(15 / 3) + SScaleMin(50 / 3)), attributePanel:GetTall())
	textPanel:SetPos(SScaleMin(90 / 3), 0)

	local minorAttBoostSkill
	local majorAttBoostSkill
	local attBoostSum = false
	if bSkill then
		minorAttBoostSkill = (minorBoost.skills[attribute] * self.payload.special[minorBoost.uniqueID])
		majorAttBoostSkill = (majorBoost.skills[attribute] * self.payload.special[majorBoost.uniqueID])
		attBoostSum = minorAttBoostSkill + majorAttBoostSkill
	end

	local titleTextPanel = textPanel:Add("Panel")
	titleTextPanel:Dock(TOP)

	local titleText = titleTextPanel:Add("DLabel")
	titleText:SetText(string.utf8upper(title))
	titleText:SetFont("LargerTitlesFontNoClamp")
	titleText:SizeToContents()
	titleText:Dock(LEFT)
	titleText:SetTextColor(Color(255, 204, 0, 255))

	if (bSkill) then
		local boostedLevels = titleTextPanel:Add("DLabel")
		boostedLevels:Dock(FILL)
		boostedLevels:SetContentAlignment(4)
		boostedLevels:SetFont("MenuFontLargerBoldNoFix")
		boostedLevels:SetTextColor(Color(75, 238, 75))
		boostedLevels:SetText("Attribute Levels: +"..attBoostSum)
		boostedLevels:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
		boostedLevels:SizeToContents()
	end

	titleTextPanel:SetSize(titleText:GetSize())

	local descText = textPanel:Add("DLabel")
	descText:SetText(desc)
	descText:SetFont("SmallerTitleFontNoBoldNoClamp")
	descText:SetWrap(true)
	descText:SetAutoStretchVertical(true)
	descText:Dock(TOP)

	textPanel.Paint = function(this, w, h)
		this:SetSize(this:GetWide(), titleText:GetTall() + descText:GetTall())
		this:Center()
		local _, y = this:GetPos()
		this:SetPos(SScaleMin(90 / 3), y - SScaleMin(2 / 3))
	end

	local attributePointsPanel = attributePanel:Add("Panel")
	attributePointsPanel:Dock(RIGHT)
	attributePointsPanel:DockMargin(0, 0, SScaleMin(25 / 3), 0)
	attributePointsPanel:SetSize(SScaleMin(30 / 3), attributePanel:GetTall())

	local upArrow = attributePointsPanel:Add("DImageButton")
	upArrow:Dock(TOP)
	upArrow:SetTall(SScaleMin(9 / 3))
	upArrow:SetImage("willardnetworks/mainmenu/charcreation/uparrow.png")

	local attributePoint = attributePointsPanel:Add("DLabel")
	attributePoint:SetFont("LargerTitlesFontNoClamp")
	attributePoint:Dock(TOP)
	attributePoint:SetText(bSkill and (self.payload.skill[attribute] or "0") or (self.payload.special[attribute] or "0"))
	attributePoint:SetContentAlignment(5)
	attributePoint:SizeToContents()

	local diff = (-SScaleMin(15 / 3) + attributePointsPanel:GetWide()) / 2
	local downArrow = attributePointsPanel:Add("DImageButton")
	downArrow:Dock(TOP)
	downArrow:DockMargin(diff, SScaleMin(5 / 3), diff, 0)
	downArrow:SetTall(SScaleMin(9 / 3))
	downArrow:SetImage("willardnetworks/mainmenu/charcreation/downarrow.png")

	upArrow:DockMargin(diff, attributePointsPanel:GetTall() * 0.5 - upArrow:GetTall() * 0.5 - attributePoint:GetTall() * 0.5 - downArrow:GetTall() * 0.5 - SScaleMin(5 / 3), diff, SScaleMin(5 / 3))

	downArrow.OnCursorEntered = function()
		surface.PlaySound("helix/ui/rollover.wav")
	end

	downArrow.DoClick = function()
		if tonumber(attributePoint:GetText()) == 0 then
			return
		end

		surface.PlaySound("helix/ui/press.wav")
		attributePoint:SetText(tostring(tonumber(attributePoint:GetText()) - 1))
		self:AttributesRefresh(attribute, tonumber(attributePoint:GetText()), bSkill)
	end

	upArrow.OnCursorEntered = function()
		surface.PlaySound("helix/ui/rollover.wav")
	end

	upArrow.DoClick = function()
		if (bSkill and tonumber(attributePoint:GetText()) == 10) or (!bSkill and tonumber(attributePoint:GetText()) == 5) then
			return
		end

		if self:GetPointsLeft(bSkill) <= 0 then
			return
		end

		surface.PlaySound("helix/ui/press.wav")
		attributePoint:SetText(tostring(tonumber(attributePoint:GetText()) + 1))
		self:AttributesRefresh(attribute, tonumber(attributePoint:GetText()), bSkill)
	end
end

-- A function to create the attributes button in the main menu
function PANEL:CreateAttributesButton()
	self.attributesButton = self.leftCreation:Add("DButton")
	self:CreateMainButton(self.attributesButton, "attributes")
	self.attributesButton.DoClick = function()
		self:ResetModelCam()
		self:ClearSelectedMainButtons()

		self:SetButtonSelected(self.attributesButton, "attributes", true)
		surface.PlaySound(table.Random(self.randomClickSounds))

		local textPanel = self.rightCreation:Add("Panel")
		textPanel:Dock(TOP)
		textPanel:SetTall(SScaleMin(20 / 3))
		textPanel:DockMargin(0, SScaleMin(55 / 3), 0, padding)

		local panelText = textPanel:Add("DLabel")
		panelText:SetText(string.utf8upper("attribute selection"))
		panelText:SetFont("MenuFontNoClamp")
		panelText:SizeToContents()
		panelText:Dock(LEFT)
		panelText:SetContentAlignment(4)

		if self.faction.noAttributes then
			local noAttributes = self.rightCreation:Add("Panel")
			noAttributes:Dock(TOP)
			noAttributes:DockMargin(0, 0 - SScaleMin(1 / 3), 0, 0)
			noAttributes:SetTall(SScaleMin(140 / 3))
			noAttributes.Paint = function(_, w, h)
				surface.SetDrawColor(Color(0, 0, 0, 100))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
				surface.DrawOutlinedRect(0, 0, w, h)
			end

			local noAttributesAvailable = noAttributes:Add("DLabel")
			noAttributesAvailable:Dock(FILL)
			noAttributesAvailable:SetFont("MenuFontNoClamp")
			noAttributesAvailable:SetText("No Attribute Selection Available for this faction")
			noAttributesAvailable:SetContentAlignment(5)
		else
			self.attributesRemaining = textPanel:Add("DLabel")
			self.attributesRemaining:SetFont("TitlesFontNoClamp")
			self.attributesRemaining:DockMargin(0, 0, 0, SScaleMin(3 / 3))
			self.attributesRemaining:Dock(RIGHT)
			self.attributesRemaining:SetContentAlignment(6)
			self.attributesRemaining:SetText(self:GetPointsLeft()..string.utf8upper(" point(s) remaining"))
			self.attributesRemaining:SizeToContents()

			self:CreateAttribute("willardnetworks/mainmenu/charcreation/strength.png", 45, 61, "strength", "Major boost to guns \nMinor boost to speed & crafting", "strength")
			self:CreateAttribute("willardnetworks/mainmenu/charcreation/perception.png", 45, 30, "perception", "Major boost to cooking \nMinor boost to smuggling & guns", "perception")
			self:CreateAttribute("willardnetworks/mainmenu/charcreation/agility.png", 38, 47, "agility", "Major boost to smuggling & speed \nMinor boost to medicine", "agility")
			self:CreateAttribute("willardnetworks/mainmenu/charcreation/intelligence.png", 48, 29, "intelligence", "Major boost to medicine & crafting \nMinor boost to cooking", "intelligence")

			self:CreateRightMenuYellowTextPanel("Attributes stay permanent and can only be temporarily buffed with items", 5)
		end

		self:CreateFinishPanel(self.faceButton, self.skillsButton)
	end
end

-- A function to create the attributes button in the main menu
function PANEL:CreateSkillsButton()
	self.skillsButton = self.leftCreation:Add("DButton")
	self:CreateMainButton(self.skillsButton, "skills")
	self.skillsButton.DoClick = function()
		self:ResetModelCam()
		self:ClearSelectedMainButtons()

		self:SetButtonSelected(self.skillsButton, "skills", true)
		surface.PlaySound(table.Random(self.randomClickSounds))

		local textPanel = self.rightCreation:Add("Panel")
		textPanel:Dock(TOP)
		textPanel:SetTall(SScaleMin(20 / 3))
		textPanel:DockMargin(0, SScaleMin(55 / 3), 0, padding)

		local panelText = textPanel:Add("DLabel")
		panelText:SetText(string.utf8upper("skills selection"))
		panelText:SetFont("MenuFontNoClamp")
		panelText:SizeToContents()
		panelText:Dock(LEFT)
		panelText:SetContentAlignment(4)

		self.attributesRemaining = textPanel:Add("DLabel")
		self.attributesRemaining:SetFont("TitlesFontNoClamp")
		self.attributesRemaining:DockMargin(0, 0, 0, SScaleMin(3 / 3))
		self.attributesRemaining:Dock(RIGHT)
		self.attributesRemaining:SetContentAlignment(6)
		self.attributesRemaining:SetText(self:GetPointsLeft(true)..string.utf8upper(" point(s) remaining"))
		self.attributesRemaining:SizeToContents()

		local attributes = ix.special.list or {}

		for skillID, skillInfo in pairs(ix.skill.list) do
			if (skillInfo.name == "Vortessence" and self.faction.name != "Vortigaunt") or skillInfo.name == "Bartering" then
				continue
			end

			local skillAttributes = {}

			-- Find the attributes that boost the skill
			for _, v in pairs(attributes) do
				if v.skills then
					if v.skills[skillInfo.uniqueID] then
						skillAttributes[v.skills[skillInfo.uniqueID]] = v
					end
				end
			end

			self:CreateAttribute(skillInfo.icon, 60, 60, skillInfo.name, skillInfo.description, skillID, true, skillAttributes[1], skillAttributes[2])
		end

		self:CreateRightMenuYellowTextPanel("Skills have a maximum level of 50", 5)

		self:CreateFinishPanel(self.attributesButton, self.backgroundButton)
	end
end

-- A function to create a title label at the top of the left side menu
function PANEL:CreateCreationTitle(text, topMargin, bottomMargin)
	local leftCreationTitle = self.leftCreation:Add("DLabel")
	leftCreationTitle:SetFont("CharCreationBoldTitleNoClamp")
	leftCreationTitle:SetText(string.utf8upper(text))
	leftCreationTitle:SizeToContents()
	leftCreationTitle:DockMargin(0, topMargin, 0, bottomMargin)
	leftCreationTitle:Dock(TOP)
end

-- A helper function to create the title labels at top of the left side menu
function PANEL:CreateCreationTitles()
	self:CreateCreationTitle("new", 0, 0)
	self:CreateCreationTitle("character", SScaleMin((0 - 5) / 3), padding)
end

-- A function to create a button in the left menu
function PANEL:CreateMainButton(parent, text)
	parent:SetText(string.utf8upper(text))
	parent:SetFont("WNMenuFontNoClamp")
	parent:SetContentAlignment(4)
	parent:SetTextInset(SScaleMin(35 / 3), 0)
	parent:SetTextColor(Color(200, 200, 200, 255))
	parent:Dock(TOP)
	parent:SetSize(self.leftCreation:GetWide(), SScaleMin(36 / 3))
	parent:DockMargin(0, 0, 0, padding)
	parent.name = text

	parent.OnCursorEntered = function()
		surface.PlaySound("willardnetworks/charactercreation/hover.wav")
	end

	parent.Paint = function(this, w, h)
		self:DrawButtonUnselected(text, this, w, h, true)
	end

	table.insert(self.mainButtonList, parent)
end

-- A function to draw the character model left of the creation
function PANEL:CreateCharacterModel()
	self.characterModelList = self.panelCreation:Add("Panel")
	self.characterModelList:SetSize(SScaleMin(400 / 3), ScrH())
	self.characterModelList:Center()

	self.characterModel = self.characterModelList:Add("ixModelPanel")
	self.characterModel:Dock(FILL)
	self.characterModel:SetModel("models/willardnetworks/citizens/female_01.mdl")
	self.characterModel:SetFOV(26)
	self.characterModel.PaintModel = self.characterModel.Paint

	self.originPos = self.characterModel:GetCamPos()
	self.originLookAt = self.characterModel:GetLookAt()
end

-- A function to create a panel for text in the right side panel
function PANEL:CreateRightMenuTextPanel(text, topMargin)
	local textPanel = self.rightCreation:Add("Panel")
	textPanel:Dock(TOP)
	textPanel:SetTall(margin)
	textPanel:DockMargin(0, SScaleMin(topMargin / 3), 0, padding)

	local panelText = textPanel:Add("DLabel")
	panelText:SetText(string.utf8upper(text))
	panelText:SetFont("MenuFontNoClamp")
	panelText:SizeToContents()
	panelText:Dock(LEFT)
	panelText:SetContentAlignment(4)

	return panelText
end

-- A function to create a text entry in the right side panel
function PANEL:CreateRightMenuTextEntry(parent, text, height, boolMultiline, maxChars, name)
	parent:Dock(TOP)
	parent:SetTall(SScaleMin(height / 3))
	parent:DockMargin(0, 0, 0, padding)
	parent:SetMultiline( boolMultiline )
	parent:SetVerticalScrollbarEnabled( boolMultiline )
	parent:SetEnterAllowed( boolMultiline )
	parent:SetTextColor(Color(200, 200, 200, 255))
	parent:SetCursorColor(Color(200, 200, 200, 255))
	parent:SetFont("MenuFontNoClamp")
	parent:SetPlaceholderText(text or "")
	parent:SetPlaceholderColor( Color(200, 200, 200, 255) )
	if name == "name" then
		parent:SetText(self.payload.name or "")
	elseif name == "desc" then
		parent:SetText(self.payload.description or "")
	end

	parent.Paint = function(this, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)

		if ( this.GetPlaceholderText and this.GetPlaceholderColor and this:GetPlaceholderText() and this:GetPlaceholderText():Trim() != "" and this:GetPlaceholderColor() and ( !this:GetText() or this:GetText() == "" ) ) then

			local oldText = this:GetText()

			local str = this:GetPlaceholderText()
			if ( str:StartWith( "#" ) ) then str = str:utf8sub( 2 ) end
			str = language.GetPhrase( str )

			this:SetText( str )
			this:DrawTextEntryText( this:GetPlaceholderColor(), this:GetHighlightColor(), this:GetCursorColor() )
			this:SetText( oldText )

			return
		end

		this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
	end

	parent.MaxChars = maxChars
	parent.OnTextChanged = function(parentSelf)
		if name == "name" then
			self.payload:Set("name", parentSelf:GetValue())
		end

		if name == "desc" then
			self.payload:Set("description", parentSelf:GetValue())
		end

		self:CheckIfFinished()
	end
end

-- A function to create a gender button inside a right side panel
function PANEL:CreateGenderButton(parent, icon, w, h, rightMargin, gender)
	parent:SetSize( SScaleMin(w / 3), SScaleMin(h / 3) )
	parent:SetImage( icon )
	parent:Dock(RIGHT)
	parent:DockMargin(0, 0, SScaleMin(rightMargin / 3), 0)
	parent:SetColor(Color(150, 150, 150, 255))

	if self.payload.gender != "male" and self.payload.gender != "female" then
		self.payload:Set("gender", "female")
	end

	if gender == "male" and self.payload.gender == "male" then
		parent:SetColor(Color(255, 204, 0, 255))
	end

	if gender == "female" and self.payload.gender == "female" then
		parent:SetColor(Color(255, 204, 0, 255))
	end

	parent.OnCursorEntered = function()
		surface.PlaySound("helix/ui/rollover.wav")
	end

	parent.DoClick = function()

		surface.PlaySound("helix/ui/press.wav")
		parent:SetColor(Color(255, 204, 0, 255))

		if gender == "female" then
			if self.genderButtonMale then
				self.genderButtonMale:SetColor(Color(150, 150, 150, 255))
			end

			self.payload:Set("gender", "female")
			self.payload:Set("model", 1)
		else
			if self.genderButtonFemale then
				self.genderButtonFemale:SetColor(Color(150, 150, 150, 255))
			end

			self.payload:Set("gender", "male")
			self.payload:Set("model", 1)
		end

		self:ResetModelCam()

		local eyeColorTable = self:GetActiveSkinEyeColorTable()

		self.characterModel.Entity:SetSkin(eyeColorTable[1] or 0)
		self.payload.data["skin"] = eyeColorTable[1]

		self.payload.data["groups"] = {}
		self.payload.data["glasses"] = false
		self.payload.data["canread"] = true
		self.payload:Set("hair", {hair = 0, color = self.payload.hair.color})

		self.payload.data.groups[self.beardBodygroups] = 0
		self.payload.data.groups[self.hairBodygroups] = 0

		self:CheckIfFinished()
	end
end

-- A function to create a custom DComboBox
function PANEL:CreateSelectionMenu(parent, width, text, selections)
	local faction = ix.faction.indices[self.payload.faction]

	parent:Dock(LEFT)
	parent:SetWide(SScaleMin(width / 3))

	if (self.payload.data[text] != nil and self.payload.data[text] != "") then
		if (string.utf8len(self.payload.data[text]) > 7) and faction.name != "Vortigaunt" then
			parent:SetText(string.utf8sub(self.payload.data[text], 1, 7).."..")
		elseif faction.name == "Vortigaunt" and string.utf8len(self.payload.data[text]) > 20 then
			parent:SetText(string.utf8sub(self.payload.data[text], 1, 20).."..")
		else
			parent:SetText(self.payload.data[text])
		end
	else
		parent:SetText(string.utf8upper(text))
	end
	parent:DockMargin(0, 0, SScaleMin(13 / 3), 0)
	parent:SetFont("MenuFontNoClamp")
	parent:SetTextColor(Color(200, 200, 200, 255))
	parent:SetContentAlignment(4)
	parent:SetTextInset(padding, 0)
	parent.Paint = function(this, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)

		local alpha = (this:IsHovered()) and 255 or 100
		surface.SetDrawColor(ColorAlpha(color_white, alpha))
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/mainmenu/charcreation/combodownarrow.png"))
		surface.DrawTexturedRect(w - SScaleMin(9 / 3) - padding, h * 0.5 - SScaleMin(5 / 3) * 0.5, SScaleMin(9 / 3), SScaleMin(5 / 3))
	end

	local savedText = parent:GetText()

	parent.OnCursorEntered = function()
		surface.PlaySound("helix/ui/rollover.wav")
		savedText = parent:GetText()
		parent:SetText(string.utf8upper(text))
	end

	parent.OnCursorExited = function()
		parent:SetText(string.utf8upper(savedText))
	end

	parent.DoClick = function()
		if text == "eye color" and (self.payload.faction == FACTION_CITIZEN or self.payload.faction == FACTION_ADMIN or self.payload.faction == FACTION_WORKERS or self.payload.faction == FACTION_MEDICAL) then
			if self.characterModel.Entity:LookupBone("ValveBiped.Bip01_Head1") then
				local eyepos = self.characterModel.Entity:GetBonePosition( self.characterModel.Entity:LookupBone("ValveBiped.Bip01_Head1") )
				if eyepos then
					self.characterModel:SetLookAt(eyepos)

					self.characterModel:SetCamPos(eyepos-Vector(-12, -12, 0))	-- Move cam in front of eyes
					self.characterModel:SetFOV(34)
				end
			end
		else
			self:ResetModelCam()
		end

		surface.PlaySound("helix/ui/press.wav")
		if IsValid(self.dropdownMenu) then
			self.dropdownMenu:Remove()
			return
		end

		self.dropdownMenu = self.panelCreation:Add("DScrollPanel")

		if #selections < 8 then
			self.dropdownMenu:SetSize( SScaleMin(width / 3), #selections * (SScaleMin(36 / 3) / 2) - (#selections * 1) )
		else
			self.dropdownMenu:SetSize( SScaleMin(width / 3), (SScaleMin(36 / 3) / 2 ) * 8 - (#selections * 1) )
		end

		self.dropdownMenu:SetPos(self.panelCreation:ScreenToLocal( parent:LocalToScreen( 0, SScaleMin(36 / 3) ) ))

		self.dropdownMenu.Paint = function(_, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 100))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		for _, v in pairs(selections) do
			local selectionButton = self.dropdownMenu:Add("DButton")
			selectionButton:Dock(TOP)
			selectionButton:SetTall( SScaleMin(36 / 3) / 2 )
			selectionButton:SetText(string.utf8upper(v))
			selectionButton:DockMargin(0, 0 - SScaleMin(1 / 3), 0, 0)
			selectionButton:SetContentAlignment(4)
			selectionButton:SetTextInset(padding, 0)
			selectionButton:SetFont("WNBackFontNoClamp")

			if text == "language" then
				local languageText = v != "none" and ix.languages:FindByID(v).name or v
				selectionButton:SetText(string.utf8upper(languageText))
			end

			selectionButton.Paint = function(_, w, h)
				surface.SetDrawColor(Color(0, 0, 0, 100))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
				surface.DrawRect(0, 0, w, h)
			end

			selectionButton.DoClick = function()
				surface.PlaySound("helix/ui/press.wav")

				self.payload.data[text] = selectionButton:GetText() or ""

				if text == "eye color" then
					local eyeColorTable = self:GetActiveSkinEyeColorTable()

					self.characterModel.Entity:SetSkin(eyeColorTable[1] or 0)
					self.payload.data["skin"] = eyeColorTable[1]
				end

				if text == "language" and v != "none" then
					self.payload.data["languages"] = {v}
				end

				if string.utf8len(selectionButton:GetText()) > 7 and faction.name != "Vortigaunt" then
					parent:SetText(string.utf8sub(selectionButton:GetText(), 1, 7).."..")
				elseif faction.name == "Vortigaunt" and string.utf8len(selectionButton:GetText()) > 20 then
					parent:SetText(string.utf8sub(selectionButton:GetText(), 1, 20).."..")
				else
					parent:SetText(selectionButton:GetText())
				end

				if IsValid(self.dropdownMenu) then
					self.dropdownMenu:Remove()
				end

				self:CheckIfFinished()
			end
		end

		self:CheckIfFinished()
	end
end

-- A function to create a important text panel in the right side menu
function PANEL:CreateRightMenuYellowTextPanel(text, topMargin)
	local textPanel = self.rightCreation:Add("Panel")
	textPanel:Dock(TOP)
	textPanel:SetTall(margin)
	textPanel:DockMargin(0, SScaleMin(topMargin / 3), 0, padding)

	local warningIcon = textPanel:Add("DImage")
	warningIcon:SetSize(SScaleMin(12 / 3), margin)
	warningIcon:Dock(LEFT)
	warningIcon:DockMargin(0, 0, SScaleMin(8 / 3), 0)
	warningIcon:SetImage("willardnetworks/mainmenu/charcreation/warning.png")

	local panelText = textPanel:Add("DLabel")
	panelText:SetText(text)
	panelText:SetFont("WNBackFontNoClamp")
	panelText:SizeToContents()
	panelText:SetTextColor(Color(255, 204, 0, 255))
	panelText:Dock(LEFT)
	panelText:SetContentAlignment(4)

	return panelText
end

-- A function to create the text next/back/finish buttons at the bottom of the right side menu
function PANEL:CreateNextBackFinishButtons(parentBack, parentNext, parentFinish, boolNext)
	local function Paint(_, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	parentBack:Dock(LEFT)
	parentBack:SetWide(SScaleMin(100 / 3))
	parentBack:SetText(string.utf8upper("back"))
	parentBack:SetContentAlignment(6)
	parentBack:SetTextInset(padding, 0)
	parentBack:SetFont("MenuFontNoClamp")
	parentBack.Paint = function(this, w, h)
		Paint(this, w, h)

		surface.SetDrawColor(color_white)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/mainmenu/charcreation/leftarrow.png"))
		surface.DrawTexturedRect(padding, h * 0.5 - SScaleMin(36 / 3) * 0.5, SScaleMin(7 / 3), SScaleMin(36 / 3))
	end

	parentBack.OnCursorEntered = function()
		surface.PlaySound("helix/ui/rollover.wav")
	end

	parentBack.DoClick = function()
		self.progress:DecrementProgress()
		ix.panelCreationActive = false
		ix.gui.mapsceneActive = nil
		ix.gui.blackBarBottom:ColorTo( Color(0, 0, 0, 0), 0, 0 )
		ix.gui.blackBarTop:ColorTo( Color(0, 0, 0, 0), 0, 0 )
		ix.gui.blackBarTop:SetVisible(false)
		ix.gui.blackBarBottom:SetVisible(false)

		if (self.WhitelistCount == 1) then
			self.factionBack:DoClick()
		else
			self:SetActiveSubpanel("faction")
		end

		self:ResetModelCam()
	end

	parentNext:Dock(LEFT)
	parentNext:DockMargin(padding, 0, 0, 0)
	parentNext:SetWide(SScaleMin(100 / 3))
	parentNext:SetText(string.utf8upper("next"))
	parentNext:SetContentAlignment(4)
	parentNext:SetTextInset(padding, 0)
	parentNext:SetFont("MenuFontNoClamp")
	parentNext.Paint = function(this, w, h)
		if isbool(boolNext) and boolNext == false then
			parentNext:SetTextColor(Color(255, 255, 255, 30))
			surface.SetDrawColor(255, 255, 255, 5)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(255, 255, 255, 30)
			surface.SetMaterial(ix.util.GetMaterial("willardnetworks/mainmenu/charcreation/rightarrow.png"))
			surface.DrawTexturedRect(w - SScaleMin(7 / 3) - padding, h * 0.5 - SScaleMin(36 / 3) * 0.5, SScaleMin(7 / 3), SScaleMin(36 / 3))

			return
		else
			Paint(this, w, h)
		end

		surface.SetDrawColor(color_white)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/mainmenu/charcreation/rightarrow.png"))
		surface.DrawTexturedRect(w - SScaleMin(7 / 3) - padding, h * 0.5 - SScaleMin(36 / 3) * 0.5, SScaleMin(7 / 3), SScaleMin(36 / 3))
	end

	parentNext.OnCursorEntered = function()
		if boolNext then
			return
		end

		surface.PlaySound("helix/ui/rollover.wav")
	end

	parentFinish:Dock(LEFT)
	parentFinish:DockMargin(padding, 0, 0, 0)
	parentFinish:SetWide(SScaleMin(100 / 3))
	parentFinish:SetTextColor(Color(255, 255, 255, 30))
	parentFinish:SetText(string.utf8upper("finish"))
	parentFinish:SetContentAlignment(4)
	parentFinish:SetTextInset(padding, 0)
	parentFinish:SetFont("MenuFontNoClamp")
	parentFinish.Paint = function(_, w, h)
		self:DrawFinishButtonNonAvailable(w, h)
	end
end

-- A function to create a the character button in the left side menu
function PANEL:CreateCharacterButton()
	self.characterButton = self.leftCreation:Add("DButton")
	self:CreateMainButton(self.characterButton, "character")
	self.characterButton.DoClick = function()
		self:ClearSelectedMainButtons()
		self:SetButtonSelected(self.characterButton, "character", true)
		if ix.panelCreationActive == true then
			surface.PlaySound(table.Random(self.randomClickSounds))
		end

		self:CreateRightMenuTextPanel(self.faction:GetNoGender(LocalPlayer()) != true and "name/gender" or "name", 60)

		-- Name
		local nameGenderPanel = self.rightCreation:Add("DTextEntry")
		self:CreateRightMenuTextEntry(nameGenderPanel, "Enter your name here...", 36, false, 35, "name")

		if self.faction:GetNoGender(LocalPlayer()) != true then
			-- Gender
			self.genderButtonFemale = nameGenderPanel:Add("DImageButton")
			self:CreateGenderButton(self.genderButtonFemale, "willardnetworks/mainmenu/charcreation/female.png", 13, 36, 10, "female")

			self.genderButtonMale = nameGenderPanel:Add("DImageButton")
			self:CreateGenderButton(self.genderButtonMale, "willardnetworks/mainmenu/charcreation/male.png", 16, 36, 5, "male")
		end

		local minLength = ix.config.Get("minNameLength", 4)
		local maxLength = ix.config.Get("maxNameLength", 32)

		local namewarning = self:CreateRightMenuYellowTextPanel("Your name needs to be minimum "..minLength.." characters ("..string.len(self.payload.name or "").." / "..maxLength..")", -1)

		nameGenderPanel.OnTextChanged = function(this)
			self.payload:Set("name", this:GetValue())
			self:CheckIfFinished()

			namewarning:SetText("Your name needs to be minimum "..minLength.." characters ("..string.len(this:GetValue() or "").." / "..maxLength..")")
			namewarning:SizeToContents()
		end

		if self.faction:GetNoGenetics(LocalPlayer()) != true then
			-- Genetics
			self:CreateRightMenuTextPanel("genetic description", 10)

			local comboBoxPanel = self.rightCreation:Add("Panel")
			comboBoxPanel:Dock(TOP)
			comboBoxPanel:SetTall(SScaleMin(36 / 3))

			local ageComboBox = comboBoxPanel:Add("DButton")
			if self.faction.name == "Vortigaunt" then
				self:CreateSelectionMenu(ageComboBox, 148, "age", {"youngling (0 - 50)", "matured youngling (50 - 250)", "adult (250 - 1000)", "sage (1000 - 2000)", "elder (2000 - 10000)"})
			else
				self:CreateSelectionMenu(ageComboBox, 100, "age", {"young adult", "adult", "middle-aged", "elderly"})
			end

			local heightComboBox = comboBoxPanel:Add("DButton")

			if self.faction.name == "Civil Protection" then
				self:CreateSelectionMenu(heightComboBox, 90, "height", {"5'5\"", "5'6\"", "5'8\"", "5'10\"", "6'0\"", "6'2\""})
			elseif self.faction.name == "Vortigaunt" then
				self:CreateSelectionMenu(heightComboBox, 148, "height", {"6'4\"", "6'5\"", "6'6\"", "6'7\"", "6'8\"", "6'9\"", "6'10\"", "6'11\""})
			else
				self:CreateSelectionMenu(heightComboBox, 90, "height", {"5'2\"", "5'4\"", "5'6\"", "5'8\"", "5'10\"", "6'0\"", "6'2\""})
			end

			local eyeColorBox = comboBoxPanel:Add("DButton")
			if self.faction.name == "Vortigaunt" then
				self:CreateSelectionMenu(eyeColorBox, 146, "eye color", {"red", "yellow", "orange"})
			else
				self:CreateSelectionMenu(eyeColorBox, 110, "eye color", {"blue", "green", "brown", "hazel", "amber", "gray"})
			end

			self:CreateRightMenuYellowTextPanel("The genetic description values stays permanent.", 10)
		end

		if self.faction.name != "Overwatch AI" then
			local languages = {}
			if (ix.languages) then
				for _, v in pairs(ix.languages.stored) do
					if (!v.notSelectable) then
						table.insert(languages, v.uniqueID)
					end
				end
			end

			table.insert(languages, "none")

			self:CreateRightMenuTextPanel("second language", 10)

			local languageBoxPanel = self.rightCreation:Add("Panel")
			languageBoxPanel:Dock(TOP)
			languageBoxPanel:SetTall(SScaleMin(36 / 3))

			local languageComboBox = languageBoxPanel:Add("DButton")
			self:CreateSelectionMenu(languageComboBox, 110, "language", languages)
		end

		-- Description
		self:CreateRightMenuTextPanel("physical description", 20)
		local charDescPanel = self.rightCreation:Add("DTextEntry")
		self:CreateRightMenuTextEntry(charDescPanel, "Describe your character's physical appearance here...", 130, true, 1000, "desc")

		local minDescLength = ix.config.Get("minDescriptionLength", 16)
		local maxDescLength = ix.config.Get("maxDescriptionLength", 512)
		local descLength = self:CreateRightMenuYellowTextPanel("Your description needs to be a minimum of "..minDescLength.." characters ("..string.len(self.payload.description or "").." / "..maxDescLength..")", -1)

		charDescPanel.OnTextChanged = function(this)
			self.payload:Set("description", this:GetValue())
			self:CheckIfFinished()

			descLength:SetText("Your description needs to be a minimum of "..minDescLength.." characters ("..string.len(this:GetValue()).." / "..maxDescLength..")")
			descLength:SizeToContents()
		end

		self:CreateFinishPanel(false, self.appearancesButton)
	end
end

-- A function to refresh what skins a model has depending on gender etc.
function PANEL:RefreshSkins()
	if !table.IsEmpty(self.skinButtonList) then
		table.Empty(self.skinButtonList)
	end

	if !table.IsEmpty(self.glassesButtonList) then
		table.Empty(self.glassesButtonList)
	end

	for _, v in pairs(self.skinButtonPanel:GetChildren()) do
		v:Remove()
	end

	if self.glassesButtonPanel and IsValid(self.glassesButtonPanel) then
		for _, v in pairs(self.glassesButtonPanel:GetChildren()) do
			v:Remove()
		end
	end

	local eyeColorTable = self:GetActiveSkinEyeColorTable()

	for k, v in pairs(eyeColorTable) do
		local skinButton = self.skinButtonPanel:Add("DButton")
		skinButton:Dock(LEFT)
		skinButton:SetWide(math.Round(self.rightCreation:GetWide() / (#eyeColorTable)) - padding)
		skinButton:DockMargin(0, 0, padding, 0)
		skinButton:SetText(k)
		skinButton:SetFont("MenuFontNoClamp")
		skinButton.name = k

		table.insert(self.skinButtonList, skinButton)

		if self.payload.data["skin"] == v then
			self:SetButtonSelected(skinButton, k, false)
		else
			skinButton.Paint = function(selfSkin, w, h)
				surface.SetDrawColor(Color(0, 0, 0, 100))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
				surface.DrawOutlinedRect(0, 0, w, h)
			end
		end

		skinButton.OnCursorEntered = function()
			surface.PlaySound("helix/ui/rollover.wav")
		end

		skinButton.DoClick = function()
			self:ClearSelectedSkins(self.skinButtonList)
			self:SetButtonSelected(skinButton, k, false)
			surface.PlaySound("helix/ui/press.wav")
			self.payload.data["skin"] = v
			self.characterModel.Entity:SetSkin(v)
			if (self.payload.faction == FACTION_CITIZEN or self.payload.faction == FACTION_ADMIN or self.payload.faction == FACTION_WORKERS or self.payload.faction == FACTION_MEDICAL) then
				local bone = self.characterModel.Entity:LookupBone("ValveBiped.Bip01_Head1")
				if (bone) then
					local eyepos = self.characterModel.Entity:GetBonePosition(bone)
					self.characterModel:SetLookAt(eyepos)

					self.characterModel:SetCamPos(eyepos-Vector(-12, -12, 0))	-- Move cam in front of eyes
					self.characterModel:SetFOV(34)
				end
			end
		end
	end

	if self.glassesButtonPanel and IsValid(self.glassesButtonPanel) then
		for i = 1, 2 do
			local glassesButton = self.glassesButtonPanel:Add("DButton")
			glassesButton:Dock(LEFT)
			if i == 1 then
				glassesButton:SetText("NO")
			else
				glassesButton:SetText("YES")
			end
			glassesButton:SetWide((math.Round(self.rightCreation:GetWide() / 2) - padding))
			glassesButton:DockMargin(0, 0, padding, 0)
			glassesButton:SetFont("MenuFontNoClamp")
			glassesButton.name = glassesButton:GetText()

			table.insert(self.glassesButtonList, glassesButton)

			if self.payload.data.glasses == true and i == 2 then
				self:SetButtonSelected(glassesButton, "YES", false)
			elseif self.payload.data.glasses == false and i == 1 then
				self:SetButtonSelected(glassesButton, "NO", false)
			else
				glassesButton.Paint = function(selfSkin, w, h)
					surface.SetDrawColor(Color(0, 0, 0, 100))
					surface.DrawRect(0, 0, w, h)

					surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
					surface.DrawOutlinedRect(0, 0, w, h)
				end
			end

			glassesButton.OnCursorEntered = function()
				surface.PlaySound("helix/ui/rollover.wav")
			end

			glassesButton.DoClick = function()
				for _, v in pairs(self.glassesButtonList) do
					v.Paint = function(this, w, h)
						self:DrawButtonUnselected(v.name, this, w, h, false)
					end
				end

				self:SetButtonSelected(glassesButton, glassesButton.name, false)
				surface.PlaySound("helix/ui/press.wav")
				if i == 2 then
					self.payload.data["glasses"] = true
					self.characterModel.Entity:SetBodygroup(8, 1)
					self.payload.data.chosenClothes["8"] = 1
				else
					self.payload.data["glasses"] = false
					self.characterModel.Entity:SetBodygroup(8, 0)
					self.payload.data.chosenClothes["8"] = 0
				end

				self:ResetModelCam()
			end
		end
	end
end

function PANEL:RefreshBeards()
	if !table.IsEmpty(self.beardButtonList) then
		table.Empty(self.beardButtonList)
	end

	if self.payload.gender == "male" then
		for _, v in pairs(self.beardButtonPanel:GetChildren()) do
			v:Remove()
		end
	end

	if self.payload.gender == "male" then
		for i = 0, 8 do
			local beardButton = self.beardButtonPanel:Add("DButton")
			beardButton:Dock(LEFT)
			if i == 0 then
				beardButton:SetText("NO BEARD")
				beardButton:SetWide((math.Round(self.rightCreation:GetWide() / 9) * 2) - padding)
			else
				beardButton:SetText(i + 1)
				beardButton:SetWide(math.Round(self.rightCreation:GetWide() / 10) - padding)
			end
			beardButton:DockMargin(0, 0, padding, 0)
			beardButton:SetFont("MenuFontNoClamp")
			beardButton.name = i

			table.insert(self.beardButtonList, beardButton)

			if self.payload.data.groups[self.beardBodygroups] == i then
				self:SetButtonSelected(beardButton, i, false)
			else
				beardButton.Paint = function(selfSkin, w, h)
					surface.SetDrawColor(Color(0, 0, 0, 100))
					surface.DrawRect(0, 0, w, h)

					surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
					surface.DrawOutlinedRect(0, 0, w, h)
				end
			end

			beardButton.OnCursorEntered = function()
				surface.PlaySound("helix/ui/rollover.wav")
			end

			beardButton.DoClick = function()
				for _, v in pairs(self.beardButtonList) do
					v.Paint = function(this, w, h)
						self:DrawButtonUnselected(v.name, this, w, h, false)
					end
				end

				self:SetButtonSelected(beardButton, i, false)
				surface.PlaySound("helix/ui/press.wav")
				self.payload.data.groups[self.beardBodygroups] = i
				self.characterModel.Entity:SetBodygroup(11, i)
				if (self.payload.faction == FACTION_CITIZEN or self.payload.faction == FACTION_ADMIN or self.payload.faction == FACTION_WORKERS or self.payload.faction == FACTION_MEDICAL) then
					if self.characterModel.Entity:LookupBone("ValveBiped.Bip01_Head1") then
						local eyepos = self.characterModel.Entity:GetBonePosition( self.characterModel.Entity:LookupBone("ValveBiped.Bip01_Head1") )
						if eyepos then
							self.characterModel:SetLookAt(eyepos)

							self.characterModel:SetCamPos(eyepos-Vector(-12, -12, 0))	-- Move cam in front of eyes
							self.characterModel:SetFOV(34)
						end
					end
				end
			end
		end
	end
end

-- A function to create a button panel
function PANEL:CreateButtonPanel(parent)
	parent:Dock(TOP)
	parent:DockMargin(0, 0, 0, 0)
	parent:SetSize(self.rightCreation:GetWide(), SScaleMin(36 / 3))
end

-- A function to create the appearances button in the left side menu
function PANEL:CreateAppearancesButton()
	self.appearancesButton = self.leftCreation:Add("DButton")
	self:CreateMainButton(self.appearancesButton, "appearances")

	self.appearancesButton.DoClick = function()
		local faction = ix.faction.indices[self.payload.faction]

		self:ClearSelectedMainButtons()
		self:SetButtonSelected(self.appearancesButton, "appearances", true)
		surface.PlaySound(table.Random(self.randomClickSounds))

		self:CreateRightMenuTextPanel("model selection", 60)

		local modelSelectionPanel = self.rightCreation:Add("DScrollPanel")
		modelSelectionPanel:Dock(TOP)

		local modelSelectionGrid = modelSelectionPanel:Add( "DGrid" )

		local iconSize = SScaleMin(94 / 3)

		if (self.rightCreation:GetWide() - (SScaleMin(94 / 3) * 6)) >= SScaleMin(94 / 3) then
			modelSelectionGrid:SetCols( 6 )
		elseif (self.rightCreation:GetWide() - (SScaleMin(94 / 3) * 7)) >= SScaleMin(94 / 3) then
			modelSelectionGrid:SetCols( 7 )
		elseif (self.rightCreation:GetWide() - (SScaleMin(94 / 3) * 8)) >= SScaleMin(94 / 3) then
			modelSelectionGrid:SetCols( 8 )
		else
			modelSelectionGrid:SetCols( 5 )
		end

		local rowCount = math.ceil(#self:GetFactionModelsGender(faction) / modelSelectionGrid:GetCols())
		modelSelectionGrid:SetColWide( rowCount > 2 and iconSize - 5 or iconSize )
		modelSelectionGrid:SetRowHeight( iconSize )

		modelSelectionPanel:SetTall(math.Clamp(rowCount, 0, 2) * iconSize)

		self.skinButtonList = {}
		self.glassesButtonList = {}
		self.canreadButtonList = {}

		for k, v in pairs(self:GetFactionModelsGender(faction)) do
			local iconbg = vgui.Create("Panel")
			iconbg:SetSize(SScaleMin(84 / 3), SScaleMin(84 / 3))
			iconbg.Paint = function(_, w, h)
				surface.SetDrawColor(Color(0, 0, 0, 100))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
				surface.DrawOutlinedRect(0, 0, w, h)
			end

			local icon = iconbg:Add("SpawnIcon")
			icon:SetSize(SScaleMin(82 / 3), SScaleMin(82 / 3))
			icon:Center()
			icon:InvalidateLayout(true)

			icon.OnCursorEntered = function()
				surface.PlaySound("helix/ui/rollover.wav")
			end

			icon.DoClick = function(this)
				self:CheckForSkinCount(k)

				self.payload:Set("model", k)

				if self.payload.data.chosenClothes[self.torsoBodygroups] then
					self.characterModel.Entity:SetBodygroup(tonumber(self.torsoBodygroups), tonumber(self.payload.data.chosenClothes[self.torsoBodygroups]))
				end

				if self.payload.data.chosenClothes[self.legsBodygroups] then
					self.characterModel.Entity:SetBodygroup(tonumber(self.legsBodygroups), tonumber(self.payload.data.chosenClothes[self.legsBodygroups]))
				end

				if self.payload.data.chosenClothes[self.shoesBodygroups] then
					self.characterModel.Entity:SetBodygroup(tonumber(self.shoesBodygroups), tonumber(self.payload.data.chosenClothes[self.shoesBodygroups]))
				end

				if self.payload.data["glasses"] == true then
					self.characterModel.Entity:SetBodygroup(8, 1)
				end

				self.payload:Set("hair", {hair = 0, color = Color(244,233,230)})

				local eyeColorTable = self:GetActiveSkinEyeColorTable()

				self.characterModel.Entity:SetSkin(eyeColorTable[1] or 0)
				self.payload.data["skin"] = eyeColorTable[1]

				self.payload.data.groups[self.beardBodygroups] = 0
				self.payload.data.groups[self.hairBodygroups] = 0

				if faction:GetNoAppearances(LocalPlayer()) != true then
					self:RefreshSkins()
				end

				self:ResetModelCam()

				surface.PlaySound("helix/ui/press.wav")
			end

			icon.PaintOver = function(this, w, h)
				if (self.payload.model == k) then
					surface.SetDrawColor(255, 78, 69, 100)

					for _ = 1, 3 do
						surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
					end
				end
			end

			if (isstring(v)) then
				icon:SetModel(v)
			else
				icon:SetModel(v[1], v[2] or 0, v[3])
			end

			modelSelectionGrid:AddItem( iconbg )
		end

		self:CreateRightMenuYellowTextPanel("Your model is permanent so choose wisely", 10)

		if faction:GetNoAppearances(LocalPlayer()) != true then
			self:CreateRightMenuTextPanel((faction.index == FACTION_VORT and "skin color/wrinkles" or "facial features"), 10)

			self.skinButtonPanel = self.rightCreation:Add("Panel")
			self:CreateButtonPanel(self.skinButtonPanel)

			if faction.index != FACTION_VORT then
				self:CreateRightMenuTextPanel("do you require glasses?", 20)

				self.glassesButtonPanel = self.rightCreation:Add("Panel")
				self:CreateButtonPanel(self.glassesButtonPanel)

				self:CreateRightMenuYellowTextPanel("Your screen will not be blurred without glasses unless enabled", 10)
				end


			self:RefreshSkins()
		end

		if !faction.ReadOptionDisabled then
			self:CreateRightMenuTextPanel("Can you read?", 5)

			local canreadButtonPanel = self.rightCreation:Add("Panel")
			self:CreateButtonPanel(canreadButtonPanel)

			-- Can read

			if !table.IsEmpty(self.canreadButtonList) then
				table.Empty(self.canreadButtonList)
			end

			if self.payload.data.canread == nil then
				self.payload.data["canread"] = true
			end

			for i = 1, 2 do
				local canreadButton = canreadButtonPanel:Add("DButton")
				canreadButton:Dock(LEFT)
				if i == 1 then
					canreadButton:SetText("NO")
				else
					canreadButton:SetText("YES")
				end

				canreadButton:SetWide((math.Round(self.rightCreation:GetWide() / 2) - padding))
				canreadButton:DockMargin(0, 0, padding, 0)
				canreadButton:SetFont("MenuFontNoClamp")
				canreadButton.name = canreadButton:GetText()

				table.insert(self.canreadButtonList, canreadButton)

				if self.payload.data.canread == true and i == 2 then
					self:SetButtonSelected(canreadButton, "YES", false)
				elseif self.payload.data.canread == false and i == 1 then
					self:SetButtonSelected(canreadButton, "NO", false)
				else
					canreadButton.Paint = function(selfSkin, w, h)
						surface.SetDrawColor(Color(0, 0, 0, 100))
						surface.DrawRect(0, 0, w, h)

						surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
						surface.DrawOutlinedRect(0, 0, w, h)
					end
				end

				canreadButton.OnCursorEntered = function()
					surface.PlaySound("helix/ui/rollover.wav")
				end

				canreadButton.DoClick = function()
					for _, v in pairs(self.canreadButtonList) do
						v.Paint = function(this, w, h)
							self:DrawButtonUnselected(v.name, this, w, h, false)
						end
					end

					self:SetButtonSelected(canreadButton, canreadButton.name, false)
					surface.PlaySound("helix/ui/press.wav")
					if i == 2 then
						self.payload.data["canread"] = true
					else
						self.payload.data["canread"] = false
					end
				end
			end

			self:CreateRightMenuYellowTextPanel("Books etc. will scramble but maintain a 'sort of readability' if 'No'", 10)
		end

		self:CreateFinishPanel(self.characterButton, self.hairButton)
	end
end

-- A helper function to create the finish panel at the bottom of the right side menu
function PANEL:CreateFinishPanel(back, next)
	local buttonPanel = self.rightCreation:Add("Panel")
	buttonPanel:Dock(TOP)
	buttonPanel:DockMargin(SScaleMin(140 / 3), margin, 0, 0)
	buttonPanel:SetTall(SScaleMin(36 / 3))

	local backButton = buttonPanel:Add("DButton")
	local nextButton = buttonPanel:Add("DButton")
	self.finishButton = buttonPanel:Add("DButton")
	self:CreateNextBackFinishButtons(backButton, nextButton, self.finishButton, next)

	if back then
		backButton.DoClick = function()
			back.DoClick()
		end
	end

	if next then
		nextButton.DoClick = function()
			next.DoClick()
		end
	end

	self:CheckIfFinished()
end

-- A function to create the buttons for the bodygroups
function PANEL:CreateBodyGroupButtons(parent, bodygroup, min, max)
	local torsoButtonList = {}
	local shoesButtonList = {}
	local trouserButtonList = {}
	self.hairButtonList = self.hairButtonList or {}

	local function ClearSelectedBodygroups(bodygroup2)
		if bodygroup2 == "torso" then
			for _, v in pairs(torsoButtonList) do
				v.Paint = function(this, w, h)
					self:DrawButtonUnselected(v.name, this, w, h, false)
				end
			end
		elseif bodygroup2 == "shoes" then
			for _, v in pairs(shoesButtonList) do
				v.Paint = function(this, w, h)
					self:DrawButtonUnselected(v.name, this, w, h, false)
				end
			end
		elseif bodygroup2 == "legs" then
			for _, v in pairs(trouserButtonList) do
				v.Paint = function(this, w, h)
					self:DrawButtonUnselected(v.name, this, w, h, false)
				end
			end
		else
			for _, v in pairs(self.hairButtonList) do
				v.Paint = function(this, w, h)
					self:DrawButtonUnselected(v.name, this, w, h, false)
				end
			end
		end
	end

	local caTorsos = {}
	local caLegs = {}
	local caShoes = {}

	for name, v in pairs(self.ccaClothingList) do
		if v.outfitCategory == "Torso" then
			caTorsos[name] = v.bg
		end

		if v.outfitCategory == "Legs" then
			caLegs[name] = v.bg
		end

		if v.outfitCategory == "Shoes" then
			caShoes[name] = v.bg
		end
	end

	local torsos = {}
	local legs = {}
	local shoes = {}

	for name, v in pairs(self.clothingList) do
		if v.outfitCategory == "Torso" then
			torsos[name] = v.bg
		end

		if v.outfitCategory == "Legs" then
			legs[name] = v.bg
		end

		if v.outfitCategory == "Shoes" then
			shoes[name] = v.bg
		end
	end

	local hairs = {}

	local gender = self.payload.gender
	for i = 0, gender == "female" and 14 or 12 do hairs[#hairs + 1] = i end

	local usedTorsoTable = torsos
	local usedLegsTable = legs
	local usedShoesTable = shoes
	local usedHairsTable = hairs

	if self.payload.faction == FACTION_ADMIN then
		usedTorsoTable = caTorsos
		usedLegsTable = caLegs
		usedShoesTable = caShoes
	end

	local activeTable = usedTorsoTable

	if bodygroup == "legs" then
		activeTable = usedLegsTable
	end

	if bodygroup == "shoes" then
		activeTable = usedShoesTable
	end

	if bodygroup == "hair" then
		activeTable = usedHairsTable
	end

	local amount = #activeTable == 0 and #table.GetKeys(activeTable) or #activeTable

	local actualAmount = amount

	local curAdd = 1

	local activeClothingTable = self.payload.faction == FACTION_ADMIN and self.ccaClothingList or self.clothingList

	for itemName, bgValue in pairs(activeTable) do
		if min or max then
			local k = itemName
			if k < min or k > max then continue end
		end

		local bodygroupButton = parent:Add("DButton")
		bodygroupButton:Dock(LEFT)
		bodygroupButton:SetWide(math.Round(self.rightCreation:GetWide() / (actualAmount - (bodygroup != "hair" and 0 or 7))) - padding)
		bodygroupButton:SetText(isstring(itemName) and curAdd or itemName or "")
		bodygroupButton:SetFont("MenuFontNoClamp")
		bodygroupButton:DockMargin(0, 0, padding, 0)
		bodygroupButton.name = bgValue

		if activeClothingTable[itemName] and activeClothingTable[itemName].uniqueID then
			bodygroupButton.item = activeClothingTable[itemName].uniqueID
		end

		if activeClothingTable[itemName] then
			if activeClothingTable[itemName].color then
				bodygroupButton.color = activeClothingTable[itemName].color
			end
		end

		if bodygroup == "torso" then
			table.insert(torsoButtonList, bodygroupButton)
		elseif bodygroup == "shoes" then
			table.insert(shoesButtonList, bodygroupButton)
		elseif bodygroup == "legs" then
			table.insert(trouserButtonList, bodygroupButton)
		else
			table.insert(self.hairButtonList, bodygroupButton)
		end

		bodygroupButton.Paint = function(_, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 100))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		local selectionTable = {"torso", "legs", "shoes", "hair"}

		for _, v2 in pairs(selectionTable) do
			if v2 != "hair" then
				if self.payload.data.chosenClothes then
					if self.payload.data.chosenClothes[v2] then
						if self.payload.data.chosenClothes[v2] == bodygroupButton.item then
							self:SetButtonSelected(bodygroupButton, bgValue, false)
						end
					end
				end
			end

			if v2 == "hair" and self.payload.hair and self.payload.hair.hair then
				if bgValue == self.payload.hair.hair then
					self:SetButtonSelected(bodygroupButton, bgValue, false)
				end
			end
		end

		bodygroupButton.OnCursorEntered = function()
			surface.PlaySound("helix/ui/rollover.wav")
		end

		bodygroupButton.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")
			ClearSelectedBodygroups(bodygroup)
			self:SetButtonSelected(bodygroupButton, bgValue, false)

			if bodygroup != "hair" then
				self.characterModel.Entity:SetBodygroup(tonumber(self[bodygroup.."Bodygroups"]), bgValue)
				self.payload.data.chosenClothes[tonumber(self[bodygroup.."Bodygroups"])] = bgValue

				self.payload.data.chosenClothes[bodygroup] = activeClothingTable[itemName].uniqueID

				if !self.payload.data.chosenClothes.color then self.payload.data.chosenClothes.color = {} end
				table.Merge(self.payload.data.chosenClothes.color, bodygroupButton.color)

				for name, color in pairs(self.payload.data.chosenClothes.color) do
					self.characterModel.overrideProxyColors[name] = color
				end
			else
				self.payload:Set("hair", {hair = bgValue, color = self.payload.hair.color})
				self.payload.data.groups[self.hairBodygroups] = bgValue
				self.characterModel.Entity:SetBodygroup(self.characterModel.Entity:FindBodygroupByName("hair"), bgValue)
			end

			self:ResetModelCam()

			if bodygroup == "shoes" then
				local footpos = self.characterModel.Entity:GetBonePosition( self.characterModel.Entity:LookupBone("ValveBiped.Bip01_L_Foot") )

				if footpos then
					if self.payload.gender == "female" then
						footpos:Add(Vector(2, 0, 5))	-- Move right slightly
					else
						footpos:Add(Vector(4, 0, 5))	-- Move right slightly
					end

					self.characterModel:SetLookAt(footpos)

					self.characterModel:SetCamPos(footpos-Vector(-12, -12, 0))	-- Move cam in front of feet
					self.characterModel:SetFOV(54)
				end
			end
		end

		curAdd = curAdd + 1
	end
end

-- A function to create the hair button on the left side menu
function PANEL:CreateHairButton()
	self.hairButton = self.leftCreation:Add("DButton")
	self:CreateMainButton(self.hairButton, "hair")
	self.hairButton.DoClick = function()
		self.beardButtonList = {}
		self:ResetModelCam()

		self:ClearSelectedMainButtons()
		self:SetButtonSelected(self.hairButton, "hair", true)

		surface.PlaySound(table.Random(self.randomClickSounds))

		if self.faction and self.faction.noHair then
			self:CreateRightMenuTextPanel("This faction does not allow for hair!", 60)
			return
		end

		self:CreateRightMenuTextPanel("hair selection", 60)

		if self.hairButtonList then self.hairButtonList = {} end

		local hairButtonPanel = self.rightCreation:Add("Panel")
		self:CreateButtonPanel(hairButtonPanel)
		self:CreateBodyGroupButtons(hairButtonPanel, "hair", 1, 8)

		local hairButtonPanel2 = self.rightCreation:Add("Panel")
		self:CreateButtonPanel(hairButtonPanel2)
		hairButtonPanel2:DockMargin(0, padding, 0, 0)
		self:CreateBodyGroupButtons(hairButtonPanel2, "hair", 9, 15)

		if self.payload.gender == "male" and self.faction.index != FACTION_VORT then
			self:CreateRightMenuTextPanel("beard", 20)
			self.beardButtonPanel = self.rightCreation:Add("Panel")
			self:CreateButtonPanel(self.beardButtonPanel)

			self:RefreshBeards()
		end

		local chooseColorText = self:CreateRightMenuTextPanel("choose color", 30)
		chooseColorText:SetFont("LargerTitlesFontNoClamp")
		chooseColorText:SetTextColor(Color(255, 204, 0, 255))
		chooseColorText:SizeToContents()

		local colorButtonList = {}

		for name, tColors in pairs(ix.allowedHairColors) do
			self:CreateRightMenuTextPanel(name, 15)

			local colorButtonPanel = self.rightCreation:Add("Panel")
			self:CreateButtonPanel(colorButtonPanel, 0)

			for _, color in pairs(tColors) do
				local colorButton = colorButtonPanel:Add("DButton")
				colorButton:Dock(LEFT)
				colorButton:SetWide(math.Round(self.rightCreation:GetWide() / 8 - padding))
				colorButton:SetText("")
				colorButton:DockMargin(0, 0, padding, 0)
				colorButton.color = color

				colorButton.Paint = function(_, w, h)
					surface.SetDrawColor(color)
					surface.DrawRect(0, 0, w, h)

					surface.SetDrawColor(self.payload.hair.color == color and Color(255, 204, 0, 255) or Color(111, 111, 136, (255 / 100 * 30)))
					surface.DrawOutlinedRect(0, 0, w, h)
				end

				colorButton.DoClick = function()
					if self.characterModel and IsValid(self.characterModel) then
						if !self.characterModel.overrideProxyColors then self.characterModel.overrideProxyColors = {} end

						self.characterModel.overrideProxyColors["HairColor"] = Vector(color.r / 255, color.g / 255, color.b / 255)
					end

					for _, v in pairs(colorButtonList) do
						v.Paint = function(this, w, h)
							surface.SetDrawColor(v.color)
							surface.DrawRect(0, 0, w, h)

							surface.SetDrawColor(v == colorButton and Color(255, 204, 0, 255) or Color(111, 111, 136, (255 / 100 * 30)))
							surface.DrawOutlinedRect(0, 0, w, h)
						end
					end

					self.payload:Set("hair", {hair = self.payload.hair.hair, color = color})
				end

				colorButtonList[#colorButtonList + 1] = colorButton
			end
		end

		self:CreateFinishPanel(self.appearancesButton, self.faceButton)
	end
end

-- A function to create the clothing button on the left side menu
function PANEL:CreateFaceButton()
	self.faceButton = self.leftCreation:Add("DButton")
	self:CreateMainButton(self.faceButton, "clothes")
	self.faceButton.DoClick = function()
		self:ResetModelCam()

		self:ClearSelectedMainButtons()
		self:SetButtonSelected(self.faceButton, "clothes", true)

		surface.PlaySound(table.Random(self.randomClickSounds))

		if self.faction:GetNoAppearances(LocalPlayer()) != true and self.faction.index != FACTION_VORT then
			self:CreateRightMenuTextPanel("jacket selection", 60)

			local jacketButtonPanel = self.rightCreation:Add("Panel")
			self:CreateButtonPanel(jacketButtonPanel)
			self:CreateBodyGroupButtons(jacketButtonPanel, "torso")

			self:CreateRightMenuTextPanel("trouser selection", 30)

			local trouserButtonPanel = self.rightCreation:Add("Panel")
			self:CreateButtonPanel(trouserButtonPanel)
			self:CreateBodyGroupButtons(trouserButtonPanel, "legs")

			self:CreateRightMenuTextPanel("shoes selection", 30)

			local shoesButtonPanel = self.rightCreation:Add("Panel")
			self:CreateButtonPanel(shoesButtonPanel)
			self:CreateBodyGroupButtons(shoesButtonPanel, "shoes")

			self:CreateRightMenuYellowTextPanel("New clothing can be purchased from stores", 10)
		else
			self:CreateRightMenuTextPanel("Appearances", 60)

			local noAppearances = self.rightCreation:Add("Panel")
			noAppearances:Dock(TOP)
			noAppearances:DockMargin(0, 0 - SScaleMin(1 / 3), 0, 0)
			noAppearances:SetTall(SScaleMin(140 / 3))
			noAppearances.Paint = function(_, w, h)
				surface.SetDrawColor(Color(0, 0, 0, 100))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
				surface.DrawOutlinedRect(0, 0, w, h)
			end

			local noAppearancesAvailable = noAppearances:Add("DLabel")
			noAppearancesAvailable:Dock(FILL)
			noAppearancesAvailable:SetFont("MenuFontNoClamp")
			noAppearancesAvailable:SetText("No Clothing Selection Available for this faction")
			noAppearancesAvailable:SetContentAlignment(5)
		end

		self:CreateFinishPanel(self.hairButton, self.attributesButton)
	end
end

-- A function to create a background selection panel
function PANEL:CreateBackgroundSelectionPanels(icon, iconW, iconH, title, desc, minusMargin, difficultyText)
	iconW = SScaleMin(iconW / 3)
	iconH = SScaleMin(iconH / 3)

	local backgroundPanel = self.rightCreation:Add("DSizeToContents")
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockPadding(SScaleMin(90 / 3), padding, padding, SScaleMin(15 / 3))
	backgroundPanel:DockMargin(0, 0 - SScaleMin(1 / 3), 0, 0)
	backgroundPanel:SetSizeX( false )
	backgroundPanel:InvalidateLayout()
	backgroundPanel.Paint = function(_, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(color_white)
		surface.SetMaterial(Material(icon))
		surface.DrawTexturedRect(SScaleMin(90 / 3) * 0.5 - iconW * 0.5, h * 0.5 - iconH * 0.5, iconW, iconH)
	end

	local textPanel = backgroundPanel:Add("DSizeToContents")
	textPanel:Dock(TOP)
	textPanel:SetSizeX( false )

	local titleText = textPanel:Add("DLabel")
	titleText:SetText(title)
	titleText:SetFont("LargerTitlesFontNoClamp")
	titleText:SizeToContents()
	titleText:Dock(TOP)
	titleText:SetTextColor(Color(255, 204, 0, 255))

	local descText = textPanel:Add("DLabel")
	descText:SetText(desc)
	descText:SetFont("MenuFontNoClamp")
	descText:SetWrap(true)
	descText:SetAutoStretchVertical(true)
	descText:Dock(TOP)

	if difficultyText then
		local textDifficulty = textPanel:Add("DLabel")
		textDifficulty:Dock(TOP)
		textDifficulty:SetText(difficultyText)
		textDifficulty:SetFont("MenuFontNoClamp")
		textDifficulty:SetWrap(true)
		textDifficulty:SetAutoStretchVertical(true)
		textDifficulty:DockMargin(0, padding, 0, 0)

		if string.match(difficultyText, "Hard") then
			textDifficulty:SetTextColor(Color(255, 78, 69, 255))
		elseif string.match(difficultyText, "This background starts with no CID.") then
			textDifficulty:SetTextColor(Color(236, 218, 101, 255))
		else
			textDifficulty:SetTextColor(Color(101, 235, 130, 255))
		end
	end

	local function PaintSelected(w, h)
		local color = ix.config.Get("color", color_white)

		surface.SetDrawColor(color.r, color.g, color.b, 200)
		for i = 1, 2 do
			local i2 = i * 2
			surface.DrawOutlinedRect(i, i, w - i2, h - i2)
		end
	end

	local buttonCover = self.rightCreation:Add("DButton")
	buttonCover:Dock(TOP)
	buttonCover.PerformLayout = function()
		buttonCover:SetWide(backgroundPanel:GetWide())
		buttonCover:SetTall(backgroundPanel:GetTall())
		buttonCover:DockMargin(0, 0 - backgroundPanel:GetTall(), 0, 0)
	end

	buttonCover:SetSize(SScaleMin(100 / 3), SScaleMin(100 / 3))

	buttonCover.Paint = function(selfButton, w, h)
		if self.payload.data["background"] == title then
			PaintSelected(w, h)
		end
	end
	buttonCover:SetText("")

	table.insert(self.backgroundButtonList, buttonCover)

	buttonCover.OnCursorEntered = function()
		surface.PlaySound("helix/ui/rollover.wav")
	end

	buttonCover.DoClick = function()
		self.payload.data["background"] = title

		surface.PlaySound("helix/ui/press.wav")
		for _, v in pairs(self.backgroundButtonList) do
			v.Paint = nil
		end

		buttonCover.Paint = function(_, w, h)
			PaintSelected(w, h)
		end

		self:CheckIfFinished()
	end
end

-- Util Functions
function PANEL:AttributesRefresh(attribute, number, bSkill)
	bSkill = bSkill or false
	if !bSkill then
		self.payload.special[attribute] = number
	else
		self.payload.skill[attribute] = number
	end

	self.attributesRemaining:SetText(self:GetPointsLeft(bSkill)..string.utf8upper(" point(s) remaining"))
	self.attributesRemaining:SizeToContents()
end

function PANEL:GetPointsSpend(bSkill)
	local pointsSpend = 0
	if !bSkill then
		for _, v in pairs(self.payload.special) do
			pointsSpend = pointsSpend + v
		end
	else
		for _, v in pairs(self.payload.skill) do
			pointsSpend = pointsSpend + v
		end
	end

	return pointsSpend
end

function PANEL:GetPointsLeft(bSkill)
	return self:GetMaxAttributePoints(bSkill) - self:GetPointsSpend(bSkill)
end


function PANEL:GetFactionModelsGender(faction)
	if self.payload.gender == "male" and faction:GetModelsMale(LocalPlayer()) then
		return faction:GetModelsMale(LocalPlayer())
	elseif self.payload.gender == "female" and faction:GetModelsFemale(LocalPlayer()) then
		return faction:GetModelsFemale(LocalPlayer())
	else
		return faction:GetModels(LocalPlayer())
	end
end

function PANEL:ClearSelectedSkins()
	for _, v in pairs(self.skinButtonList) do
		v.Paint = function(this, w, h)
			self:DrawButtonUnselected(v.name, this, w, h, false)
		end
	end
end

function PANEL:CheckForSkinCount(k)
	for _, v2 in pairs(self.skinButtonList) do
		if v2.name == 1 then
			self:SetButtonSelected(v2, k, false)
		end
	end
end

function PANEL:GetActiveSkinEyeColorTable()
	local entityModel = self.characterModel.Entity:GetModel()

	local vortEyeRedSkins = { 0, 6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 56 }
	local vortEyeYellowSkins = { 4, 9, 14, 19, 24, 29, 34, 39, 44, 49, 54, 59 }
	local vortEyeOrangeSkins = { 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60 }

	if (string.match(entityModel, "vortigaunt")) then
		local activeEyeColor = vortEyeRedSkins

		if self.payload.data["eye color"] == "YELLOW" then
			activeEyeColor = vortEyeYellowSkins
		end

		if self.payload.data["eye color"] == "ORANGE" then
			activeEyeColor = vortEyeOrangeSkins
		end

		return activeEyeColor
	end

	local eyeColorBrownSkins = { 0, 1, 2, 3, 4 }
	local eyeColorBlueSkins = { 5, 6, 7, 8, 9 }
	local eyeColorGreenSkins = { 10, 11, 12, 13, 14 }

	if (string.match(entityModel, "/male02")) then
		eyeColorBrownSkins = { 0, 1, 2, 3, 4, 5, 6, 7, 8 }
		eyeColorBlueSkins = { 9, 10, 11, 12, 13, 14, 15, 16, 17 }
		eyeColorGreenSkins = { 18, 19, 20, 21, 22, 23, 24, 25, 26 }
	end

	if (string.match(entityModel, "/male06")) then
		eyeColorBrownSkins = { 0, 1, 2, 3, 4, 5 }
		eyeColorBlueSkins = { 6, 7, 8, 9, 10, 11 }
		eyeColorGreenSkins = { 12, 13, 14, 15, 16, 17 }
	end

	if (string.match(entityModel, "/male07")) then
		eyeColorBrownSkins = { 0, 1, 2, 3, 4, 5, 6 }
		eyeColorBlueSkins = { 7, 8, 9, 10, 11, 12, 13 }
		eyeColorGreenSkins = { 14, 15, 16, 17, 18, 19, 20 }
	end

	if (string.match(entityModel, "/male10")) then
		eyeColorBrownSkins = { 0 }
		eyeColorBlueSkins = { 1 }
		eyeColorGreenSkins = { 2 }
	end

	if (string.match(entityModel, "/female_03")) then
		eyeColorBrownSkins = { 0, 1, 2, 3 }
		eyeColorBlueSkins = { 4, 5, 6, 7 }
		eyeColorGreenSkins = { 8, 9, 10, 11 }
	end

	local activeEyeColor = eyeColorBrownSkins

	if self.payload.data["eye color"] == "BLUE" or self.payload.data["eye color"] == "GRAY" then
		activeEyeColor = eyeColorBlueSkins
	end

	if self.payload.data["eye color"] == "GREEN" then
		activeEyeColor = eyeColorGreenSkins
	end

	if self.payload.data["eye color"] == "HAZEL" or self.payload.data["eye color"] == "BROWN"
	or self.payload.data["eye color"] == "AMBER"  then
		activeEyeColor = eyeColorBrownSkins
	end

	return activeEyeColor
end

function PANEL:ResetClothingInfo()

end

function PANEL:SetStandardFactionInfo(panel)
	self.faction = ix.faction.indices[panel.faction]
	self.torsoBodygroups = "2"
	self.legsBodygroups = "3"
	self.shoesBodygroups = "4"
	self.hairBodygroups = "10"
	self.beardBodygroups = "11"

	self.payload:Set("faction", panel.faction)
	self.payload:Set("model", 1)
	self.payload:Set("gender", "female")
	self.payload:Set("data", {})
	self.payload.data["languages"] = nil
	self.payload:Set("hair", {hair = 0, color = Color(244,233,230)})

	if self.characterModel and IsValid(self.characterModel) then
		self.characterModel.overrideProxyColors = {}
		self.characterModel.overrideProxyColors["HairColor"] = Vector(244 / 255, 233 / 255, 230 / 255)
	end

	if self.faction:GetModelsFemale(LocalPlayer()) then
		self.characterModel:SetModel(self.faction:GetModelsFemale(LocalPlayer())[1] or "models/willardnetworks/citizens/female_01.mdl")
		local model = self.characterModel:GetModel()
		if model:find("models/willardnetworks/citizens/") then
			if ix.faction.indices[panel.faction].index == FACTION_CP then
				model = self.characterModel:GetModel()
				if model then
					model = string.Replace(model, "models/willardnetworks/citizens/", "models/wn7new/metropolice/")
					if self.payload.gender == "male" then
						model = string.Replace(model, "male", "male_")
					end

					self.characterModel:SetModel(model)
				end
			end
		end
	end

	self.payload.data["age"] = ""
	self.payload.data["height"] = ""
	self.payload.data["eye color"] = ""

	self.torsoBodygroups = "2"
	self.legsBodygroups = "3"
	self.shoesBodygroups = "4"
	self.hairBodygroups = "10"
	self.beardBodygroups = "11"

	self.payload.data["groups"] = {}
	self.payload.data["skin"] = 0
	self.payload.data["chosenClothes"] = {}
	self.payload.data.chosenClothes[self.beardBodygroups] = 0

	self:ResetClothingInfo()

	self.payload.data["glasses"] = false
	self.payload.data["canread"] = true

	self.payload:Set("special", {})
	self.payload.special["strength"] = 0
	self.payload.special["perception"] = 0
	self.payload.special["agility"] = 0
	self.payload.special["intelligence"] = 0

	self.payload:Set("skill", {})

	self.payload.data["background"] = ""
end

function PANEL:CheckIfFinished(name)
	for k, v in SortedPairsByMemberValue(ix.char.vars, "index") do
		if (name ~= nil and (v.category or "character") != name) then
			continue
		end

		local value = self.payload[k]

		if (!v.bNoDisplay or v.OnValidate) then
			if (v.OnValidate) then
				local result = {v:OnValidate(value, self.payload, LocalPlayer())}

				if (result[1] == false) then
					if IsValid(self.finishButton) then
						self.finishButton:SetTextColor(Color(255, 255, 255, 30))
						self.finishButton.Paint = function(_, w, h)
							self:DrawFinishButtonNonAvailable(w, h)
						end
					end

					return false
				end
			end
		end
	end

	if IsValid(self.finishButton) then
		self.finishButton:SetTextColor(color_white)
		self.finishButton.Paint = function(_, w, h)
			self:DrawFinishButtonAvailable(w, h)
		end

		self.finishButton.DoClick = function()
			surface.PlaySound("willardnetworks/charactercreation/final.wav")
			self:SendPayload()
		end
	end

	return true
end

function PANEL:GetWhitelistFactions()
	local Count = 0

	for _, v in pairs(ix.faction.teams) do
		if (ix.faction.HasWhitelist(v.index)) then
			Count = Count + 1
		end
	end

	return Count
end


function PANEL:ResetPanel()
	self:ResetPayload(true)
	self.repopulatePanels = {}
end

function PANEL:ClearSelectedMainButtons()
	for _, v in pairs(self.mainButtonList) do
		v:SetTextColor(Color(200, 200, 200, 255))
		v.Paint = function(this, w, h)
			self:DrawButtonUnselected(v.name, this, w, h, true)
		end
	end

	for _, v in pairs(self.rightCreation:GetChildren()) do
		v:SetVisible(false)
	end

	if IsValid(self.dropdownMenu) then
		self.dropdownMenu:Remove()
	end
end

function PANEL:ResetModelCam()
	self.characterModel:SetFOV(26)
	self.characterModel:SetCamPos(self.originPos)
	self.characterModel:SetLookAt(self.originLookAt)
end

-- Paint Functions
function PANEL:SetButtonSelected(parent, text, boolMainButton)
	parent:SetTextColor(color_white)
	parent.Paint = function(this, w, h)
		self:DrawButtonSelected(text, this, w, h, boolMainButton)
	end
end

function PANEL:DrawRoundedBox(parent, w, h, alpha)
	draw.RoundedBox( 10, 0, 0, parent:GetWide(), parent:GetTall(), Color(78, 79, 100, alpha) )
end

function PANEL:FadeInBars()
	ix.gui.blackBarBottom:ColorTo( Color(0, 0, 0, 255), 1, 1 )
	ix.gui.blackBarTop:ColorTo( Color(0, 0, 0, 255), 1, 1 )
	ix.gui.blackBarTop:SetVisible(true)
	ix.gui.blackBarBottom:SetVisible(true)
end

function PANEL:Dim(length, callback)
	local animationTime = 1
	self.currentDimAmount = 0
	self.currentY = 0
	self.currentScale = 1
	self.currentAlpha = 255
	self.targetDimAmount = 255
	self.targetScale = 0.9

	length = length or animationTime
	self.currentDimAmount = 0

	self:CreateAnimation(length, {
		target = {
			currentDimAmount = self.targetDimAmount,
			currentScale = self.targetScale,
			OnComplete = callback
		},
		easing = "outCubic"
	})
end

function PANEL:DrawFinishButtonAvailable(w, h)
	surface.SetDrawColor(Color(0, 0, 0, 100))
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
	surface.DrawOutlinedRect(0, 0, w, h)

	surface.SetDrawColor(color_white)
	surface.SetMaterial(ix.util.GetMaterial("willardnetworks/mainmenu/charcreation/tick.png"))
	surface.DrawTexturedRect(w - SScaleMin(15 / 3) - padding, h * 0.5 - SScaleMin(36 / 3) * 0.5, SScaleMin(15 / 3), SScaleMin(36 / 3))
end

function PANEL:DrawFinishButtonNonAvailable(w, h)
	surface.SetDrawColor(255, 255, 255, 5)
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(255, 255, 255, 30)
	surface.SetMaterial(ix.util.GetMaterial("willardnetworks/mainmenu/charcreation/tick.png"))
	surface.DrawTexturedRect(w - SScaleMin(15 / 3) - padding, h * 0.5 - SScaleMin(36 / 3) * 0.5, SScaleMin(15 / 3), SScaleMin(36 / 3))
end

function PANEL:DrawButtonUnselected(text, this, w, h, bMainButton)
	surface.SetDrawColor(Color(0, 0, 0, 100))
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
	surface.DrawOutlinedRect(0, 0, w, h)
	if bMainButton then
		if this:IsHovered() then
			this:SetTextColor(color_white)
			surface.SetDrawColor(color_white)
		else
			this:SetTextColor(Color(200, 200, 200, 255))
			surface.SetDrawColor(Color(255, 255, 255, 160))
		end

		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/mainmenu/charcreation/"..text..".png"))
		surface.DrawTexturedRect(SScaleMin(9 / 3), SScaleMin(9 / 3), margin, margin)
	end
end

function PANEL:DrawButtonSelected(text, this, w, h, bMainButton)
	surface.SetDrawColor(Color(255, 78, 69, 255))
	surface.DrawRect(0, 0, w, h)

	if bMainButton then
		surface.SetDrawColor(color_white)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/mainmenu/charcreation/"..text..".png"))
		surface.DrawTexturedRect(SScaleMin(9 / 3), SScaleMin(9 / 3), margin, margin)
	end
end

function PANEL:Paint(width, height)
	surface.SetDrawColor(255, 255, 255, 0)
	surface.DrawTexturedRect(0, 0, width, height)
	BaseClass.Paint(self, width, height)
end

vgui.Register("ixCharMenuNew", PANEL, "ixCharMenuPanel")
