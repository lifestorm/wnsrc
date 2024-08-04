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

local PLUGIN = PLUGIN

PLUGIN.name = "Bird"
PLUGIN.author = "Aspect™ & Arny"
PLUGIN.description = "Adds the Bird faction, along with some other bird mechanics."

ix.util.Include("cl_hooks.lua")
ix.util.Include("cl_plugin.lua")
ix.util.Include("sh_commands.lua")
ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")

-- Thanks Whitehole
ix.anim.bird = {
    normal = {
        [ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE},
        [ACT_MP_CROUCH_IDLE] = {ACT_IDLE, ACT_IDLE},
        [ACT_MP_WALK] = {ACT_WALK, ACT_WALK},
        [ACT_MP_CROUCHWALK] = {ACT_WALK, ACT_WALK},
        [ACT_MP_RUN] = {ACT_RUN, ACT_RUN},
        [ACT_MP_JUMP] = {ACT_HOP, ACT_HOP},
        [ACT_MP_SWIM] = {ACT_FLY, ACT_FLY}
    }
}

ix.anim.SetModelClass("models/crow.mdl", "bird")
ix.anim.SetModelClass("models/pigeon.mdl", "bird")
ix.anim.SetModelClass("models/seagull.mdl", "bird")

ix.container.Register("models/fless/exodus/gnezdo.mdl", {
	name = "Nid d'oiseau",
	description = "Un petit nid d'Oiseaux, fait de bâtons de bois, de feuilles, etc.",
	width = 3,
	height = 3
})

ix.config.Add("birdRecogniseEachother", true, "Les Oiseauxx peuvent-ils se reconnaître entre eux ?.", nil, {
	category = "Oiseaux"
})

ix.config.Add("birdFlightSpeed", 100, "La vitesse à laquelle un Oiseaux peut voler.", nil, {
	data = {min = 0, max = 100},
	category = "Oiseaux"
})

ix.config.Add("birdHealth", 5, "La santé par défaut des Oiseauxx.", nil, {
	data = {min = 1, max = 100},
	category = "Oiseaux"
})

ix.config.Add("birdChat", true, "Permettre aux Oiseauxx de parler ?", nil, {
	category = "Oiseaux"
})

ix.config.Add("birdActions", true, "Les Oiseauxx peuvent-ils utiliser /moi et /c'est ?", nil, {
	category = "Oiseaux"
})

ix.config.Add("birdOOC", true, "Permettre aux Oiseauxx d'utiliser l'OOC ?", nil, {
	category = "Oiseaux"
})

ix.config.Add("birdRatio", 10, "Joueurs en ligne minimum", nil, {
	data = {min = 1, max = 100},
	category = "Oiseaux"
})
