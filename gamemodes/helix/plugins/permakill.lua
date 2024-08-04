--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Permakill"
PLUGIN.author = "Thadah Denyse"
PLUGIN.description = "Ajoute la mort permanente dans les options du serveur."

ix.config.Add("permakill", false, "Si permakill est activé ou non sur le serveur.", nil, {
	category = "Permakill"
})

ix.config.Add("permakillWorld", false, "Que le monde et les dommages à soi-même produisent ou non une mort permanente.", nil, {
	category = "Permakill"
})

function PLUGIN:PlayerDeath(client, inflictor, attacker)
	local character = client:GetCharacter()

	if (ix.config.Get("permakill") and character) then
		if (hook.Run("ShouldPermakillCharacter", client, character, inflictor, attacker) == false) then
			return
		end

		if (ix.config.Get("permakillWorld") and !(client == attacker or inflictor:IsWorld())) then
			return
		end

		character:SetData("permakilled", true)
	end
end

function PLUGIN:PlayerSpawn(client)
	local character = client:GetCharacter()

	if (ix.config.Get("permakill") and character and character:GetData("permakilled")) then
		character:Ban()
		character:SetData("permakilled")
	end
end
