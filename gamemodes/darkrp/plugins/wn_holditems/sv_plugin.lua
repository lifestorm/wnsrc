--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

function PLUGIN:PlayerSwitchWeapon( client, oldWeapon, newWeapon )
    if client.ixHoldingItemEnt and IsValid(client.ixHoldingItemEnt) then
        client.ixHoldingItemEnt:Remove()
    end
end