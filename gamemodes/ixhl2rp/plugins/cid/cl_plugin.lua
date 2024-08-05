--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local netstream = netstream
local vgui = vgui
local hook = hook
local IsValid = IsValid
local pairs = pairs
local LocalPlayer = LocalPlayer
local Derma_Select = Derma_Select
local timer = timer
local Derma_Query = Derma_Query

local PLUGIN = PLUGIN

netstream.Hook("ixCreditTransactionLog", function(data, bShowReadButton)
	local transactionUI = vgui.Create("ixCIDTransactionLog")
	transactionUI:CreateContent(data, bShowReadButton)
end)

netstream.Hook("ixRequestCredits", function(client, amount, reason)
	local clientName = hook.Run("GetCharacterName", client, "ic") or client:GetName()
	if (IsValid(PLUGIN.posTransactionPanel)) then
		client:NotifyLocalized("posTransOngoing")
		netstream.Start("ixDenyCreditOperation")
		return
	end

	local cards = {}
	for _, v in pairs(LocalPlayer():GetCharacter():GetInventory():GetItemsByUniqueID("id_card")) do
		cards[#cards + 1] = {
			text = v:GetName(),
			value = v
		}
	end

	local amountPercent = amount / 100
	local vat = math.Round(amountPercent * ix.config.Get("transactionVatPercent", 2))

	local cardsCount = #cards
	if (cardsCount > 1) then
		PLUGIN.posTransactionPanel = Derma_Select("Credits Requested", clientName.." requests "..amount.." credit(s) from you for '"..reason.."'. Transaction vat: " .. vat .. " credit(s). What card will you choose to pay?",
			cards, "Select ID Card",
			"Confirm Operation", function(value, name)
				netstream.Start("ixConfirmCreditOperation", value:GetID())
				timer.Remove("ixPosTransactionQuery")
			end, "Refuse Request", function()
				netstream.Start("ixDenyCreditOperation")
				timer.Remove("ixPosTransactionQuery")
			end)
	elseif (cardsCount == 1) then
		PLUGIN.posTransactionPanel = Derma_Query(clientName.." requests "..amount.." credit(s) from you for '"..reason.."'. Transaction vat: " .. vat .. " credit(s). Are you confirming this transaction?", "Credits Requested",
		"Confirm Operation", function()
			netstream.Start("ixConfirmCreditOperation", cards[1].value:GetID())
			timer.Remove("ixPosTransactionQuery")
		end, "Refuse Request", function()
			netstream.Start("ixDenyCreditOperation")
			timer.Remove("ixPosTransactionQuery")
		end)
	else
		LocalPlayer():NotifyLocalized("You have received a credits request, but you do not have an ID card to perform it.")
		netstream.Start("ixDenyCreditOperation")
		return
	end

	timer.Create("ixPosTransactionQuery", 14, 1, function()
		client:NotifyLocalized("posTransExpired")
		PLUGIN.posTransactionPanel:Remove()
		netstream.Start("ixDenyCreditOperation")
	end)
end)

netstream.Hook("ixSelectCID", function(hasFail)
	local cidSelector = vgui.Create("CIDSelector")

	if (hasFail) then
		cidSelector.ExitCallback = function()
			netstream.Start("ixSelectCIDFail")
		end
	end

	cidSelector.SelectCallback = function(cardID)
		netstream.Start("ixSelectCIDSuccess", cardID)
	end
end)

net.Receive("changeLockAccess", function()
	local entity = net.ReadEntity()

	ix.menu.Open({["Set Member Access"] = true, ["Set Management Access"] = true}, entity)
end)

net.Receive("changeLockAccessCmru", function()
	local entity = net.ReadEntity()

	local accessLevels = {}
	for i=1, 5 do
		accessLevels["Set Level "..tostring(i).." Access"] = true
	end
	ix.menu.Open(accessLevels, entity)
end)

net.Receive("changeLockAccessCon", function()
	local entity = net.ReadEntity()

	local accessLevels = {}
	for i=1, 5 do
		accessLevels["Set Level "..tostring(i).." Access"] = true
	end
	ix.menu.Open(accessLevels, entity)
end)

function PLUGIN:CreateExtraCharacterTabInfo(character, informationSubframe, CreatePart)
	local citizenID = LocalPlayer():GetCharacter():GetCid() or "N/A"

	local cidPanel = informationSubframe:Add("Panel")
	CreatePart(cidPanel, "Citizen ID:", citizenID, "cid")
end
