--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Predator Pro v3 XHP35 HI flashlight"
att.Icon = Material("vgui/entities/eft_attachments/tactical/tactical_predator.png", "mips smooth")
att.Description = "Powerful flashlight in a heavy-duty frame, manufactured by Armytek."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = {"eft_tactical"}

att.Model = "models/entities/eft_attachments/tactical/eft_tactical_predator.mdl"
att.ModelOffset = Vector(0, -0, 0.2)
att.OffsetAng = Angle(180, 0, 0)

att.KeepBaseIrons = true

att.Laser = false
att.LaserStrength = 3 / 5
att.LaserBone = "laser"

att.ColorOptionsTable = {Color(255, 0, 0)}

att.Mult_SightTime = 1.05
att.Mult_Recoil = 1
att.Mult_RecoilSide = 1
att.Mult_VisualRecoilMult = 1

att.Mult_SpeedMult = 0.99
att.Mult_SightedSpeedMult = 0.95

att.Flashlight = false
att.FlashlightFOV = 25
att.FlashlightFarZ = 4096 -- how far it goes
att.FlashlightNearZ = 1 -- how far away it starts
att.FlashlightAttenuationType = ArcCW.FLASH_ATT_LINEAR -- LINEAR, CONSTANT, QUADRATIC are available
att.FlashlightColor = Color(180, 180, 255)
att.FlashlightTexture = "effects/flashlight001"
att.FlashlightBrightness = 16
att.FlashlightBone = "laser"

att.ToggleStats = {
    {
        PrintName = "On",
        Flashlight = true,
    },
    {
        PrintName = "Off",
    }
}