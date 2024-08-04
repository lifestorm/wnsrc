--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Ration Coupons"
ITEM.model = Model("models/willardnetworks/misc/idcard.mdl")
ITEM.description = "Kupon racji żywnościowej do wykorzystania w dystrybutorze racji w zamian za kredyty."
ITEM.amount = 5
ITEM.category = "Ration Coupons"
ITEM.maxStackSize = 5

ITEM.base = "base_stackable"
ITEM.bInstanceMaxstack = false

ITEM.functions.Use = {
	OnRun = function(itemTable)
		local client = itemTable.player
		local character = client:GetCharacter()
		local errorMsg = "Aby to zrobić, musisz być w pobliżu i patrzeć na dystrybutor racji lub terminal cywilny!"
		local entity = client:GetEyeTraceNoCursor().Entity

		if (IsValid(entity)) then
			if (entity:GetClass() != "ix_rationdispenser" and entity:GetClass() != "ix_terminal") then
				client:NotifyLocalized(errorMsg)

				return false
			end

			if (client:GetShootPos():Distance(entity:GetPos()) > 50) then
				client:NotifyLocalized(errorMsg)

				return false
			end

			if ((!entity.canUse or (entity.nextUseTime and entity.nextUseTime > CurTime())) or (entity:GetClass() == "ix_rationdispenser" and !entity:GetEnabled())) then
				client:NotifyLocalized("Ten terminal jest w trybie offline lub w użyciu.")

				return false
			else
				client.ixCouponUsed = itemTable.id

				-- Check for citizen id(s)
				local idCards = character:GetInventory():GetItemsByUniqueID("id_card")

				if (#idCards == 1) then
					idCards[1]:LoadOwnerGenericData(entity.CheckIdCardCoupon, entity.CheckIdError, client, entity, itemTable.amount)
				else
					netstream.Start(client, "CIDSelectorCoupon", entity)
				end

				return false
			end
		end

		client:NotifyLocalized(errorMsg)

		return false
	end
}
