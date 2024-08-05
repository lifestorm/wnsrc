--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- luacheck: globals SMUGGLER_BUY SMUGGLER_SELL SMUGGLER_BOTH SMUGGLER_WELCOME SMUGGLER_LEAVE SMUGGLER_NOTRADE SMUGGLER_PRICE
-- luacheck: globals SMUGGLER_STOCK SMUGGLER_MODE SMUGGLER_MAXSTOCK SMUGGLER_SELLANDBUY SMUGGLER_SELLONLY SMUGGLER_BUYONLY

local PLUGIN = PLUGIN

PLUGIN.name = "Smugglers"
PLUGIN.author = "Chessnut & Gr4Ss"
PLUGIN.description = "Adds NPC smugglers that can sell things. Heavily based on Chessnut's vendor plugin."

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Smugglers",
	MinAccess = "superadmin"
})

PLUGIN.cacheIDList = PLUGIN.cacheIDList or {}

SMUGGLER_BUY = 1
SMUGGLER_SELL = 2
SMUGGLER_BOTH = 3

-- Keys for smuggler messages.
SMUGGLER_WELCOME = 1
SMUGGLER_LEAVE = 2
SMUGGLER_NOTRADE = 3

-- Keys for item information.
SMUGGLER_PRICE = 1
SMUGGLER_STOCK = 2
SMUGGLER_MODE = 3
SMUGGLER_MAXSTOCK = 4

-- Sell and buy the item.
SMUGGLER_SELLANDBUY = 1
-- Only sell the item to the player.
SMUGGLER_SELLONLY = 2
-- Only buy the item from the player.
SMUGGLER_BUYONLY = 3

ix.util.Include("cl_plugin.lua")
ix.util.Include("cl_hooks.lua")
ix.util.Include("sh_items.lua")
ix.util.Include("sh_properties.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")

ix.config.Add("SmugglerMoveInterval", 2, "The amount of hours in between the smuggler moving.", nil, {
	data = {min = 0.1, max = 8, decimals = 1},
	category = "Smuggler"
})

ix.config.Add("SmugglerDefaultMoney", 800, "The amount of money a smuggler spawns with by default.", nil, {
	data = {min = 0, max = 2000},
	category = "Smuggler"
})

ix.config.Add("SmugglerPickupDelay", 45, "The amount of minutes until items are available for pickup.", nil, {
	data = {min = 1, max = 300},
	category = "Smuggler"
})

ix.config.Add("SmugglingSellExpScale", 1, "The scale smuggling experience for selling items based on the price of the item.", nil, {
	data = {min = 0.1, max = 10, decimals = 2},
	category = "Smuggler"
})

ix.config.Add("SmugglingBuyExpScale", 1, "The scale smuggling experience for buying items based on the price of the item.", nil, {
	data = {min = 0.1, max = 10, decimals = 2},
	category = "Smuggler"
})

ix.config.Add("SmugglingShowWaypoints", true, "Should player see exact location of the smuggling stashes?", nil, {
	category = "Smuggler"
})

ix.lang.AddTable("english", {
	smugglerNoSellItems = "There are no items to sell.",
	smugglerNoBuyItems = "There are no items to purchase.",
	smugglerSettings = "Smuggler Settings",
	smugglerUseMoney = "Smuggler should use money?",
	smugglerBoth = "Buy and Sell",
	smugglerBuy = "Buy Only",
	smugglerSell = "Sell Only",
	smugglerWelcome = "Welcome to my store, what can I get you today?",
	smugglerBye = "Come again soon!",
	smugglerEditor = "Smuggler Editor",
	smugglerEditCurStock = "Edit Current Stock",
	smugglerStockReq = "Enter the maximum amount of the item the smuggler can buy each time it spawns.",
	smugglerStockCurReq = "Enter how many items are available for purchase currently or the next time this smuggler spawns.",
	smugglerNoTrade = "This smuggler refuses to trade with you!",
	smugglerNoTrust = "This smuggler doesn't trust you enough yet to trade this item!",
	smugglerNoMoney = "This smuggler can not afford that item!",
	smugglerNoStock = "This smuggler does not have that item in stock. Order it for delivery instead!",
	smugglerNoItems = "This smuggler is not willing to sell you any items.",
	smugglerMaxStock = "This smuggler cannot carry any more of that item!",
	smugglerSelectPickupItem = "Select an item to retrieve:",
	smugglerPickupItem = "You have picked up a %s.",
	smugglerPickupNoSpace = "You do not have enough space for %s!",
	smugglerNoPickupItems = "There are no items available for pickup here!",
	smugglerSelectDelivery = "Select Delivery Location",
	smugglerDeliverTo = "Buy & Deliver to %s",
	smugglerPrepMove = "This smuggler is preparing to move, they will no longer start new trades.",
	smugglerAvailableDelivery = "Available only on order for delivery",
	smugglerAvailable = "Available to buy: %d",
	smugglerStock = "Smuggler can buy: %d\nYou have: %d",
	smugglerItemsDelivery = "Your items will be delivered to the pick-up point in %d minutes.",
	smugglerUniqueIDExists = "A pickup cache with this unique ID already exists!",
	smugglerStackSize = "Sold in stacks of %d.",
	smugglerDeliveryNotify = "You have some items to pick up! Find the marked stash",
	smugglerNeedAtLeast = "You need at least %d of this item to sell."
})

ix.lang.AddTable("spanish", {
	smugglerBye = "¡Vuelve pronto!",
	smugglerMaxStock = "¡El contrabandista no puede llevar más de ese objeto!",
	smugglerNoMoney = "¡El contrabandista no puede permitirse ese objeto!",
	smugglerPrepMove = "El contrabandista se está preparando para trasladarse, ya no iniciará nuevos intercambios.",
	smugglerEditCurStock = "Editar Actual Stock",
	smugglerStockCurReq = "Introduce cuántos objetos están disponibles para su compra al momento o la próxima vez que aparezca este contrabandista.",
	smugglerNoPickupItems = "¡No hay artículos disponibles que recoger aquí!",
	smugglerPickupItem = "Has recogido un %s.",
	smugglerNoTrust = "¡El contrabandista aún no confía lo suficiente en ti como para intercambiar este objeto!",
	smugglerWelcome = "Bienvenido a mi tienda, ¿qué puedo ofrecerte hoy?",
	smugglerBuy = "Solo Compra",
	smugglerNoTrade = "¡El contrabandista se niega a comerciar contigo!",
	smugglerStock = "Contrabandista puede comprar: %d\nTienes: %d",
	smugglerAvailable = "Disponible para comprar: %d",
	smugglerNoItems = "El contrabandista no está dispuesto a venderte ningún objeto.",
	smugglerSelectPickupItem = "Elige un objeto a recuperar:",
	smugglerDeliverTo = "Comprar y enviar a %s",
	smugglerNoSellItems = "No hay objetos para vender.",
	smugglerBoth = "Compra y Venta",
	smugglerUseMoney = "¿Debería el contrabandista usar dinero?",
	smugglerUniqueIDExists = "¡Ya existe un alijo de recogida con este ID único!",
	smugglerItemsDelivery = "Tus objetos serán entregados en el punto de recogida en %d minutos.",
	smugglerNoStock = "El contrabandista no tiene ese artículo en stock. ¡Pídelo para que te lo envíen!",
	smugglerPickupNoSpace = "¡No tienes espacio suficiente para %s!",
	smugglerSell = "Solo Venta",
	smugglerAvailableDelivery = "Disponible solo por pedido para su entrega",
	smugglerStockReq = "Introduce la cantidad máxima del objeto que el contrabandista puede comprar cada vez que aparezca.",
	smugglerNoBuyItems = "No hay objetos para comprar.",
	smugglerDeliveryNotify = "¡Tienes objetos que recoger! Encuentra el alijo marcado",
	smugglerStackSize = "Se vende en lotes de %d.",
	smugglerNeedAtLeast = "Necesitas al menos %d de este objeto para venderlo.",
	smugglerSelectDelivery = "Selecciona el lugar de entrega",
	smugglerEditor = "Editor del Contrabandista",
	smugglerSettings = "Configuración del contrabandista"
})

ix.char.RegisterVar("smugglingPickupItems", {
	default = {},
	bNoDisplay = true,
	field = "smugglingPickup",
	fieldType = ix.type.text,
	bNoNetworking = true,
	OnSet = function(character, itemID, locationID, amount)
		if (!itemID or !ix.item.list[itemID]) then
			return false
		end

		local items = character:GetSmugglingPickupItems()
		local location = items[locationID] or {}
		if (amount) then
			location[itemID] = math.max((location[itemID] or 0) + amount, 0)
			if (location[itemID] == 0) then
				location[itemID] = nil
			end
		else
			if (location[itemID] > 0) then
				location[itemID] = location[itemID] - 1

				if (location[itemID] == 0) then
					location[itemID] = nil
				end
			else
				return false
			end
		end

		if (!table.IsEmpty(location)) then
			items[locationID] = location
		else
			items[locationID] = nil
		end

		character.vars.smugglingPickupItems = items
	end,
	OnGet = function(character)
		return character.vars.smugglingPickupItems or {}
	end
})

ix.char.RegisterVar("smugglingPickupDelay", {
	default = {},
	bNoDisplay = true,
	field = "smugglingPickupDelay",
	fieldType = ix.type.text,
	bNoNetworking = true,
	OnSet = function(character, itemID, locationID, offset)
		if (!itemID or !ix.item.list[itemID]) then
			return
		end

		local items = character:GetSmugglingPickupDelay()

		local time = os.time() + ix.config.Get("SmugglerPickupDelay") * 60 * offset
		items[#items + 1] = {time, itemID, locationID}

		character.vars.smugglingPickupDelay = items
		character:SetSmugglingNextPickup(time)
	end,
	OnGet = function(character)
		return character.vars.smugglingPickupDelay or {}
	end
})

ix.char.RegisterVar("smugglingNextPickup", {
	default = 0,
	bNoDisplay = true,
	isLocal = true
})

ix.command.Add("SmugglerForceRotate", {
	description = "Forcefully rotates the current smuggler to a new one.",
	superAdminOnly = true,
	OnRun = function(self, client)
		PLUGIN:RotateActiveSmuggler()
	end
})

ix.command.Add("CheckPlayerSmugglerPickupItems", {
	description = "Prints out data about smuggler items for specific player.",
	adminOnly = true,
	arguments = {
		ix.type.character,
	},	
	OnRun = function(self, client, character)
		client:ChatPrint(character:GetName() .. "'s Pickup Items:")

		for k, v in pairs(character:GetSmugglingPickupItems()) do
			for key, val in pairs(v) do 
				client:ChatPrint(character:GetName() .. ": [" .. key .. "] - with amount of " .. val .. " is stored in crate with ID: " .. k)
			end 
		end
		client:ChatPrint(character:GetName() .. "'s Pickup Delay:")
		for k, v in ipairs(character:GetSmugglingPickupDelay()) do
			local delay = v[1] - os.time() 
            delay = math.Round(delay / 60)
            if (delay % 5 != 0) then
                delay = delay - (delay % 5) + 5
            end
			client:ChatPrint(character:GetName() .. ": ".. "Item["..v[2].."] - ".. delay .. " minutes until arriving to cache with ID: " .. v[3])
		end
	end
})

function PLUGIN:PhysgunPickup(client, entity)
	if (entity:GetClass() == "ix_smuggler" or entity:GetClass() == "ix_pickupcache") then
		return CAMI.PlayerHasAccess(client, "Helix - Manage Smugglers")
	end
end

function PLUGIN:InitializedPlugins()
	for uniqueID, data in pairs(self.itemList) do
		local item = ix.item.list[uniqueID]
		if (!item) then
			ErrorNoHalt("[SMUGGLER] Attempted to add unknown item '"..uniqueID.."'.")
			self.itemList[uniqueID] = nil
			continue
		end

		if (!data.buy and !data.sell) then
			ErrorNoHalt("[SMUGGLER] Attempted to add item '"..uniqueID.."' without buy or sell price.")
			self.itemList[uniqueID] = nil
			continue
		end

		ix.action:RegisterSkillAction("smuggling", "recipe_smuggling_"..uniqueID, {
			name = item.name,
			data = data,
			itemID = uniqueID,
			bNoLog = true,
			description = "Allows you to buy and sell the '"..item.name.."' item via the smuggling network.",
			CanDo = data.level or 0,
			DoResult = function(action, character, skillLevel, bIsSelling)
				if (skillLevel < action.CanDo) then return 0 end

				-- set to selling if not specified to use sell exp as default exp
				if (bIsSelling == nil) then bIsSelling = self.itemList[action.itemID].sell != nil end

				local exp
				if (bIsSelling != false and self.itemList[action.itemID]) then
					exp = self.itemList[action.itemID].sellExp or self.itemList[action.itemID].sell
				elseif (bIsSelling == false and self.itemList[action.itemID]) then
					exp = self.itemList[action.itemID].buyExp or self.itemList[action.itemID].buy
				end

				if (!exp) then return 0 end

				if (bIsSelling != false) then
					exp = exp * ix.config.Get("SmugglingSellExpScale")
				else
					exp = exp * ix.config.Get("SmugglingBuyExpScale")
				end

				return exp
			end}
		)

		local RECIPE = ix.recipe:New()
		RECIPE.uniqueID = "smuggling_"..uniqueID
		RECIPE.name = item.name
		RECIPE.description = "Allows you to buy and sell the '"..item.name.."' item via the smuggling network."
		RECIPE.model = item.model
		RECIPE.category = data.cat or item.category
		RECIPE.hidden = false
		RECIPE.skill = "smuggling"
		RECIPE.level = data.level or 0
		RECIPE.cost = data.sell or "N/A"
		RECIPE.buyPrice = data.buy or "N/A"
		RECIPE.result = {[uniqueID] = 1}
		RECIPE.bNoAction = true
		RECIPE.costIcon = "willardnetworks/tabmenu/charmenu/chips.png"

		RECIPE:Register()
	end

	if (SERVER) then
		timer.Create("ixSmugglerRotation", 300, 0, function()
			if (!self.nextRotation) then return end
			if (self.nextRotation < os.time()) then
				self:RotateActiveSmuggler()
			elseif (self.nextRotation < os.time() + 300) then
				self:PreRotateActiveSmuggler()
			end
		end)
	end
end
