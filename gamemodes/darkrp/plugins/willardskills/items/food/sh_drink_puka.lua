--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Puka Vodna"
ITEM.description = "Un flacon marron contenant un liquide marron doré de qualité premium. L'étiquette au dos de la bouteille se lit en petits caractères... Remboursements non disponibles en cas de décès grave suite à une consommation d'alcool présumée."
ITEM.category = "Nourriture"
ITEM.model = "models/willardnetworks/food/prop_bar_bottle_f.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(-164.23, -189.89, 37.43),
  ang = Angle(6.75, 49.13, 0),
  fov = 4.07
}
ITEM.thirst = 10
ITEM.boosts = {
  strength = -3,
  agility = -3,
  perception = -3,
  intelligence = -3
}
ITEM.energyShift = -0.003 -- fatigue_system
ITEM.spoil = false
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.colorAppendix = {["green"] = "[Drug]: Applique des visuels d'écran loufoques. Les autres joueurs pourront détecter si vous êtes drogué.", ["blue"] = "[RP]: Vous pouvez ignorer le FearRP si vous êtes drogué."}
ITEM.drug = {
  ["bloom"] = 15, ["saturated"] = 15, ["jarate"] = 15
}
ITEM.junk = "junk_empty_beer"