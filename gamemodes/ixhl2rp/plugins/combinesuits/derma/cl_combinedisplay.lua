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

AccessorFunc(PANEL, "font", "Font", FORCE_STRING)
AccessorFunc(PANEL, "maxLines", "MaxLines", FORCE_NUMBER)

function PANEL:Init()
	if (IsValid(ix.gui.combine)) then
		ix.gui.combine:Remove()
	end

	self.lines = {}

	self:SetMaxLines(10)
	self:SetFont("DebugFixedRadio")

	self:SetPos(SScaleMin( 30 / 3 ), SScaleMin( 30 / 3 ))
	self:SetSize(ScrW(), self.maxLines * SScaleMin( 20 / 2 ))
	self:ParentToHUD()

	ix.gui.combine = self
end

-- Adds a line to the combine display. Set expireTime to 0 if it should never be removed.
function PANEL:AddLine(text, color, location, ...)
	self:ExpireLines()

	if (#self.lines >= self.maxLines) then
		for k, info in ipairs(self.lines) do
			if (info.expireTime != 0) then
				table.remove(self.lines, k)
				break
			end
		end
	end

	-- check for any phrases and replace the text
	if (text:utf8sub(1, 1) == "@") then
		text = L(text:utf8sub(2), ...)
	end

	if (location) then
		text = text.." at "..location
	end

	table.insert(self.lines, {
		text = "<:: " .. text .. "...",
		color = color or color_white,
		expireTime = CurTime() + 30,
		character = 1,
		font = "ImportantDisplayMessage"
	})
end

function PANEL:AddImportantLine(text, color, location, ...)
	self:ExpireLines()

	if (#self.lines >= self.maxLines) then
		for k, info in ipairs(self.lines) do
			if (info.expireTime != 0) then
				table.remove(self.lines, k)
				break
			end
		end
	end

	-- check for any phrases and replace the text
	if (text:utf8sub(1, 1) == "@") then
		text = L(text:utf8sub(2), ...)
	end

	if (location) then
		text = text.." at "..string.upper(location)
	end

	table.insert(self.lines, {
		text = "<:: " .. text .. "...",
		color = color or color_white,
		expireTime = CurTime() + 30,
		character = 1,
		important = true,
		font = "ImportantDisplayMessage"
	})

	if (!LocalPlayer().HasActiveCombineMask or !LocalPlayer().IsDispatch) then return end

	if (LocalPlayer():HasActiveCombineMask() or LocalPlayer():IsDispatch()) then
		surface.PlaySound("buttons/blip1.wav")
	end
end

function PANEL:ExpireLines()
	local curTime = CurTime()
	for i = #self.lines, 1, -1 do
		if (self.lines[i].expireTime != 0 and curTime >= self.lines[i].expireTime) then
			table.remove(self.lines, i)
			continue
		end
	end
end

function PANEL:Think()
	if (!IsValid(LocalPlayer())) then return end

	if (LocalPlayer():HasActiveCombineMask() or LocalPlayer():IsDispatch()) then
		local x, y = self:GetPos()
		y = ix.bar.newTotalHeight or y
		if (ix.option.Get("HUDPosition") != "Top Left") then
			y = SScaleMin(10 / 3)
		end

		self:SetPos(x, y)

		self:ExpireLines()
	end
end

function PANEL:Paint(width, height)
	if (!LocalPlayer():HasActiveCombineMask() and !LocalPlayer():IsDispatch()) then
		return
	end

	local y = 0

	surface.SetFont(self.font)

	if (ix.plugin.list.combineutilities) then
		local teams = ix.plugin.list.combineutilities.teams
		for k, v in SortedPairs(teams) do
			if (table.IsEmpty(v.members)) then continue end
			surface.SetFont("ImportantDisplayMessage")
			surface.SetTextColor(color_white)
			surface.SetTextPos(0, y)
			local owner = v.owner
			local members = {}
			for _, v1 in pairs(v.members) do
				if (v1 == owner) then continue end
				if (!IsValid(v1)) then continue end
				members[#members + 1] = v1:GetName()
			end
			table.sort(members)

			surface.DrawText(string.format("<:: PT-%d: %s%s; %s", k, IsValid(owner) and owner:GetName() or "no leader", IsValid(owner) and " (L)" or "", table.concat(members, ", ")))

			local textHeight = draw.GetFontHeight("ImportantDisplayMessage")
			y = y + textHeight + 5
		end
	end

	if (!ix.config.Get("suitsNoConnection")) then
		surface.SetFont("ImportantDisplayMessage")
		surface.SetTextColor(Schema.colors[GetNetVar("visorColor", "blue")] or color_white)
		surface.SetTextPos(0, y)
		surface.DrawText(string.upper("<:: CURRENT SOCIO-STATUS CODE: " .. GetNetVar("visorStatus", "blue")))

		local textHeight = draw.GetFontHeight("ImportantDisplayMessage")
		y = y + textHeight + 5
	end

	for _, info in ipairs(self.lines) do

		if (info.character < info.text:utf8len()) then
			info.character = info.character + 1
		end

		surface.SetFont(info.font)
		surface.SetTextColor(info.color)
		surface.SetTextPos(0, y)
		surface.DrawText(info.text:utf8sub(1, info.character))

		local textHeight = draw.GetFontHeight(info.font)
		y = y + textHeight + 5
	end

	surface.SetDrawColor(Color(0, 0, 0, 255))
end

vgui.Register("ixCombineDisplay", PANEL, "Panel")
