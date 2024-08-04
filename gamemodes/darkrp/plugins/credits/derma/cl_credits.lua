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
local PLUGIN = PLUGIN

function PANEL:Init()
    self:SetSize(ScrW(), ScrH())
    self:SetAlpha(0)
    self:MakePopup()
    self:SetZPos(99999)

    self:PlayMusic()
end

function PANEL:FadeInLogo()
    local logoPanel = self:Add("Panel")
    logoPanel:SetAlpha(0)
    logoPanel:AlphaTo(255, 3, 0, function()
        logoPanel:AlphaTo(0, 3, 0, function()
            self:FadeInTitleImage()
        end)
    end)

    local willardLabel = logoPanel:Add("DLabel")
    willardLabel:SetFont("WNMenuTitleNoClamp")
    willardLabel:SetText("WILLARD NETWORKS")
    willardLabel:SizeToContents()

    logoPanel:SetSize(willardLabel:GetWide(), SScaleMin(196 / 3) + willardLabel:GetTall() + SScaleMin(20 / 3))
    logoPanel:Center()

    local logo = logoPanel:Add("DImage")
    logo:SetImage("willardnetworks/newlogo.png")
    logo:SetSize(SScaleMin(195 / 3), SScaleMin(196 / 3))
    logo:Center()
    local x, _ = logo:GetPos()
    logo:SetPos(x, 0)

    willardLabel:Center()
    local x2, _ = willardLabel:GetPos()

    willardLabel:SetPos(x2, SScaleMin(196 / 3) + SScaleMin(20 / 3))
end

function PANEL:FadeInTitleImage()
    local titleImagePanel = self:Add("DHTML")
    titleImagePanel:OpenURL(ix.config.Get("eventCreditsImageURL", ""))
    titleImagePanel:SetSize(ix.config.Get("eventCreditsImageW", 1), ix.config.Get("eventCreditsImageH", 1))
    titleImagePanel:Center()

    local fadeThing = self:Add("Panel")
    fadeThing:SetSize(ix.config.Get("eventCreditsImageW", 1), ix.config.Get("eventCreditsImageH", 1))
    fadeThing:Center()
    fadeThing:SetAlpha(255)
    fadeThing:AlphaTo(0, 2, 0)
    fadeThing.Paint = function(this, w, h)
        surface.SetDrawColor(color_black)
        surface.DrawRect(0, 0, w, h)
    end

    timer.Simple(ix.config.Get("eventCreditsImageShownTimer", 5) + 2, function()
        fadeThing:AlphaTo(255, 2, 0, function()
            titleImagePanel:Remove()
            fadeThing:Remove()
            self:AlphaTo(0, 3, 0, function()
                self:Remove()
            end)
        end)
    end)
end

function PANEL:FadeInCredits()
    local height = 0
    local panelMove = self:Add("Panel")
    panelMove:SetWide(ScrW())

    local thanksTo = panelMove:Add("DLabel")
    thanksTo:SetFont("WNMenuTitle")
    thanksTo:SetText("THANKS TO:")
    thanksTo:Dock(TOP)
    thanksTo:SizeToContents()
    thanksTo:DockMargin(0, 0, 0, SScaleMin(20 / 3))
    thanksTo:SetContentAlignment(5)

    height = height + thanksTo:GetTall() + SScaleMin(20 / 3)

    for _, v in pairs(PLUGIN.creditsMembers) do
        local member = panelMove:Add("DLabel")
        member:SetFont("WNSmallerMenuTitleNoBold")
        member:SetText(v or "")
        member:Dock(TOP)
        member:SizeToContents()
        member:SetContentAlignment(5)
        member:DockMargin(0, 0, 0, SScaleMin(20 / 3))

        height = height + member:GetTall() + SScaleMin(20 / 3)
    end

    panelMove:SetTall(height)
    panelMove:SetPos(0, ScrH())
    panelMove:MoveTo( 0, -ScrH(), ix.config.Get("eventCreditsSpeedOfRoller", 60), 0, 1, function()
        self:AlphaTo(0, 3, 0, function()
            self:Remove()
        end)
    end)
end

function PANEL:PlayMusic()
    self:MoveToFront()
	self:RequestFocus()

	sound.PlayFile("sound/buttons/combine_button2.wav", "", function()
		timer.Create("ixEventCreditsStart", 2, 1, function()
			sound.PlayFile("sound/willardnetworks/wn_forlorn.mp3", "", function(channel, status, error)
				if (IsValid(channel)) then
					channel:SetVolume(1)
					self.channel = channel
				end
			end)
		end)
	end)
end

function PANEL:OnRemove()
	timer.Remove("ixEventCreditsStart")

	if (IsValid(self.channel)) then
		self.channel:Stop()
	end
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(color_black)
    surface.DrawRect(0, 0, w, h)
end

vgui.Register("ixEventCredits", PANEL, "Panel")