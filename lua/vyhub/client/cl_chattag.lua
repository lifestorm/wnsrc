--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local f = string.format

local color_red = Color(255, 0, 0)

if VyHub.Config.chat_tags and not DarkRP then
	hook.Add("OnPlayerChat", "vyhub_chattag_OnPlayerChat", function(ply, msg)
		if IsValid(ply) then
			local group = VyHub.Group:get(ply:GetUserGroup())

			if group then
				local teamcolor = team.GetColor(ply:Team())
				local deadTag = ""

				if not ply:Alive() then
					deadTag = f("*%s* ", VyHub.lang.other.dead)
				end

				chat.AddText(VyHub.Util:hex2rgb(group.color), "[", group.name, "]", " ", color_red, deadTag, teamcolor, ply:Nick(), color_white, ": ", msg)

				return true
			end
		end
	end)
end