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

function PANEL:Init()
	self:SetSize(ScrW(), ScrH())
	self:SetAlpha(0)
	self:AlphaTo(255, 0.5, 0)
	self.Paint = function( self, w, h )
		surface.SetDrawColor(Color(63, 58, 115, 220))
		surface.DrawRect(0, 0, w, h)

		Derma_DrawBackgroundBlur( self, 1 )
	end

	self.content = self:Add("EditablePanel")
	self.content:SetSize(SScaleMin(400 / 3), SScaleMin(600 / 3))
	self.content:Center()
	self.content:MakePopup()
	Schema:AllowMessage(self.content)
	self.content.Paint = function(self, w, h)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	self.topbar = self.content:Add("Panel")
	self.topbar:SetSize(self.content:GetWide(), SScaleMin(50 / 3))
	self.topbar:Dock(TOP)
	self.topbar.Paint = function( self, w, h )
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	local titleText = self.topbar:Add("DLabel")
	titleText:SetFont("LargerTitlesFontNoClamp")
	titleText:Dock(LEFT)
	titleText:SetText("Civil Administration")
	titleText:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	titleText:SetContentAlignment(4)
	titleText:SizeToContents()

	local exit = self.topbar:Add("DImageButton")
	exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	exit:DockMargin(0, SScaleMin(15 / 3), SScaleMin(10 / 3), SScaleMin(15 / 3))
	exit:Dock(RIGHT)
	exit.DoClick = function()
		LocalPlayer().messagelist = nil
		self:Remove()
		surface.PlaySound("helix/ui/press.wav")
	end

	self:CreateInner()
end

local function PaintButton(self, w, h)
	surface.SetDrawColor(Color(0, 0, 0, 100))
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
	surface.DrawOutlinedRect(0, 0, w, h)
end

function PANEL:CreateBackButton()
	local divider = self.topbar:Add("DShape")
	divider:SetType("Rect")
	divider:Dock(RIGHT)
	divider:DockMargin(padding, padding, padding, padding)
	divider:SetWide(1)
	divider:SetColor(Color(111, 111, 136, (255 / 100 * 30)))

	local back = self.topbar:Add("DButton")
	back:Dock(RIGHT)
	back:SetText("BACK")
	back:SetFont("TitlesFontNoClamp")
	back.Paint = nil
	back:SizeToContents()
	back.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self:Remove()
		local panel = vgui.Create("ixCAPDA")
		panel:SetAlpha(255)
	end
end

function PANEL:CreateNewspaperButton()
	self.newspapers = self.innerContent:Add("DButton")
	self.newspapers:Dock(TOP)
	self.newspapers:SetTall(SScaleMin(50 / 3))
	self.newspapers:SetText("Union Newspapers")
	self.newspapers:SetFont("WNBleedingMinutesBoldNoClamp")
	self.newspapers:SetContentAlignment(4)
	self.newspapers:SetTextInset(SScaleMin(10 / 3), 0)
	self.newspapers.Paint = function(self, w, h)
		PaintButton(self, w, h)
	end
	
	self.newspapers:DockMargin(0, -1, 0, 0)

	self.newspapers.DoClick = function()
		self:CreateBackButton()
		surface.PlaySound("helix/ui/press.wav")
		self.innerContent:Clear()

		for k, v in pairs(self.storedNewspapers) do
			local newspaper = self.innerContent:Add("DButton")
			newspaper:Dock(TOP)
			newspaper:SetTall(SScaleMin(50 / 3))
			newspaper:SetText(v[3][1].columnTitle.." | "..v[3][1].columnSubtitle)
			newspaper:SetFont("WNBleedingMinutesBoldNoClamp")
			newspaper:SetContentAlignment(4)
			newspaper:SetTextInset(SScaleMin(10 / 3), 0)
			newspaper.Paint = function(self, w, h)
				PaintButton(self, w, h)
			end
			
			if k != 1 then
				newspaper:DockMargin(0, -1, 0, 0)
			end

			newspaper.DoClick = function()
				surface.PlaySound("helix/ui/press.wav")
				local areyousure = vgui.Create("Panel")
				areyousure:SetSize(SScaleMin(300 / 3), SScaleMin(100 / 3))
				areyousure:Center()
				areyousure:MakePopup()
				areyousure.Paint = function(self, w, h)
					PaintButton(self, w, h)
				end

				local label = areyousure:Add("DLabel")
				label:SetFont("WNBleedingMinutesBoldNoClamp")
				label:SetText("Remove stored newspaper?")
				label:SizeToContents()
				label:Dock(TOP)
				label:SetContentAlignment(5)

				local buttonpanel = areyousure:Add("Panel")
				buttonpanel:Dock(BOTTOM)
				buttonpanel:SetTall(SScaleMin(50 / 3))

				local yes = buttonpanel:Add("DButton")
				yes:Dock(LEFT)
				yes:SetWide((areyousure:GetWide() * 0.5) - SScaleMin(5 / 3))
				yes:SetText("Yes")
				yes:SetFont("MenuFontNoClamp")
				yes.Paint = function(self, w, h)
					PaintButton(self, w, h)
				end
				yes.DoClick = function()
					surface.PlaySound("helix/ui/press.wav")
					areyousure:Remove()
					newspaper:Remove()

					netstream.Start("RemoveStoredNewspaper", k)
				end

				local no = buttonpanel:Add("DButton")
				no:Dock(RIGHT)
				no:SetWide((areyousure:GetWide() * 0.5) - SScaleMin(5 / 3))
				no:SetText("No")
				no:SetFont("MenuFontNoClamp")
				no.Paint = function(self, w, h)
					PaintButton(self, w, h)
				end
				no.DoClick = function()
					surface.PlaySound("helix/ui/press.wav")
					areyousure:Remove()
				end
			end
		end
	end
end

function PANEL:CreateDoorAccessButton()
	self.doorAccess = self.innerContent:Add("DButton")
	self.doorAccess:Dock(TOP)
	self.doorAccess:SetTall(SScaleMin(50 / 3))
	self.doorAccess:SetText("Combine Doors")
	self.doorAccess:SetFont("WNBleedingMinutesBoldNoClamp")
	self.doorAccess:SetContentAlignment(4)
	self.doorAccess:SetTextInset(SScaleMin(10 / 3), 0)
	self.doorAccess.Paint = function(self, w, h)
		PaintButton(self, w, h)
	end
	
	self.doorAccess:DockMargin(0, -1, 0, 0)

	self.doorAccess.DoClick = function()
		self:CreateBackButton()
		surface.PlaySound("helix/ui/press.wav")
		self.innerContent:Clear()

		for k, v in ipairs(ents.GetAll()) do
			if (v:IsDoor()) then
				if (!v:HasSpawnFlags(256) and !v:HasSpawnFlags(1024) and v:GetNetVar("combineDoor")) then
					local name = v:GetNetVar("combineDoor")
					if name then
						local doorNameButton = self.innerContent:Add("DButton")
						doorNameButton:Dock(TOP)
						doorNameButton:SetText(name)
						doorNameButton:SetTall(SScaleMin(50 / 3))
						doorNameButton:SetFont("WNBleedingMinutesBoldNoClamp")
						doorNameButton:SetContentAlignment(4)
						doorNameButton:SetTextInset(padding, 0)
						doorNameButton.Paint = function(self, w, h)
							PaintButton(self, w, h)
						end

						doorNameButton.DoClick = function()
							Derma_StringRequest(
								"Grant Access",
								"Enter CID",
								"",
								function(enteredCid)
									for k2, v2 in pairs(ix.char.loaded) do
										if v2:GetCid() == enteredCid then
											netstream.Start("SetDoorAccessCID", v, k2)
											break
										end
									end
								end,

								nil
							)
						end
					end
				end
			end
		end
	end
end

function PANEL:CreateInner()
	self.innerContent = self.content:Add("DScrollPanel")
	self.innerContent:Dock(TOP)
	self.innerContent:SetTall(self.content:GetTall() - SScaleMin(50 / 3))

	self.barteringConfigs = self.innerContent:Add("DButton")
	self.barteringConfigs:Dock(TOP)
	self.barteringConfigs:SetTall(SScaleMin(50 / 3))
	self.barteringConfigs:SetText("Bartering")
	self.barteringConfigs:SetFont("WNBleedingMinutesBoldNoClamp")
	self.barteringConfigs:SetContentAlignment(4)
	self.barteringConfigs:SetTextInset(padding, 0)
	self.barteringConfigs.Paint = function(self, w, h)
		PaintButton(self, w, h)
	end
	
	self.barteringConfigs.DoClick = function()
		self:CreateBackButton()
		surface.PlaySound("helix/ui/press.wav")
		self.innerContent:Clear()

		local recipes = ix.recipe.stored
		local categories = {}
		for uniqueID, RECIPE in SortedPairs(recipes) do
			if RECIPE.cost and RECIPE.skill == "bartering" then
				if !table.HasValue(categories, RECIPE.category) then
					table.insert(categories, RECIPE.category)

					local priceMultiplier = self.innerContent:Add("DButton")
					priceMultiplier:Dock(TOP)
					priceMultiplier:SetText("Price Multiplier "..RECIPE.category)
					priceMultiplier:SetTall(SScaleMin(50 / 3))
					priceMultiplier:SetFont("WNBleedingMinutesBoldNoClamp")
					priceMultiplier:SetContentAlignment(4)
					priceMultiplier:SetTextInset(padding, 0)
					priceMultiplier.Paint = function(self, w, h)
						PaintButton(self, w, h)
					end

					priceMultiplier.DoClick = function()
						surface.PlaySound("helix/ui/press.wav")
						Derma_StringRequest(
							"Set Multiplier "..RECIPE.category,
							"Price multiplier "..RECIPE.category.." (1 decimal max, default is 1.0)",
							ix.config.Get("BarteringPriceMultiplier"..RECIPE.category),
							function(number)
								local toNumber = tonumber(number)
								if isnumber(toNumber) then
									local maxValue = ix.config.stored.BarteringPriceMultiplierClothing.data.data.max or 100
									local minValue = ix.config.stored.BarteringPriceMultiplierClothing.data.data.min or 0
									if (toNumber <= maxValue) and (toNumber >= minValue) then
										netstream.Start("ixBarteringPriceMultiplier", RECIPE.category, tonumber(number))
										LocalPlayer():NotifyLocalized("Set Bartering Price Multiplier "..RECIPE.category.." to "..number)
									else
										LocalPlayer():NotifyLocalized("Number needs to be below or equal to 100 and above or equal to 0")
									end
								end
							end,

							nil
						)
					end
				end
			end
		end
	end

	self.ration = self.innerContent:Add("DButton")
	self.ration:Dock(TOP)
	self.ration:SetTall(SScaleMin(50 / 3))
	self.ration:SetText("Rations")
	self.ration:SetFont("WNBleedingMinutesBoldNoClamp")
	self.ration:SetContentAlignment(4)
	self.ration:SetTextInset(padding, 0)
	self.ration.Paint = function(self, w, h)
		PaintButton(self, w, h)
	end
	
	self.ration:DockMargin(0, -1, 0, 0)

	self.ration.DoClick = function()
		self:CreateBackButton()
		surface.PlaySound("helix/ui/press.wav")
		self.innerContent:Clear()

		local rationInterval = self.innerContent:Add("DButton")
		rationInterval:Dock(TOP)
		rationInterval:SetTall(SScaleMin(50 / 3))
		rationInterval:SetText("Ration Interval")
		rationInterval:SetFont("WNBleedingMinutesBoldNoClamp")
		rationInterval:SetContentAlignment(4)
		rationInterval:SetTextInset(padding, 0)
		rationInterval.Paint = function(self, w, h)
			PaintButton(self, w, h)
		end

		rationInterval.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")
			Derma_StringRequest(
				"Set Ration Interval",
				"Set Ration Interval in hours (0 decimals, default is 4)",
				ix.config.Get("rationInterval"),
				function(number)
					local toNumber = tonumber(number)
					if isnumber(toNumber) then
						local maxValue = ix.config.stored.rationInterval.data.data.max or 10
						local minValue = ix.config.stored.rationInterval.data.data.min or 1
						if (toNumber <= maxValue) and (toNumber >= minValue) then
							netstream.Start("SetRationIntervalPDA", tonumber(number))
							LocalPlayer():NotifyLocalized("Set Ration Interval timer to "..number.. " hours")
						else
							LocalPlayer():NotifyLocalized("Number needs to be below or equal to 10 and above or equal to 1")
						end
					end
				end,
			nil)
		end
	end

	if istable(LocalPlayer().messagelist) then
		if !table.IsEmpty(LocalPlayer().messagelist) then
			self.messages = self.innerContent:Add("DButton")
			self.messages:Dock(TOP)
			self.messages:SetTall(SScaleMin(50 / 3))
			self.messages:SetText("Messages")
			self.messages:SetFont("WNBleedingMinutesBoldNoClamp")
			self.messages:SetContentAlignment(4)
			self.messages:SetTextInset(padding, 0)
			self.messages.Paint = function(self, w, h)
				PaintButton(self, w, h)
			end
			
			self.messages:DockMargin(0, -1, 0, 0)

			self.messages.DoClick = function()
				self:CreateBackButton()
				surface.PlaySound("helix/ui/press.wav")
				self.innerContent:Clear()

				local messagePanel = self.innerContent:Add("Panel")
				messagePanel:Dock(TOP)
				messagePanel:SetTall(self.innerContent:GetTall())

				for k, v in pairs(LocalPlayer().messagelist) do
					local message = messagePanel:Add("DButton")
					message:Dock(TOP)
					message:SetTall(SScaleMin(50 / 3))
					message:SetText(v["message_date"].." | "..string.utf8sub(v["message_poster"], 1, 18).." | #"..v["message_cid"])
					if v["message_reply"] then
						message:SetTextColor(Color(210, 255, 255, 255))
					else
						message:SetTextColor(Color(255, 205, 205, 255))
					end
					message:SetFont("WNBleedingMinutesBold")
					message:SetContentAlignment(4)
					message:SetTextInset(padding, 0)
					message.Paint = function(self, w, h)
						PaintButton(self, w, h)
					end
					
					if k != 1 then
						message:DockMargin(0, -1, 0, 0)
					end
					
					message.DoClick = function()
						messagePanel:Clear()

						surface.PlaySound("helix/ui/press.wav")

						local textEntry = messagePanel:Add("DTextEntry")
						textEntry:Dock(FILL)
						textEntry:SetTextColor(Color(200, 200, 200, 255))
						textEntry:SetMultiline( true )
						textEntry:SetEditable(false)
						textEntry:SetVerticalScrollbarEnabled( true )
						textEntry:SetCursorColor(Color(200, 200, 200, 255))
						textEntry:SetValue(v["message_text"])
						textEntry.Paint = function(self, w, h)
							surface.SetDrawColor(Color(0, 0, 0, 100))
							surface.DrawRect(0, 0, w, h)

							surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
							surface.DrawOutlinedRect(0, 0, w, h)

							self:DrawTextEntryText( self:GetTextColor(), self:GetHighlightColor(), self:GetCursorColor() )
						end

						local optionsPanel = messagePanel:Add("Panel")
						optionsPanel:Dock(BOTTOM)
						optionsPanel:SetSize(self.content:GetWide(), SScaleMin(50 / 3))

						local remove = optionsPanel:Add("DButton")
						remove:Dock(FILL)
						remove:SetText("REMOVE")
						remove:SetFont("WNBleedingMinutesBoldNoClamp")
						remove:SetContentAlignment(5)
						remove.Paint = function(self, w, h)
							PaintButton(self, w, h)
						end
						remove.DoClick = function()
							surface.PlaySound("helix/ui/press.wav")
							LocalPlayer().messagelist[k] = nil
							netstream.Start("RemoveCAMessage", v["message_id"])

							self.innerContent:Remove()
							self:CreateInner()
						end

						local sendReply = optionsPanel:Add("DButton")
						sendReply:Dock(RIGHT)
						sendReply:SetWide(optionsPanel:GetWide() * 0.5)
						if v["message_reply"] then
							sendReply:SetText("READ REPLY")
						else
							sendReply:SetText("REPLY")
						end
						sendReply:SetFont("WNBleedingMinutesBold")
						sendReply:SetContentAlignment(5)
						sendReply.Paint = function(self, w, h)
							PaintButton(self, w, h)
						end

						sendReply.DoClick = function()
							surface.PlaySound("helix/ui/press.wav")
							if v["message_reply"] then
								textEntry:SetValue(v["message_reply"])
								return
							end

							textEntry:SetEditable(true)
							sendReply:SetText("SEND REPLY")
							textEntry:SetValue("Write your reply here..")

							sendReply.DoClick = function()
								surface.PlaySound("helix/ui/press.wav")
								v["message_reply"] = textEntry:GetValue()
								netstream.Start("SetCAMessageReply", v["message_id"], textEntry:GetValue())
								self.innerContent:Remove()
								self:CreateInner()
							end
						end
					end
				end
			end
		end
	end

	self:CreateDoorAccessButton()
end

vgui.Register("ixCAPDA", PANEL, "EditablePanel")