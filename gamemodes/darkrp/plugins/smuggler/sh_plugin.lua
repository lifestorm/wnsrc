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

ix.config.Add("SmugglerMoveInterval", 2, "Le nombre d’heures entre le passage du contrebandier.", nil, {
	data = {min = 0.1, max = 8, decimals = 1},
	category = "Contrebandier"
})

ix.config.Add("SmugglerDefaultMoney", 800, "Le montant d’argent qu’un contrebandier génère par défaut.", nil, {
	data = {min = 0, max = 2000},
	category = "Contrebandier"
})

ix.config.Add("SmugglerPickupDelay", 45, "Nombre de minutes avant que les articles soient disponibles pour le ramassage.", nil, {
	data = {min = 1, max = 300},
	category = "Contrebandier"
})

ix.config.Add("SmugglingSellExpScale", 1, "L’expérience de la contrebande d’échelle pour vendre des articles en fonction du prix de l’article.", nil, {
	data = {min = 0.1, max = 10, decimals = 2},
	category = "Contrebandier"
})

ix.config.Add("SmugglingBuyExpScale", 1, "L’expérience de la contrebande d’échelle pour acheter des articles en fonction du prix de l’article.", nil, {
	data = {min = 0.1, max = 10, decimals = 2},
	category = "Contrebandier"
})

ix.config.Add("SmugglingShowWaypoints", true, "Le joueur devrait-il voir l’emplacement exact des cachettes de contrebande?", nil, {
	category = "Contrebandier"
})

ix.lang.AddTable("english", {
	smugglerNoSellItems = "Il n'y a aucun article à vendre.",
	smugglerNoBuyItems = "Il n'y a aucun article à acheter.",
	smugglerSettings = "Paramètres de contrebandier",
	smugglerUseMoney = "Le contrebandier devrait utiliser de l'argent?",
	smugglerBoth = "Acheter et vendre",
	smugglerBuy = "Achat uniquement",
	smugglerSell = "Vente uniquement",
	smugglerWelcome = "Bienvenue chez moi mon gamin, que puis-je t'offrir aujourd'hui ?",
	smugglerBye = "Mouais, tu reviendra j'espère!",
	smugglerEditor = "Éditeur contrebandier",
	smugglerEditCurStock = "Modifier le stock actuel",
	smugglerStockReq = "Entrez le montant maximum de l'objet que le contrebandier peut acheter à chaque fois qu'il apparaît.",
	smugglerStockCurReq = "Entrez le nombre d'articles disponibles à l'achat actuellement ou la prochaine fois que ce contrebandier apparaîtra.",
	smugglerNoTrade = "Ce contrebandier refuse de commercer avec vous!",
	smugglerNoTrust = "Ce contrebandier ne vous fait pas encore assez confiance pour échanger cet objet!",
	smugglerNoMoney = "Ce contrebandier ne peut pas se permettre cet objet!",
	smugglerNoStock = "Ce contrebandier n'a pas cet objet en stock. Commandez-le plutôt pour vous le faire livrez!",
	smugglerNoItems = "Ce contrebandier n'a pas envi de vous vendre des objets.",
	smugglerMaxStock = "Ce contrebandier ne peut plus transporter plus d'objet de ce genre!",
	smugglerSelectPickupItem = "Sélectionnez un élément à récupérer:",
	smugglerPickupItem = "Vous avez ramassé un %s.",
	smugglerPickupNoSpace = "Vous n'avez pas assez d'espace pour %s !",
	smugglerNoPickupItems = "Il n'y a pas d'articles disponibles pour le ramassage ici !",
	smugglerSelectDelivery = "Sélectionnez le lieu de livraison",
	smugglerDeliverTo = "Acheter et livrer à %s",
	smugglerPrepMove = "Ce contrebandier va bientôt partir, il ne fera plus de trocs.",
	smugglerAvailableDelivery = "Disponible uniquement sur commande pour livraison",
	smugglerAvailable = "Disponible à l'achat : %d",
	smugglerStock = "Le contrebandier peut acheter : %d\nVous avez : %d",
	smugglerItemsDelivery = "Vos articles seront livrés au point relais dans %d minutes.",
	smugglerUniqueIDExists = "Un cache avec cet ID unique existe déjà!",
	smugglerStackSize = "Vendu en lots de %d.",
	smugglerDeliveryNotify = "Vous avez des objets à récupérer ! Trouvez la cache marquée",
	smugglerNeedAtLeast = "Vous avez besoin d'au moins %d de cet article pour vendre."
})

ix.lang.AddTable("french", {
	smugglerNoSellItems = "Il n'y a aucun article à vendre.",
	smugglerNoBuyItems = "Il n'y a aucun article à acheter.",
	smugglerSettings = "Paramètres de contrebandier",
	smugglerUseMoney = "Le contrebandier devrait utiliser de l'argent?",
	smugglerBoth = "Acheter et vendre",
	smugglerBuy = "Achat uniquement",
	smugglerSell = "Vente uniquement",
	smugglerWelcome = "Bienvenue chez moi mon gamin, que puis-je t'offrir aujourd'hui ?",
	smugglerBye = "Mouais, tu reviendra j'espère!",
	smugglerEditor = "Éditeur contrebandier",
	smugglerEditCurStock = "Modifier le stock actuel",
	smugglerStockReq = "Entrez le montant maximum de l'objet que le contrebandier peut acheter à chaque fois qu'il apparaît.",
	smugglerStockCurReq = "Entrez le nombre d'articles disponibles à l'achat actuellement ou la prochaine fois que ce contrebandier apparaîtra.",
	smugglerNoTrade = "Ce contrebandier refuse de commercer avec vous!",
	smugglerNoTrust = "Ce contrebandier ne vous fait pas encore assez confiance pour échanger cet objet!",
	smugglerNoMoney = "Ce contrebandier ne peut pas se permettre cet objet!",
	smugglerNoStock = "Ce contrebandier n'a pas cet objet en stock. Commandez-le plutôt pour vous le faire livrez!",
	smugglerNoItems = "Ce contrebandier n'a pas envi de vous vendre des objets.",
	smugglerMaxStock = "Ce contrebandier ne peut plus transporter plus d'objet de ce genre!",
	smugglerSelectPickupItem = "Sélectionnez un élément à récupérer:",
	smugglerPickupItem = "Vous avez ramassé un %s.",
	smugglerPickupNoSpace = "Vous n'avez pas assez d'espace pour %s !",
	smugglerNoPickupItems = "Il n'y a pas d'articles disponibles pour le ramassage ici !",
	smugglerSelectDelivery = "Sélectionnez le lieu de livraison",
	smugglerDeliverTo = "Acheter et livrer à %s",
	smugglerPrepMove = "Ce contrebandier va bientôt partir, il ne fera plus de trocs.",
	smugglerAvailableDelivery = "Disponible uniquement sur commande pour livraison",
	smugglerAvailable = "Disponible à l'achat : %d",
	smugglerStock = "Le contrebandier peut acheter : %d\nVous avez : %d",
	smugglerItemsDelivery = "Vos articles seront livrés au point relais dans %d minutes.",
	smugglerUniqueIDExists = "Un cache avec cet ID unique existe déjà!",
	smugglerStackSize = "Vendu en lots de %d.",
	smugglerDeliveryNotify = "Vous avez des objets à récupérer ! Trouvez la cache marquée",
	smugglerNeedAtLeast = "Vous avez besoin d'au moins %d de cet article pour vendre."
})

ix.lang.AddTable("spanish", {
	smugglerNoSellItems = "Il n'y a aucun article à vendre.",
	smugglerNoBuyItems = "Il n'y a aucun article à acheter.",
	smugglerSettings = "Paramètres de contrebandier",
	smugglerUseMoney = "Le contrebandier devrait utiliser de l'argent?",
	smugglerBoth = "Acheter et vendre",
	smugglerBuy = "Achat uniquement",
	smugglerSell = "Vente uniquement",
	smugglerWelcome = "Bienvenue chez moi mon gamin, que puis-je t'offrir aujourd'hui ?",
	smugglerBye = "Mouais, tu reviendra j'espère!",
	smugglerEditor = "Éditeur contrebandier",
	smugglerEditCurStock = "Modifier le stock actuel",
	smugglerStockReq = "Entrez le montant maximum de l'objet que le contrebandier peut acheter à chaque fois qu'il apparaît.",
	smugglerStockCurReq = "Entrez le nombre d'articles disponibles à l'achat actuellement ou la prochaine fois que ce contrebandier apparaîtra.",
	smugglerNoTrade = "Ce contrebandier refuse de commercer avec vous!",
	smugglerNoTrust = "Ce contrebandier ne vous fait pas encore assez confiance pour échanger cet objet!",
	smugglerNoMoney = "Ce contrebandier ne peut pas se permettre cet objet!",
	smugglerNoStock = "Ce contrebandier n'a pas cet objet en stock. Commandez-le plutôt pour vous le faire livrez!",
	smugglerNoItems = "Ce contrebandier n'a pas envi de vous vendre des objets.",
	smugglerMaxStock = "Ce contrebandier ne peut plus transporter plus d'objet de ce genre!",
	smugglerSelectPickupItem = "Sélectionnez un élément à récupérer:",
	smugglerPickupItem = "Vous avez ramassé un %s.",
	smugglerPickupNoSpace = "Vous n'avez pas assez d'espace pour %s !",
	smugglerNoPickupItems = "Il n'y a pas d'articles disponibles pour le ramassage ici !",
	smugglerSelectDelivery = "Sélectionnez le lieu de livraison",
	smugglerDeliverTo = "Acheter et livrer à %s",
	smugglerPrepMove = "Ce contrebandier va bientôt partir, il ne fera plus de trocs.",
	smugglerAvailableDelivery = "Disponible uniquement sur commande pour livraison",
	smugglerAvailable = "Disponible à l'achat : %d",
	smugglerStock = "Le contrebandier peut acheter : %d\nVous avez : %d",
	smugglerItemsDelivery = "Vos articles seront livrés au point relais dans %d minutes.",
	smugglerUniqueIDExists = "Un cache avec cet ID unique existe déjà!",
	smugglerStackSize = "Vendu en lots de %d.",
	smugglerDeliveryNotify = "Vous avez des objets à récupérer ! Trouvez la cache marquée",
	smugglerNeedAtLeast = "Vous avez besoin d'au moins %d de cet article pour vendre."
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
	description = "Fait tourner le contrebandier actuel vers un nouveau.",
	superAdminOnly = true,
	OnRun = function(self, client)
		PLUGIN:RotateActiveSmuggler()
	end
})

ix.command.Add("CheckPlayerSmugglerPickupItems", {
	description = "Imprime des données sur des objets de contrebandier pour un joueur spécifique.",
	adminOnly = true,
	arguments = {
		ix.type.character,
	},	
	OnRun = function(self, client, character)
		client:ChatPrint(character:GetName() .. "'Ramassage des articles:")

		for k, v in pairs(character:GetSmugglingPickupItems()) do
			for key, val in pairs(v) do 
				client:ChatPrint(character:GetName() .. ": [" .. key .. "] - avec la quantité de " .. val .. " est stocké dans une caisse avec ID : " .. k)
			end 
		end
		client:ChatPrint(character:GetName() .. "'Retard de ramassage:")
		for k, v in ipairs(character:GetSmugglingPickupDelay()) do
			local delay = v[1] - os.time() 
            delay = math.Round(delay / 60)
            if (delay % 5 != 0) then
                delay = delay - (delay % 5) + 5
            end
			client:ChatPrint(character:GetName() .. ": ".. "Item["..v[2].."] - ".. delay .. " minutes avant d’arriver à la cache avec ID : " .. v[3])
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
			ErrorNoHalt("[CONTREBANDIER] Tentative d’ajouter un élément inconnu '"..uniqueID.."'.")
			self.itemList[uniqueID] = nil
			continue
		end

		if (!data.buy and !data.sell) then
			ErrorNoHalt("[CONTREBANDIER] Tentative d’ajouter un article '"..uniqueID.."' sans prix d’achat ou de vente.")
			self.itemList[uniqueID] = nil
			continue
		end

		ix.action:RegisterSkillAction("smuggling", "recipe_smuggling_"..uniqueID, {
			name = item.name,
			data = data,
			itemID = uniqueID,
			bNoLog = true,
			description = "Vous permet d’acheter et de vendre le '"..item.name.."' article via le réseau de contrebande.",
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
		RECIPE.description = "Vous permet d’acheter et de vendre le '"..item.name.."' article via le réseau de contrebande."
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
