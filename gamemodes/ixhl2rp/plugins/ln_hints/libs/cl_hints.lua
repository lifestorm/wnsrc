--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ix.hints = ix.hints or {}
ix.hints.stored = ix.hints.stored or {}

-- A function to register a hint.
function ix.hints.Add(hint)
	if (!table.HasValue(ix.hints.stored, hint)) then
		ix.hints.stored[#ix.hints.stored + 1] = hint
	end
end
