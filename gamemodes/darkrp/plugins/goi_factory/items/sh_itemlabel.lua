--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Étiquette"
ITEM.model = "models/props_lab/box01a.mdl"
ITEM.category = "Autres"
ITEM.description = "Une étiquette pouvant être appliqué à n'importe quel objet pour changer son nom et sa description."

function ITEM:GetName()
	local name = self:GetData("labelInfoName")
	return self.name .. (name and (" \"" .. name .. "\"") or "")
end

function ITEM:GetDescription()
	local description = self:GetData("labelInfoDesc")
	return self.description .. (description and (" Le texte est le suivant : \"" .. description .. "\"") or "")
end

ITEM.functions.editAName = { -- Sorry, I wanted it at the top
	name = "Modifier le nom",
	icon = "icon16/tag_blue_edit.png",
	OnRun = function(item, data)
		local client = item.player

		client:RequestString("Modifier le nom", "Saisissez le nom que doit porter cette étiquette :", function(name)
			item:SetData("labelInfoName", name)
			client:Notify("Vous avez changé le nom de cette étiquette.")
		end, "")

		return false
	end
}

ITEM.functions.editDesc = {
	name = "Modifier la description",
	icon = "icon16/tag_blue_edit.png",
	OnRun = function(item, data)
		local client = item.player

		client:RequestString("Modifier la description", "Saisissez la description que cette étiquette devrait avoir :", function(description)
			item:SetData("labelInfoDesc", description)

			client:Notify("Vous avez changé le nom de cette étiquette.")
		end, "")

		return false
	end
}

ITEM.functions.combined = {
	OnRun = function(item, data)
		local targetItem = ix.item.instances[data[1]]

		if (!targetItem) then return false end
		
		if (targetItem.functions.combine) then
			client:Notify("Vous ne pouvez pas apposer d’étiquette sur cet article.!")
			
			return false
		end
		
		local client = item.player

		if (targetItem.uniqueID == "itemlabel") then
			client:Notify("Vous ne pouvez pas apposer une étiquette sur une autre étiquette!")

			return false
		end

		local name = item:GetData("labelInfoName", false)
		local description = item:GetData("labelInfoDesc", false)

		if (!name and !description) then
			client:Notify("L’étiquette est vide!")

			return false
		end

		targetItem:SetData("labelName", name)
		targetItem:SetData("labelDescription", description)

		client:Notify("Vous appliquez l’étiquette au " .. targetItem.name .. ".")
	end,
	OnCanRun = function(item, data)
		return true
	end
}
