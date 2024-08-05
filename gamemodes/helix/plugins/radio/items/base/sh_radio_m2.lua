--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Radio (M2) Base"
ITEM.model = Model("models/props_lab/citizenradio.mdl")
ITEM.description = "A big powerful long-range radio allowing for communication across large distances - or through thick obstructions."

ITEM.isRadio = true

ITEM.category = "Radio"
ITEM.height = 4
ITEM.width = 4

ITEM.maxFrequencies = 3

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
        if (item:GetData("enabled")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end

	function ITEM:PopulateTooltip(tooltip)
        if (self:GetData("enabled")) then
			local name = tooltip:GetRow("name")
			name:SetBackgroundColor(derma.GetColor("Success", tooltip))
		end

		local channels = self:GetChannels()
		if (channels) then
			local channelNames = {}
			for k, v in ipairs(channels) do
				if (ix.radio:FindByID(v)) then
					channelNames[#channelNames + 1] = ix.radio:FindByID(v).name
				end
			end

			local chTip = tooltip:AddRowAfter("name", "channel")
			chTip:SetText("Channels: "..table.concat(channelNames, ", "))
			chTip:SizeToContents()
		end
	end
end

function ITEM:GetChannels(bForce)
    if (bForce or self:GetData("enabled")) then
		return self:GetData("channels", {})
	else
		return {}
	end
end

function ITEM:OnRemoved()
    self:SetData("enabled", false)
	local owner = self:GetOwner()
	if (owner) then
		for _, v in ipairs(self:GetChannels(true)) do
			ix.radio:RemoveListenerFromChannel(owner, v)
		end
	end
end

function ITEM:OnDestroyed(entity)
	self:SetData("enabled", false)
end

ITEM.functions.setRadioFrequency = {
    name = "Set Frequency",
    icon = "icon16/transmit.png",
    isMulti = true,
    multiOptions = function(item, player)
        local options = {}
		for i = 1, item.maxFrequencies do
			options[i] = {name = "Freq "..i, OnClick = function(itemTbl)
                local freq = itemTbl:GetData("channels", {})[i]
                local freqText = freq and string.match(freq, "^freq_(%d%d%d)$") or ""
                Derma_StringRequest("Select Frequency", "Please enter the frequency you wish to switch to:", freqText, function(text)
                    local newFreq = tonumber(text)
                    if (string.len(text) == 2 and newFreq and newFreq >= 10) then
                        net.Start("ixInventoryAction")
                            net.WriteString("setRadioFrequency")
                            net.WriteUInt(itemTbl.id, 32)
                            net.WriteUInt(itemTbl.invID, 32)
                            net.WriteTable({i, text})
                        net.SendToServer()
                    else
                        player:Notify("Please enter a frequency between 100 and 999")
                    end
                end, nil, "Set", "Cancel")
                return false
            end}
		end

        return options
    end,
    OnRun = function(item, data)
		if (!data or !data[1]) then return false end
        if (data[1] < 1 or data[1] > item.maxFrequencies) then return false end
        local newFreq = tonumber(data[2])
        if (string.len(data[2]) != 2 or !newFreq or newFreq < 10) then return false end

        local channels = item:GetData("channels", {})
        local oldFreq = channels[data[1]]
        channels[data[1]] = "freq_"..data[2]
        item:SetData("channels", channels)

        if (oldFreq) then
			ix.radio:RemoveListenerFromChannel(item:GetOwner(), oldFreq)
		end
        ix.radio:AddListenerToChannel(item:GetOwner(), channels[data[1]])

		return false
	end,
	OnCanRun = function(item)
        if (IsValid(item.entity)) then return false end

		return true
	end
}

ITEM.functions.setRadioOn = {
	name = "Toggle Radio On",
	icon = "icon16/connect.png",
	OnRun = function(item)
		item:SetData("enabled", true)
		item.player:EmitSound("buttons/lever7.wav", 50, math.random(170, 180), 0.25)

		local owner = item:GetOwner()
		if (owner) then
			for _, v in ipairs(item:GetChannels()) do
				ix.radio:AddListenerToChannel(owner, v)
			end
		end

		return false
	end,
	OnCanRun = function(item)
		return item:GetData("enabled", false) == false
	end
}

ITEM.functions.setRadioOff = {
	name = "Toggle Radio Off",
	icon = "icon16/disconnect.png",
	OnRun = function(item)
		item:SetData("enabled", false)
		item.player:EmitSound("buttons/lever7.wav", 50, math.random(170, 180), 0.25)

		local owner = item:GetOwner()
		if (owner) then
			for _, v in ipairs(item:GetChannels(true)) do
				ix.radio:RemoveListenerFromChannel(owner, v)
			end
		end

		return false
	end,
	OnCanRun = function(item)
		return item:GetData("enabled", false) == true
	end
}

function ITEM:OnInstanced()
	local tbl = {"freq_10"}
	if (self.maxFrequencies > 1) then
		for i = 1, self.maxFrequencies - 1 do
			tbl[#tbl + 1] = "freq_1"..i
		end
	end
    self:SetData("channels", tbl)
end
