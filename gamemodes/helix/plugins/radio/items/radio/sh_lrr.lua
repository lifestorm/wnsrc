--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Long-Range Radio"
ITEM.model = Model("models/props_lab/citizenradio.mdl")
ITEM.description = "A big powerful long-range radio allowing for communication across large distances - or through thick obstructions."

ITEM.height = 4
ITEM.width = 3

function ITEM:GetChannel(bForce)
	if (bForce or self:GetData("enabled")) then
		return self:GetData("channel", "freq_10")
	else
		return false
	end
end

function ITEM:OnInstanced()
	self:SetData("channel", "freq_11")
	self:UpdateChannel("10")
end

function ITEM:UpdateChannel(newFreq)
	local client = self:GetOwner()
	local oldChannel = client and self:GetChannel()
	self:SetData("channel", "freq_"..newFreq)

	if (client and self:GetChannel() != oldChannel) then
		ix.radio:RemoveListenerFromChannel(client, oldChannel)
		ix.radio:AddListenerToChannel(client, self:GetChannel())
	end
end

ITEM.functions.setRadioFrequency = {
    name = "Set Frequency",
    icon = "icon16/transmit.png",
    OnClick = function(item)
        local freq = item:GetChannel(true)
        local freqText = freq and string.match(freq, "^freq_(%d%d)$") or ""
        Derma_StringRequest("Select Frequency", "Please enter the frequency you wish to switch to:", freqText, function(text)
            local newFreq = tonumber(text)
            if (string.len(text) == 2 and newFreq and newFreq >= 10) then
                net.Start("ixInventoryAction")
                    net.WriteString("setRadioFrequency")
                    net.WriteUInt(item.id, 32)
                    net.WriteUInt(item.invID, 32)
                    net.WriteTable({text})
                net.SendToServer()
            elseif (IsValid (item.player)) then
                item.player:Notify("Please enter a frequency between 10 and 99")
            end
        end)

        return false
    end,
    OnRun = function(item, data)
		if (!data or !data[1]) then return false end
        local newFreq = tonumber(data[1])
        if (string.len(data[1]) != 2 or !newFreq or newFreq < 10) then return false end

        item:UpdateChannel(data[1])

		return false
	end,
	OnCanRun = function(item)
        if (IsValid(item.entity)) then return false end

		return true
	end
}