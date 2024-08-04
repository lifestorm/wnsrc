--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Chemise boutonnée --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_button_red"
RECIPE.name = "Chemise boutonnée - Rouge"
RECIPE.description = "Une simple chemise en laine rouge, conforme aux normes de l'Union."
RECIPE.model = "models/willardnetworks/clothingitems/torso_citizen2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemise boutonnée"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["buttoned_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_button_red"
RECIPE.name = "Chemise boutonnée - Beige"
RECIPE.description = "Une simple chemise en laine beige, conforme aux normes de l'Union."
RECIPE.model = "models/willardnetworks/clothingitems/torso_citizen2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemise boutonnée"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["buttoned_beige"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_button_black"
RECIPE.name = "Chemise boutonnée - Noire"
RECIPE.description = "Une simple chemise en laine noire, conforme aux normes de l'Union."
RECIPE.model = "models/willardnetworks/clothingitems/torso_citizen2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemise boutonnée"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["buttoned_black"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_button_blue"
RECIPE.name = "Chemise boutonnée - Bleue"
RECIPE.description = "Une simple chemise en laine bleue, conforme aux normes de l'Union."
RECIPE.model = "models/willardnetworks/clothingitems/torso_citizen2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemise boutonnée"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["buttoned_blue"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_button_brown"
RECIPE.name = "Chemise boutonnée - Marron"
RECIPE.description = "Une simple chemise en laine marron, conforme aux normes de l'Union."
RECIPE.model = "models/willardnetworks/clothingitems/torso_citizen2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemise boutonnée"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["buttoned_brown"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_button_green"
RECIPE.name = "Chemise boutonnée - Verte"
RECIPE.description = "Une simple chemise en laine verte, conforme aux normes de l'Union."
RECIPE.model = "models/willardnetworks/clothingitems/torso_citizen2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemise boutonnée"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["buttoned_green"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_button_lightblue"
RECIPE.name = "Chemise boutonnée - Bleue Claire"
RECIPE.description = "Une simple chemise en laine bleue claire, conforme aux normes de l'Union."
RECIPE.model = "models/willardnetworks/clothingitems/torso_citizen2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemise boutonnée"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["buttoned_lightblue"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_button_white"
RECIPE.name = "Chemise boutonnée - Blanche"
RECIPE.description = "Une simple chemise en laine blanche, conforme aux normes de l'Union."
RECIPE.model = "models/willardnetworks/clothingitems/torso_citizen2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemise boutonnée"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["buttoned_white"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Tenue Conforme --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_jumpsuit_black"
RECIPE.name = "Chemise - Noire"
RECIPE.description = "Rappelant le péril de l'asservissement de l'humanité tout en restant dépourvue d'apparence visuelle et lourde pour celui qui la porte, la combinaison de citoyen est considérée comme le vêtement standardisé du régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_jumpsuit_recolorable.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemises"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 7
RECIPE.result = {["jumpsuit_black"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_jumpsuit_blue"
RECIPE.name = "Chemise - Bleue"
RECIPE.description = "Rappelant le péril de l'asservissement de l'humanité tout en restant dépourvue d'apparence visuelle et lourde pour celui qui la porte, la combinaison de citoyen est considérée comme le vêtement standardisé du régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_jumpsuit_recolorable.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemises"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 7
RECIPE.result = {["jumpsuit_blue"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_jumpsuit_brown"
RECIPE.name = "Chemise - Marron"
RECIPE.description = "Rappelant le péril de l'asservissement de l'humanité tout en restant dépourvue d'apparence visuelle et lourde pour celui qui la porte, la combinaison de citoyen est considérée comme le vêtement standardisé du régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_jumpsuit_recolorable.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemises"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 7
RECIPE.result = {["jumpsuit_brown"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_jumpsuit_green"
RECIPE.name = "Chemise - Verte"
RECIPE.description = "Rappelant le péril de l'asservissement de l'humanité tout en restant dépourvue d'apparence visuelle et lourde pour celui qui la porte, la combinaison de citoyen est considérée comme le vêtement standardisé du régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_jumpsuit_recolorable.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemises"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 7
RECIPE.result = {["jumpsuit_green"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_jumpsuit_grey"
RECIPE.name = "Chemise - Grise"
RECIPE.description = "Rappelant le péril de l'asservissement de l'humanité tout en restant dépourvue d'apparence visuelle et lourde pour celui qui la porte, la combinaison de citoyen est considérée comme le vêtement standardisé du régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_jumpsuit_recolorable.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemises"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 7
RECIPE.result = {["jumpsuit_grey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_jumpsuit_red"
RECIPE.name = "Chemise - Rouge"
RECIPE.description = "Rappelant le péril de l'asservissement de l'humanité tout en restant dépourvue d'apparence visuelle et lourde pour celui qui la porte, la combinaison de citoyen est considérée comme le vêtement standardisé du régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_jumpsuit_recolorable.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemises"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 7
RECIPE.result = {["jumpsuit_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Chemise en Jean --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_denim_black"
RECIPE.name = "Chemise en jean - Noire"
RECIPE.description = "Une tenue robuste en jean noire, rugueuse sur les bords mais faite pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/torso_jumpsuit_recolorable.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemises en Jean"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 9
RECIPE.result = {["denim_black"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_denim_blue"
RECIPE.name = "Chemise en jean - Bleue"
RECIPE.description = "Une tenue robuste en jean bleue, rugueuse sur les bords mais faite pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/torso_jumpsuit_recolorable.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemises en Jean"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 9
RECIPE.result = {["denim_blue"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_denim_green"
RECIPE.name = "Chemise en jean - Verte"
RECIPE.description = "Une tenue robuste en jean verte, rugueuse sur les bords mais faite pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/torso_jumpsuit_recolorable.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemises en Jean"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 9
RECIPE.result = {["denim_green"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_denim_grey"
RECIPE.name = "Chemise en jean - Grise"
RECIPE.description = "Une tenue robuste en jean grise, rugueuse sur les bords mais faite pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/torso_jumpsuit_recolorable.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemises en Jean"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 9
RECIPE.result = {["torso_blue_shirt"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_denim_red"
RECIPE.name = "Chemise en jean - Rouge"
RECIPE.description = "Une tenue robuste en jean rouge, rugueuse sur les bords mais faite pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/torso_jumpsuit_recolorable.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chemises en Jean"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 9
RECIPE.result = {["denim_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Vestes --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_casual_blue"
RECIPE.name = "Veste - Bleue"
RECIPE.description = "Quelque peu usée et vieillie, la veste vous tient au chaud face aux intempéries."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat1.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["casual_blue"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()


local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_casual_bluered"
RECIPE.name = "Veste - Bleue & Rouge"
RECIPE.description = "Quelque peu usée et vieillie, la veste vous tient au chaud face aux intempéries."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat1.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["casual_bluered"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_casual_green"
RECIPE.name = "Veste - Verte"
RECIPE.description = "Quelque peu usée et vieillie, la veste vous tient au chaud face aux intempéries."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat1.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["casual_green"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_casual_grey"
RECIPE.name = "Veste - Grise"
RECIPE.description = "Quelque peu usée et vieillie, la veste vous tient au chaud face aux intempéries."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat1.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["torso_black_jacket"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_casual_darkgreen"
RECIPE.name = "Veste - Grise & Verte"
RECIPE.description = "Quelque peu usée et vieillie, la veste vous tient au chaud face aux intempéries."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat1.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["casual_greygreen"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_casual_orange"
RECIPE.name = "Veste - Orange"
RECIPE.description = "Quelque peu usée et vieillie, la veste vous tient au chaud face aux intempéries."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat1.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["casual_orange"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_casual_purple"
RECIPE.name = "Veste - Violette"
RECIPE.description = "Quelque peu usée et vieillie, la veste vous tient au chaud face aux intempéries."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat1.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["casual_purple"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_casual_red"
RECIPE.name = "Veste - Rouge"
RECIPE.description = "Quelque peu usée et vieillie, la veste vous tient au chaud face aux intempéries."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat1.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["casual_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_casual_brown"
RECIPE.name = "Veste - Marron"
RECIPE.description = "Quelque peu usée et vieillie, la veste vous tient au chaud face aux intempéries."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat1.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["casual_brown"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_casual_darkblue"
RECIPE.name = "Veste - Noire & Bleue"
RECIPE.description = "Quelque peu usée et vieillie, la veste vous tient au chaud face aux intempéries."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat1.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["casual_darkblue"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_casual_darkred"
RECIPE.name = "Veste - Noire & Rouge"
RECIPE.description = "Quelque peu usée et vieillie, la veste vous tient au chaud face aux intempéries."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat1.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["casual_darkred"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Imperméable --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_raincoat_blue"
RECIPE.name = "Imperméable - Bleu"
RECIPE.description = "Le temps est instable, sinon légèrement acide, ces jours-ci... Mieux vaut garder un bon manteau."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Imperméables"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["raincoat_blue"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_raincoat_darkgreen"
RECIPE.name = "Imperméable - Vert Foncé"
RECIPE.description = "Le temps est instable, sinon légèrement acide, ces jours-ci... Mieux vaut garder un bon manteau."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Imperméables"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["raincoat_darkgreen"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_raincoat_green"
RECIPE.name = "Imperméable - Vert"
RECIPE.description = "Le temps est instable, sinon légèrement acide, ces jours-ci... Mieux vaut garder un bon manteau."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Imperméables"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["raincoat_green"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_raincoat_orange"
RECIPE.name = "Imperméable - Orange"
RECIPE.description = "Le temps est instable, sinon légèrement acide, ces jours-ci... Mieux vaut garder un bon manteau."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Imperméables"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["raincoat_orange"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_raincoat_purple"
RECIPE.name = "Imperméable - Violet"
RECIPE.description = "Le temps est instable, sinon légèrement acide, ces jours-ci... Mieux vaut garder un bon manteau."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Imperméables"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["raincoat_purple"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_raincoat_red"
RECIPE.name = "Imperméable - Rouge"
RECIPE.description = "Le temps est instable, sinon légèrement acide, ces jours-ci... Mieux vaut garder un bon manteau."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Imperméables"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["raincoat_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_raincoat_yellow"
RECIPE.name = "Imperméable - Jaune"
RECIPE.description = "Le temps est instable, sinon légèrement acide, ces jours-ci... Mieux vaut garder un bon manteau."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Imperméables"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["raincoat_yellow"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_raincoat_dark"
RECIPE.name = "Imperméable - Noir"
RECIPE.description = "Le temps est instable, sinon légèrement acide, ces jours-ci... Mieux vaut garder un bon manteau."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Imperméables"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["raincoat_dark"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_raincoat_brown"
RECIPE.name = "Imperméable - Marron"
RECIPE.description = "Le temps est instable, sinon légèrement acide, ces jours-ci... Mieux vaut garder un bon manteau."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Imperméables"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["raincoat_brown"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_raincoat_murky"
RECIPE.name = "Imperméable - Vert Obscur"
RECIPE.description = "Le temps est instable, sinon légèrement acide, ces jours-ci... Mieux vaut garder un bon manteau."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Imperméables"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["raincoat_murky"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Pardessus --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_overcoat_blue"
RECIPE.name = "Pardessus - Bleu"
RECIPE.description = "Couramment utilisée par la population, cette veste procure une sensation de chaleur mais n'est pas adaptée aux conditions climatiques difficiles."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat3.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pardessus"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 16
RECIPE.result = {["overcoat_blue"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_overcoat_dark"
RECIPE.name = "Pardessus - Noir"
RECIPE.description = "Couramment utilisée par la population, cette veste procure une sensation de chaleur mais n'est pas adaptée aux conditions climatiques difficiles."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat3.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pardessus"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 16
RECIPE.result = {["overcoat_dark"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_overcoat_green"
RECIPE.name = "Pardessus - Vert"
RECIPE.description = "Couramment utilisée par la population, cette veste procure une sensation de chaleur mais n'est pas adaptée aux conditions climatiques difficiles."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat3.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pardessus"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 16
RECIPE.result = {["torso_green_jacket"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_overcoat_grey"
RECIPE.name = "Pardessus - Gris"
RECIPE.description = "Couramment utilisée par la population, cette veste procure une sensation de chaleur mais n'est pas adaptée aux conditions climatiques difficiles."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat3.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pardessus"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 16
RECIPE.result = {["overcoat_grey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_overcoat_orange"
RECIPE.name = "Pardessus - Orange"
RECIPE.description = "Couramment utilisée par la population, cette veste procure une sensation de chaleur mais n'est pas adaptée aux conditions climatiques difficiles."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat3.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pardessus"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 16
RECIPE.result = {["overcoat_orange"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_overcoat_purple"
RECIPE.name = "Pardessus - Violet"
RECIPE.description = "Couramment utilisée par la population, cette veste procure une sensation de chaleur mais n'est pas adaptée aux conditions climatiques difficiles."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat3.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pardessus"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 16
RECIPE.result = {["overcoat_purple"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_overcoat_red"
RECIPE.name = "Pardessus - Rouge"
RECIPE.description = "Couramment utilisée par la population, cette veste procure une sensation de chaleur mais n'est pas adaptée aux conditions climatiques difficiles."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat3.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pardessus"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 16
RECIPE.result = {["overcoat_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_overcoat_teal"
RECIPE.name = "Pardessus - Cyan"
RECIPE.description = "Couramment utilisée par la population, cette veste procure une sensation de chaleur mais n'est pas adaptée aux conditions climatiques difficiles."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat3.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pardessus"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 16
RECIPE.result = {["overcoat_teal"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_overcoat_brown"
RECIPE.name = "Pardessus - Marron"
RECIPE.description = "Couramment utilisée par la population, cette veste procure une sensation de chaleur mais n'est pas adaptée aux conditions climatiques difficiles."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat3.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pardessus"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 16
RECIPE.result = {["overcoat_brown"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_overcoat_shady"
RECIPE.name = "Pardessus - Obscur"
RECIPE.description = "Couramment utilisée par la population, cette veste procure une sensation de chaleur mais n'est pas adaptée aux conditions climatiques difficiles."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat3.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pardessus"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 16
RECIPE.result = {["overcoat_shady"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_overcoat_murky"
RECIPE.name = "Pardessus - Vert Foncé"
RECIPE.description = "Couramment utilisée par la population, cette veste procure une sensation de chaleur mais n'est pas adaptée aux conditions climatiques difficiles."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat3.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pardessus"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 16
RECIPE.result = {["overcoat_murky"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Blouson --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_zipper_black"
RECIPE.name = "Blouson - Noir"
RECIPE.description = "Une veste confortable couramment portée avec une fermeture éclair pour se tenir au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat4.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Blousons"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["zipper_black"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_zipper_blue"
RECIPE.name = "Blouson - Bleu"
RECIPE.description = "Une veste confortable couramment portée avec une fermeture éclair pour se tenir au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat4.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Blousons"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["zipper_blue"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_zipper_green"
RECIPE.name = "Blouson - Vert"
RECIPE.description = "Une veste confortable couramment portée avec une fermeture éclair pour se tenir au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat4.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Blousons"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["zipper_green"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_zipper_grey"
RECIPE.name = "Blouson - Gris"
RECIPE.description = "Une veste confortable couramment portée avec une fermeture éclair pour se tenir au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat4.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Blousons"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["torso_grey_jacket"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_zipper_orange"
RECIPE.name = "Blouson - Orange"
RECIPE.description = "Une veste confortable couramment portée avec une fermeture éclair pour se tenir au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat4.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Blousons"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["zipper_orange"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_zipper_purple"
RECIPE.name = "Blouson - Violet"
RECIPE.description = "Une veste confortable couramment portée avec une fermeture éclair pour se tenir au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat4.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Blousons"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["zipper_purple"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_zipper_red"
RECIPE.name = "Blouson - Rouge"
RECIPE.description = "Une veste confortable couramment portée avec une fermeture éclair pour se tenir au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat4.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Blousons"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["zipper_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_zipper_oldburgundy"
RECIPE.name = "Blouson - Bordeaux"
RECIPE.description = "Une veste confortable couramment portée avec une fermeture éclair pour se tenir au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat4.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Blousons"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["zipper_oldburgundy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_zipper_kombu"
RECIPE.name = "Blouson - Vert Kombu"
RECIPE.description = "Une veste confortable couramment portée avec une fermeture éclair pour se tenir au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat4.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Blousons"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["zipper_kombu"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_zipper_taupe"
RECIPE.name = "Blouson - Taupe"
RECIPE.description = "Une veste confortable couramment portée avec une fermeture éclair pour se tenir au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat4.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Blousons"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["zipper_taupe"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Vestes d'intempéries --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_weather_black"
RECIPE.name = "Veste d'intempéries - Noire"
RECIPE.description = "Une veste adaptée pour tenir à distance les conditions météorologiques les plus rudes, bien au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat10.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes d'intempéries"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["weather_black"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_weather_blue"
RECIPE.name = "Veste d'intempéries - Bleue"
RECIPE.description = "Une veste adaptée pour tenir à distance les conditions météorologiques les plus rudes, bien au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat10.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes d'intempéries"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["weather_blue"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_weather_brown"
RECIPE.name = "Veste d'intempéries - Marron"
RECIPE.description = "Une veste adaptée pour tenir à distance les conditions météorologiques les plus rudes, bien au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat10.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes d'intempéries"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["weather_brown"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_weather_burgundy"
RECIPE.name = "Veste d'intempéries - Bordeaux"
RECIPE.description = "Une veste adaptée pour tenir à distance les conditions météorologiques les plus rudes, bien au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat10.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes d'intempéries"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["weather_burgundy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_weather_darkblue"
RECIPE.name = "Veste d'intempéries - Bleue Foncée"
RECIPE.description = "Une veste adaptée pour tenir à distance les conditions météorologiques les plus rudes, bien au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat10.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes d'intempéries"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["weather_darkblue"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_weather_green"
RECIPE.name = "Veste d'intempéries - Verte"
RECIPE.description = "Une veste adaptée pour tenir à distance les conditions météorologiques les plus rudes, bien au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat10.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes d'intempéries"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["weather_green"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_weather_lavender"
RECIPE.name = "Veste d'intempéries - Lavande"
RECIPE.description = "Une veste adaptée pour tenir à distance les conditions météorologiques les plus rudes, bien au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat10.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes d'intempéries"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["weather_lavender"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_weather_orange"
RECIPE.name = "Veste d'intempéries - Orange"
RECIPE.description = "Une veste adaptée pour tenir à distance les conditions météorologiques les plus rudes, bien au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat10.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes d'intempéries"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["weather_orange"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_weather_purple"
RECIPE.name = "Veste d'intempéries - Violette"
RECIPE.description = "Une veste adaptée pour tenir à distance les conditions météorologiques les plus rudes, bien au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat10.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes d'intempéries"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["weather_purple"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_weather_red"
RECIPE.name = "Veste d'intempéries - Rouge"
RECIPE.description = "Une veste adaptée pour tenir à distance les conditions météorologiques les plus rudes, bien au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat10.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes d'intempéries"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["torso_red_jacket"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_weather_teal"
RECIPE.name = "Veste d'intempéries - Cyan"
RECIPE.description = "Une veste adaptée pour tenir à distance les conditions météorologiques les plus rudes, bien au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat10.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes d'intempéries"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["weather_teal"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_weather_white"
RECIPE.name = "Veste d'intempéries - Blanche"
RECIPE.description = "Une veste adaptée pour tenir à distance les conditions météorologiques les plus rudes, bien au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat10.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes d'intempéries"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["weather_white"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_weather_yellow"
RECIPE.name = "Veste d'intempéries - Jaune"
RECIPE.description = "Une veste adaptée pour tenir à distance les conditions météorologiques les plus rudes, bien au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat10.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes d'intempéries"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["weather_yellow"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_weather_murky"
RECIPE.name = "Veste d'intempéries - Obscure"
RECIPE.description = "Une veste adaptée pour tenir à distance les conditions météorologiques les plus rudes, bien au chaud."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat10.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vestes d'intempéries"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["weather_murky"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Laine --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_wool_blue"
RECIPE.name = "Laine - Bleue"
RECIPE.description = "Une chemise chaude en laine complétée par une veste sombre."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat5.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Laine"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 11
RECIPE.result = {["wool_blue"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_wool_burgundy"
RECIPE.name = "Laine - Bordeaux"
RECIPE.description = "Une chemise chaude en laine complétée par une veste sombre."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat5.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Laine"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 11
RECIPE.result = {["wool_burgundy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_wool_green"
RECIPE.name = "Laine - Verte"
RECIPE.description = "Une chemise chaude en laine complétée par une veste sombre."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat5.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Laine"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 11
RECIPE.result = {["wool_green"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_wool_grey"
RECIPE.name = "Laine - Grise"
RECIPE.description = "Une chemise chaude en laine complétée par une veste sombre."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat5.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Laine"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 11
RECIPE.result = {["torso_black_stylish_jacket"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_wool_orange"
RECIPE.name = "Laine - Orange"
RECIPE.description = "Une chemise chaude en laine complétée par une veste sombre."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat5.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Laine"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 11
RECIPE.result = {["wool_orange"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_wool_purple"
RECIPE.name = "Laine - Violette"
RECIPE.description = "Une chemise chaude en laine complétée par une veste sombre."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat5.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Laine"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 11
RECIPE.result = {["wool_purple"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_wool_red"
RECIPE.name = "Laine - Rouge"
RECIPE.description = "Une chemise chaude en laine complétée par une veste sombre."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat5.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Laine"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 11
RECIPE.result = {["wool_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_wool_brown"
RECIPE.name = "Laine - Marron"
RECIPE.description = "Une chemise chaude en laine complétée par une veste sombre."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat5.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Laine"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 11
RECIPE.result = {["wool_brown"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_wool_onyx"
RECIPE.name = "Laine - Onyx"
RECIPE.description = "Une chemise chaude en laine complétée par une veste sombre."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat5.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Laine"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 11
RECIPE.result = {["wool_onyx"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Veste collaborateur --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_white_suit_jacket"
RECIPE.name = "Veste - Blanche"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["torso_white_suit_jacket"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_collab_ice"
RECIPE.name = "Veste - Bleu cassé"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["collab_ice"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_collab_office"
RECIPE.name = "Veste - Bleue"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["collab_office"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_collab_office"
RECIPE.name = "Veste - Bleue clair"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["collab_bluedelight"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_blue_suit_jacket"
RECIPE.name = "Veste - Bleue Foncée"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["torso_blue_suit_jacket"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_blue_suit_jacket"
RECIPE.name = "Veste - Bleue Foncée"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["torso_blue_suit_jacket"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_collab_walkster"
RECIPE.name = "Veste - Chocolat"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["collab_walkster"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_collab_creme"
RECIPE.name = "Veste - Crème"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["collab_creme"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_collab_burgundy"
RECIPE.name = "Veste - Bordeaux"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["collab_burgundy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_collab_afternoon"
RECIPE.name = "Veste - Grise & bleu"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["collab_afternoon"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_collab_foreigner"
RECIPE.name = "Veste - Grise"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["collab_foreigner"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_collab_idealist"
RECIPE.name = "Veste - Grise foncée"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["collab_idealist"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_collab_fixer"
RECIPE.name = "Veste - Noire"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["collab_fixer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_collab_csual"
RECIPE.name = "Veste - Noire & bleu"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["collab_csual"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_collab_modnightred"
RECIPE.name = "Veste - Noire & rouge"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["collab_modnightred"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_collab_orangedawn"
RECIPE.name = "Veste - Orange"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["collab_orangedawn"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_collab_redhaven"
RECIPE.name = "Veste - Rouge"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["collab_redhaven"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_brown_suit_jacket"
RECIPE.name = "Veste - Saumon"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["torso_brown_suit_jacket"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_collab_fixer"
RECIPE.name = "Veste - Verte foncée"
RECIPE.description = "Une veste confortable pour les collaborateurs en soutien au régime."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Veste collaborateur"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["collab_fixer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Manteau à carreaux --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_plaid_blue"
RECIPE.name = "Veste à carreaux - Bleue"
RECIPE.description = "Une veste à carreaux d'inspiration écossaise capable de vous garder au chaud et à l'aise."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat6.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Manteaux à carreaux"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["plaid_blue"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_plaid_brown"
RECIPE.name = "Veste à carreaux - Marron"
RECIPE.description = "Une veste à carreaux d'inspiration écossaise capable de vous garder au chaud et à l'aise."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat6.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Manteaux à carreaux"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["plaid_brown"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_plaid_dark"
RECIPE.name = "Veste à carreaux - Noire"
RECIPE.description = "Une veste à carreaux d'inspiration écossaise capable de vous garder au chaud et à l'aise."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat6.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Manteaux à carreaux"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["plaid_dark"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_plaid_green"
RECIPE.name = "Veste à carreaux - Verte"
RECIPE.description = "Une veste à carreaux d'inspiration écossaise capable de vous garder au chaud et à l'aise."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat6.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Manteaux à carreaux"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["plaid_green"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_plaid_lightbrown"
RECIPE.name = "Veste à carreaux - Marron Clair"
RECIPE.description = "Une veste à carreaux d'inspiration écossaise capable de vous garder au chaud et à l'aise."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat6.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Manteaux à carreaux"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["plaid_lightbrown"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_plaid_lightred"
RECIPE.name = "Veste à carreaux - Rouge Claire"
RECIPE.description = "Une veste à carreaux d'inspiration écossaise capable de vous garder au chaud et à l'aise."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat6.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Manteaux à carreaux"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["torso_plaid_jacket"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_plaid_purple"
RECIPE.name = "Veste à carreaux - Violette"
RECIPE.description = "Une veste à carreaux d'inspiration écossaise capable de vous garder au chaud et à l'aise."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat6.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Manteaux à carreaux"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["plaid_purple"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_plaid_red"
RECIPE.name = "Veste à carreaux - Rouge"
RECIPE.description = "Une veste à carreaux d'inspiration écossaise capable de vous garder au chaud et à l'aise."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat6.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Manteaux à carreaux"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["plaid_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_plaid_darkgrey"
RECIPE.name = "Veste à carreaux - Grise Foncée"
RECIPE.description = "Une veste à carreaux d'inspiration écossaise capable de vous garder au chaud et à l'aise."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat6.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Manteaux à carreaux"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["plaid_darkgrey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_plaid_lightgrey"
RECIPE.name = "Veste à carreaux - Grise Claire"
RECIPE.description = "Une veste à carreaux d'inspiration écossaise capable de vous garder au chaud et à l'aise."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat6.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Manteaux à carreaux"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["plaid_lightgrey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_plaid_darkbrown"
RECIPE.name = "Veste à carreaux - Marron Foncée"
RECIPE.description = "Une veste à carreaux d'inspiration écossaise capable de vous garder au chaud et à l'aise."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat6.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Manteaux à carreaux"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["plaid_darkbrown"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Khaki --
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_khaki_black"
RECIPE.name = "Khaki - Noir"
RECIPE.description = "Une veste kaki de bonne qualité. Elle vous tient chaud et possède de nombreuses poches."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat8.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Khaki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 17
RECIPE.result = {["khaki_black"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()


local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_khaki_blue"
RECIPE.name = "Khaki - Bleu"
RECIPE.description = "Une veste kaki de bonne qualité. Elle vous tient chaud et possède de nombreuses poches."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat8.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Khaki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 17
RECIPE.result = {["khaki_blue"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_khaki_brown"
RECIPE.name = "Khaki - Marron"
RECIPE.description = "Une veste kaki de bonne qualité. Elle vous tient chaud et possède de nombreuses poches."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat8.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Khaki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 17
RECIPE.result = {["torso_khaki_jacket"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_khaki_green"
RECIPE.name = "Khaki - Vert"
RECIPE.description = "Une veste kaki de bonne qualité. Elle vous tient chaud et possède de nombreuses poches."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat8.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Khaki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 17
RECIPE.result = {["khaki_green"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_khaki_grey"
RECIPE.name = "Khaki - Gris"
RECIPE.description = "Une veste kaki de bonne qualité. Elle vous tient chaud et possède de nombreuses poches."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat8.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Khaki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 17
RECIPE.result = {["khaki_grey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_khaki_orange"
RECIPE.name = "Khaki - Orange"
RECIPE.description = "Une veste kaki de bonne qualité. Elle vous tient chaud et possède de nombreuses poches."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat8.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Khaki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 17
RECIPE.result = {["khaki_orange"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_khaki_purple"
RECIPE.name = "Khaki - Violet"
RECIPE.description = "Une veste kaki de bonne qualité. Elle vous tient chaud et possède de nombreuses poches."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat8.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Khaki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 17
RECIPE.result = {["khaki_purple"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_khaki_red"
RECIPE.name = "Khaki - Rouge"
RECIPE.description = "Une veste kaki de bonne qualité. Elle vous tient chaud et possède de nombreuses poches."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat8.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Khaki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 17
RECIPE.result = {["khaki_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_khaki_matterhorn"
RECIPE.name = "Khaki - Chocolat"
RECIPE.description = "Une veste kaki de bonne qualité. Elle vous tient chaud et possède de nombreuses poches."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat8.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Khaki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 17
RECIPE.result = {["khaki_matterhorn"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_khaki_shuttle"
RECIPE.name = "Khaki - Cyan"
RECIPE.description = "Une veste kaki de bonne qualité. Elle vous tient chaud et possède de nombreuses poches."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat8.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Khaki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 17
RECIPE.result = {["khaki_shuttle"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_torso_khaki_hurricane"
RECIPE.name = "Khaki - Marron Foncé"
RECIPE.description = "Une veste kaki de bonne qualité. Elle vous tient chaud et possède de nombreuses poches."
RECIPE.model = "models/willardnetworks/clothingitems/torso_alyxcoat8.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Khaki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 17
RECIPE.result = {["khaki_hurricane"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register() 

-- Sacs --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_satchel"
RECIPE.name = "Sacoche"
RECIPE.description = "Une petite sacoche qui repose sur votre hanche."
RECIPE.model = "models/willardnetworks/clothingitems/satchel.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Sacs"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["smallbag"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_backpack"
RECIPE.name = "Sac à dos"
RECIPE.description = "Un petit sac à dos avec le timbre Combine dessus."
RECIPE.model = "models/willardnetworks/clothingitems/backpack.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Sacs"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 17
RECIPE.result = {["largebag"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()


-- Pantalon de combinaison --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_jumpsuit_black"
RECIPE.name = "Pantalon de combinaison - Noir"
RECIPE.description = "Pantalon conforme aux normes de l'Union, assorti à son look morne."
RECIPE.model = "models/willardnetworks/clothingitems/legs_jumpsuit_recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon de combinaison"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 9
RECIPE.result = {["legs_jumpsuit_black"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_jumpsuit_blue"
RECIPE.name = "Pantalon de combinaison - Bleu"
RECIPE.description = "Pantalon conforme aux normes de l'Union, assorti à son look morne."
RECIPE.model = "models/willardnetworks/clothingitems/legs_jumpsuit_recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon de combinaison"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 9
RECIPE.result = {["legs_jumpsuit_blue"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_jumpsuit_brown"
RECIPE.name = "Pantalon de combinaison - Marron"
RECIPE.description = "Pantalon conforme aux normes de l'Union, assorti à son look morne."
RECIPE.model = "models/willardnetworks/clothingitems/legs_jumpsuit_recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon de combinaison"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 9
RECIPE.result = {["legs_jumpsuit_brown"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_jumpsuit_green"
RECIPE.name = "Pantalon de combinaison - Vert"
RECIPE.description = "Pantalon conforme aux normes de l'Union, assorti à son look morne."
RECIPE.model = "models/willardnetworks/clothingitems/legs_jumpsuit_recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon de combinaison"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 9
RECIPE.result = {["legs_jumpsuit_green"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_jumpsuit_grey"
RECIPE.name = "Pantalon de combinaison - Gris"
RECIPE.description = "Pantalon conforme aux normes de l'Union, assorti à son look morne."
RECIPE.model = "models/willardnetworks/clothingitems/legs_jumpsuit_recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon de combinaison"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 9
RECIPE.result = {["legs_jumpsuit_grey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_jumpsuit_red"
RECIPE.name = "Pantalon de combinaison - Rouge"
RECIPE.description = "Pantalon conforme aux normes de l'Union, assorti à son look morne."
RECIPE.model = "models/willardnetworks/clothingitems/legs_jumpsuit_recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon de combinaison"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 9
RECIPE.result = {["legs_jumpsuit_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Pantalon --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_civ_beige"
RECIPE.name = "Pantalon - Beige"
RECIPE.description = "Un pantalon beige, usé et minable maintenant.. Mais fait pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["legs_civilian_beige"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_civ_black"
RECIPE.name = "Pantalon - Noir"
RECIPE.description = "Un pantalon noir, usé et minable maintenant.. Mais fait pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["legs_dark_grey_pants"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_civ_blue"
RECIPE.name = "Pantalon - Bleu"
RECIPE.description = "Un pantalon bleu, usé et minable maintenant.. Mais fait pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["legs_blue_pants"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_civ_brown"
RECIPE.name = "Pantalon - Marron"
RECIPE.description = "Un pantalon marron, usé et minable maintenant.. Mais fait pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["legs_civilian_brown"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_civ_darkgreen"
RECIPE.name = "Pantalon - Vert Foncé"
RECIPE.description = "Un pantalon vert foncé, usé et minable maintenant.. Mais fait pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["legs_green_pants"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_civ_darkgrey"
RECIPE.name = "Pantalon - Gris Foncé"
RECIPE.description = "Un pantalon gris foncé, usé et minable maintenant.. Mais fait pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["legs_grey_pants"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_civ_darkred"
RECIPE.name = "Pantalon - Rouge Foncé"
RECIPE.description = "Un pantalon rouge foncé, usé et minable maintenant.. Mais fait pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["legs_civilian_darkred"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_civ_green"
RECIPE.name = "Pantalon - Vert"
RECIPE.description = "Un pantalon vert, usé et minable maintenant.. Mais fait pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["legs_civilian_green"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_civ_grey"
RECIPE.name = "Pantalon - Gris"
RECIPE.description = "Un pantalon gris, usé et minable maintenant.. Mais fait pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["legs_light_grey_pants"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_civ_lightblue"
RECIPE.name = "Pantalon - Bleu Clair"
RECIPE.description = "Un pantalon bleu clair, usé et minable maintenant.. Mais fait pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["legs_civilian_lightblue"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_civ_purple"
RECIPE.name = "Pantalon - Violet"
RECIPE.description = "Un pantalon violet, usé et minable maintenant.. Mais fait pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["legs_civilian_purple"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_civ_red"
RECIPE.name = "Pantalon - Rouge"
RECIPE.description = "Un pantalon rouge, usé et minable maintenant.. Mais fait pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["legs_civilian_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_civ_teal"
RECIPE.name = "Pantalon - Cyan"
RECIPE.description = "Un pantalon cyan, usé et minable maintenant.. Mais fait pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["legs_civilian_teal"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_legs_civ_yellow"
RECIPE.name = "Pantalon - Jaune"
RECIPE.description = "Un pantalon jaune, usé et minable maintenant.. Mais fait pour durer."
RECIPE.model = "models/willardnetworks/clothingitems/recolorable_pants.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalon"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["legs_civilian_yellow"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Bonnets --
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_brown"
RECIPE.name = "Bonnet - Marron"
RECIPE.description = "Un bonnet en laine marron, légèrement négligé. Chaud et confortable à poser sur la tête."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Bonnets"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["beanie_brown"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_grey"
RECIPE.name = "Bonnet - Gris"
RECIPE.description = "Un bonnet en laine gris, légèrement négligé. Chaud et confortable à poser sur la tête."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Bonnets"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["beanie_grey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_red"
RECIPE.name = "Bonnet - Rouge"
RECIPE.description = "Un bonnet en laine rouge, légèrement négligé. Chaud et confortable à poser sur la tête."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Bonnets"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["beanie_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_blue"
RECIPE.name = "Bonnet - Bleu"
RECIPE.description = "Un bonnet en laine bleu, légèrement négligé. Chaud et confortable à poser sur la tête."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Bonnets"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["head_blue_beanie"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_green"
RECIPE.name = "Bonnet - Vert"
RECIPE.description = "Un bonnet en laine vert, légèrement négligé. Chaud et confortable à poser sur la tête."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Bonnets"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["head_green_beanie"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Chapeaux spéciaux --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_boonie"
RECIPE.name = "Chapeau en toile"
RECIPE.description = "Un chapeau avec de larges bords. Idéal pour faire face au soleil."
RECIPE.model = "models/willardnetworks/clothingitems/head_boonie.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chapeaux"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["head_boonie_hat"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_cap"
RECIPE.name = "Bérêt"
RECIPE.description = "Un bérêt old-school, élégant à mettre sur la tête."
RECIPE.model = "models/willardnetworks/clothingitems/head_hat2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chapeaux"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["head_flat_cap"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_visor"
RECIPE.name = "Casquette"
RECIPE.description = "Un chapeau avec une visière. Protège vos pauvres petits yeux."
RECIPE.model = "models/willardnetworks/clothingitems/head_hat.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chapeaux"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["head_visor_cap"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "head_military_cap"
RECIPE.name = "Casquette militaire"
RECIPE.description = "Une casquette avec des insignes militaires usés."
RECIPE.model = "models/willardnetworks/clothingitems/head_confederatehat.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chapeaux"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["head_military_cap"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Fedora --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "head_fedora_brown"
RECIPE.name = "Fedora - Marron"
RECIPE.description = "Un rare chapeau élégant qui rappel le bon vieux temps."
RECIPE.model = "models/willardnetworks/clothingitems/head_fedora_recolorable.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chapeaux élégants - LOYALISTE"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["fedora_brown"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "head_fedora_black"
RECIPE.name = "Fedora - Noir"
RECIPE.description = "Un rare chapeau élégant qui rappel le bon vieux temps."
RECIPE.model = "models/willardnetworks/clothingitems/fedora_item.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chapeaux élégants - LOYALISTE"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["head_fedora"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "head_fedora_white"
RECIPE.name = "Fedora Blanc"
RECIPE.description = "Un rare chapeau élégant qui rappel le bon vieux temps."
RECIPE.model = "models/willardnetworks/clothingitems/head_fedora_recolorable.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chapeaux élégants - LOYALISTE"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["fedora_white"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Lunettes --

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_glasses"
RECIPE.name = "Lunettes"
RECIPE.description = "Une paire de lunettes noires, à monture carrée. Vous aide à mieux voir."
RECIPE.model = "models/willardnetworks/clothingitems/glasses.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Accessoires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["glasses"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_aviators"
RECIPE.name = "Lunettes d'aviateurs"
RECIPE.description = "Une paire de lunettes d'aviateurs, qui rappelle le bon vieux temps."
RECIPE.model = "models/willardnetworks/clothingitems/head_aviators.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Accessoires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["aviators"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_70s"
RECIPE.name = "Lunettes des années 70'"
RECIPE.description = "Une paire de lunettes vintage des années 70 avec une monture marron."
RECIPE.model = "models/willardnetworks/clothingitems/head_glasses_70s.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Accessoires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["70sglasses"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_gloves"
RECIPE.name = "Gants"
RECIPE.description = "Une paire de gants. Parfaite pour le travail, la météo, ou autre."
RECIPE.model = "models/willardnetworks/clothingitems/hands_glove.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Gants"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 7
RECIPE.result = {["hands_gloves"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tipless_gloves"
RECIPE.name = "Mitaines"
RECIPE.description = "Une paire de mitaines. Laissez vos doigts libres !"
RECIPE.model = "models/willardnetworks/clothingitems/hands_glove_fingerless.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Gants"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 7
RECIPE.result = {["hands_tipless_gloves"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Chaussures usées --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_worn_dark"
RECIPE.name = "Chaussures Sombres - Usées"
RECIPE.description = "Une paire de chaussures sombres, usées et fatiguées... Elles en ont trop vu."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_military.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chaussures"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["shoes_worn_dark"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_worn_brown"
RECIPE.name = "Chaussures Marron - Usées"
RECIPE.description = "Une paire de chaussures marron, usées et fatiguées... Elles en ont trop vu."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_military.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chaussures"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["shoes_worn_brown"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Chaussures --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_black"
RECIPE.name = "Chaussures - Noires"
RECIPE.description = "Une paire de chaussures robustes pour les routes et chemins qui ne sont plus entretenus."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chaussures"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["shoes_black_shoes"] = 1} -- Old ID name, to let players keep item on update
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_darkblue"
RECIPE.name = "Chaussures - Bleu Foncé"
RECIPE.description = "Une paire de chaussures robustes pour les routes et chemins qui ne sont plus entretenus."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chaussures"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["shoes_blue_shoes"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_grey"
RECIPE.name = "Chaussures - Grises"
RECIPE.description = "Une paire de chaussures robustes pour les routes et chemins qui ne sont plus entretenus."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chaussures"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["shoes_grey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_brown"
RECIPE.name = "Chaussures - Marrons"
RECIPE.description = "Une paire de chaussures robustes pour les routes et chemins qui ne sont plus entretenus."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chaussures"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["shoes_brown_shoes"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_red"
RECIPE.name = "Chaussures - Rouge Foncé"
RECIPE.description = "Une paire de chaussures robustes pour les routes et chemins qui ne sont plus entretenus."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chaussures"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["shoes_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Chaussures en cuir --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_leather_dark"
RECIPE.name = "Bottes en cuir foncé"
RECIPE.description = "Une paire de bottes en cuir sombre et durable, prêtes pour le long voyage à venir."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_boots.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chaussures"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 11
RECIPE.result = {["shoes_leather_dark"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_leather_brown"
RECIPE.name = "Bottes en cuir marron"
RECIPE.description = "Une paire de bottes en cuir marron résistantes, prêtes pour le long voyage à venir."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_boots.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Chaussures"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 11
RECIPE.result = {["shoes_leather_brown"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()
