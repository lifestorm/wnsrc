--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Remake the connect & disconnect chat classes to stop the default ones.
function PLUGIN:InitializedChatClasses()
	ix.chat.classes["connect"] = nil
	ix.chat.classes["disconnect"] = nil

	ix.chat.Register("new_connect", {
		CanSay = function(_, speaker, text)
			return !IsValid(speaker)
		end,
		OnChatAdd = function(_, speaker, text)
			local icon = ix.util.GetMaterial("willardnetworks/chat/connected_icon.png")

			chat.AddText(icon, Color(151, 153, 152), L("playerConnected", text))
		end,
		noSpaceAfter = true
	})

	ix.chat.Register("new_disconnect", {
		CanSay = function(_, speaker, text)
			return !IsValid(speaker)
		end,
		OnChatAdd = function(_, speaker, text)
			local icon = ix.util.GetMaterial("willardnetworks/chat/disconnected_icon.png")

			chat.AddText(icon, Color(151, 153, 152), L("playerDisconnected", text))
		end,
		noSpaceAfter = true
	})

	ix.chat.Register("bastionPlayerDeath", {
		CanSay = function(_, speaker, text)
			return true
		end,
		OnChatAdd = function(_, speaker, text)
			local icon = ix.util.GetMaterial("icon16/user_red.png")

			chat.AddText(icon, Color(255, 0, 0), text)
		end,
		CanHear = function(_, speaker, listener)
			return listener:IsAdmin() and ix.option.Get(listener, "playerDeathNotification")
		end
	})
end
