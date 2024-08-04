--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Incendary Pulse"
att.Icon = Material("entities/fireround.png")
att.Description = "Sets them on fire while doing more damage towards ignited targets"
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "ar2_ammo"

att.Hook_BulletHit = function(wep, data)
    if CLIENT then return end

    local ent = data.tr.Entity

    ent:Ignite(1, 300)

    if ent:IsOnFire() then
        ent:SetHealth(ent:Health() - 5)
        ent:EmitSound("ambient/fire/gascan_ignite1.wav", 75, 100, 100, CHAN_AUTO)
    end
end

att.Mult_Damage = 0.7
att.Mult_DamageMin = 0.5

att.Mult_Recoil = 0.5

att.Mult_ShootPitch = 1.2