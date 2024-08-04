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
	Derma_Query("I am already learning "..languageName..", delete progress?", "Languages", "Yes", function()
		netstream.Start("QueryDeleteLanguageSuccess")
	end, "No")
end)

function PLUGIN:DoVortShout(speaker)
	netstream.Start("ForceShoutAnim", speaker)
end

