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
PLUGIN.description = "Ajoute mCompass et le modifie légèrement pour s'adapter à Willard."

ix.util.Include("cl_plugin.lua")

ix.option.Add("enableCompass", ix.type.bool, true, {category = "Protection Civile"})

ix.lang.AddTable("english", {
	optEnableCompass = "Activer la boussole",
	optdEnableCompass = "Si la boussole est activée ou non."
})

ix.lang.AddTable("french", {
	optEnableCompass = "Activer la boussole",
	optdEnableCompass = "Si la boussole est activée ou non."
})
