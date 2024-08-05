--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local ix = ix


local PLUGIN = PLUGIN

PLUGIN.name = "Cigarettes"
PLUGIN.author = "Fruity"
PLUGIN.description = "Adds non PAC3 cigarettes."

ix.util.Include("sv_plugin.lua")

PLUGIN.allowedModels = {
    [1] = "models/willardnetworks/citizens/",
	[2] = "models/willardnetworks/vortigaunt.mdl",
	[3] = "models/wn7new/metropolice/",
	[4] = "models/wn7new/metropolice_c8/",
	[5] = "models/thomask_110/"
}

if (CLIENT) then
	ix.option.Add("firstPersonCigarette", ix.type.bool, true, {
		category = "Cigarettes"
	})
end

ix.lang.AddTable("english", {
	optFirstPersonCigarette = "Show Cigarette in First Person",
	optdFirstPersonCigarette = "Toggles whether you want the cigarette to show in first person or not."
})

ix.lang.AddTable("spanish", {
	optFirstPersonCigarette = "Mostrar el Cigarro en Primera Persona",
	optdFirstPersonCigarette = "Alterna si quieres que el cigarro se muestre en primera persona o no."
})
