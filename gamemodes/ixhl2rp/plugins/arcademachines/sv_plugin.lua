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

					client:Notify("You paid " .. price .. " credit(s) to the arcade machine.")

					callback()

					client:EmitSound("buttons/lever8.wav", 65)
				else
					client:Notify("The arcade machines emits a mocking error sound. \"Insufficient funds.\"")
				end
			else
				ix.combineNotify:AddImportantNotification("WRN:// Inactive Identification Card #" .. cardItem:GetData("cid", 00000) .. " usage attempt detected", nil, client, client:GetPos())
				client:Notify("The arcade machine emits a mocking error sound. \"Unable to read CID card data.\"")
			end

			cardItem:LoadOwnerGenericData(function(idCard, genericData)
				local isBOL = genericData.bol
				local isAC = genericData.anticitizen
				if (isBOL or isAC) then
					local text = isBOL and "BOL Suspect" or "Anti-Citizen"

					ix.combineNotify:AddImportantNotification("WRN:// " .. text .. " Identification Card activity detected", nil, client, client:GetPos())
				end
			end)
		else
			client:Notify("The arcade machine emits a mocking error sound. \"Unable to read CID card data.\"")
		end
	end, function()
		client:Notify("The arcade machine stands idle, the CID card reader light blinking. It is waiting for a CID card.")
	end)
end
