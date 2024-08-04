--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Bag System"
PLUGIN.author = "Fruity & Aspect™"
PLUGIN.description = "Un système de sac simple."

ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_plugin.lua")

ix.lang.AddTable("english", {
	restrictedBag = "Cet inventaire ne peut pas contenir ce type d'objet !"
})

ix.lang.AddTable("french", {
	restrictedBag = "Cet inventaire ne peut pas contenir ce type d'objet !"
})

