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

ITEM.name = "Su Şişesi"
ITEM.model = "models/props_junk/garbage_plasticbottle002a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "Yeniden doldurulabilir bir plastik şişe. Suyla doldurabilirsiniz."
ITEM.category = "Food"
ITEM.maxDurability = 25
ITEM.base = "base_tools"

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
        local water = self:GetData("water", 0)
		local filtrated = self:GetData("filtrated", false) and "YES" or "NO"

        local panel = tooltip:AddRowAfter("name", "remaining tobacco")
        panel:SetBackgroundColor(derma.GetColor("Warning", tooltip))
        panel:SetText("Remaining Water: "..water.."%")
        panel:SizeToContents()

        local panel2 = tooltip:AddRowAfter("remaining tobacco", "filtrated")
        panel2:SetBackgroundColor(Color(100, 100, 100, 255))
        panel2:SetText("Filtrated: "..filtrated)
        panel2:SizeToContents()
	end
end

ITEM.functions.drink = {
	name = "Su İç",
	tip = "applyTip",
	icon = "icon16/drink.png",
	OnRun = function(item)
		if (SERVER) then
			local client = item.player
			PLUGIN:RequestDrinkWater(client, item)
		end

		return false
	end
}

ITEM.functions.drinkquench = {
	name = "Yeterli Miktarda İç",
	icon = "icon16/drink.png",
	OnRun = function(item)
		if (SERVER) then
			local client = item.player
			local thirst = math.Round(client:GetCharacter():GetThirst())

			if (!PLUGIN:CanDrinkWater(client, item)) then return false end
			if (thirst <= 1) then return false end

			local water = item:GetData("water", 0)

			if (water < thirst) then
				thirst = water
			end

			PLUGIN:DrinkWater(client, item:GetID(), thirst)
		end

		return false
	end
}

ITEM.functions.fill = {
	name = "Doldur",
	tip = "applyTip",
	icon = "icon16/arrow_in.png",
	OnRun = function(item)
		if (SERVER) then
			local client = item.player
			PLUGIN:FillEmptyWaterCannister(client, item)
		end

		return false
	end
}

ITEM.functions.empty = {
	name = "Tüm Suyu Boşalt",
	tip = "applyTip",
	icon = "icon16/cancel.png",
	OnRun = function(item)
		if (SERVER) then
			local client = item.player
			PLUGIN:EmptyWaterCannister(client, item)
		end

		return false
	end
}

ITEM.functions.filtrate = {
	name = "Filtrele",
	tip = "applyTip",
	icon = "icon16/shading.png",
	OnRun = function(item)
		if (SERVER) then
			local client = item.player
			PLUGIN:FiltrateWater(client, item)
		end

		return false
	end
}

ITEM.functions.fillcan = {
	name = "Boş Kutuyu Doldur",
	tip = "applyTip",
	icon = "icon16/shading.png",
	OnRun = function(item)
		local target = ix.item.list["drink_breen_water"]
		local client = item.player
		local character = client:GetCharacter()
		local emptyCan = character:GetInventory():HasItem("junk_empty_can")

		emptyCan:Remove()
		character:GetInventory():Add("drink_breen_water")
		item:SetData("water", item:GetData("water", 0) - target.thirst)
		return false
	end,
	OnCanRun = function(item)
		local target = ix.item.list["drink_breen_water"]
		if (!target or !target.thirst) then return false end

		if (!item:GetData("filtrated", false) or item:GetData("water", 0) < target.thirst) then return false end

		local client = item.player
		if (!IsValid(client)) then return false end

		local character = client:GetCharacter()
		if (!character) then return false end

		local emptyCan = character:GetInventory():HasItem("junk_empty_can")
		if (!emptyCan) then
			return false
		end

		return true
	end
}