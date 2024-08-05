--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

hook.Add( "EntityTakeDamage", "SimfDamageScale", function( target, dmginfo )
	if IsValid(target) then
		if target:IsPlayer() or target:IsNPC() then
			if IsValid(dmginfo:GetInflictor()) then
				if dmginfo:GetInflictor() ~= target then
					if dmginfo:GetInflictor():GetClass():find("gmod_sent_vehicle_fphysics_base") then
						if dmginfo:GetInflictor():GetDriver():IsValid() then	
							dmginfo:SetAttacker(dmginfo:GetInflictor():GetDriver())
							if dmginfo:GetInflictor() ~= dmginfo:GetInflictor():GetDriver() then return end
						end
						if target:IsNPC() then 
							dmginfo:ScaleDamage( 4 )
						elseif target:IsPlayer() then
							dmginfo:ScaleDamage( 2 )
						end
					end
				end
			end
		end
	end
end )