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

ITEM.name = "Cigarette"
ITEM.description = "A cigarette."
ITEM.model = Model("models/willardnetworks/cigarettes/cigarette.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.junkCleanTime = 120

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
        local length = self:GetData("length", 0)

        local panel = tooltip:AddRowAfter("name", "remaining tobacco")
        panel:SetBackgroundColor(derma.GetColor("Warning", tooltip))
        panel:SetText("Remaining Tobacco: "..(math.Round(math.Remap(length, 0, 1, 100, 0), 0)).."%")
        panel:SizeToContents()
	end

	function ITEM:PaintOver(item, w, h)
        local length = item:GetData("length", 0)
        surface.SetDrawColor(length >= 1 and (Color(255, 110, 110, 100)) or (length < 1 and length != 0 and Color(255, 193, 110, 100)) or (Color(110, 255, 110, 100)))
        surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
	end
end

function ITEM:GetModelFlexes()
	return {[0] = self:GetData("length", 0)}
end

function ITEM:CreateCigarette(client)
    if ( SERVER ) then
        PLUGIN:CreateCigarette(self, client)
    end
end

function ITEM:CheckIfModelAllowed(client)
    local faceIndex = client:FindBodygroupByName("face")

    if string.find(client:GetModel(), "models/willardnetworks/citizens/") then
        local headIndex = client:FindBodygroupByName("head")
        if client:GetBodygroup(faceIndex) == 1 or client:GetBodygroup(headIndex) == 4 then
            return false
        end
    end

    if string.find(client:GetModel(), "models/thomask_110/") then
        if client:GetBodygroup(faceIndex) == 3 or client:GetBodygroup(faceIndex) == 4 then
            return false
        end
    end

    if string.find(client:GetModel(), "models/willardnetworks/vortigaunt.mdl") and client:GetBodygroup(faceIndex) == 1 then
        return false
    end

    if string.find(client:GetModel(), "models/wn7new/metropolice/") and client:GetBodygroup(client:FindBodygroupByName("Cp_Head")) > 0 then
        return false
    end

    if string.find(client:GetModel(), "models/wn7new/metropolice_c8/") and client:GetBodygroup(client:FindBodygroupByName("Cp_Head")) > 0 then
        return false
    end

    for _, v in pairs(PLUGIN.allowedModels) do
        if string.find(client:GetModel(), v) then return true end
    end

    return false
end

function ITEM:OnCanRunSmoke()
    local client = self.player

    local length = self:GetData("length", 0)
    if length >= 1 then return false end
    if client and !self:CheckIfModelAllowed(client) then return false end
    if math.Round(math.Remap(length, 0, 1, 100, 0), 0) == 0 then return false end
    if self.entity then return false end
    if client and client.cigarette and IsValid(client.cigarette) then return false end
    if !self.cigaretteEnt then return true end

    return false
end

function ITEM:OnRunSmoke()
    local client = self.player
    if !client then return false end
    if (!client:Alive()) then return false end

    self:CreateCigarette(client)
    client:NotifyLocalized("You insert the cigarette into your mouth. Use a lighter to light it.")
end

function ITEM:OnRunStopSmoke(client, value, bRemove)
    client = client or self.player

    if !client then return false end
    if (!client:Alive()) then return false end

    if (value and !bRemove) then
        self:SetData("length", value)
    end

    if IsValid(self.cigaretteEnt) and IsEntity(self.cigaretteEnt) then
        if !value and !bRemove then
            local length = self.cigaretteEnt:GetFlexWeight(self.cigaretteEnt.flexIndexLength)
            self:SetData("length", length)
        end

        self.cigaretteEnt:Remove()
        client.cigarette = nil
    end

    self.cigaretteEnt = nil

    client:NotifyLocalized(self:GetData("length") == 1 and "You finish smoking the cigarette - all that is left is the cigarette butt." or "You have removed the cigarette from your mouth.")

    local itemID = self:GetID()
    if bRemove then
        self:Remove()
    end

    netstream.Start(client, "CigaretteSetClientEntity", itemID, nil, nil)
end

function ITEM:OnCanRunStopSmoke()
    local length = self:GetData("length", 0)
    if length >= 1 then return false end
    if math.Round(math.Remap(length, 0, 1, 100, 0), 0) == 0 then return false end
    if self.cigaretteEnt and IsEntity(self.cigaretteEnt) then return true end
    if self.player and !self:CheckIfModelAllowed(self.player) then return false end

    return false
end

function ITEM:SmokingFinished(client, value)
    self:OnRunStopSmoke(client, value, true)
end

function ITEM:OnTransferred(curInv, inventory)
    local client = self.player
    if client and client.cigarette and IsEntity(client.cigarette) and client.cigarette.cigaretteItem and client.cigarette.cigaretteItem == self then
        self:OnRunStopSmoke()
    end
end

ITEM.functions.smoke = {
    name = "Place in mouth",
	tip = "Place the cigarette in your mouth.",
	icon = "icon16/brick_add.png",
	OnRun = function(item)
        item:OnRunSmoke()

        return false
    end,

    OnCanRun = function(item)
        if item:OnCanRunSmoke() then return true end

        return false
    end
}

ITEM.functions.stopsmoke = {
    name = "Remove from mouth",
	tip = "Remove the cigarette from your mouth/unlight it.",
	icon = "icon16/brick_add.png",
	OnRun = function(item)
        item:OnRunStopSmoke()

        return false
    end,
    OnCanRun = function(item)
        if item:OnCanRunStopSmoke() then return true end

        return false
    end
}

if (CLIENT) then
    netstream.Hook("CigaretteSetClientEntity", function(itemID, entIndex, isLit)
        if itemID and ix.item.instances[itemID] then
            ix.item.instances[itemID].cigaretteEnt = entIndex or nil
        end

        LocalPlayer().cigarette = entIndex or nil

        if !LocalPlayer().cigarette then return end
        LocalPlayer().cigarette.isLit = isLit or nil
    end)
end