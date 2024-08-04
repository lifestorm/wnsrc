--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if CLIENT then return end

-- We have to do a timer because there is no "PlayerGivenSWEP" or similar
hook.Add("PlayerGiveSWEP", "ArcCW_Autoload", function(ply, class, tbl)
    local weptbl = weapons.Get(class)
    if not weptbl or not weptbl.ArcCW then return end

    -- Mark the player's next weapon to get ammo restore
    ply.ArcCW_Sandbox_FirstSpawn = true
end)