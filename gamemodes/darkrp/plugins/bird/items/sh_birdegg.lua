--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Oeuf d'oiseau"
ITEM.model = "models/willardnetworks/food/egg2.mdl"
ITEM.description = "Cet objet fragile et délicat semble avoir été tout juste pondu. Sa coquille est lisse et possède une teinte délicate, comme si elle avait été peinte à l'aquarelle. On peut facilement imaginer les petits piaillements de l'oisillon qui grandira à l'intérieur de cet œuf."
ITEM.category = "Nourriture"

ITEM.functions.Hatch = {
	name = "Éclore",
	icon = "icon16/briefcase.png",
	OnRun = function(item)
		if (item:GetData("hatchTime", 0) < os.time()) then
			net.Start("birdEggHatch")
			net.Send(item.player)

			return false
		else
			item.player:Notify("L'oeuf n'est pas encore prêt d'éclore !")

			return false
		end
	end,
	OnCanRun = function(item)
		return item.player:Team() == FACTION_BIRD
	end
}
