--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Identity Card Creation Device"
ITEM.model = Model("models/props_lab/reciever01d.mdl")
ITEM.description = "A device used to bind blank Identity Cards to a specific person."
ITEM.category = "Combine"
ITEM.functions.CreateIDTarget = {
	name = "Create Identity Card for target",
	icon = "icon16/vcard_add.png",
	OnRun = function(itemTable)
		local client = itemTable.player

		if (ix.config.Get("creditsNoConnection")) then
			client:EmitSound("hl1/fvox/buzz.wav", 60, 100, 0.5)
			return false
		end

		if (itemTable:CheckAccess(client, itemTable) == false) then
			client:EmitSound("buttons/combine_button_locked.wav", 60, 100, 0.5)
			return false
		end

		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96
			data.filter = client
		local target = util.TraceLine(data).Entity

		if (IsValid(target) and target:IsPlayer() and target:GetCharacter()) then
			client:SetAction("@scanning", 5)
			client:EmitSound("buttons/button18.wav", 60, 100, 0.5)
			client:DoStaredAction(target, function()
				itemTable:CreateIDCard(client, target)
			end, 5, function()
				client:SetAction()
				client:EmitSound("buttons/combine_button_locked.wav", 60, 100, 0.5)
			end)
		else
			client:NotifyLocalized("plyNotValid")
		end

		return false
	end,
	OnCanRun = function(itemTable)
		return !IsValid(itemTable.entity)
	end
}

ITEM.functions.CreateIDSelf = {
	name = "Create Identity Card for yourself",
	icon = "icon16/vcard.png",
	OnRun = function(itemTable)
		local client = itemTable.player

		if (ix.config.Get("creditsNoConnection")) then
			client:EmitSound("hl1/fvox/buzz.wav", 60, 100, 0.5)
			return false
		end

		if (itemTable:CheckAccess(client, itemTable) == false) then
			client:EmitSound("buttons/combine_button_locked.wav", 60, 100, 0.5)
			return false
		end

		client:SetAction("@scanning", 5, function()
			itemTable:CreateIDCard(client, client)
		end)
		client:EmitSound("buttons/button18.wav", 60, 100, 0.5)
		return false
	end
}

function ITEM:CreateIDCard(client, target)
	local character = target:GetCharacter()
	local cid = character:GetCid()

	if (!cid) then
		client:NotifyLocalized("idNotFound")
		client:EmitSound("buttons/combine_button_locked.wav", 60, 100, 0.5)
		return
	end

	local inventory = client:GetCharacter():GetInventory()
	local blankCard = inventory:HasItem("id_card_blank")

	if (!blankCard) then
		client:NotifyLocalized("idNoBlank")
		client:EmitSound("buttons/combine_button_locked.wav", 60, 100, 0.5)
		return
	end

	blankCard:Remove()
	character:CreateIDCard()
	client:EmitSound("buttons/button4.wav", 60, 100, 0.5)
	client:NotifyLocalized("idCardAdded")

	ix.combineNotify:AddNotification("NTC:// Identification Card #" .. character:GetCid() .. " created by " .. client:GetCombineTag())
end

function ITEM:CheckAccess(client, itemTable)
	if (!client:HasActiveCombineSuit() and !ix.faction.Get(client:Team()).allowCIDCreator) then
		client:NotifyLocalized("idNotAllowed")
		return false
	end
end
