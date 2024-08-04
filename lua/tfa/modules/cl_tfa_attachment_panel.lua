--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

if SERVER then
	AddCSLuaFile()
	return
end

local dimensions, padding
local tooltip_mincount = 1

local PANEL = {}

PANEL.HasInitialized = false
PANEL.Wep = nil
PANEL.Att = nil
PANEL.x = -1
PANEL.y = -1
PANEL.AttachmentTable = {}
PANEL.AttachmentIcons = {}
PANEL.VAtt = 0

function PANEL:Init()
	self.HasInitialized = false
	self.Wep = nil
	self.Att = nil
	self.x = -1
	self.y = -1
	self.AttachmentTable = {}
	self.AttachmentIcons = {}
	self:SetMouseInputEnabled(true)
end

function PANEL:Initialize()
	if not IsValid(self.Wep) then return false end

	if not self.Att then return end

	self.AttachmentTable = self.Wep.Attachments[ self.VAtt ]
	self.VGUIAttachmentTable = self.Wep.VGUIAttachments[ self.VAtt ]

	dimensions = math.Round(TFA.ScaleH(TFA.Attachments.IconSize))
	padding = math.Round(TFA.ScaleH(TFA.Attachments.UIPadding))

	local attCnt = #self.VGUIAttachmentTable.atts
	local truewidth = dimensions * attCnt + padding * ( math.max(0,attCnt-1) + 2 )
	local finalwidth = math.max( truewidth, dimensions * tooltip_mincount + padding * ( math.max(0,tooltip_mincount-1) + 2 ) )

	self:SetSize( finalwidth, dimensions + padding * 2 ) --+ tooltipheightmax + padding * 2 )
	self:DockPadding( 0, 0, 0, 0 )

	local toppanel = self:Add("DPanel")

	--toppanel:Dock( FILL )
	--toppanel:Dock(TOP)

	toppanel:SetWidth( finalwidth )
	toppanel:SetHeight( self:GetTall() )
	toppanel:DockPadding( padding,padding, padding, padding )
	toppanel.Paint = function(myself,w,h)
		if not IsValid(self.Wep) then return end
		draw.RoundedBox( 0, 0, 0, w, h, ColorAlpha( TFA.Attachments.Colors["secondary"], ( self.Wep:GetInspectingProgress() or 0 ) * 128 ) )
	end

	self.FinalWidth = finalwidth
	self.TopDockPanel = toppanel

	--self:InitializeTooltip()

	--[[

	local tooltip = self:Add("TFAAttachmentTip")
	tooltip:SetWeapon( self.Wep )
	tooltip:SetAttachment( self.Att )
	--tooltip:SetHeight( tooltipheightmax + padding * 2 )
	tooltip:SetSize( finalwidth, tooltipheightmax + padding * 2 )
	tooltip:SetPos(0, toppanel:GetTall() )
	self.ToolTip = tooltip

	]]--

	--local keyz = table.GetKeys( self.AttachmentTable.atts )
	--table.sort(keyz)
	--PrintTable(keyz)
	--for _,k in ipairs(keyz) do
	--	local v = self.AttachmentTable.atts[k]

	self.HasInitialized = true
	return true
end

function PANEL:PopulateIcons()
	dimensions = math.Round(TFA.ScaleH(TFA.Attachments.IconSize))
	padding = math.Round(TFA.ScaleH(TFA.Attachments.UIPadding))

	local i = 0

	for k,v in ipairs( self.VGUIAttachmentTable.atts ) do
		local p = self.TopDockPanel:Add("TFAAttachmentIcon")

		p:SetWeapon( self.Wep )
		p:SetGunAttachment( self.Att )
		p:SetAttachment( v[1] )
		p:SetID( v[2] )

		p:SetSize(dimensions, dimensions)
		p:SetPos(dimensions * i + padding * ( i + 1 ), padding)

		i = i + 1
		--p:SetPos(0,0)
		--p:DockMargin( 0,0, padding, 0 )
		--p:Dock(LEFT)
		self.AttachmentIcons[k] = p
	end

	return self
end

function PANEL:InitializeTooltip()
	local tooltip = vgui.Create("TFAAttachmentTip")
	tooltip.Anchor = self
	tooltip:SetWeapon(self.Wep)
	tooltip:SetAttachment(self.Att)
	tooltip:SetWidth(self.FinalWidth)
	tooltip:SetPos(0, self.TopDockPanel:GetTall())
	self.ToolTip = tooltip
	tooltip.LastTouched = 0
	tooltip.LastFrameAffectedImportant = 0

	return tooltip
end

function PANEL:SetupTooltip(tooltip)
	tooltip.Anchor = self
	tooltip:SetWidth(math.max(self.FinalWidth, tooltip:GetWide()))
	tooltip:SetPos(0, self.TopDockPanel:GetTall())
	self.ToolTip = tooltip

	return tooltip
end

--[[
function PANEL:CalcVAtt()
	if not self.VAtt then
		self.VAtt = 0
		local keyz = table.GetKeys( self.Wep.Attachments or {} )
		table.RemoveByValue( keyz, "BaseClass" )
		table.sort( keyz, function(a,b)
			--A and B are keys
			local v1 = self.Wep.Attachments[a]
			local v2 = self.Wep.Attachments[b]
			if v1 and v2 and v1.order then
				return v1.order < ( v2.order or math.huge )
			else
				return a < b
			end
		end)
		for k,v in ipairs(keyz) do
			if self.Att == v then
				self.VAtt = k
			end
		end
		--self:SetZPos( 100 - self.VAtt )
	end
end
]]--

function PANEL:Think()
	if not IsValid(self.ToolTip) then return end

	--self:CalcVAtt()

	local header
	local texttable

	for _,v in pairs( self.AttachmentIcons ) do
		if v:IsHovered() then
			header = TFA.Attachments.Atts[v.Attachment].Name
			texttable = TFA.Attachments.Atts[v.Attachment].Description
			break
		end
	end

	if not header then
		for _,v in pairs( self.AttachmentIcons ) do
			if v:GetSelected() then
				header = TFA.Attachments.Atts[v.Attachment].Name
				texttable = {}--TFA.Attachments.Atts[v.Attachment].Description
				break
			end
		end
	end

	if header and header ~= "" or self.ToolTip.LastTouched < RealTime() then
		if texttable and #texttable == 0 and self.ToolTip.LastFrameAffectedImportant > RealTime() then
			return
		end

		self.ToolTip:SetHeader(header)
		self.ToolTip:SetTextTable(texttable)
		self.ToolTip:SetActive( texttable and #texttable > 0 )
		self.ToolTip:SetContentPanel( self.ContentPanel )
		self.ToolTip.LastTouched = RealTime() + 0.1

		if texttable and #texttable ~= 0 then
			self.ToolTip.LastFrameAffectedImportant = RealTime() + 0.1
		end
	end
end

function PANEL:SetContentPanel( p )
	if IsValid(p) then
		self.ContentPanel = p
	else
		self.ContentPanel = nil
	end
end

function PANEL:SetWeapon( wepv )
	if IsValid(wepv) then
		self.Wep = wepv
	end
end

function PANEL:SetAttachment( att )
	if att ~= nil then
		self.VAtt = att
	end
end

function PANEL:SetCategory( att )
	if att ~= nil then
		self.Att = att
	end
end

function PANEL:GetAnchoredH()
	return true
end

-- @Deprecated
function PANEL:Position()
	-- self:SetPos( math.floor( self:GetParent():GetWide() - 32 - self:GetWide() ), math.max( self.VAtt - 1, 0 ) * dimensions + math.max( self.VAtt - 1, 0 ) * padding * 4 + math.max( self.VAtt - 1, 0 ) * spacing )
	-- self.HAnchored = true
end

function PANEL:Paint( w, h )
	if not self.HasInitialized then return false end

	if not IsValid(self.Wep)
		or not IsValid(self.Wep:GetOwner())
		or not self.Wep:GetOwner():IsPlayer()
		or self.Wep:GetOwner():GetActiveWeapon() ~= self.Wep
		or (self.Wep:GetInspectingProgress() or 0) < 0.01 then
		if IsValid(self.ToolTip) then
			self.ToolTip:Remove()
		end

		self:Remove()
	end
end

vgui.Register( "TFAAttachmentPanel", PANEL, "Panel" )