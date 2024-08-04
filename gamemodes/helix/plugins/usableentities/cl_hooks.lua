--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function PLUGIN:InitPostEntity()
	for _, entityData in pairs(self.usableEntityLookup) do
		if (entityData.class == "ix_clock" and !timer.Exists("ix_clock_ambience")) then
			timer.Create("ix_clock_ambience", 1, 0, function()
				for _, entity in ipairs(ents.FindByClass("ix_clock")) do
					if (entity:GetNetVar("enabled")) then
						entity:StopSound("tick.wav")
						entity:EmitSound("tick.wav", 60, math.random(95, 105), 1, CHAN_AUTO)
					end
				end
			end)
		end
	end
end
