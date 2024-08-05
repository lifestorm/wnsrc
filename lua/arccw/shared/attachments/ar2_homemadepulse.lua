--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Homemade Pulse"
att.Icon = Material("entities/round.png")
att.Description = "A pulse round made from a pair of AA batteries found strewn about. It'll never round out of ammo as long as said user has suit-armor."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "ar2_ammo"

att.Override_Ammo = "AirboatGun"

att.Hook_Think = function(wep)
    if wep.Owner:Armor() >= 0 then
        wep.Owner:SetAmmo( wep.Owner:Armor(), 20)
    end
    
end

att.Hook_GetCapacity = function(wep, cap)
    return wep.Owner:Armor()
end

att.Mult_Damage = 0.7
att.Mult_DamageMin = 0.5