--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Rebounding Slugs"
att.Icon = Material("entities/acwatt_gauss_rifle_ammo.png")
att.Description = "Slug with specialized head that ricochets off any surface or target for up to 40 times. Each bounce reduces damage, and hitting targets reduces damage further."
att.Desc_Pros = {
    "Slug bounces off surfaces"
}
att.Desc_Cons = {
    "Ricocheting slug can hit self",
    --"- Magazine capacity"
}
att.Slot = "gauss_rifle_bullet"

att.AutoStats = true
att.Mult_Penetration = 0
att.Mult_Precision = 8
att.MagReducer = true
att.Mult_Damage = 0.8
att.Mult_DamageMin = 0.8
--[[]
att.MagReducer = true
att.ActivateElements = {"reducedmag"}
]]

att.Hook_BulletHit = function(wep, data)
    if CLIENT then return end

    if data.tr.HitPos then
        local dir = data.tr.Normal - 2 * (data.tr.Normal:Dot(data.tr.HitNormal)) * data.tr.HitNormal
        local r = ents.Create("arccw_ricochet_gauss")
        r.FireTime = CurTime()
        r.Owner = wep.Owner
        r.Damage = math.ceil(data.tr.HitNonWorld and (data.damage * 0.75) or data.damage)
        r.Direction = dir
        r.Inflictor = wep
        r:SetPos(data.tr.HitPos)
        r:Spawn()

        return false
    end

end

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
end