--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Bird Egg"
ITEM.model = "models/willardnetworks/food/egg2.mdl"
ITEM.description = "A small, fertile egg. There may be tiny traces of excrement on it, if it has not been cleaned."

ITEM.functions.Hatch = {
	icon = "icon16/briefcase.png",
	OnRun = function(item)
		if (item:GetData("hatchTime", 0) < os.time()) then
			net.Start("birdEggHatch")
			net.Send(item.player)

			return false
		else
			item.player:Notify("This egg is not ready to hatch yet!")

			return false
		end
	end,
	OnCanRun = function(item)
		return item.player:Team() == FACTION_BIRD
	end
}
