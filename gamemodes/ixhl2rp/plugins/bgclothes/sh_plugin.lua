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

PLUGIN.name = "BG Clothes"
PLUGIN.author = "Fruity"
PLUGIN.description = "Simply just adds clothing items to the schema instead of framework."

function PLUGIN:LoadAllClothingItems()
    local mainDirectory = "ixhl2rp/plugins/bgclothes/items/bgclothes/"
    local toInclude = {
        "face", "hands", "head", "legs", "shoes", "torso", "torso/buttoned", "torso/casual", "torso/conscript", "torso/civiladmin",
        "torso/collaborator", "torso/denim", "torso/jumpsuit", "torso/khaki", "torso/medic", "torso/overcoat", "torso/plaid",
        "torso/raincoat", "torso/rebel", "torso/static", "torso/weatherjacket", "torso/wool",
        "torso/worker", "torso/worn", "torso/zipper", "legs/civiladmin", "legs/civilian", "legs/jumpsuit",
        "legs/rebel", "legs/worn"
    }

    for _, subDir in pairs(toInclude) do
        for _, v2 in ipairs(file.Find(mainDirectory..subDir.."/*.lua", "LUA")) do
            ix.item.Load(mainDirectory..subDir.."/".. v2, "base_bgclothes")
        end
    end
end

function PLUGIN:PluginLoaded()
    self:LoadAllClothingItems()
end