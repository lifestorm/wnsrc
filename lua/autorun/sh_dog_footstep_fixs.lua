--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

game.AddParticles( "particles/stalactite.pcf" )

local footstep_tab = {
2,
4
}

hook.Add("EntityEmitSound", "DOGGS_Fix_Sound",function(t)
if IsValid(t.Entity) and t.Entity != NULL and t.Entity:GetClass()=="npc_vj_hl2_dog" and string.find(t.SoundName,"footstep")  then
t.SoundName = "^npc/dog/dog_footstep" .. table.Random(footstep_tab) .. ".wav"
t.SoundLevel = SNDLVL_100db
t.Volume = 0.8
t.Pitch = 90
t.Channel = CHAN_STATIC
return true
end
end)