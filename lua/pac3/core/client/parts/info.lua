--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local BUILDER, PART = pac.PartTemplate("base")

PART.ClassName = "info"

PART.Group = ''
PART.Icon = 'icon16/help.png'

BUILDER:StartStorableVars()
	BUILDER:GetSet("SpawnEntity", "")
	BUILDER:GetSet("UserData", "")
BUILDER:EndStorableVars()