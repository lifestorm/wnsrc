--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Radio (M) Base"
ITEM.category = "Radio"
ITEM.model = Model("models/deadbodies/dead_male_civilian_radio.mdl")
ITEM.description = "A shiny handheld radio with a frequency tuner."

ITEM.isRadio = true

-- Inventory drawing
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
	return {}
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

ITEM.functions.ToggleOn = {
	name = "Toggle Radio On",
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

ITEM.functions.ToggleOff = {
	name = "Toggle Radio Off",
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
