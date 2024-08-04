--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Explosive Slugs"
att.Icon = Material("entities/acwatt_gauss_rifle_ammo.png")
att.Description = "Slug containing an explosive payload. Does less direct damage, and cannot penetrate surfaces.\nExplosive shell can take down various Combine vehicles."
att.Desc_Pros = {
    "+ Explosion on hit"
}
att.Desc_Cons = {
}
att.Slot = "gauss_rifle_bullet"
att.Override_DamageType = DMG_BURN

att.AutoStats = true
att.Mult_Penetration = 0
att.Mult_Damage = 0.6
att.Mult_DamageMin = 0.6
att.MagReducer = true
att.ActivateElements = {"reducedmag"}

att.Hook_BulletHit = function(wep, data)
    local ent = data.tr.Entity
    local effectdata = EffectData()
    effectdata:SetOrigin( data.tr.HitPos )
    util.Effect( "Explosion", effectdata)
    local rad = math.Clamp(math.ceil(wep:GetDamage(0)), 100, 500)
    util.BlastDamage(wep, wep:GetOwner(), data.tr.HitPos, rad, wep:GetDamage(data.range))
    if ent:IsValid() and ent:GetClass() == "npc_helicopter" then
        -- The Hunter Chopper is hardcoded to only take damage from HL2 airboat
        -- Screw you, Valve! Screw you!
        data.dmgtype = DMG_AIRBOAT
    end
end

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
end