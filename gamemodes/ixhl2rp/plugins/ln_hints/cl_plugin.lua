--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


net.Receive("ixInitializeHints", function()
	if (ix.option.Get("enableHints", true)) then
		if (timer.Exists("ixHintsTimer")) then
			return
		end

		timer.Create("ixHintsTimer", ix.option.Get("hintInterval", 300), 0, function()
			if (!LocalPlayer():GetCharacter()) then
				return
			end

			if (ix.gui.notices) then
				ix.gui.notices:AddNotice(ix.hints.stored[math.random(1, #ix.hints.stored)])
			end
		end)
	end
end)
