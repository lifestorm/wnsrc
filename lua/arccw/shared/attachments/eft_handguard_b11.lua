--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Zenit B-11"
att.Icon = Material("vgui/entities/eft_aks74u/handguard_b11.png", "mips smooth")
att.Description = "The integrally machined B-11 foregrip is manufactured from aluminum alloy D16T with black coating and can be installed instead of the standard-issue foregrip on the AKS-74U. The foregrip is fitted with Picatinny rail mounts on three sides, allowing for the installation of additional equipment such as tactical foregrips, flashlights, and laser designators. Manufactured by Zenit."

att.SortOrder = 97

att.Desc_Pros = {
}
att.Desc_Cons = {
}

att.AutoStats = true

att.Mult_Recoil = 1.04
att.Mult_RecoilSide = 1.07

att.Mult_HipDispersion = 1.15
att.Mult_SpeedMult = 0.97

att.GivesFlags = {"lowerrail", "leftrail", "rightrail"}
att.ActivateElements = {"b11_handguard"}
att.Slot = "eftaks74u_handguard"

att.LHIK = false

att.Model = "models/entities/eft_attachments/handguard_b11/handguard_b11/models/eft_handguard_b11.mdl"