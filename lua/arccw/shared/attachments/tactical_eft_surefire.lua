--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "X400 tactical flashlight"
att.Icon = Material("vgui/entities/eft_attachments/surefire_icon.png", "mips smooth")
att.Description = "SureFire X400 combined LED and red laser Weapon Light."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = {"eft_tactical"}

att.Model = "models/entities/eft_attachments/eft_tactical_surefire/models/eft_tactical_surefire.mdl"


att.KeepBaseIrons = true

att.Laser = false
att.LaserStrength = 3 / 5
att.LaserBone = "laser"

att.ColorOptionsTable = {Color(255, 0, 0)}

att.Mult_SightTime = 1.04
att.Mult_Recoil = 1
att.Mult_RecoilSide = 1
att.Mult_VisualRecoilMult = 1

att.Mult_SpeedMult = 0.99
att.Mult_SightedSpeedMult = 1

att.Flashlight = false
att.FlashlightFOV = 50
att.FlashlightFarZ = 512 -- how far it goes
att.FlashlightNearZ = 1 -- how far away it starts
att.FlashlightAttenuationType = ArcCW.FLASH_ATT_LINEAR -- LINEAR, CONSTANT, QUADRATIC are available
att.FlashlightColor = Color(255, 255, 255)
att.FlashlightTexture = "effects/flashlight001"
att.FlashlightBrightness = 4
att.FlashlightBone = "laser"

att.ToggleStats = {
    {
        PrintName = "Both",
        Laser = true,
        Flashlight = true,
        Mult_HipDispersion = 0.75,
        Mult_MoveDispersion = 0.75
    },
    {
        PrintName = "Laser",
        Laser = true,
        Mult_HipDispersion = 0.75,
        Mult_MoveDispersion = 0.75
    },
    {
        PrintName = "Light",
        Flashlight = true,
    },
    {
        PrintName = "Off",
    }
}