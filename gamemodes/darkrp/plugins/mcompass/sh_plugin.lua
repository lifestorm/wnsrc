--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "mCompass"
PLUGIN.author = "Raven & Aspect™"
PLUGIN.description = "Adds mCompass, and slightly alters it to fit Willard."

ix.util.Include("cl_plugin.lua")

ix.option.Add("enableCompass", ix.type.bool, true, {category = "Civil Protection"})

ix.lang.AddTable("english", {
	optEnableCompass = "Pusulayı Etkinleştir",
	optdEnableCompass = "Pusula aktif olmalı mı?"
})
