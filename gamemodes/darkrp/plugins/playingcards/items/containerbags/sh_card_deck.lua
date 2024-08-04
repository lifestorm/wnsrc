--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Jeu de 52 cartes"
ITEM.model = Model("models/cards/stack.mdl")
ITEM.description = "Un jeu de cartes traditionnel de 52 cartes à jouer en costume français."
ITEM.category = "Carte à jouer"
ITEM.invWidth = 13
ITEM.invHeight = 4
ITEM.allowNesting = true
ITEM.restriction = {"base_cards"}
ITEM.noEquip = true

function ITEM:OnBagInitialized(inventory) -- Dumb, I know, but I wanted them to be in order.
	inventory:Add("card_clubs_ace")
	inventory:Add("card_clubs_2")
	inventory:Add("card_clubs_3")
	inventory:Add("card_clubs_4")
	inventory:Add("card_clubs_5")
	inventory:Add("card_clubs_6")
	inventory:Add("card_clubs_7")
	inventory:Add("card_clubs_8")
	inventory:Add("card_clubs_9")
	inventory:Add("card_clubs_10")
	inventory:Add("card_clubs_jack")
	inventory:Add("card_clubs_king")
	inventory:Add("card_clubs_queen")
	inventory:Add("card_diamonds_ace")
	inventory:Add("card_diamonds_2")
	inventory:Add("card_diamonds_3")
	inventory:Add("card_diamonds_4")
	inventory:Add("card_diamonds_5")
	inventory:Add("card_diamonds_6")
	inventory:Add("card_diamonds_7")
	inventory:Add("card_diamonds_8")
	inventory:Add("card_diamonds_9")
	inventory:Add("card_diamonds_10")
	inventory:Add("card_diamonds_jack")
	inventory:Add("card_diamonds_king")
	inventory:Add("card_diamonds_queen")
	inventory:Add("card_hearts_ace")
	inventory:Add("card_hearts_2")
	inventory:Add("card_hearts_3")
	inventory:Add("card_hearts_4")
	inventory:Add("card_hearts_5")
	inventory:Add("card_hearts_6")
	inventory:Add("card_hearts_7")
	inventory:Add("card_hearts_8")
	inventory:Add("card_hearts_9")
	inventory:Add("card_hearts_10")
	inventory:Add("card_hearts_jack")
	inventory:Add("card_hearts_king")
	inventory:Add("card_hearts_queen")
	inventory:Add("card_spades_ace")
	inventory:Add("card_spades_2")
	inventory:Add("card_spades_3")
	inventory:Add("card_spades_4")
	inventory:Add("card_spades_5")
	inventory:Add("card_spades_6")
	inventory:Add("card_spades_7")
	inventory:Add("card_spades_8")
	inventory:Add("card_spades_9")
	inventory:Add("card_spades_10")
	inventory:Add("card_spades_jack")
	inventory:Add("card_spades_king")
	inventory:Add("card_spades_queen")
end

ITEM.functions.PullRandom = {
	name = "Tirer une carte au hasard",
	icon = "icon16/tag_blue_add.png",
	OnRun = function(item)
		local inventory = item:GetInventory()
		local items = inventory:GetItems()
		local client = item.player
		
		if (table.IsEmpty(items)) then
			client:Notify("Le jeu de cartes est vide !")

			return false
		end

		if (item.entity) then
			inventory:AddReceiver(client) -- Adding the client as a receiver to allow him to transfer items to his inventory.
		end

		local randomItem = table.Random(items)
		local bSuccess, transferError = randomItem:Transfer(client:GetCharacter():GetInventory():GetID(), nil, nil, client)

		if (bSuccess) then
			client:Notify("Vous tirez un " .. randomItem.name .. " du jeu de cartes.")
		else
			client:NotifyLocalized(transferError)
		end

		if (item.entity) then
			inventory:RemoveReceiver(client) -- Removing the client from the receiver list to allow the inventory to be opened by others again.
		end

		return false
	end
}
