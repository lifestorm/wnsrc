--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ix.hud.appendixColors = {
	["yellow"] = Color(255, 204, 0, 255),
	["red"] = Color(255, 78, 69, 255),
	["green"] = Color(128, 200, 97, 255),
	["blue"] = Color(85, 194, 240, 255)
}

local function DrawAppendixTable(tooltip, data)
	for color, text in pairs(data) do
		text = tostring(text)

		if (text != "" and text != " ") then
			text = L(text)
		end

		local appendix = tooltip:Add("DLabel")
		appendix:SetText(text or "NOAPPENDIXTEXT")
		appendix:SetTextColor(ix.hud.appendixColors[color] or color_white)
		appendix:SetTextInset(15, 0)
		appendix:Dock(BOTTOM)
		appendix:DockMargin(0, 0, 0, 5)
		appendix:SetFont("ixSmallFont")
		appendix:SizeToContents()
		appendix:SetTall(appendix:GetTall() + 15)
	end
end

function DFrameFixer(parent, bShouldNotPopup, bNoBackgroundBlur, bOverridePaint)
	if !bShouldNotPopup then
		parent:MakePopup()
	end

	if !bNoBackgroundBlur then
		parent:SetBackgroundBlur(true)
	end
    parent:SetDeleteOnClose(true)

	parent.PerformLayoutWindow = function(this)
		local titlePush = 0

		if (IsValid(this.imgIcon)) then

			this.imgIcon:SetPos(SScaleMin(5 / 3), SScaleMin(5 / 3))
			this.imgIcon:SetSize(SScaleMin(16 / 3), SScaleMin(16 / 3))
			titlePush = SScaleMin(16 / 3)
		end

		this.btnClose:SetPos(this:GetWide() - SScaleMin(31 / 3) - (0 - SScaleMin(4 / 3)), 0)
		this.btnClose:SetSize(SScaleMin(31 / 3), SScaleMin(24 / 3))

		this.btnMaxim:SetPos(this:GetWide() - SScaleMin(31 / 3) * 2 - (0 - SScaleMin(4 / 3)), 0)
		this.btnMaxim:SetSize(SScaleMin(31 / 3), SScaleMin(24 / 3))

		this.btnMinim:SetPos(this:GetWide() - SScaleMin(31 / 3) * 3 - (0 - SScaleMin(4 / 3)), 0)
		this.btnMinim:SetSize(SScaleMin(31 / 3), SScaleMin(24 / 3))

		this.lblTitle:SetPos(SScaleMin(8 / 3) + titlePush, SScaleMin(2 / 3))
		this.lblTitle:SetSize(this:GetWide() - SScaleMin(25 / 3) - titlePush, SScaleMin(20 / 3))
	end

	if (!bOverridePaint) then
		parent.Paint = function(this, w, h)
			if (this.m_bBackgroundBlur) then
				Derma_DrawBackgroundBlur(this, this.m_fCreateTime)
			end

			surface.SetDrawColor(Color(40, 40, 40, 100))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color(111, 111, 136, 255 / 100 * 30))
			surface.DrawOutlinedRect(0, 0, w, h)

			surface.DrawRect(0, 0, w, this.lblTitle:GetTall() + SScaleMin(5 / 3))

			return true
		end
	end

	parent.lblTitle:SetFont("MenuFontNoClamp")
	parent.lblTitle:SizeToContents()
end

function ix.hud.PopulateItemTooltip(tooltip, item, bShowcase)
	local labelName = item:GetData("labelName")
	local labelDesc = item:GetData("labelDescription")

	local name = tooltip:AddRow("name")
	name:SetImportant()
	name:SetText((labelName and ("\"" .. labelName .. "\"")) or (item.GetName and item:GetName()) or L(item.name))
	name:SetMaxWidth(math.max(name:GetMaxWidth(), ScrW() * 0.5))
	name:SizeToContents()

	local description = tooltip:AddRow("description")
	description:SetText(labelDesc and ("The label reads: \"" .. labelDesc .. "\"") or item:GetDescription() or "")
	description:SizeToContents()

	if item.invID or bShowcase then
		if (item.GetColorAppendix) then
			if (isfunction(item.GetColorAppendix) and istable(item:GetColorAppendix()) and item:GetColorAppendix() != false) then
				DrawAppendixTable(tooltip, item:GetColorAppendix())
			end
		end

		if (item.colorAppendix and istable(item.colorAppendix)) then
			DrawAppendixTable(tooltip, item.colorAppendix)
		end
	end

	if (item.PopulateTooltip) then
		item:PopulateTooltip(tooltip)
	end

	hook.Run("PopulateItemTooltip", tooltip, item)
end

function Derma_Query( strText, strTitle, ... )

	local Window = vgui.Create( "DFrame" )
	Window:SetTitle( strTitle or "Message Title (First Parameter)" )
	Window:SetDraggable( false )
	Window:ShowCloseButton( false )
	Window:SetDrawOnTop( true )
	DFrameFixer(Window)

	local InnerPanel = vgui.Create( "DPanel", Window )
	InnerPanel:SetPaintBackground( false )

	local Text = vgui.Create( "DLabel", InnerPanel )
	Text:SetText( strText or "Message Text (Second Parameter)" )
	Text:SetFont("MenuFontNoClamp")
	Text:SizeToContents()
	Text:SetContentAlignment( 5 )
	Text:SetTextColor( color_white )

	local ButtonPanel = vgui.Create( "DPanel", Window )
	ButtonPanel:SetTall( SScaleMin(30 / 3) )
	ButtonPanel:SetPaintBackground( false )

	-- Loop through all the options and create buttons for them.
	local NumOptions = 0
	local x = 5

	for k=1, 8, 2 do

		local Text = select( k, ... )
		if Text == nil then break end

		local Func = select( k+1, ... ) or function() end

		local Button = vgui.Create( "DButton", ButtonPanel )
		Button:SetText( Text )
		Button:SetFont("MenuFontNoClamp")
		Button:SizeToContents()
		Button:SetTall( SScaleMin(25 / 3) )
		Button:SetWide( Button:GetWide() + SScaleMin(20 / 3) )
		Button.DoClick = function() Window:Close() Func() end
		Button:SetPos( x, SScaleMin(5 / 3) )

		x = x + Button:GetWide() + SScaleMin(5 / 3)

		ButtonPanel:SetWide( x )
		NumOptions = NumOptions + 1

	end

	local w, h = Text:GetSize()

	w = math.max( w, ButtonPanel:GetWide() )

	Window:SetSize( w + SScaleMin(50 / 3), h + SScaleMin(25 / 3) + SScaleMin(45 / 3) + SScaleMin(10 / 3) )
	Window:Center()

	InnerPanel:StretchToParent( SScaleMin(5 / 3), SScaleMin(25 / 3), SScaleMin(5 / 3), SScaleMin(45 / 3) )

	Text:StretchToParent( SScaleMin(5 / 3), SScaleMin(5 / 3), SScaleMin(5 / 3), SScaleMin(5 / 3) )

	ButtonPanel:CenterHorizontal()
	ButtonPanel:AlignBottom( 8 )

	Window:DoModal()

	if ( NumOptions == 0 ) then

		Window:Close()
		Error( "Derma_Query: Created Query with no Options!?" )
		return nil

	end

	return Window

end

function Derma_StringRequest( strTitle, strText, strDefaultText, fnEnter, fnCancel, strButtonText, strButtonCancelText, fuckYouModal )

	local Window = vgui.Create( "DFrame" )
	Window:SetTitle( strTitle or "Message Title (First Parameter)" )
	Window:SetDraggable( false )
	Window:ShowCloseButton( false )
	Window:SetDrawOnTop( true )
	DFrameFixer(Window)

	local InnerPanel = vgui.Create( "DPanel", Window )
	InnerPanel:SetPaintBackground( false )

	local Text = vgui.Create( "DLabel", InnerPanel )
	Text:SetText( strText or "Message Text (Second Parameter)" )
	Text:SetFont("MenuFontNoClamp")
	Text:SizeToContents()
	Text:SetContentAlignment( 5 )
	Text:SetTextColor( color_white )

	local TextEntry = vgui.Create( "DTextEntry", InnerPanel )
	TextEntry:SetText( strDefaultText or "" )
	TextEntry:SetFont("MenuFontNoClamp")
	TextEntry.OnEnter = function() Window:Close() fnEnter( TextEntry:GetValue() ) end
	TextEntry:SetTall(Text:GetTall())

	local ButtonPanel = vgui.Create( "DPanel", Window )
	ButtonPanel:SetTall( SScaleMin(30 / 3) )
	ButtonPanel:SetPaintBackground( false )

	local Button = vgui.Create( "DButton", ButtonPanel )
	Button:SetText( strButtonText or "OK" )
	Button:SetFont("MenuFontNoClamp")
	Button:SizeToContents()
	Button:SetTall( SScaleMin(25 / 3) )
	Button:SetWide( Button:GetWide() + SScaleMin(20 / 3) )
	Button:SetPos( SScaleMin(5 / 3), SScaleMin(5 / 3) )
	Button.DoClick = function() Window:Close() fnEnter( TextEntry:GetValue() ) end

	local ButtonCancel = vgui.Create( "DButton", ButtonPanel )
	ButtonCancel:SetText( strButtonCancelText or "Cancel" )
	ButtonCancel:SetFont("MenuFontNoClamp")
	ButtonCancel:SizeToContents()
	ButtonCancel:SetTall( SScaleMin(25 / 3) )
	ButtonCancel:SetWide( Button:GetWide() + SScaleMin(20 / 3) )
	ButtonCancel:SetPos( SScaleMin(5 / 3), SScaleMin(5 / 3) )
	ButtonCancel.DoClick = function() Window:Close() if ( fnCancel ) then fnCancel( TextEntry:GetValue() ) end end
	ButtonCancel:MoveRightOf( Button, SScaleMin(5 / 3) )

	ButtonPanel:SetWide( Button:GetWide() + SScaleMin(5 / 3) + ButtonCancel:GetWide() + SScaleMin(10 / 3) )

	local w, h = Text:GetSize()
	w = math.max( w, SScaleMin(400 / 3) )

	Window:SetSize( w + SScaleMin(50 / 3), h + SScaleMin(25 / 3) + SScaleMin(75 / 3) + SScaleMin(10 / 3) )
	Window:Center()

	InnerPanel:StretchToParent( SScaleMin(5 / 3), SScaleMin(25 / 3), SScaleMin(5 / 3), SScaleMin(45 / 3) )

	Text:StretchToParent( SScaleMin(5 / 3), SScaleMin(5 / 3), SScaleMin(5 / 3), SScaleMin(35 / 3) )

	TextEntry:StretchToParent( SScaleMin(5 / 3), nil, SScaleMin(5 / 3), nil )
	TextEntry:AlignBottom( 5 )

	TextEntry:RequestFocus()
	TextEntry:SelectAllText( true )

	ButtonPanel:CenterHorizontal()
	ButtonPanel:AlignBottom( 8 )

	if !fuckYouModal then
		Window:DoModal()
	end

	return Window

end

function PLUGIN:StartChat()
	if IsValid(ix.gui.chat) then
		if (IsValid(self.disableAutoScroll)) then
			self.disableAutoScroll:Remove()
		end

		self.disableAutoScroll = vgui.Create("DButton")
		self.disableAutoScroll:SetText(ix.option.Get("disableAutoScrollChat", false) and "Enable Auto Scroll" or "Disable Auto Scroll")
		self.disableAutoScroll:SetFont("DebugFixedRadio")
		self.disableAutoScroll:SizeToContents()
		self.disableAutoScroll.Paint = nil

		self.disableAutoScroll.Think = function(this)
			if IsValid(ix.gui.chat) then
				if !ix.gui.chat.GetPos or !ix.gui.chat.GetWide then return end
				if !IsValid(self.disableAutoScroll) or (IsValid(self.disableAutoScroll) and !self.disableAutoScroll.GetWide) then return end
				local x, y = ix.gui.chat:GetPos()
				y = y - SScaleMin(20 / 3)

				x = x + ix.gui.chat:GetWide() - self.disableAutoScroll:GetWide()
				self.disableAutoScroll:SetPos(x, y)
			end
		end

		self.disableAutoScroll.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")

			if ix.option.Get("disableAutoScrollChat", false) then
				ix.option.Set("disableAutoScrollChat", false)
			else
				ix.option.Set("disableAutoScrollChat", true)
			end

			self.disableAutoScroll:SetText(ix.option.Get("disableAutoScrollChat", false) and "Enable Auto Scroll" or "Disable Auto Scroll")
			self.disableAutoScroll:SizeToContents()
		end
	end
end

function PLUGIN:FinishChat()
	if self.disableAutoScroll and IsValid(self.disableAutoScroll) then
		self.disableAutoScroll:Remove()
	end
end
