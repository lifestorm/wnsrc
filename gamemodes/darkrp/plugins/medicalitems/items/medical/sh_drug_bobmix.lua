--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Mix spécial"
ITEM.description = "Que se passerait-il si l'on prenait le distillat de toutes les boissons alcoolisées disponibles (publiquement), qu'on les mélangeait et qu'on s'injectait le produit obtenu dans le bras ? Les loyalistes ont dit rien de bon, tandis que les drogués de la basse-ville ont dit que vous vous élèveriez. Allez prouver que l'un ou l'autre a raison."
ITEM.category = "Drogues"
ITEM.model = Model("models/willardnetworks/skills/medx.mdl")

ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.boosts = {
    strength = 3,
    perception = 5,
    agility = 5,
    intelligence = -5
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drogue]: Applique des visuels d'écran loufoques. Les autres joueurs pourront détecter si vous êtes drogué.", ["blue"] = "[RP] : Vous pouvez ignorer le FearRP si vous êtes drogué."}
ITEM.drug = {
    ["saturated"] = 15
}
ITEM.junk = "crafting_water"