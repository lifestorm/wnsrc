--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Ptasie jajo"
ITEM.model = "models/willardnetworks/food/egg2.mdl"
ITEM.description = "Małe jajo z którego niedługo wykluje się piskle."

ITEM.functions.Hatch = {
	icon = "icon16/briefcase.png",
	OnRun = function(item)
		if (item:GetData("hatchTime", 0) < os.time()) then
			net.Start("birdEggHatch")
			net.Send(item.player)

			return false
		else
			item.player:Notify("Jajo nie jest jeszcze gotowe do wyklucia!")

			return false
		end
	end,
	OnCanRun = function(item)
		return item.player:Team() == FACTION_BIRD
	end
}
