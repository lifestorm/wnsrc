--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Radio Base"
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

		local channel = ix.radio:FindByID(self:GetChannel())
		if (channel) then
			local chTip = tooltip:AddRowAfter("name", "channel")
			chTip:SetText("Channel: "..channel.name)
			chTip:SizeToContents()
		end
	end
end

function ITEM:GetChannel(bForce)
	if (bForce or self:GetData("enabled")) then
		return self.channel
	else
		return false
	end
end

function ITEM:OnRemoved()
	self:SetData("enabled", false)
	local owner = self:GetOwner()
	if (owner) then
		ix.radio:RemoveListenerFromChannel(owner, self:GetChannel(true))
	end
end

function ITEM:OnDestroyed(entity)
	self:SetData("enabled", false)
	if (IsValid(entity)) then
		ix.radio:RemoveStationaryFromChannel(self:GetChannel(true), entity)
	end
end

ITEM.functions.ToggleOn = {
	name = "Toggle On",
	OnRun = function(item)
		item:SetData("enabled", true)
		item.player:EmitSound("buttons/lever7.wav", 50, math.random(170, 180), 0.25)

		item:SetData("volume", 0, nil, false)

		if (!IsValid(item.entity)) then
			local owner = item:GetOwner()
			if (owner) then
				ix.radio:AddListenerToChannel(owner, item:GetChannel())
			end
		else
			ix.radio:AddStationaryToChannel(item:GetChannel(), item.entity)
		end

		return false
	end,
	OnCanRun = function(item)
		return item:GetData("enabled", false) == false
	end
}

ITEM.functions.ToggleOff = {
	name = "Toggle Off",
	OnRun = function(item)
		item:SetData("enabled", false)
		item.player:EmitSound("buttons/lever7.wav", 50, math.random(170, 180), 0.25)


		if (!IsValid(item.entity)) then
			local owner = item:GetOwner()
			if (owner) then
				ix.radio:RemoveListenerFromChannel(owner, item:GetChannel(true))
			end
		else
			ix.radio:RemoveStationaryFromChannel(item:GetChannel(true), item.entity)
		end

		return false
	end,
	OnCanRun = function(item)
		return item:GetData("enabled", false) == true
	end
}

ITEM.functions.VolumeDown = {
	name = "Volume Down",
	OnRun = function(item)
		item:SetData("volume", 0, nil, false)
		ix.radio:RemoveStationaryFromChannel(item:GetChannel(), item.entity)

		return false
	end,
	OnCanRun = function(item)
		return IsValid(item.entity) and item:GetData("volume", 0) == 1 and item:GetData("enabled")
	end
}

ITEM.functions.VolumeUp = {
	name = "Volume Up",
	OnRun = function(item)
		item:SetData("volume", 1, nil, false)
		ix.radio:AddStationaryToChannel(item:GetChannel(), item.entity)

		return false
	end,
	OnCanRun = function(item)
		return IsValid(item.entity) and item:GetData("volume", 0) == 0 and item:GetData("enabled")
	end
}
