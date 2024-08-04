--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ix.radio:RegisterChannel("pc", {
	name = "Protection Civile",
	color = Color(180, 226, 226, 255),
	icon = "willardnetworks/chat/cmb_shared_icon.png",
	--shortcutCommand = "Cmb" --automatically create commands to radio on this channel without switching to it
})

ix.radio:RegisterChannel("haa", {
	name = "Haute Autorité Administrative",
	color = Color(151, 161, 255, 255),
	icon = "willardnetworks/chat/ca_radio_icon.png",
	priority = 1
})

ix.radio:RegisterChannel("bc", {
	name = "Bureau de la Communication",
	color = Color(151, 161, 255, 255),
	icon = "willardnetworks/chat/ca_radio_icon.png",
	priority = 1
})

ix.radio:RegisterChannel("tac-3", {
	name = "TAC-3",
	color = Color(81, 208, 231, 255),
	icon = "willardnetworks/chat/cp_radio_icon.png",
	priority = 1
})

ix.radio:RegisterChannel("tac-4", {
	name = "TAC-4",
	color = Color(85, 169, 208, 255),
	icon = "willardnetworks/chat/cp_radio_icon.png",
	priority = 1
})

ix.radio:RegisterChannel("tac-5", {
	name = "TAC-5",
	color = Color(237, 222, 59, 255),
	icon = "willardnetworks/chat/dispatch_icon.png",
	priority = 0
})

ix.radio:RegisterChannel("ota", {
	name = "O.T.A",
	color = Color(222, 33, 33, 255),
	icon = "willardnetworks/chat/dispatch_icon.png",
	priority = 2
})


ix.radio:RegisterChannel("utc", {
	name = "Union des Travailleurs civils",
	color = Color(151, 161, 255, 255),
	icon = "willardnetworks/chat/ca_radio_icon.png",
	priority = 1
})

ix.radio:RegisterChannel("ucmr", {
	name = "Union Civile de Médecine et de Recherche",
	color = Color(63, 142, 164, 255),
	icon = "willardnetworks/chat/ca_radio_icon.png",
	priority = 1
})

