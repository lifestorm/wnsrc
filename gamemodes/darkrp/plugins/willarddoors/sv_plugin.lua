--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLUGIN = PLUGIN

ix.char.RegisterVar("ownedDoors", {
    field = "OwnedDoors",
    fieldType = ix.type.array,
    default = {},
    bNoDisplay = true,
    OnSet = function(character, value)
        if (character.vars.ownedDoors) then
            table.insert(
                character.vars.ownedDoors,
                #character.vars.ownedDoors + 1,
                value
            )
        else
            character.vars.ownedDoors = {value}
        end
    end,
    OnGet = function(character, _)
        return character.vars.ownedDoors or {}
    end
})

function PLUGIN:CanPlayerAccessDoor(client, door, access)
    for _, v in ipairs(client:GetCharacter():GetOwnedDoors()) do
        if (v == door:EntIndex()) then
            return true
        end
    end
end

util.AddNetworkString("OnDoorPrintOwners")
