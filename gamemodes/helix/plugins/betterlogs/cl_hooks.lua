--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local CAMI = CAMI
local LocalPlayer = LocalPlayer
local CurTime = CurTime
local table = table
local os = os
local pairs = pairs
local draw = draw
local Color = Color
local netstream = netstream
local IsValid = IsValid

local PLUGIN = PLUGIN

PLUGIN.marks = {}

function PLUGIN:CreateMenuButtons(tabs)
	if (CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Manage Logs", nil)) then
		tabs["Logs"] = {
			RowNumber = 8,
			Width = 23,
			Height = 17,
			Right = true,
			Icon = "willardnetworks/tabmenu/charmenu/licenses.png",
			Create = function(info, container)
				local panel = container:Add("ixLogs")
				ix.gui.logs = panel
			end
		}
	end
end

function PLUGIN:LogMark(pos, record)
	local curTime = CurTime()
	table.insert(self.marks, {
		fadeTime = curTime + 120,
		text = "["..os.date("%d/%m/%y %X", record.datetime).."] "..record.text,
		pos = pos
	})
end

function PLUGIN:HUDPaint()
	if (self.marks) then
		local curTime = CurTime()

		for _, v in pairs(self.marks) do
			if (v.fadeTime > curTime) then
				local pos = v.pos:ToScreen()
				draw.SimpleTextOutlined(v.text, "DermaDefault", pos.x, pos.y, Color(255, 255, 255), TEXT_ALIGN_CENTER, nil, 1, Color(0, 0, 0))
			else
				table.remove(v)
			end
		end
	end
end

netstream.Hook("ixSendLogTypes", function(logTypes)
	if (IsValid(ix.gui.logs)) then
		ix.gui.logs.requestedLogTypes = logTypes
		ix.gui.logs:Rebuild()
	end
end)

netstream.Hook("ixSendLogs", function(logs)
	if (IsValid(ix.gui.logs)) then
		ix.gui.logs.requestedLogs = logs
		ix.gui.logs:FillLogs(true)
	end
end)
