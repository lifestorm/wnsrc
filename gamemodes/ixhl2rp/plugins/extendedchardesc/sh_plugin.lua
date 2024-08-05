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
local tostring = tostring


PLUGIN.name = "Extended Character Description"
PLUGIN.author = "AleXXX_007"
PLUGIN.description = "Adds new panel for longer character descriptions."

ix.util.Include("cl_hooks.lua")
ix.util.Include("sh_commands.lua")
ix.util.Include("sv_hooks.lua")

ix.config.Add("maxDescriptionLength", 512, "Maximum amount of characters in the description.", nil, {
	data = {min = 64, max = 2048},
	category = "characters"
})

ix.lang.AddTable("english", {
	descMaxLen = "Your description must not be more than %d characters!"
})

ix.lang.AddTable("spanish", {
	descMaxLen = "¡Tu descripción no puede tener más de %d carácteres!"
})

do
  ix.char.vars.description.OnValidate = function(self, value, payload)
    value = string.Trim((tostring(value):gsub("\r\n", ""):gsub("\n", "")))
    local minLength = ix.config.Get("minDescriptionLength", 16)
    local maxLength = ix.config.Get("maxDescriptionLength", 512)

    if (value:utf8len() < minLength) then
      return false, "descMinLen", minLength
    elseif (value:utf8len() > maxLength) then
      return false, "descMaxLen", maxLength
    elseif (!value:find("%S")) then
      return false, "invalid", "description"
    end

    return value
  end
end
