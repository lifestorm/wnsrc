--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Sahte Kimlik Kartı Oluşturma Cihazı"
ITEM.model = Model("models/props_lab/reciever01a.mdl")
ITEM.description = "Boş Kimlik Kartlarını gerçek, işlevsel kartlar gibi görünecek şekilde değiştirmek için kullanılan bir cihaz."
ITEM.category = "Tools"

ITEM.functions.CreateID = {
	name = "Sahte Kimlik Oluşturma",
	icon = "icon16/vcard.png",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:RequestString("Name", "Bu sahte kimliğin verileceği kişinin adını girin", function(name)
			client:RequestString("CID", "Bu sahte kimliğin ait olacağı kişinin CID'sini girin", function(cid)
				client:RequestString("Generic Description", "Bu sahte kimliğin ait olacağı kişinin genel tanımını girin", function(desc)
					local inventory = client:GetCharacter():GetInventory()
					local card = inventory:HasItem("id_card_blank")

					if (!card) then
						client:Notify("Sahte bir kimlik kartına dönüştürmek için Boş Kimlik Kartına ihtiyacınız var!")
						client:EmitSound("buttons/combine_button_locked.wav")

						return false
					end

					card:Remove()

					inventory:Add("fake_id_card", 1, {
						name = name,
						cid = cid,
						geneticDesc = desc
					})

					client:Notify("Sahte Kimlik Kartı oluşturuldu.")
					client:EmitSound("ambient/machines/combine_terminal_idle2.wav")
				end, "YOUNG ADULT/ADULT/MIDDLE-AGED/ELDERLY | 0\'00\" | [COLOR] EYES | [COLOR] HAIR")
			end, "00000")
		end, "")

		return false
	end
}
