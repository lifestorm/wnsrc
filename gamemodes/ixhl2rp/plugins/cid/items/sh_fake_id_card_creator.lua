--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Urządzenie do tworzenia fałszywych kart identyfikacyjnych"
ITEM.model = Model("models/props_lab/reciever01a.mdl")
ITEM.description = "Urządzenie do tworzenia fałszywych kart identyfikacyjnych "
ITEM.category = "Tools"

ITEM.functions.CreateID = {
	name = "Stwórz fałszywy CID",
	icon = "icon16/vcard.png",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:RequestString("Imię", "Wprowadź imię osoby na którą będzie ta karta identyfikacyjna", function(name)
			client:RequestString("CID", "Wprowadź CID jakiego używać będzie osoba na którą będzie ta karta identyfikacyjna", function(cid)
				client:RequestString("Opis", "Wprowadź opis ogólny osoby która będzie używać tej karty identyfikacyjnej", function(desc)
					local inventory = client:GetCharacter():GetInventory()
					local card = inventory:HasItem("id_card_blank")

					if (!card) then
						client:Notify("Potrzebujesz pustej karty CID aby stworzyć fałszywy CID!")
						client:EmitSound("buttons/combine_button_locked.wav")

						return false
					end

					card:Remove()

					inventory:Add("fake_id_card", 1, {
						name = name,
						cid = cid,
						geneticDesc = desc
					})

					client:Notify("Fałszywa karta identyfikacyjna stworzona.")
					client:EmitSound("ambient/machines/combine_terminal_idle2.wav")
				end, "MŁODY DOROSŁY/DOROSŁY/W ŚREDNIM WIEKU/STARSZY | 0\'00\" | [COLOR] OCZY | [COLOR] WŁOSY")
			end, "00000")
		end, "")

		return false
	end
}
