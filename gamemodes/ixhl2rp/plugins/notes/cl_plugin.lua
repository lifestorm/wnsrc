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

function PLUGIN:F1MenuCreated(panel, mainFrame, leftFrame, rightFrame)
	local notes = vgui.Create("DButton", rightFrame)
	notes:SetFont("MenuFontNoClamp")
	notes:SetText("Personal Notes")
	notes:Dock(TOP)
	notes:DockMargin(0, 0, 0, 0 - SScaleMin(1 / 3))
	notes:SetSize(rightFrame:GetWide(), SScaleMin(30 / 3))
	notes.Paint = function(self, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 50))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(100, 100, 100, 150))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	notes.DoClick = function (btn)
		PLUGIN:CreateNotesTab()
	end

	mainFrame:SetTall(mainFrame:GetTall() + notes:GetTall())
end

function PLUGIN:CreateNotesTab(characterId, charNotes)
	local maxLen = ix.config.Get("notesMaxLen")
	local dataKey = "notes-"..string.gsub(game.GetIPAddress(), "%p", "").."-"..LocalPlayer():GetCharacter():GetID()

	local frame = vgui.Create("DFrame")
	frame:SetSize(ScrW() * 0.4, ScrH() * 0.4)
	frame:SetTitle(characterId != nil and "Admin Notes" or "Personal Notes")
	frame:Center()
	frame:MakePopup()

	local textEntry = vgui.Create("DTextEntry", frame)
	textEntry:Dock(FILL)
	textEntry:SetMultiline(true)

	textEntry.OnTextChanged = function(self)
		local txt = self:GetValue()
		local amt = string.utf8len(txt)

		if amt > maxLen then
			self:SetText(self.oldText)
			self:SetValue(self.oldText)
		else
			self.oldText = txt
		end
	end

	local text

	if (characterId != nil) then
		text = charNotes
	else
		text = ix.data.Get(dataKey, "", true, true)
	end

	if (!text) then
		frame:Remove()
		LocalPlayer():Notify("Unable to open character notes")

		return
	end
	
	textEntry:SetValue(text)

	local submitButton = vgui.Create("DButton", frame)
	submitButton:Dock(BOTTOM)
	submitButton:SetText("Submit")
	submitButton.DoClick = function(self)
		if (characterId) then
			netstream.Start("ixNotesSet", characterId, utf8.sub(textEntry:GetValue(), 1, maxLen))
		else
			ix.data.Set(dataKey, textEntry:GetValue(), true, true)

			LocalPlayer():Notify("Notes successfully saved.")
		end
	end
end

netstream.Hook("ixNotes", function(characterId, charNotes)
	PLUGIN:CreateNotesTab(characterId, charNotes)
end)
