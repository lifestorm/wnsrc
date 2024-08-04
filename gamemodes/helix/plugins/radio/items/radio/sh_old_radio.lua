--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Ręcznie zrobione radio"
ITEM.model = Model("models/willardnetworks/skills/handheld_radio.mdl")
ITEM.description = "Ręcznie zmontowane radio, które wspiera tylko częstotliwość analogową."

function ITEM:OnInstanced()
	self:SetData("qt", {})
	self:UpdateChannel()
end

function ITEM:UpdateChannel()
	local client = self:GetOwner()
	local oldChannel = client and self:GetChannel()

	local channel = self:GetData("ch", 1)
	local qt = self:GetData("qt")
	self:SetData("channel", "freq_1_"..channel.."_"..(qt[channel] or channel))

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

ITEM.functions.channel = {
	name = "Ustaw kanał",
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
	name = "Ustaw QT",
	OnClick = function(item)
		local channel = item:GetData("ch", 1)
		local text = "QT Tone"

		local qt = item:GetData("qt")
		Derma_StringRequest(text, "Na jaką wartość chiałbyś ustawić "..text.."? 1-16", qt[channel] or channel,
		function(newQT)
			newQT = math.floor(tonumber(newQT))
			if (newQT < 1 or newQT > 16) then return end

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
		qt[item:GetData("ch", 1)] = data[1]
		item:SetData("qt", qt)
		item:UpdateChannel()

		return false
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity)
	end
}
