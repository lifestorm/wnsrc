--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_breen_water"
RECIPE.name = "Canette d'eau"
RECIPE.description = "Une canette d'eau au goût étrange. C'est cependant rafraîchissant."
RECIPE.model = "models/props_junk/PopCan01a.mdl"
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["drink_breen_water"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_boboriginal"
RECIPE.name = "Bob Soda"
RECIPE.description = "L'étiquette se lit avec humour : Le doux goût accueillant d'origine du Bob Soda. Avertissement : Peut provoquer des saignements intestinaux graves et une légère fatigue oculaire."
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 4
RECIPE.category = "Soda"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["drink_boboriginal"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_banksoda_pink"
RECIPE.name = "Bank Soda Lite"
RECIPE.description = "La boisson alternative à faible teneur en sucre, fabriquée par la chaîne de production de Bank Soda. Régalez-vous avec les délices de ce soda diététique entièrement biologique."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 1
RECIPE.category = "Soda"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["drink_banksoda_pink"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_banksoda"
RECIPE.name = "Bank Soda"
RECIPE.description = "La boisson gazeuse de haute qualité fabriquée par Bank Soda. Laissez-vous séduire par les délices de ce concurrent sucré entièrement biologique."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 2
RECIPE.category = "Soda"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["drink_banksoda_grey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_c24"
RECIPE.name = "Bank Soda Red"
RECIPE.description = "Une canette rouge ornée de l'insigne de Cité Vingt-Quatre et de l'étiquette Bank Soda. À l'intérieur de la boisson gazeuse se trouve un liquide jaune-brun qui ressemble à la caféine, au goût amèrement tranchant et servile. Évoque un profond sentiment de patriotisme."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 3
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["drink_banksoda_c24"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_ocean"
RECIPE.name = "Bank Soda Blue"
RECIPE.description = "Une canette bleue avec un design ondulé évoquant le torrent océanique orné de l'emblème Bank Soda. À l'intérieur de la boisson gazeuse se trouve un liquide clair avec une légère teinte bleutée et une douceur acidulée, rappelant des saveurs telles que la framboise bleue et l'ananas."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 7
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["drink_banksoda_ocean"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_lager"
RECIPE.name = "Bank Soda Lager"
RECIPE.description = "Une canette blanche et marron ornée de l'emblème Bank Soda. À l'intérieur de la boisson gazeuse se trouve un liquide caramel luisant avec une texture crémeuse et riche, au goût doux-amer rappelant la salsepareille, la vanille et la Gaulthérie couchée."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 5
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["drink_banksoda_lager"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_licorice"
RECIPE.name = "Bank Soda Réglisse"
RECIPE.description = "Une canette rose, ornée de confettis et de chewing-gum, est décorée de l'emblème Bank Soda. À l'intérieur de la boisson gazeuse se trouve un liquide vert fluorescent d'origine inconnue, au goût d'un dessert mousseux à la vanille pour une saveur de bubblegum sucrée et piquante, rappelant les soda-pop."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 6
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["drink_banksoda_licorice"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_c8"
RECIPE.name = "Bank Soda Grape"
RECIPE.description = "A purple can with two wavy lines adorned with the Bank Soda emblem and images of grapes. Inside the carbonated beverage is a grape liquid with an artificially sweet, mildly sour, sugary flavour similar to grape."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 4
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["drink_banksoda_c8"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_banksoda_red"
RECIPE.name = "Bank Soda Oriental"
RECIPE.description = "Une canette rouge-violette ornée de l'emblème Bank Soda et de l'insigne du Combine. À l'intérieur de la boisson gazeuse se trouve un liquide vert fluorescent d'origine inconnue, et au lieu de saveurs uniques, elle présente un goût aigu, une odeur âcre et une acidité inhabituelle. Contient du plomb."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 0
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["drink_banksoda_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_proc_lemonade"
RECIPE.name = "Limonade Artificielle"
RECIPE.description = "Pas exactement la boisson la plus rafraîchissante. Il y a une légère touche d'arrière-goût métallique."
RECIPE.model = "models/props_junk/GlassBottle01a.mdl"
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["drink_proc_lemonade"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_proc_fruit_juice"
RECIPE.name = "Jus de fruit artificiel"
RECIPE.description = "Un liquide artificiel ressemblant à une sorte de jus de fruit."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_e.mdl"
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["drink_proc_fruit_juice"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_sparkling_water"
RECIPE.name = "Eau pétillante"
RECIPE.description = "Une canette d'eau rouge, un peu de pétillante. C'est assez sucré."
RECIPE.model = "models/willardnetworks/food/breencan1.mdl"
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_sparkling_water"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_coffee"
RECIPE.name = "Café"
RECIPE.description = "Une tasse de café chaud vous aide à rester alerte et éveillé pendant ces temps étranges."
RECIPE.model = "models/willardnetworks/food/coffee.mdl"
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_coffee"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_premium_water"
RECIPE.name = "Eau pétillante Premium"
RECIPE.description = "Il s'agit d'une canette d'eau très raffinée avec un goût très sucré. Pour une raison quelconque, elle vous fait vous sentir plus heureux...?"
RECIPE.model = "models/willardnetworks/food/breencan2.mdl"
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["drink_premium_water"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_lemonade"
RECIPE.name = "Limonade"
RECIPE.description = "Un verre de limonade rafraîchissante. Vous rappelle le passé."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_b.mdl"
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["drink_lemonade"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_fruit_juice"
RECIPE.name = "Jus de fruit"
RECIPE.description = "Un jus de fruit rafraîchissant au goût quelque peu authentique."
RECIPE.model = "models/props_junk/garbage_plasticbottle003a.mdl"
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 13
RECIPE.result = {["drink_fruit_juice"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_wi_coffee"
RECIPE.name = "Café Willard Industries"
RECIPE.description = "Une surdose peut entraîner de l'insomnie, de la diarrhée, de la fatigue, de la dépression, des cauchemars, des vomissements, des maux de tête, de l'anxiété ou la mort. Consultez un professionnel de la santé approuvé par Willard Industries en cas de décès consécutif à la consommation."
RECIPE.model = "models/willardnetworks/food/wi_coffee.mdl"
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["drink_wi_coffee"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobgrape"
RECIPE.name = "Bob Soda Grape"
RECIPE.description = "L'étiquette indique: Goût fruité doux ! Fabriqué à partir de raisins artificiels authentiques et infusé avec une pâte sablonneuse et boueuse"
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 0
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["drink_bobgrape"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobsurprise"
RECIPE.name = "Bob Soda Surprise"
RECIPE.description = "L'étiquette indique de manière humoristique: Le goût fort et marquant du soda à la cerise. Saveur intense, avec un goût unique garanti dans chaque canette ! Profitez d'une infusion aléatoire d'une multitude d'ingrédients, y compris de la viande de cerf artificielle et des copeaux de crayon !"
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 3
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["drink_bobsurprise"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobfizz"
RECIPE.name = "Bob Soda Fizz"
RECIPE.description = "L'étiquette indique: Citron, lime, sublime, sans la moindre bave ! Un goût frais et pétillant pour envoyer vos papilles gustatives en orbite !"
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 2
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_bobfizz"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobdark"
RECIPE.name = "Bob Soda Dark"
RECIPE.description = "L'étiquette indique: Le goût subtil et sensuel de notre édition 'Dark' érodera un morceau de votre âme mortelle à chaque gorgée ! Avertissement : veuillez consulter les professionnels de Willard Industries de votre région en cas d'hallucinations démoniaques"
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 1
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 13
RECIPE.result = {["drink_bobdark"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobenergy"
RECIPE.name = "Bob Soda Energy"
RECIPE.description = "L'étiquette indique: Avalez cette gâterie sucrée en une seule gorgée pour passer d'un monde à l'autre et devenir une énergie pure, en harmonie avec vous-même et l'univers."
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 6
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 13
RECIPE.result = {["drink_bobenergy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()


-- non-drinks

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_ciggie_pack"
RECIPE.name = "Paquet de cigarettes"
RECIPE.description = "Un paquet de cigarettes fabriqué par l'Union contenant 8 cigarettes."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack.mdl"
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["ciggie_pack"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_carddeck"
RECIPE.name = "Jeu de 52 cartes"
RECIPE.description = "Un jeu traditionnel de 52 cartes de cartes à jouer de couleur française."
RECIPE.model = "models/cards/stack.mdl"
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 31
RECIPE.result = {["card_deck"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_tea"
RECIPE.name = "Tasse de Thé"
RECIPE.description = "Réconfortant et chaud au toucher."
RECIPE.model = "models/props_junk/garbage_coffeemug001a.mdl"
RECIPE.category = "Sans Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_tea"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()