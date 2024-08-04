--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLUGIN = PLUGIN

netstream.Hook("QueryDeleteLanguageLearningProgress", function(languageName)
	Derma_Query("J'apprends déjà : "..languageName..". Supprimer la progression ?", "Langage", "Oui", function()
		netstream.Start("QueryDeleteLanguageSuccess")
	end, "Non")
end)

function PLUGIN:DoVortShout(speaker)
	netstream.Start("ForceShoutAnim", speaker)
end

