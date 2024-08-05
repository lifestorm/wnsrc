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

REQUEST_CP = 0
REQUEST_MED = 1
REQUEST_WORK = 2

ITEM.name = "Request Device"
ITEM.model = Model("models/gibs/shield_scanner_gib1.mdl")
ITEM.description = "A small device with rounded corners, housing one button. A small combine logo is visible.\n\nThe instructions read: please first register this device by holding your ID card against this device. Once registration is completed, you can request assistance from Civil Protection by pressing the button and stating your request. Your name and CID is automatically included with the request.\nPlease be aware the misuse of the request device, making false statements to Civil Protection and identity fraud are punishable by law and will result in prosecution by Civil Protection."
ITEM.price = 20
ITEM.category = "Combine"
function ITEM:GetDescription()
    local idCard = ix.item.instances[self:GetData("cardID")]
    return idCard and string.format(self.description.."\n\nCurrently bound to identity card #%s.", idCard:GetData("cardNumber")) or self.description
end

local function GetRequestTable(data)
	return {
		name = data.actionName,
		icon = "icon16/help.png",
		OnClick = function(itemTable)
				if (ix.config.Get("creditsNoConnection")) then
					itemTable.player:EmitSound("hl1/fvox/buzz.wav", 60, 100, 0.5)
					return
				end

				Derma_StringRequest(data.requestTitle, data.requestMessage, PLUGIN.text,
					function(text)
						if (text and string.utf8len(text) > 0) then
							netstream.Start("ixRequest", itemTable:GetID(), text, data.requestType)
						end

						PLUGIN.text = nil
					end,
					function(text)
						if (text == PLUGIN.text) then
							PLUGIN.text = text
						elseif (text and string.utf8len(text) > 0)then
							PLUGIN.text = text
						else
							PLUGIN.text = nil
						end
					end, "MAKE REQUEST", "CANCEL"
				)
			end,
		OnRun = function(itemTable)
			return false
		end,
		OnCanRun = function(itemTable)
			if (IsValid(itemTable.entity)) then
				return false
			end

			if (!itemTable:GetData("cardID", false)) then
				return false
			end

			return true
		end
	}
end

ITEM.functions.RequestCp = GetRequestTable({
	actionName = "Make CP Request",
	requestTitle = "Request Civil Protection Assistance",
	requestMessage = "Please enter your assistance request for Civil Protection. Your name and CID will automatically be included in the request.",
	requestType = REQUEST_CP
})

ITEM.functions.RequestMed = GetRequestTable({
	actionName = "Make CMRU Request",
	requestTitle = "Request Civil Medical & Research Union Assistance",
	requestMessage = "Please enter your assistance request for Civil Medical Research Union. Your name and CID will automatically be included in the request. Do not forget to tell your location!",
	requestType = REQUEST_MED
})

ITEM.functions.RequestCwu = GetRequestTable({
	actionName = "Make CWU Request",
	requestTitle = "Request Civil Workers Union Assistance",
	requestMessage = "Please enter your assistance request for Civil Workers Union. Your name and CID will automatically be included in the request.",
	requestType = REQUEST_WORK
})

ITEM.functions.Bind = {
	name = "Bind ID Card",
	icon = "icon16/vcard_edit.png",
	OnClick = function(itemTable)
		local cards = {}

		for _, v in pairs(LocalPlayer():GetCharacter():GetInventory():GetItemsByUniqueID("id_card")) do
			table.insert(cards, {
				text = v:GetName(),
				value = v
			})
		end

		local cardsCount = table.Count(cards)
		if (cardsCount > 1) then
			Derma_Select("Bind ID Card to RD", "Please select a ID card to bind to this Request Device:",
				cards, "Select ID card",
				"Confirm Operation", function(value, name)
					netstream.Start("ixBindRequestDevice", itemTable:GetID(), value:GetID())
				end, "Cancel")
		elseif (cardsCount == 1) then
			Derma_Query("Are you sure you wish to bind your ID to this Request Device?", "Bind ID Card to RD",
			"Confirm Operation", function()
				netstream.Start("ixBindRequestDevice", itemTable:GetID(), cards[1].value:GetID())
			end, "Cancel")
		else
			LocalPlayer():NotifyLocalized("You do not have ID card to bind to this request device.")
		end
	end,
	OnRun = function(itemTable)
		return false
	end,
	OnCanRun = function(itemTable)
		if (IsValid(itemTable.entity)) then
			return false
		end

		if (!IsValid(itemTable.player)) then
			return false
		end

		local inventory = itemTable.player:GetCharacter():GetInventory()
		if (!inventory:HasItem("id_card")) then
			return false
		end

		if (!itemTable:GetData("cardID", false)) then
			return true
		end

		if (inventory:GetItemCount("id_card") == 1 and inventory:GetItemByID(itemTable:GetData("cardID"))) then
			return false
		end

		return true
	end
}

if (CLIENT) then
	netstream.Hook("rdMoreThanOneText", function(text)
		PLUGIN.rdText = text
	end)
end
