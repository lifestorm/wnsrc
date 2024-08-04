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

netstream.Hook("ixNotesSet", function(client, characterId, text)
  if (CAMI.PlayerHasAccess(client, "Helix - Basic Admin Commands")) then
    local character = ix.char.loaded[characterId]

    if (character) then
      character:SetNotes(text)
      client:Notify("Notatki zostały pomyślnie zapisane.")
    else
      client:Notify("Nie znaleziono postaci.")
    end
  else
    client:Notify("Nie masz do tego uprawnień.")
  end
end)
