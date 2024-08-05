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

function PLUGIN:CreateMenuButtons(tabs)
	tabs["Group"] = {
	RowNumber = 4,
	Width = 23,
	Height = 17,
	Icon = "willardnetworks/tabmenu/charmenu/faction.png",
	Create = function(info, container)
		local panel = container:Add("ixGroup")
		ix.gui.group = panel
	end
	}
end

function PLUGIN:ShouldShowPlayerOnScoreboard(client, panel)
  if (!panel.group and client.group and !client.group.hidden and !panel.faction.separateUnknownTab) then
	return false
  end
end

local function SyncGroup(group)
  if (!group or table.IsEmpty(group)) then return end

  local id = group.id
  local stored = PLUGIN:FindGroup(id)

  local groupTable = stored or table.Copy(ix.meta.group)
  groupTable:FromTable(group)

  if (!stored) then
	PLUGIN.stored[id] = groupTable
  end

  local client = LocalPlayer()
  local character = client.GetCharacter and client:GetCharacter()

  if (character) then
	local clientGroup = character:GetGroup()

	if ((clientGroup and clientGroup.id == id or !clientGroup) and IsValid(ix.gui.group)) then
	  ix.gui.group:Rebuild()
	  netstream.Start("ixGroupRequestMembers", group.id)
	end

	if (IsValid(ix.gui.scoreboard)) then
	  ix.gui.scoreboard:Update()
	end
  end
end

local function SyncGroupThird(group)
	if (!group or table.IsEmpty(group)) then return end
  
	local id = group.id
	local stored = PLUGIN:FindGroup(id)
  
	local groupTable = table.Copy(ix.meta.group)
	groupTable:FromTableThird(group)
  
	PLUGIN.stored[id] = groupTable
  
	local client = LocalPlayer()
	local character = client.GetCharacter and client:GetCharacter()
  
	if (character) then
	  local clientGroup = character:GetGroup()
  
	  if ((clientGroup and clientGroup.id == id or !clientGroup) and IsValid(ix.gui.group)) then
		ix.gui.group:Rebuild()
		netstream.Start("ixGroupRequestMembers", group.id)
	  end
  
	  if (IsValid(ix.gui.scoreboard)) then
		ix.gui.scoreboard:Update()
	  end
	end
  end
  
netstream.Hook("ixGroupSync", function(group)
  SyncGroup(group)
end)

netstream.Hook("ixGroupSyncNotOwned", function(group)
	SyncGroupThird(group)
  end)

netstream.Hook("ixGroupSyncAll", function(groups)
  for _, v in pairs(groups) do
	SyncGroup(v)
  end
end)

netstream.Hook("ixGroupInvite", function(groupID, client)
	local group = PLUGIN:FindGroup(groupID)

	if (group) then
		local inviteUI = vgui.Create("ixGroupInvite")
		inviteUI.groupID = groupID
		inviteUI.nameText = group:GetName()
		inviteUI.whoInvited = client:GetName()
	end
end)

netstream.Hook("ixGroupSendMembers", function(members)
	if (IsValid(ix.gui.group)) then
		if ix.gui.group:IsVisible() then
			ix.gui.group.receivedMembers = members
			if ix.gui.group.lastSelected then
				if ix.gui.group.buttonlist then
					if ix.gui.group.buttonlist[ix.gui.group.lastSelected] then
						if ix.gui.group.buttonlist[ix.gui.group.lastSelected].DoClick() then
							timer.Simple(0.05, function()
								ix.gui.group.buttonlist[ix.gui.group.lastSelected].DoClick()
							end)
						end
					end
				end
			else
				if ix.gui.group.buttonlist[2] then
					timer.Simple(0.05, function()
						ix.gui.group.buttonlist[2].DoClick()
					end)
				end
			end
		end
	end
end)

function PLUGIN:GetPlayerESPText(client, toDraw, distance, alphaFar, alphaMid, alphaClose)
	if (!ix.option.Get("groupESP")) then return end

	local character = client:GetCharacter()
	local groupID = character:GetGroupID()
    if (groupID and groupID > 0 and self.stored[groupID]) then
		toDraw[#toDraw + 1] = {alpha = alphaClose, priority = 21, text = "Group: "..self.stored[groupID].name}
	end
end