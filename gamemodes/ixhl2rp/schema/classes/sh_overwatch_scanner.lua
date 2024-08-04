--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

CLASS.name = "Overwatch Scanner"
CLASS.description = "An Overwatch scanner, it utilises Combine technology."
CLASS.faction = FACTION_OVERWATCH

function CLASS:CanSwitchTo(client)
    return Schema:IsCombineRank(client:Name(), "SCN") or Schema:IsCombineRank(client:Name(), "Disp:AI")
end

function CLASS:OnSpawn(client)
    local scanners = ix.plugin.list["scannerplugin"]

    if (scanners) then
        timer.Simple(0.1, function()
            scanners:CreateScanner(client, nil)
        end)
    end
end

CLASS_OW_SCANNER = CLASS.index
