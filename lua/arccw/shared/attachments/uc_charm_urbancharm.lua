--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Urban Charm"
att.Description = "The icon of a Garry's Mod addon."

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "charm"

att.Free = true

att.Model = "models/weapons/arccw/atts/charmbase.mdl"

att.DroppedModel = "models/Items/BoxSRounds.mdl"

att.Charm = true
att.CharmModel = "models/weapons/arccw/atts/uc_urbancharm.mdl"
att.CharmAtt = "Charm"
att.CharmScale = Vector(0.5, 0.5, 0.5)
att.CharmOffset = Vector(0, -1.1, -0.2)
att.CharmAngle = Angle(20, 0, 80)
att.CharmSkin = 0

att.Ignore = true --Toggles need to be done

att.ToggleLockDefault = true
att.ToggleStats = {
    {
        PrintName = "Common",
        CharmSkin = 0,
    },
    {
        PrintName = "Decay",
        CharmSkin = 1,
    },
    {
        PrintName = "Renewal",
        CharmSkin = 2,
    },
    {
        PrintName = "Anarchy",
        CharmSkin = 3,
    },
    {
        PrintName = "Ordinance",
        CharmSkin = 4,
    }
}
