--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local ix = ix

ix.observer = ix.observer or {}
ix.observer.types = ix.observer.types or {}

function ix.observer:RegisterESPType(type, func, optionName, optionNiceName, optionDesc, bDrawClamped)
    optionName = string.lower(optionName)
    local editCapital = string.utf8sub(optionName, 1, 1)
	local capitalName = string.utf8upper(editCapital)..string.utf8sub(optionName, 2)

    ix.option.Add(optionName.."ESP", ix.type.bool, false, {
        category = "observer",
        hidden = function()
            return !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Observer Extra ESP")
        end
    })
    ix.lang.AddTable("english", {
        ["opt"..capitalName.."ESP"] = optionNiceName or "Show "..capitalName.." ESP",
        ["optd"..capitalName.."ESP"] = optionDesc or "Turn on/off the "..optionName.." ESP."
    })

    ix.observer.types[string.lower(type)] = {optionName.."ESP", func, bDrawClamped}
end

function ix.observer:ShouldRenderAnyTypes()
    for _, v in pairs(ix.observer.types) do
        if (ix.option.Get(v[1])) then
            return true
        end
    end

    return false
end