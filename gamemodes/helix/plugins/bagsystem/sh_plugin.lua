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
PLUGIN.description = "A simple bag system."

ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_plugin.lua")

ix.lang.AddTable("english", {
	restrictedBag = "This inventory cannot hold this type of item!"
})
