--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

Schema.voices = {}
Schema.voices.stored = {}
Schema.voices.classes = {}

function Schema.voices.Add(class, key, text, sound, global)
	class = string.utf8lower(class)
	key = string.utf8lower(key)

	Schema.voices.stored[class] = Schema.voices.stored[class] or {}
	Schema.voices.stored[class][key] = {
		text = text,
		sound = sound,
		global = global
	}
end

function Schema.voices.Get(class, key)
	class = string.utf8lower(class)
	key = string.utf8lower(key)

	if (Schema.voices.stored[class]) then
		return Schema.voices.stored[class][key]
	end
end

function Schema.voices.AddClass(class, condition)
	class = string.utf8lower(class)

	Schema.voices.classes[class] = {
		condition = condition
	}
end

function Schema.voices.GetClass(client)
	local classes = {}

	for k, v in pairs(Schema.voices.classes) do
		if (v.condition(client)) then
			classes[#classes + 1] = k
		end
	end

	return classes
end