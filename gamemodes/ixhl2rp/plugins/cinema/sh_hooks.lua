--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN 

function PLUGIN:HandleMovieBars(player, radius)
	if (!radius) then
		radius = 250;
	end;
	
	if (player.movieBarPlayers) then
		for k, v in pairs (player.movieBarPlayers) do
			if (IsValid(v) and v:IsPlayer() and !v.cannotMovieBar) then
				v:SetNetVar("MovieBars", false);
			end;
		end;
	else
		player.movieBarPlayers = {}
	end;
	
	for k, v in pairs (ents.FindInSphere(player:GetEyeTrace().HitPos, radius)) do
		if (IsValid(v) and v:IsPlayer()) then
			table.insert(player.movieBarPlayers, v);
			
			if (!v:GetNetVar("MovieBars") and !v.cannotMovieBar) then
				v:SetNetVar("MovieBars", true);
			end;
		end;
	end;
end;

