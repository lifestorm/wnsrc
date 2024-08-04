--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


util.AddNetworkString("ixWNContainerPassword")

ix.allowedHoldableClasses["ix_wncontainer"] = true

ix.log.AddType("containerNameNew", function(client, ...)
	local arg = {...}
	return string.format("%s a défini le nom du conteneur '%s' sur '%s'.", client:Name(), arg[1], arg[2], arg[3])
end)

ix.log.AddType("containerPasswordNew", function(client, ...)
	local arg = {...}
	return string.format("%s a %s le mot de passe du stockage sur '%s' (#%s).", client:Name(), arg[3] and "défini" or "retiré", arg[1], arg[2])
end)

ix.log.AddType("containerSetPrivate", function(client, ...)
	local arg = {...}
	return string.format("%s a défini le stockage '%s' sur privé, détenu par '%s'.", client:Name(), arg[1], arg[2], arg[3])
end)

ix.log.AddType("containerSetPremium", function(client, ...)
	local arg = {...}
	return string.format("%s a défini le stockage '%s' sur %s.", client:Name(), arg[1], arg[2], arg[3] and "vip" or "non vip")
end)

ix.log.AddType("containerSetGroup", function(client, ...)
	local arg = {...}
	return string.format("%s a défini le stockage '%s' sur groupe / faction, détenu par '%s'.", client:Name(), arg[1], arg[2], arg[3])
end)

ix.log.AddType("containerSetPublic", function(client, ...)
	local arg = {...}
	return string.format("%s a défini le stockage '%s' sur publique.", client:Name(), arg[1], arg[2])
end)

ix.log.AddType("containerSetAdminText", function(client, ...)
	local arg = {...}
	return string.format("%s a défini le stockage '%s' container (#%s) admin text to '%s'.", client:Name(), arg[1], arg[2], arg[3])
end)

ix.log.AddType("containerSetManCleanup", function(client, ...)
	local arg = {...}
	return string.format("%s a défini le stockage '%s' sur nettoyage.", client:Name(), arg[1], arg[2])
end)

ix.log.AddType("containerAOpen", function(client, name, invID)
	return string.format("%s a effectué une recherche admin '%s'.", client:Name(), name, invID)
end)
ix.log.AddType("containerAClose", function(client, name, invID)
	return string.format("%s a effectué une recherche admin '%s'.", client:Name(), name, invID)
end)

net.Receive("ixWNContainerPassword", function(length, client)
	if ((client.ixNextContainerPassword or 0) > RealTime()) then
		client:Notify("Vous ne pouvez pas encore faire une autre tentative de mot de passe. Veuillez attendre quelques secondes !")
		
		return
	end

	if (!playerPasswordAttempts) then
		playerPasswordAttempts = {}
	end

	if (!playerPasswordAttempts[client:SteamID()]) then
		playerPasswordAttempts[client:SteamID()] = 1
	elseif (playerPasswordAttempts[client:SteamID()] >= 10) then
		client:Notify("Vous avez fait trop de tentatives de mot de passe erroné !")

		return
	end

	local entity = net.ReadEntity()
	local password = net.ReadString()
	local dist = entity:GetPos():DistToSqr(client:GetPos())

	if (dist < 16384 and password and password != "") then
		if (entity:GetPassword() == password) then
			entity:OpenInventory(client)
			entity.Sessions[client:GetCharacter():GetID()] = true
		else
			client:NotifyLocalized("wrongPassword")

			playerPasswordAttempts[client:SteamID()] = playerPasswordAttempts[client:SteamID()] + 1
		end
	end

	client.ixNextContainerPassword = RealTime() + 5
end)
