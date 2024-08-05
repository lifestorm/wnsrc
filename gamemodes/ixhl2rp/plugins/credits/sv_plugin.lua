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
local netstream = netstream
local isnumber = isnumber
local tonumber = tonumber


local PLUGIN = PLUGIN

function PLUGIN:PostLoadData()
    self.creditsMembers = ix.data.Get("EventCreditsMembers", {})
end

netstream.Hook("EventCreditsSaveTitleValues", function(client, titleValues, creditsMembers)
    if !client:IsAdmin() then return end

    if !isnumber(tonumber(titleValues[1])) or !isnumber(tonumber(titleValues[2])) then
        client:NotifyLocalized("Width or height of the title image was invalid.")
        return false
    end

    ix.config.Set("eventCreditsImageW", tonumber(titleValues[1]))
    ix.config.Set("eventCreditsImageH", tonumber(titleValues[2]))
    ix.config.Set("eventCreditsImageURL", titleValues[3])

    PLUGIN.creditsMembers = creditsMembers
    ix.data.Set("EventCreditsMembers", creditsMembers)

    client:NotifyLocalized("Updated event credits.")
end)