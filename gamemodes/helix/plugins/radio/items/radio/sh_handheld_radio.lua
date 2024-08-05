--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Handheld Radio"
ITEM.model = Model("models/willardnetworks/skills/handheld_radio.mdl")
ITEM.description = "A properly made handheld radio supporting analog and digital frequencies."

function ITEM:OnInstanced()
	self:SetData("qt", {{}, {}, {}})
	self:UpdateChannel()
end

function ITEM:UpdateChannel()
	local client = self:GetOwner()
	local oldChannel = client and self:GetChannel()

	local zone, channel = self:GetData("zone", 1), self:GetData("ch", 1)
	local qt = self:GetData("qt")
	self:SetData("channel", "freq_"..zone.."_"..channel.."_"..(qt[zone][channel] or channel))

	if (client and self:GetChannel() != oldChannel) then
		ix.radio:RemoveListenerFromChannel(client, oldChannel)
		ix.radio:AddListenerToChannel(client, self:GetChannel())
	end
end

function ITEM:GetChannel(bForce)
	if (bForce or self:GetData("enabled")) then
		return self:GetData("channel")
	else
		return false
	end
end

ITEM.functions.zone = {
	name = "Set Zone",
	isMulti = true,
	multiOptions = function(item, player)
		local zones = {}
		for i = 1, 3 do
			zones[i] = {name = i, data = {i}}
		end

		return zones
	end,
	OnRun = function(item, data)
		item:SetData("zone", data[1])
		item:UpdateChannel()

		return false
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity)
	end
}

ITEM.functions.channel = {
	name = "Set Channel",
	isMulti = true,
	multiOptions = function(item, player)
		local channels = {}
		for i = 1, 16 do
			channels[i] = {name = i, data = {i}}
		end

		return channels
	end,
	OnRun = function(item, data)
		item:SetData("ch", data[1])
		item:UpdateChannel()

		return false
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity)
	end
}

ITEM.functions.qt = {
	name = "Set QT/DQT",
	OnClick = function(item)
		local zone, channel = item:GetData("zone", 1), item:GetData("ch", 1)
		local max = zone == 1 and 16 or 99
		local text = zone == 1 and "QT Tone" or "DQT Code"

		local qt = item:GetData("qt")
		Derma_StringRequest(text, "What would you like to set the "..text.." to? 1-"..max, qt[zone][channel] or channel,
		function(newQT)
			newQT = math.floor(tonumber(newQT))
			if (newQT < 1 or newQT > max) then return end

			net.Start("ixInventoryAction")
				net.WriteString("qt")
				net.WriteUInt(item.id, 32)
				net.WriteUInt(item.invID, 32)
				net.WriteTable({newQT})
			net.SendToServer()
		end)
	end,
	OnRun = function(item, data)
		local qt = item:GetData("qt")
		qt[item:GetData("zone", 1)][item:GetData("ch", 1)] = data[1]
		item:SetData("qt", qt)
		item:UpdateChannel()

		return false
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity)
	end
}
