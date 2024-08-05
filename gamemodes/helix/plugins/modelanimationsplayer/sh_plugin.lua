--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

PLUGIN.name = "Model Animations Player"
PLUGIN.description = "Adds an interactable list of animations you can play on your character's model."
PLUGIN.author = "Mango"

ix.lang.AddTable("english", {
    MAcommandDesc = "Shows a menu with all the animations of a character's model, allowing you to play them with ease.",
    MAresetBtn = "RESET",
    MAsubmitBtn = "RUN ANIMATION"
})

CAMI.RegisterPrivilege({
	Name = "Helix - " .. PLUGIN.name,
	MinAccess = "admin"
})

ix.command.Add("modelAnims", {
    description = L"MAcommandDesc",
    adminOnly = true,
    OnRun = function(self, client)
        netstream.Start(client, "ixModelAnimationsShowMenu")
    end
})

ix.util.Include("cl_hooks.lua")
ix.util.Include("sv_hooks.lua")