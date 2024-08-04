--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if GetConVar( "cmb_tracers_energyball" ):GetFloat() >= 1 then
	TRACK_CB = {}
	function CheckCB()
		local cb = ents.FindByClass("prop_combine_ball") 
		for k, v in pairs(cb) do 
			if not(TRACK_CB[v]) then 
				TRACK_CB[v] = {true, v:GetPos(), CurTime()}
				ParticleEffectAttach("ar2_combineball", PATTACH_ABSORIGIN_FOLLOW, v, 0)
			else 
				TRACK_CB[v][1] = true
				TRACK_CB[v][2] = v:GetPos()
			end
		end
	end
	hook.Add("Tick", "CheckCB", CheckCB)
end