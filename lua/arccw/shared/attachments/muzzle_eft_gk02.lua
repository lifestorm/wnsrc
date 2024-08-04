--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "GK-02 12ga muzzle brake"
att.Icon = Material("vgui/entities/eft_attachments/muzzles/12g_muzzle_gk02.png", "mips smooth")
att.Description = "The Ilyin GK-02 muzzle brake is a modernized and improved version of Vsevolod Ilyin's muzzle brake, with enhanced recoil and muzzle climb reduction capabilities."

att.SortOrder = 1

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_muzzle_12g"

att.SortOrder = 15

att.Model = "models/entities/eft_attachments/12gmuzzles/red_heat_gk-02_12g.mdl"

att.ModelScale = Vector(1, 1, 1)

att.IsMuzzleDevice = true

att.Mult_HeatDissipation = 0.7

att.Mult_Recoil = 0.86
att.Mult_RecoilSide = 0.86
att.Mult_DrawTime = 1.02
att.Mult_SightTime = 1.02

att.Mult_MuzzleVelocity = 1.05

att.Add_BarrelLength = 4