--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Ammo types

local ammotable = {}
ammotable["556_M855"] = "556x45mm M855"
ammotable["556_M995"] = "556x45mm M995"
ammotable["556_HP"] = "556x45mm HP"

for v, k in pairs(ammotable) do
    game.AddAmmoType({
        name = v,
        dmgtype = DMG_BULLET,
        tracer = TRACER_LINE_AND_WHIZ
    })
    if CLIENT then
        language.Add( v .. "_ammo", k )
    end
end