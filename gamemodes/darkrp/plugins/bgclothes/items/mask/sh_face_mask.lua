--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Masque Chirurgical"
ITEM.description = "Le masque chirurgical est un petit objet en papier, conçu pour se fixer confortablement sur votre visage. Il comporte des élastiques doux qui s'accrochent facilement derrière vos oreilles, tandis que le tissu léger et respirant couvre votre bouche et votre nez. Il est conçu pour vous protéger des particules en suspension dans l'air et des éclaboussures potentielles, vous permettant de vous sentir un peu plus en sécurité dans un environnement potentiellement dangereux"
ITEM.category = "Vêtements - Visage"
ITEM.model = "models/willardnetworks/clothingitems/medicmask_item.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "Face"
ITEM.bodyGroups = {
    ["face"] = 4 -- The actual name of the bodypart, then number in that bodypart (model-wise)
}

ITEM.filterQuality = 0.3
ITEM.maxFilterValue = 60
ITEM.refillItem = nil
ITEM.filterDecayStart = 0.2
ITEM.refillItem = "comp_yellowcompound"