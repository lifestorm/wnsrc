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
	name = "Bird Nest",
	description = "A small bird nest, made of wooden sticks, leaves, etc.",
	width = 3,
	height = 3
})

ix.config.Add("birdRecogniseEachother", true, "Can birds recognise eachother?.", nil, {
	category = "Bird"
})

ix.config.Add("birdFlightSpeed", 100, "The speed at which a bird can fly.", nil, {
	data = {min = 0, max = 100},
	category = "Bird"
})

ix.config.Add("birdHealth", 5, "The default health of birds.", nil, {
	data = {min = 1, max = 100},
	category = "Bird"
})

ix.config.Add("birdChat", true, "Allow the birds to talk?", nil, {
	category = "Bird"
})

ix.config.Add("birdActions", true, "Allow the birds use /me and /it?", nil, {
	category = "Bird"
})

ix.config.Add("birdOOC", true, "Allow the birds use OOC?", nil, {
	category = "Bird"
})

ix.config.Add("birdRatio", 10, "How many other characters have to be on for a bird to be able to be played.", nil, {
	data = {min = 1, max = 100},
	category = "Bird"
})
