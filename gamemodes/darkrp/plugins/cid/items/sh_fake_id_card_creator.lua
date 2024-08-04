--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Dispositif de création de carte CID"
ITEM.model = Model("models/props_lab/reciever01a.mdl")
ITEM.description = "Un appareil utilisé pour modifier les cartes CID vierges afin qu'elles ressemblent à de vraies cartes fonctionnelles."
ITEM.category = "Outils"

ITEM.functions.CreateID = {
	name = "Créer une carte CID contrefaite",
	icon = "icon16/vcard.png",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:RequestString("Nom", "Entrez le nom de la personne à qui cette fausse carte sera destinée", function(name)
			client:RequestString("CID", "Entrez le CID de la personne à qui cette fausse carte sera destinée", function(cid)
				client:RequestString("Description générique", "Entrez la description génétique de la personne à qui cette fausse carte sera destinée", function(desc)
					local inventory = client:GetCharacter():GetInventory()
					local card = inventory:HasItem("id_card_blank")

					if (!card) then
						client:Notify("Vous avez besoin d'une carte CID vierge pour faire une contrefaçon !")
						client:EmitSound("buttons/combine_button_locked.wav")

						return false
					end

					card:Remove()

					inventory:Add("fake_id_card", 1, {
						name = name,
						cid = cid,
						geneticDesc = desc
					})

					client:Notify("Fausse carte CID crée.")
					client:EmitSound("ambient/machines/combine_terminal_idle2.wav")
				end, "~... ANS | ~..M.. | YEUX ...")
			end, "00000")
		end, "")

		return false
	end
}
