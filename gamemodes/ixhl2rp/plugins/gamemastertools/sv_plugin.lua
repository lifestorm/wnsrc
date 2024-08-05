--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

netstream.Hook("SaveGMData", function(client, player, text)
    if (!CAMI.PlayerHasAccess(client, "Helix - ViewInfo")) then return end
    player:GetCharacter():SetGmInfo(text)
end)

netstream.Hook("setAge", function(client, player, text)
    if (!CAMI.PlayerHasAccess(client, "Helix - ViewInfo")) then return end
    player:GetCharacter():SetAge(string.utf8upper(text))
end)

netstream.Hook("setHeight", function(client, player, text)
    if (!CAMI.PlayerHasAccess(client, "Helix - ViewInfo")) then return end
    player:GetCharacter():SetHeight(string.utf8upper(text))
end)

netstream.Hook("setEyeColor", function(client, player, text)
    if (!CAMI.PlayerHasAccess(client, "Helix - ViewInfo")) then return end
    player:GetCharacter():SetEyeColor(string.utf8upper(text))
end)

netstream.Hook("setPerception", function(client, player, number)
    if (!CAMI.PlayerHasAccess(client, "Helix - ViewInfo")) then return end
    player:GetCharacter():SetSpecial("perception", number)
end)

netstream.Hook("setAgility", function(client, player, number)
    if (!CAMI.PlayerHasAccess(client, "Helix - ViewInfo")) then return end
    player:GetCharacter():SetSpecial("agility", number)
end)

netstream.Hook("setIntelligence", function(client, player, number)
    if (!CAMI.PlayerHasAccess(client, "Helix - ViewInfo")) then return end
    player:GetCharacter():SetSpecial("intelligence", number)
end)

netstream.Hook("setStrength", function(client, player, number)
    if (!CAMI.PlayerHasAccess(client, "Helix - ViewInfo")) then return end
    player:GetCharacter():SetSpecial("strength", number)
end)

netstream.Hook("setBackground", function(client, player, background)
    if (!CAMI.PlayerHasAccess(client, "Helix - ViewInfo")) then return end
    player:GetCharacter():SetBackground(background)
end)

netstream.Hook("setDescription", function(client, player, desc)
    if (!CAMI.PlayerHasAccess(client, "Helix - ViewInfo")) then return end
    player:GetCharacter():SetDescription(string.Replace(desc, "\n", " "))
end)