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
	timer.Create("crematorAmbience", 4.4133334159851, 0, function()
		for _, player in ipairs(player.GetAll()) do
			player:StopSound("npc/cremator/cremator_breath_new_loop.wav")
			
			if (player:Team() == FACTION_CREMATOR and player:GetCharacter() and player:Alive()) then
				player:EmitSound("npc/cremator/cremator_breath_new_loop.wav", 70, 100, 0.6, CHAN_AUTO)
			end
		end
	end)
end
