--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "ArcCW Magazine"
ITEM.model = "models/Items/BoxMRounds.mdl"
ITEM.description = "A magazine that contains %s %s."
ITEM.category = "Ammunition (New)"

ITEM.bullets = "stackable_bullets_assaultrifle" -- type of the ammo
ITEM.maxAmmo = 30 -- amount of the ammo

function ITEM:OnInstanced()
	if (!self:GetData("ammoRemaining")) then
		self:SetData("ammoRemaining", 0)
	end
end

function ITEM:GetAmmo()
	return math.Clamp(self:GetData("ammoRemaining", 0), 0, self.maxAmmo)
end

function ITEM:SetAmmo(ammo)
	self:SetData("ammoRemaining", math.Clamp(ammo, 0, self.maxAmmo))
end

function ITEM:GetDescription()
	local bullets = ix.item.list[self.bullets]
	return L(self.description, self:GetAmmo(), bullets and string.utf8lower(bullets.name) or "bullets")
end

function ITEM:GetColorAppendix()
	local bullets = ix.item.list[self.bullets]
    local info = {["green"] = string.format("This magazine can be loaded with %s.", bullets and string.utf8lower(bullets.name) or "bullets")}

    return info
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		draw.SimpleText(
			item:GetAmmo(), "DermaDefault", w - 5, h - 5,
			color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black
		)

		local bullets = ix.item.list[self.bullets]
		if (bullets and bullets.outlineColor) then
			surface.SetDrawColor(bullets.outlineColor)
			surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
		end
	end
end

ITEM.functions.combine = {
	OnRun = function(item, data)
        local other = ix.item.instances[data[1]]
		-- merging with a stack of bullets
		if (other.uniqueID == item.bullets) then
			if (other:GetStackSize() + item:GetAmmo() > item.maxAmmo) then
				local added = item.maxAmmo - item:GetAmmo()
				item:SetAmmo(item.maxAmmo)
				other:RemoveStack(added)
			else
				item:SetAmmo(item:GetAmmo() + other:GetStackSize())
				other:RemoveStack(other:GetStackSize())
			end
		end

		return false
	end,
	OnCanRun = function(item, data)
        if (item:GetAmmo() == item.maxAmmo) then return false end

		local other = ix.item.instances[data[1]]
        if (!other or other.uniqueID != item.bullets) then
            return false
        end
	end
}

ITEM.functions.unload = {
	name = "Unload Magazine",
	isMulti = true,
	multiOptions = function(item, player)
		local options = {{name = "1", data = {1}}}

        for i = 5, item:GetAmmo() - 1, 5 do
            options[#options + 1] = {name = tostring(i), data = {i}}
        end
		options[#options + 1] = {name = tostring(item:GetAmmo()), data = {item:GetAmmo()}}

        if (item:GetAmmo() > 1) then
            options[#options + 1] = {name = "other", data = {-1}, OnClick = function(itemTable)
                Derma_StringRequest("Unload Magazine", "How many bullets do you wish to unload?", LocalPlayer().ixLastBulletUnload or "", function(text)
                    local amount = tonumber(text)
                    if (!amount or amount <= 0 or amount >= itemTable:GetAmmo()) then return end

                    LocalPlayer().ixLastBulletUnload = amount

                    net.Start("ixInventoryAction")
                        net.WriteString("unload")
                        net.WriteUInt(itemTable.id, 32)
                        net.WriteUInt(itemTable.invID, 32)
                        net.WriteTable({amount})
                    net.SendToServer()
                end)

                return false
            end}
        end

        return options
	end,
	OnRun = function(item, data)
        local amount = tonumber(data and data[1] or item:GetAmmo())
        if (!amount or amount <= 0) then return false end
		amount = math.Clamp(math.floor(amount), 1, item:GetAmmo())

		item:SetAmmo(item:GetAmmo() - amount)
		local inventory = ix.item.inventories[item.invID]
		if (!inventory:Add(item.bullets, 1, {stack = amount, bIsSplit = true})) then
			ix.item.Spawn(uniqueID, item.player, function(itemT)
                itemT:SetStack(amount)
            end)
		end

		return false
	end,
	OnCanRun = function(item)
        if (IsValid(item.entity)) then return false end

        if (item:GetAmmo() == 0) then return false end

		local bullets = ix.item.list[item.bullets]
		if (!bullets) then return false end

		local inventory = ix.item.inventories[item.invID]
		if (!inventory) then return false end

		return !IsValid(item.entity) and inventory:FindEmptySlot(bullets.width, bullets.height) != nil
	end
}