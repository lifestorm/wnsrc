--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Tromix Monster Claw 12ga muzzle brake"
att.Icon = Material("vgui/entities/eft_attachments/muzzles/12g_cssclaw.png", "mips smooth")
att.Description = "Monster Claw muzzle brake from Tromix significantly reduces recoil and can be used for breaking of tempered glass."

att.SortOrder = 1

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_muzzle_12g"

att.SortOrder = 15

att.Model = "models/entities/eft_attachments/12gmuzzles/css_monster_caw_large.mdl"

att.ModelScale = Vector(1, 1, 1)

att.IsMuzzleDevice = true

att.Mult_HeatDissipation = 0.7

att.Mult_Recoil = 0.76
att.Mult_RecoilSide = 0.76
att.Mult_DrawTime = 1.06
att.Mult_SightTime = 1.06

att.Mult_MuzzleVelocity = 1.025

att.Add_BarrelLength = 6