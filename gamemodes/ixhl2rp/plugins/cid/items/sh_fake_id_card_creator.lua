--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Counterfeit Identity Card Creation Device"
ITEM.model = Model("models/props_lab/reciever01a.mdl")
ITEM.description = "A device used to modify blank Identity Cards to look like real, functional ones."
ITEM.category = "Tools"

ITEM.functions.CreateID = {
	name = "Create Counterfeit ID",
	icon = "icon16/vcard.png",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:RequestString("Name", "Enter the name of the person that this counterfeit ID will be for", function(name)
			client:RequestString("CID", "Enter the CID of the person that this counterfeit ID will be for", function(cid)
				client:RequestString("Generic Description", "Enter the generic description of the person that this counterfeit ID will be for", function(desc)
					local inventory = client:GetCharacter():GetInventory()
					local card = inventory:HasItem("id_card_blank")

					if (!card) then
						client:Notify("You need a Blank Identity Card to turn into a counterfeit one!")
						client:EmitSound("buttons/combine_button_locked.wav")

						return false
					end

					card:Remove()

					inventory:Add("fake_id_card", 1, {
						name = name,
						cid = cid,
						geneticDesc = desc
					})

					client:Notify("Counterfeit Identity Card created.")
					client:EmitSound("ambient/machines/combine_terminal_idle2.wav")
				end, "YOUNG ADULT/ADULT/MIDDLE-AGED/ELDERLY | 0\'00\" | [COLOR] EYES | [COLOR] HAIR")
			end, "00000")
		end, "")

		return false
	end
}
