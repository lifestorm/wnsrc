--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "30-Round Black Bakelite Mag"
att.AbbrevName = "30-Round Mag (Black)"
att.Icon = Material("entities/att/ur_ak/magazines/545_30_b.png", "mips smooth")
att.Description = "Identical to the stock magazine, spray-painted black. Might suit your taste better."
att.Slot = {"ur_ak_mag"}
att.AutoStats = true
att.Desc_Neutrals = {
    "uc.cosmetic",
}

att.SortOrder = 99

att.HideIfBlocked = true

att.ActivateElements = {"mag_545_black"}
att.RequireFlags = {"cal_545"}