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

PLUGIN.name = "Fake Names"
PLUGIN.author = "AleXXX_007"
PLUGIN.description = "Allows characters to recognize themselves with a fake name."

ix.util.Include("cl_hooks.lua")
ix.util.Include("sv_hooks.lua")

ix.char.RegisterVar("fakeName", {
	field = "fakeName",
	fieldType = ix.type.string,
	default = "",
	isLocal = true,
	bNoDisplay = true
})

ix.char.RegisterVar("fakeNames", {
    field = "fakeNames",
	default = {},
    isLocal = true,
	bNoDisplay = true
})
