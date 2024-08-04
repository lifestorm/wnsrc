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

PLUGIN.name = "Item Giving Notify"
PLUGIN.author = "AleXXX_007"
PLUGIN.description = "Notifies superadmins when someone gives themself any item."

ix.lang.AddTable("english", {
	optItemGivingNotify = "Notification de give",
	optdItemGivingNotify = "Recevoir une notification lorsque quelqu'un utilise une forme quelconque de GiveItem (commande, spawnmenu, ...)"
})

ix.lang.AddTable("french", {
	optItemGivingNotify = "Notification de give",
	optdItemGivingNotify = "Recevoir une notification lorsque quelqu'un utilise une forme quelconque de GiveItem (commande, spawnmenu, ...)"
})

ix.lang.AddTable("spanish", {
	optItemGivingNotify = "Notificación GiveItem",
	optdItemGivingNotify = "Recibe una notificación cuando alguien use alguna forma de GiveItem (comandos, spawnmenu, ...)."
})

CAMI.RegisterPrivilege({
	Name = "Helix - Item Give Notify",
	MinAccess = "superadmin"
})

if (SERVER) then
	function PLUGIN:PlayerGaveItem(client, character, uniqueID, amount)
		for _, v in ipairs(player.GetAll()) do
			if (CAMI.PlayerHasAccess(v, "Helix - Item Give Notify") and client != v) then
				netstream.Start(v, "ixItemGiveNotify", client, character:GetPlayer(), uniqueID, amount)
			end
		end
	end

	function PLUGIN:PlayerSpawnedItem(client, pos, uniqueID)
		for _, v in ipairs(player.GetAll()) do
			if (CAMI.PlayerHasAccess(v, "Helix - Item Give Notify") and client != v) then
				netstream.Start(v, "ixItemSpawnNotify", client, pos, uniqueID)
			end
		end
	end
else
	ix.option.Add("itemGivingNotify", ix.type.bool, true, {
		category = "Administration",
		hidden = function()
			return !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Item Give Notify")
		end
	})

	netstream.Hook("ixItemGiveNotify", function(client, target, uniqueID, amount)
		if (!ix.option.Get("itemGivingNotify")) then return end
		if (!IsValid(target)) then return end

		local pos = target:GetPos()
		local text = client:GetName().." a donné à "..target:GetName().." : "..uniqueID.." x"..amount.."!"

		hook.Run("LogMark", pos, {
			datetime = os.time(),
			text = text.." Pos. Reçeveur",
			pos = pos
		})

		if (client != target) then
			local giverPos = client:GetPos()

			hook.Run("LogMark", giverPos, {
				datetime = os.time(),
				text = text.." Pos. Donneur",
				pos = giverPos
			})
		end

		LocalPlayer():NotifyLocalized(text)
		surface.PlaySound("common/warning.wav")
	end)

	netstream.Hook("ixItemSpawnNotify", function(client, pos, uniqueID)
		if (!ix.option.Get("itemGivingNotify")) then return end

		local text = (IsValid(client) and client:GetName() or "SOMEONE").." a spawn un "..uniqueID.." sur la position marquée !"

		hook.Run("LogMark", pos, {
			datetime = os.time(),
			text = text,
			pos = pos
		})

		LocalPlayer():NotifyLocalized(text)
		surface.PlaySound("common/warning.wav")
	end)
end
