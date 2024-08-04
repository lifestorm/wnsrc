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

util.AddNetworkString("arcade_msg")

util.AddNetworkString("arcade_moretime_credit")
util.AddNetworkString("arcade_adjust_timer")

util.AddNetworkString("arcade_request_pacman")
util.AddNetworkString("arcade_accept_pacman")
util.AddNetworkString("arcade_open_pacman")

util.AddNetworkString("arcade_request_space")
util.AddNetworkString("arcade_accept_space")
util.AddNetworkString("arcade_open_space")

util.AddNetworkString("arcade_request_pong")
util.AddNetworkString("arcade_accept_pong")
util.AddNetworkString("arcade_open_pong")

net.Receive("arcade_moretime_credit", function(_, client)
	PLUGIN:PayArcade(client, function()
		net.Start("arcade_adjust_timer")
		net.Send(client)
	end)
end)

function PLUGIN:PayArcade(client, callback)
	local price = ix.config.Get("arcadePrice")

	client:SelectCIDCard(function(cardItem)
		if (cardItem) then
			if (cardItem:GetData("active")) then
				if (cardItem:HasCredits(price)) then
					cardItem:TakeCredits(price, "Arcade machine", "Arcade Game cost")
					ix.city.main:AddCredits(price)

					client:Notify("Wpłaciłeś " .. price .. " kredyt(ów) do tego automatu do gier.")

					callback()

					client:EmitSound("buttons/lever8.wav", 65)
				else
					client:Notify("Automat do gier emituje szyderczy dźwięk błędu. \"Niewystarczające fundusze.\"")
				end
			else
				ix.combineNotify:AddImportantNotification("WRN:// Wykryto próbę użycia nieaktywnego CID #" .. cardItem:GetData("cid", 00000), nil, client, client:GetPos())
				client:Notify("Automat do gier emituje szyderczy dźwięk błędu. \"Nie można odczytać danych CID.\"")
			end

			cardItem:LoadOwnerGenericData(function(idCard, genericData)
				local isBOL = genericData.bol
				local isAC = genericData.anticitizen
				if (isBOL or isAC) then
					local text = isBOL and "Podejrzany BOL" or "Antyobywatel"

					ix.combineNotify:AddImportantNotification("WRN:// Wykryto aktywność identyfikatora " .. text, nil, client, client:GetPos())
				end
			end)
		else
			client:Notify("Automat do gier emituje szyderczy dźwięk błędu. \"Nie można odczytać danych CID.\"")
		end
	end, function()
		client:Notify("Automat stoi bezczynnie, a kontrolka czytnika kart CID miga. Czeka na kartę CID.")
	end)
end
