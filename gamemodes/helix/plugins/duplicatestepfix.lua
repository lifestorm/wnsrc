--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLUGIN = PLUGIN;

PLUGIN.name = "Fix Duplicate Step Sound"
PLUGIN.author = "Fruity"
PLUGIN.description = "Fixes duplicate step sound while in third person."

if (CLIENT) then
	function PLUGIN:EntityEmitSound(soundData)
		if (ix.option.Get("thirdpersonEnabled")) then
			if (!soundData.Entity:IsPlayer()) then
				return;
			end;

			local soundName = soundData.OriginalSoundName;
			local blockedSuffixes = { ".stepleft", ".stepright" };

			for _, v in pairs(blockedSuffixes) do
				if (soundName:utf8sub(-#v) == v) then
					return false;
				end;
			end;
		end;
	end;
end