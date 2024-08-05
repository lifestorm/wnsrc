--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Item Label"
ITEM.model = "models/props_lab/box01a.mdl"
ITEM.description = "A label that can be applied on any item to change its name & description."

function ITEM:GetName()
	local name = self:GetData("labelInfoName")
	return self.name .. (name and (" \"" .. name .. "\"") or "")
end

function ITEM:GetDescription()
	local description = self:GetData("labelInfoDesc")
	return self.description .. (description and (" It reads: \"" .. description .. "\"") or "")
end

ITEM.functions.editAName = { -- Sorry, I wanted it at the top
	name = "Edit Name",
	icon = "icon16/tag_blue_edit.png",
	OnRun = function(item, data)
		local client = item.player

		client:RequestString("Edit Label Name", "Enter the name that this label should have:", function(name)
			item:SetData("labelInfoName", name)
			client:Notify("You have changed this label's name.")
		end, "")

		return false
	end
}

ITEM.functions.editDesc = {
	name = "Edit Description",
	icon = "icon16/tag_blue_edit.png",
	OnRun = function(item, data)
		local client = item.player

		client:RequestString("Edit Label Description", "Enter the description that this label should have:", function(description)
			item:SetData("labelInfoDesc", description)

			client:Notify("You have changed this label's name.")
		end, "")

		return false
	end
}

ITEM.functions.combined = {
	OnRun = function(item, data)
		local targetItem = ix.item.instances[data[1]]

		if (!targetItem) then return false end
		
		if (targetItem.functions.combine) then
			client:Notify("You cannot apply a label to this item!")
			
			return false
		end
		
		local client = item.player

		if (targetItem.uniqueID == "itemlabel") then
			client:Notify("You cannot apply a label onto another label!")

			return false
		end

		local name = item:GetData("labelInfoName", false)
		local description = item:GetData("labelInfoDesc", false)

		if (!name and !description) then
			client:Notify("The label is blank!")

			return false
		end

		targetItem:SetData("labelName", name)
		targetItem:SetData("labelDescription", description)

		client:Notify("You apply the label to the " .. targetItem.name .. ".")
	end,
	OnCanRun = function(item, data)
		return true
	end
}
