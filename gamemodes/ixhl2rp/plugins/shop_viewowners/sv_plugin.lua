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

util.AddNetworkString("ix.shopOverview.createPanel")

function PLUGIN:OpenShopInfo(client)
    if (!client:IsCombine() and !client:GetCharacter():HasFlags("U")) then
        return
    end

	local housing = ix.plugin.Get("housing")
	local housingApartments = housing.apartments
	local requiredInfo = {}

	for k, v in pairs(housingApartments) do
		if v.type == "shop" then
			requiredInfo[#requiredInfo + 1] = {
				shopName = v.name,
				tenants = table.GetKeys(v.tenants)
			}
		end
	end

	for k, v in pairs(requiredInfo) do
		for tKey, tenant in pairs(v.tenants) do
			housing:LookUpCardItemIDByCID(tostring(tenant), function(result)
				local idCardID = result[1].idcard or false
				local charID
				if !result then return end
				if !ix.item.instances[idCardID] then
					ix.item.LoadItemByID(idCardID, false, function(card)
						if !card then return end
						charID = card:GetData("owner")
					end)
				else
					charID = ix.item.instances[idCardID]:GetData("owner")
				end
				local character = ix.char.loaded[charID]
				if character then
					requiredInfo[k]["tenants"][tKey] = character:GetName()
				else
					local query = mysql:Select("ix_characters_data")
						query:Where("key", "genericdata")
						query:Where("id", tostring(charID))
						query:Select("data")
						query:Callback(function(genResult)
							if (!istable(genResult) or #genResult == 0) then
								return
							end
							local genericData = util.JSONToTable(genResult[1]["data"])

							requiredInfo[k]["tenants"][tKey] = genericData.name
						end)
					query:Execute()
				end
			end)
		end
	end

	timer.Simple(0.25, function()
        if !IsValid(client) then
            return
        end

		net.Start("ix.shopOverview.createPanel")
			net.WriteString(util.TableToJSON(requiredInfo))
		net.Send(client)
	end)
end