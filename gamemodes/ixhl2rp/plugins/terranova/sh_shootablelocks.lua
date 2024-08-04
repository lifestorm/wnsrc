--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

--[[
	© 2020 TERRANOVA do not share, re-distribute or modify
	without permission of its author.
--]]

local PLUGIN = PLUGIN

local SHOOT_DISTANCE = 180 * 180

function PLUGIN:EntityTakeDamage(entity, dmgInfo)
	if (entity:GetClass() == "prop_door_rotating" and (entity.NextBreach or 0) < CurTime()) then
		local handle = entity:LookupBone("handle")

		if (handle and dmgInfo:IsBulletDamage()) then
			local client = dmgInfo:GetAttacker()
			local position = dmgInfo:GetDamagePosition()

			if (!client:IsPlayer() or client:GetEyeTrace().Entity != entity or client:GetPos():DistToSqr(position) > SHOOT_DISTANCE) then
				return
			end

			if (entity.ixLock) then
				return false
			end

			if (entity.doorPartner and entity.doorPartner.ixLock) then
				return false
			end

			if (IsValid(client) and position:DistToSqr(entity:GetBonePosition(handle)) <= 12 * 12) then
				if (hook.Run("CanPlayerBustLock", client, entity) == false) then
					return
				end

				local effect = EffectData()
					effect:SetStart(position)
					effect:SetOrigin(position)
					effect:SetScale(2)
				util.Effect("GlassImpact", effect)

				local name = client:SteamID64()..CurTime()
				client:SetName(name)

				entity.OldSpeed = entity.OldSpeed or entity:GetKeyValues().speed or 100

				entity:Fire("setspeed", entity.OldSpeed * 5)
				entity:Fire("unlock")
				entity:Fire("openawayfrom", name)
				entity:EmitSound("physics/wood/wood_plank_break"..math.random(1, 4)..".wav", 100, 120)

				entity.NextBreach = CurTime() + 1

				timer.Simple(0.5, function()
					if (IsValid(entity)) then
						entity:Fire("setspeed", entity.OldSpeed)
					end
				end)
			end
		end
	end
end
