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
local string = string
local derma = derma
local netstream = netstream
local hook = hook
local vgui = vgui
local surface = surface

local PLUGIN = PLUGIN

function PLUGIN:PopulateCharacterInfo(client, character, container)
	local maxLen = ix.config.Get("descriptionDisplayLength", 256)
	local descriptionText = character:GetDescription()

	if (string.utf8len(descriptionText) >= maxLen) then
		local fullDescription = container:AddRowAfter("description", "fullDescription")
		fullDescription:SetBackgroundColor(derma.GetColor("Info", container))
		fullDescription:SetText("Press E to see full description.")
		fullDescription:SizeToContents()
		fullDescription:SetZPos(100)
	end
end

netstream.Hook("ixExtendedDescription", function(client, edit)
	local character = client:GetCharacter()
	if (character) then
		if (character:IsVortigaunt() and character:GetConterminous() or client:IsCP() and client:GetNetVar("combineMaskEquipped", false)) then return end

		local characterName = hook.Run("GetCharacterName", client, "ic") or character:GetName()
		local panel = vgui.Create("ixExtendedDescription")
		panel:SetDescription(character:GetDescription())
		panel:SetEditable(edit)
		panel:SetTitle(characterName.."'s description")
		panel.characterId = character:GetID()

		surface.PlaySound("helix/ui/press.wav")
	end
end)
