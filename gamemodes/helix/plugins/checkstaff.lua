--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


if (!sam) then return end

PLUGIN.name = "Check Staff"
PLUGIN.author = "AleXXX_007"
PLUGIN.description = "Allows superadmins to check various info about server staff."

ix.command.Add("CheckStaff", {
	description = "Obtenez la liste des administrateurs avec leur dernier temps de jeu.",
	superAdminOnly = true,
	OnRun = function(self, client)
		local query = mysql:Select("sam_players")
			query:Select("steamid")
			query:Select("name")
			query:Select("rank")
			query:Select("last_join")
			query:Select("play_time")
			query:WhereNotLike("rank", "user")
			query:Callback(function(result)
				if (!result or !istable(result) or #result == 0) then
					client:NotifyLocalized("Aucun membre du STAFF trouvé!")
					return
				end

				for _, v in pairs(result) do
					local playTime = math.Round(v.play_time / 3600, 1)
					if (player.GetBySteamID(v.steamid)) then
						client:ChatPrint(v.name .. " (" .. v.steamid .. "), " .. v.rank .. " est actuellement en ligne. Temps de jeu total : " .. playTime .. " heures.")
					else
						client:ChatPrint(v.name .. " (" .. v.steamid .. "), " .. v.rank .. " est en ligne " .. os.date("%x %X", v.last_join) .. ". Temps de jeu total : " .. playTime .. " heures.")
					end
				end
			end)
    	query:Execute()
	end
})
