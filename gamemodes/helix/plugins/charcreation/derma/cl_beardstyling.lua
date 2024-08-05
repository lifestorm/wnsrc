--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PANEL = {}
local padding = SScaleMin(10 / 3)

local function Paint(self, w, h)
	surface.SetDrawColor(Color(0, 0, 0, 100))
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
	surface.DrawOutlinedRect(0, 0, w, h)
end

function PANEL:CustomInit(target)
	self:SetSize(ScrW(), ScrH())

	local background = self:Add("Panel")
	background:SetSize(self:GetSize())
	background.Paint = function(this, w, h)
		surface.SetDrawColor(Color(63, 58, 115, 220))
		surface.DrawRect(0, 0, w, h)

		Derma_DrawBackgroundBlur( this, 1 )
	end

	self.innerContent = background:Add("EditablePanel")
	self.innerContent:SetSize(SScaleMin(1300 / 3), SScaleMin(900 / 3))
	self.innerContent:Center()
	self.innerContent:MakePopup()
	self.innerContent.Paint = function(this, w, h)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	Schema:AllowMessage(self.innerContent)

	self:DrawTopBar()
	self:DrawModel()
	self:DrawLeftSide()
end

function PANEL:DrawTopBar()
	local topbar = self.innerContent:Add("Panel")
	topbar:SetSize(self.innerContent:GetWide(), SScaleMin(50 / 3))
	topbar:Dock(TOP)
	topbar.Paint = function( this, w, h )
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	local titleText = topbar:Add("DLabel")
	titleText:SetFont("CharCreationBoldTitleNoClamp")
	titleText:Dock(LEFT)
	titleText:SetText("Hair/Beard Styling")
	titleText:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	titleText:SetContentAlignment(4)
	titleText:SizeToContents()

	local exit = topbar:Add("DImageButton")
	exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	exit:DockMargin(0, SScaleMin(15 / 3), SScaleMin(10 / 3), SScaleMin(15 / 3))
	exit:Dock(RIGHT)
	exit.DoClick = function()
		self:Remove()
		surface.PlaySound("helix/ui/press.wav")
	end
end

function PANEL:DrawModel()
	local target = self.target or LocalPlayer()
	local characterModelList = self.innerContent:Add("Panel")
	characterModelList:Dock(RIGHT)
	characterModelList:SetWide(self.innerContent:GetWide() * 0.5)
	characterModelList.Paint = function(this, w, h)
		surface.SetDrawColor(Color(255, 255, 255, 30));
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	local imgBackground = characterModelList:Add("DImage")
	imgBackground:SetImage(ix.faction.indices[target:Team()].inventoryImage or
	"materials/willardnetworks/tabmenu/inventory/backgrounds/street.png")
	imgBackground:SetKeepAspect(true)
	imgBackground:Dock(FILL)
	imgBackground:DockMargin(1, 1, 1, 1)

	self.characterModel = imgBackground:Add("ixModelPanel")
	self.characterModel:Dock(FILL)

	local styleButton = characterModelList:Add("DButton")
	styleButton:Dock(BOTTOM)
	styleButton:SetFont("MenuFontLargerBoldNoFix")
	styleButton:SetText("Style")
	styleButton:SetTall(SScaleMin(50 / 3))
	styleButton.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		local char = target.GetCharacter and target:GetCharacter()

		local hairBG = target:FindBodygroupByName("hair")
		local beard = target:FindBodygroupByName("beard")

		local curHair = target:GetBodygroup(hairBG)
		local curBeard = target:GetBodygroup(beard)
		local newHair = self.characterModel.Entity:GetBodygroup(hairBG)
		local newBeard = self.characterModel.Entity:GetBodygroup(beard)
		local curHairColor = char and char.GetHair and char:GetHair() and char:GetHair().color or color_white
		local newHairColor = self.hairColor

		if (curHair != newHair) or (curBeard != newBeard) or (curHairColor and newHairColor and curHairColor != newHairColor) then
			netstream.Start("SetHairBeardBodygroup", newHair, newBeard, newHairColor, target)
			target:NotifyLocalized("You've successfully styled your beard/hair!")
			self:Remove()
		else
			target:NotifyLocalized("You cannot select the same hair/beard you already have!")
		end
	end

	styleButton.Paint = function(this, w, h)
		Paint(this, w, h)
	end

	self:SetCharacter()

	local bone = self.characterModel.Entity:LookupBone("ValveBiped.Bip01_Head1")
	if bone then
		local eyepos = self.characterModel.Entity:GetBonePosition( bone )

		self.characterModel:SetLookAt(eyepos)
		self.characterModel:SetCamPos(eyepos-Vector(-12, -12, 0))	-- Move cam in front of eyes
		self.characterModel:SetFOV(60)
		self.characterModel.PaintModel = self.characterModel.Paint
	end
end

function PANEL:SetCharacter()
	local target = self.target or LocalPlayer()
	local model = target:GetModel()
	self.characterModel:SetModel(model, target:GetSkin(), true)

	local isCP = model:find("wn7new")
	local indexName = isCP and "cp_Head" or "headwear"
	local index = target:FindBodygroupByName(indexName)

	if index != -1 then
		if self.characterModel.Entity:GetBodygroup(index) > 0 then
			self.characterModel.Entity:SetBodygroup(index, 0)
		end
	end

	local curHair = target:GetCharacter():GetHair()
	local hairValue = curHair and curHair.hair
	if hairValue then
		local hairIndex = target:FindBodygroupByName("hair")
		self.characterModel.Entity:SetBodygroup(hairIndex, hairValue)
	end
end

function PANEL:DrawLeftSide()
	self.leftSide = self.innerContent:Add("Panel")
	self.leftSide:Dock(LEFT)
	self.leftSide:SetWide(self.innerContent:GetWide() * 0.5)
	self.leftSide.Paint = function(this, w, h)
		surface.SetDrawColor(Color(255, 255, 255, 10));
		surface.DrawRect(0, 0, w, h )

		surface.SetDrawColor(Color(255, 255, 255, 30));
		surface.DrawOutlinedRect(0, 0, w + 1, h)
	end

	self:DrawShaveTrimButtons()

	local beardBodygroup = self.characterModel.Entity:GetBodygroup(11)

	local beardPart = self.leftSide:Add("DScrollPanel")
	beardPart:Dock(BOTTOM)
	beardPart:SetTall((beardBodygroup != 5 and beardBodygroup != 8 and SScaleMin(100 / 3)) or (self.innerContent:GetTall() - SScaleMin(50 / 3)) * 0.5)
	beardPart.Paint = function(this, w, h)
		surface.SetDrawColor(color_white)
		surface.DrawRect(0, 0, w, 1)
	end
	beardPart:DockMargin(0, padding * 3 - 1, 0, 0)

	local hairParts = self.leftSide:Add("Panel")
	hairParts:Dock(FILL)

	local hairPart = hairParts:Add("DScrollPanel")
	hairPart:Dock(LEFT)
	hairPart:SetWide(self.innerContent:GetWide() * 0.25)

	local hairColorPart = hairParts:Add("DScrollPanel")
	hairColorPart:Dock(FILL)

	local titleText = hairPart:Add("DLabel")
	titleText:SetFont("CharCreationBoldTitleNoClamp")
	titleText:Dock(TOP)
	titleText:SetText("Hair")
	titleText:DockMargin(0, padding * 3 - 1, 0, 0)
	titleText:SetContentAlignment(5)
	titleText:SizeToContents()

	local titleText2 = hairColorPart:Add("DLabel")
	titleText2:SetFont("CharCreationBoldTitleNoClamp")
	titleText2:Dock(TOP)
	titleText2:SetText("Hair Color")
	titleText2:DockMargin(0, padding * 3 - 1, 0, 0)
	titleText2:SetContentAlignment(5)
	titleText2:SizeToContents()

	self:DrawHairButtons(hairPart, hairColorPart)

	if beardBodygroup == 5 or beardBodygroup == 8 then
		self:DrawBeardButtons(beardPart)
	else
		local notEnough = beardPart:Add("DLabel")
		notEnough:SetText("There is not enough beard to style...")
		notEnough:SetFont("MenuFontLargerBoldNoFix")
		notEnough:SetContentAlignment(5)
		notEnough:Dock(TOP)
		notEnough:DockMargin(0, padding * 3 - 1, 0, 0)
	end
end

function PANEL:DrawBeardButtons(beardPart)
	local target = self.target or LocalPlayer()
	for i = 1, 6 do
		local beardButton = beardPart:Add("DButton")
		local sideMargins = self.leftSide:GetWide() * 0.1
		beardButton:Dock(TOP)
		beardButton:SetTall(SScaleMin(50 / 3))
		beardButton:SetFont("MenuFontLargerBoldNoFix")
		beardButton:SetText("Style "..i)
		beardButton:DockMargin(sideMargins, padding * 3 - 1, sideMargins, 0)

		beardButton.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")
			local beard = target:FindBodygroupByName("beard")
			if i == 5 then
				self.characterModel.Entity:SetBodygroup(beard, 6)
			elseif i == 6 then
				self.characterModel.Entity:SetBodygroup(beard, 7)
			else
				self.characterModel.Entity:SetBodygroup(beard, i)
			end
		end

		beardButton.OnCursorEntered = function()
			surface.PlaySound("helix/ui/rollover.wav")
		end

		beardButton.Paint = function(this, w, h)
			Paint(this, w, h)
		end
	end
end

function PANEL:DrawHairButtons(hairPart, hairColorPart)
	local target = self.target or LocalPlayer()
	local gender = target.GetCharacter and target:GetCharacter():GetGender() or "female"
	local hairs = {}
	for i = 0, gender == "female" and 14 or 12 do hairs[#hairs + 1] = i end

	local curStyle = 0
	for _, hairID in pairs(hairs) do
		curStyle = curStyle + 1
		local hairButton = hairPart:Add("DButton")
		local sideMargins = self.leftSide:GetWide() * 0.1
		hairButton:Dock(TOP)
		hairButton:SetTall(SScaleMin(50 / 3))
		hairButton:SetFont("MenuFontLargerBoldNoFix")
		hairButton:SetText("Style "..curStyle)
		hairButton:DockMargin(sideMargins, padding * 3 - 1, sideMargins, 0)

		hairButton.DoClick = function()
			local hairBG = target:FindBodygroupByName("hair")
			surface.PlaySound("helix/ui/press.wav")
			self.characterModel.Entity:SetBodygroup(hairBG, hairID)
		end

		hairButton.OnCursorEntered = function()
			surface.PlaySound("helix/ui/rollover.wav")
		end

		hairButton.Paint = function(this, w, h)
			Paint(this, w, h)
		end
	end

	for _, colorTable in pairs(ix.allowedHairColors) do
		for _, color in pairs(colorTable) do
			local hairButton = hairColorPart:Add("DButton")
			local sideMargins = self.leftSide:GetWide() * 0.1
			hairButton:Dock(TOP)
			hairButton:SetTall(SScaleMin(50 / 3))
			hairButton:SetFont("MenuFontLargerBoldNoFix")
			hairButton:SetText("")
			hairButton:DockMargin(sideMargins, padding * 3 - 1, sideMargins, 0)

			hairButton.DoClick = function()
				surface.PlaySound("helix/ui/press.wav")

				if self.characterModel and IsValid(self.characterModel) then
					self.characterModel.overrideProxyColors = {HairColor = Vector(color.r / 255, color.g / 255, color.b / 255)}
				end

				self.hairColor = color
			end

			hairButton.OnCursorEntered = function()
				surface.PlaySound("helix/ui/rollover.wav")
			end

			hairButton.Paint = function(this, w, h)
				surface.SetDrawColor(color)
				surface.DrawRect(0, 0, w, h)
			end
		end
	end
end

function PANEL:DrawShaveTrimButtons()
	local target = self.target or LocalPlayer()
	local buttonPanel = self.leftSide:Add("Panel")
	buttonPanel:Dock(BOTTOM)
	buttonPanel:SetTall(SScaleMin(50 / 3))

	local shaveButton = buttonPanel:Add("DButton")
	shaveButton:Dock(FILL)
	shaveButton:SetText("Shave")
	shaveButton:SetFont("MenuFontLargerBoldNoFix")
	shaveButton:SetWide(self.leftSide:GetWide() * 0.5)
	shaveButton.DoClick = function()
		surface.PlaySound("willardnetworks/charactercreation/boop1.wav")
		self:CreateWarningPanel()
	end

	local gender = target.GetCharacter and target:GetCharacter():GetGender() or "female"
	if gender == "female" then shaveButton:SetDisabled(true) end

	shaveButton.Paint = function(this, w, h)
		if gender == "female" then
			surface.SetDrawColor(255, 255, 255, 5)
			surface.DrawRect(0, 0, w, h)
			return
		end

		Paint(this, w, h)
	end

	local beardBodygroup = self.characterModel.Entity:GetBodygroup(11)

	if beardBodygroup == 0 then
		shaveButton:SetDisabled(true)
		shaveButton.Paint = function(this, w, h)
			surface.SetDrawColor(255, 255, 255, 5)
			surface.DrawRect(0, 0, w, h)
		end

		shaveButton.OnCursorEntered = function() end
	end
end

function PANEL:CreateWarningPanel()
	local warningPanel = vgui.Create("Panel")
	warningPanel:SetAlpha(0)
	warningPanel:MakePopup()
	warningPanel:SetSize(ScrW(), ScrH())
	warningPanel:AlphaTo(255, 0.5, 0)
	warningPanel.Paint = function(this, w, h)
		surface.SetDrawColor(0, 0, 0, 230)
		surface.DrawRect(0, 0, w, h)
	end

	local warningContent = warningPanel:Add("Panel")
	warningContent:SetSize(ScrW() * 0.4, SScaleMin(95 / 3))
	warningContent:Center()

	local label = warningContent:Add("DLabel")
	label:SetFont("CharCreationBoldTitleNoClamp")
	label:SetText("This will remove your beard, are you sure?")
	label:SetContentAlignment(5)
	label:Dock(TOP)
	label:SizeToContents()

	local warningButtons = warningContent:Add("Panel")
	warningButtons:Dock(TOP)
	warningButtons:DockMargin(0, padding, 0, 0)
	warningButtons:SetTall(SScaleMin(50 / 3))

	local yes = warningButtons:Add("DButton")
	yes:Dock(LEFT)
	yes:SetWide(warningContent:GetWide() * 0.5)
	yes:SetText("YES")
	yes:SetFont("CharCreationBoldTitleNoClamp")
	yes:SetContentAlignment(6)
	yes:SetTextColor(Color(200, 200, 200, 255))
	yes:SetTextInset(padding * 2, 0)
	yes.Paint = function(this, w, h)
		if this:IsHovered() then
			this:SetTextColor(Color(255, 255, 255, 255))
		else
			this:SetTextColor(Color(200, 200, 200, 255))
		end
	end

	local target = self.target or LocalPlayer()

	yes.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		surface.PlaySound("npc/antlion/idle1.wav")
		warningPanel:AlphaTo(0, 0.5, 0, function()
			local beard = target:FindBodygroupByName("beard")
			warningPanel:Remove()
			self:Remove()

			netstream.Start("RemoveBeardBodygroup", target)
			self.characterModel.Entity:SetBodygroup(beard, 0)
		end)
	end

	local no = warningButtons:Add("DButton")
	no:Dock(RIGHT)
	no:SetWide(warningContent:GetWide() * 0.5)
	no:SetText("NO")
	no:SetFont("CharCreationBoldTitleNoClamp")
	no:SetTextColor(Color(200, 200, 200, 255))
	no:SetContentAlignment(4)
	no:SetTextInset(padding * 2, 0)
	no.Paint = function(this, w, h)
		if this:IsHovered() then
			this:SetTextColor(Color(255, 255, 255, 255))
		else
			this:SetTextColor(Color(200, 200, 200, 255))
		end
	end
	no.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		warningPanel:AlphaTo(0, 0.5, 0, function()
			warningPanel:Remove()
		end)
	end

	yes.OnCursorEntered = function()
		surface.PlaySound("helix/ui/rollover.wav")
	end

	no.OnCursorEntered = function()
		surface.PlaySound("helix/ui/rollover.wav")
	end
end

function PANEL:SetTarget(target)
	self.target = target
end

vgui.Register("BeardStyling", PANEL, "EditablePanel")
