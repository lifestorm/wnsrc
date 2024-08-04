--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function PLUGIN:InitializedPlugins()
	local panelPlugin = ix.plugin.Get("3dpanel")

	if (panelPlugin) then
		ix.command.list["paneladd"].adminOnly = nil
		ix.command.list["paneladd"].OnCheckAccess = function() return true end -- eh
		ix.command.list["paneladd"].OnRun = function(self, client, url, scale, brightness)
			local character = client:GetCharacter()
			local panelItem = character:GetInventory():HasItem("paintcan") or character:GetInventory():HasItem("rolledposter")
			local group = character.GetGroup and character:GetGroup() or {}
			local groupname = group.name
			scale = scale or 1

			if ((panelItem and (client:Team() == FACTION_WORKERS or (groupname and groupname == "Department of Business"))) or CAMI.PlayerHasAccess(client, "Helix - Manage Panels")) then
				-- Get the position and angles of the panel.
				local trace = client:GetEyeTrace()
				local position = trace.HitPos
				local angles = trace.HitNormal:Angle()
				angles:RotateAroundAxis(angles:Up(), 90)
				angles:RotateAroundAxis(angles:Forward(), 90)

				if (panelItem) then
					panelItem:Remove()

					if (panelItem.uniqueID == "paintcan") then
						character:GetInventory():Add("junk_paintcan")
					end
				end

				-- Add the panel.
				panelPlugin:AddPanel(position + angles:Up() * 1, angles, url, math.min(scale, 5), brightness)
				return "@panelAdded"
			else
				return "You need to be CWU/DOB and have a paint can or rolled poster to add a panel!"
			end
		end

		ix.command.list["panelremove"].adminOnly = nil
		ix.command.list["panelremove"].OnCheckAccess = function() return true end -- eh
		ix.command.list["panelremove"].OnRun = function(self, client, radius)
			local character = client:GetCharacter()
			local group = character.GetGroup and character:GetGroup() or {}
			local groupname = group.name

			if (client:IsAdmin() or client:IsCombine() or client:Team() == FACTION_WORKERS or (groupname and groupname == "Department of Business")) then
				-- Get the origin to remove panel.
				local trace = client:GetEyeTrace()
				local position = trace.HitPos
				-- Remove the panel(s) and get the amount removed.
				local amount = panelPlugin:RemovePanel(position, math.min(radius or 100, 500))

				return "@panelRemoved", amount
			else
				return "@notAllowed"
			end
		end
	end
end
