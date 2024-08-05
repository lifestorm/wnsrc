--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ix.option.Add("enableHints", ix.type.bool, true, {
	category = "appearance",
	OnChanged = function(oldValue, value)
		if (timer.Exists("ixHintsTimer")) then
			if (value) then
				timer.UnPause("ixHintsTimer") 
			else
				timer.Pause("ixHintsTimer")
			end
		end
	end
})

ix.option.Add("hintInterval", ix.type.number, 300, {
	category = "appearance",
	min = 1,
	max = 1800,
	OnChanged = function(oldValue, value)
		if (timer.Exists("ixHintsTimer")) then
			timer.Adjust("ixHintsTimer", value)
		end
	end
})
