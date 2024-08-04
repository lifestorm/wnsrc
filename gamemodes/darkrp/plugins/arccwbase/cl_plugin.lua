--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- ArcCW.Sway
function PLUGIN:CreateMove(userCmd)
	local client = LocalPlayer()
	local weapon = client:GetActiveWeapon()

	if !weapon.ArcCW then return end

	local angles = userCmd:GetViewAngles()

	if (weapon:GetState() == ArcCW.STATE_SIGHTS and !weapon.NoSway) then
		local sway = weapon:GetBuff("Sway")
		sway = sway != 0 and sway or self.swayDefault
		-- sway = sway * math.Clamp(1 / (weapon:GetActiveSights().ScopeMagnification or 1), 0.1, 1)

		if (sway == 0) then
			return
		end

		local character = client:GetCharacter()
		local skillLevel = character:GetSkillLevel("guns")
		local minSkillLevel, maxSkillLevel = ix.weapons:GetWeaponSkillRequired(weapon:GetClass())

		if (skillLevel < minSkillLevel) then
			sway = sway + (sway * self.swayMaxIncrease) * (1 - skillLevel / minSkillLevel)
		else
			skillLevel = math.min(skillLevel, maxSkillLevel)
			sway = sway - (sway * self.swayMaxDecrease) * ((skillLevel - minSkillLevel) / (maxSkillLevel - minSkillLevel))
		end

		if weapon:InBipod() then
			sway = sway * (weapon.BipodDispersion * weapon:GetBuff_Mult("Mult_BipodDispersion"))
		end

		if sway > 0.05 then
			angles.p = math.Clamp(angles.p + math.sin(CurTime() * 1.25) * FrameTime() * sway, -89, 89)

			ArcCW.SwayDir = ArcCW.SwayDir + math.Rand(-360, 360) * FrameTime() / math.min(sway, 1)

			angles.p = angles.p + math.sin(ArcCW.SwayDir) * FrameTime() * sway
			angles.y = angles.y + math.cos(ArcCW.SwayDir) * FrameTime() * sway

			-- angles.p = angles.p + math.Rand(-1, 1) * FrameTime() * sway
			-- angles.y = angles.y + math.Rand(-1, 1) * FrameTime() * sway

			userCmd:SetViewAngles(angles)
		end
	end
end

hook.Remove("CreateMove", "ArcCW_Sway")
