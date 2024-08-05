--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


DEFINE_BASECLASS("EditablePanel")

local PANEL = {}

function PANEL:Init()
end

function PANEL:SetText(text)
    self.text = text

	self:Clear()

    -- Some calculations
    local temp = self:Add("DLabel")
    temp:SetText(self.text)
    temp:SetFont("SmallerTitleFontNoBoldNoClampLessWeight")
	temp:Dock(TOP)
	temp:SetContentAlignment(5)
    temp:SizeToContents()
    temp:SetVisible(false)

	surface.SetFont("SmallerTitleFontNoBoldNoClampLessWeight")
	local tempW, _ = surface.GetTextSize(self.text)

    local textWidth = tempW
    local letterCount = string.len(text)
    local letterChunks = math.floor(letterCount / (textWidth / self.width) - SScaleMin(10 / 3))
    local iters = math.ceil(letterCount / letterChunks)
    local _, replaces = text:gsub("\\n", "\n")
    -- Add new line breaks
    iters = iters + replaces

    -- Split string into lines
    self.height = 0
    local last = 1
    local lines = 1

    for i = 1, iters do
        local part = text:sub(last, last + letterChunks - 1)
        local lastSpace = 0
        local len = string.len(part)
        local startStr = string.find(part, "\\n")

        if startStr then
            lastSpace = startStr - 1
            last = last + 2
        end

        if lastSpace == 0 then
            -- Finding last space
            for i2 = 1, len do
                if part:find(" ", -i2) then
                    lastSpace = ((len - i2) + 1)
                    break
                end
            end
        end

        if lastSpace > 0 and i ~= iters then
            last = last + lastSpace
            part = part:sub(1, lastSpace)
        else
            last = last + letterChunks
        end

        local line = self:Add("DLabel")
        line:SetText(part)
        line:SetFont("SmallerTitleFontNoBoldNoClampLessWeight")
		line:Dock(TOP)
		line:SetContentAlignment(5)
        line:SizeToContents()
        line:SetTextColor(self.color or color_white)
        lines = lines + 1

        self.height = self.height + line:GetTall()
    end

    self:SetSize(self.width, self.height)
	return self.width, self.height, lines - 1
end

vgui.Register("ixCenterWrappedText", PANEL, "Panel")

PANEL = {}

function PANEL:Init()
	if (IsValid(ix.gui.intro)) then
		ix.gui.intro:Remove()
	end

	ix.gui.intro = self

	self:SetSize(ScrW(), ScrH())
	self:SetPos(0, 0)
	self:SetZPos(99999)
	self:MakePopup()

	self.volume = 1

	self.backgroundPanel = self:Add("Panel")
	self.backgroundPanel:SetSize(self:GetSize())
	self.backgroundPanel.Paint = function(this, w, h)
		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawRect(0, 0, w, h)
	end

	self.firstText = self.backgroundPanel:Add("DLabel")
	self.firstText:SetText("Willard Networks HL2RP")
	self.firstText:SetFont("WNSmallerMenuTitleNoBold")
	self.firstText:SizeToContents()
	self.firstText:SetAlpha(0)
	self.firstText:Center()

	local sText = ix.config.Get("IntroTextLong", "")

	self.secondText = self.backgroundPanel:Add("ixCenterWrappedText")
	self.secondText.width = ScrW() / 2
	self.secondText:SetText(sText)
	self.secondText:Center()
	self.secondText:SetY(self.secondText:GetY() - SScaleMin(25 / 3))
	self.secondText:SetAlpha(0)

	if sText == "" then
		timer.Simple(10, function()
			if IsValid(self.secondText) then
				self.secondText:SetText(ix.config.Get("IntroTextLong", ""))
				self.secondText:Center()
				self.secondText:SetY(self.secondText:GetY() - SScaleMin(25 / 3))

				self.continueText:Center()
				self.continueText:SetY(self.continueText:GetY() + self.secondText:GetTall() / 2 + SScaleMin(25 / 3))
			end
		end)
	end

	self.continueText = self.backgroundPanel:Add("DLabel")
	self.continueText:SetText("Press Space to Continue")
	self.continueText:SetFont("CharCreationBoldTitle")
	self.continueText:SizeToContents()
	self.continueText:SetAlpha(0)
	self.continueText:Center()
	self.continueText:SetY(self.continueText:GetY() + self.secondText:GetTall() / 2 + SScaleMin(25 / 3))

	self:SetTimers()
end

function PANEL:SetTimers()
	timer.Simple(8, function() -- 8
		self.firstText:AlphaTo( 255, 3, 0 )
	end)

	timer.Simple(11, function() -- 11
		self.firstText:AlphaTo( 0, 3, 0 )
	end)

	timer.Simple(14, function() -- 14
		self.secondText:AlphaTo( 255, 3, 0 )
	end)

	timer.Simple(17, function() -- 17
		self.continueText:AlphaTo( 255, 1, 0 )
	end)
end

-- @todo h a c k
function PANEL:Think()
	if (IsValid(LocalPlayer())) then
		self:BeginIntro()
		self.Think = nil
	end
end

function PANEL:BeginIntro()
	-- something could have errored on startup and invalidated all options, so we'll be extra careful with setting the option
	-- because if it errors here, the sound will play each tick and proceed to hurt ears
	local bLoaded = false

	if (ix and ix.option and ix.option.Set) then
		local bSuccess, _ = pcall(ix.option.Set, "showIntro", true)
		bLoaded = bSuccess
	end

	if (!bLoaded) then
		self:Remove()

		if (ix and ix.gui and IsValid(ix.gui.characterMenu)) then
			ix.gui.characterMenu:Remove()
		end

		ErrorNoHalt(
			"[Helix] Something has errored and prevented the framework from loading correctly - check your console for errors!\n")

		return
	end

	self:MoveToFront()
	self:RequestFocus()

	sound.PlayFile("sound/buttons/combine_button2.wav", "", function()
		timer.Create("ixIntroStart", 2, 1, function()
			sound.PlayFile("sound/willardnetworks/intro.mp3", "", function(channel, status, error)
				if (IsValid(channel)) then
					channel:SetVolume(self.volume)
					self.channel = channel
				end
			end)
		end)
	end)
end

function PANEL:OnKeyCodePressed(key)
	if (key == KEY_SPACE and self.continueText:GetAlpha() == 255) then
		self:Remove()
	end
end

function PANEL:OnRemove()
	timer.Remove("ixIntroStart")

	if (IsValid(self.channel)) then
		self.channel:Stop()
	end

	if (IsValid(ix.gui.characterMenu)) then
		ix.gui.characterMenu:PlayMusic()
	end
end

function PANEL:Remove(bForce)
	if (bForce) then
		BaseClass.Remove(self)
		return
	end

	if (self.bClosing) then
		return
	end

	self.bClosing = true
	self.bBackground = nil

	self.backgroundPanel:AlphaTo( 0, 2, 0 )
	self.continueText:AlphaTo( 0, 2, 0 )

	-- audio
	self:CreateAnimation(2, {
		index = 1,
		target = {volume = 0},

		Think = function(anim, panel)
			if (IsValid(panel.channel)) then
				panel.channel:SetVolume(panel.volume)
			end
		end,

		OnComplete = function()
			timer.Simple(0, function()
				BaseClass.Remove(self)
			end)
		end
	})
end

vgui.Register("ixIntro", PANEL, "EditablePanel")
