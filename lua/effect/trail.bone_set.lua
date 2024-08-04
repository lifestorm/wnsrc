--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

WeaponTrail.BoneSet = {}

function WeaponTrail:AddBone(data)
	WeaponTrail.BoneSet[data.Number] = data
end

local bone = {
	Number = 0,
	BoneName = "ValveBiped.Bip01_R_Hand",
	AddAngle = Angle(0,0,0),
	AngleType = 0, -- 0 = GetUp(), 1 = GetRight(), 2 = GetForward()
	Trail_Time = 0.1 -- Default 0.1 Longer this time, longer is the trajectory.
}
WeaponTrail:AddBone(bone)
local bone = {
	Number = 1,
	BoneName = "R_Weapon",
	AddAngle = Angle(0,0,0),
	AngleType = 0, -- 0 = GetUp(), 1 = GetRight(), 2 = GetForward()
	Trail_Time = 0.2 -- Default 0.1 Longer this time, longer is the trajectory.
}
WeaponTrail:AddBone(bone)
local bone = {
	Number = 2,
	BoneName = "R_Weapon001",
	AddAngle = Angle(0,0,0),
	AngleType = 0, -- 0 = GetUp(), 1 = GetRight(), 2 = GetForward()
	Trail_Time = 0.5 -- Default 0.1 Longer this time, longer is the trajectory.
}
WeaponTrail:AddBone(bone)
local bone = {
	Number = 3,
	BoneName = "R_Weapon",
	AddAngle = Angle(0,0,0),
	AngleType = 1, -- 0 = GetUp(), 1 = GetRight(), 2 = GetForward()
	Trail_Time = 0.2 -- Default 0.1 Longer this time, longer is the trajectory.
}
WeaponTrail:AddBone(bone)
local bone = {
	Number = 4,
	BoneName = "L_Weapon001",
	AddAngle = Angle(0,0,180),
	AngleType = 0, -- 0 = GetUp(), 1 = GetRight(), 2 = GetForward()
	Trail_Time = 0.5 -- Default 0.1 Longer this time, longer is the trajectory.
}
WeaponTrail:AddBone(bone)
local bone = {
	Number = 5,
	BoneName = "R_Weapon",
	AddAngle = Angle(180,0,0),
	AngleType = 2, -- 0 = GetUp(), 1 = GetRight(), 2 = GetForward()
	Trail_Time = 0.2 -- Default 0.1 Longer this time, longer is the trajectory.
}
WeaponTrail:AddBone(bone)
local bone = {
	Number = 6,
	BoneName = "R_Weapon",
	AddAngle = Angle(0,0,180),
	AngleType = 0, -- 0 = GetUp(), 1 = GetRight(), 2 = GetForward()
	Trail_Time = 0.2 -- Default 0.1 Longer this time, longer is the trajectory.
}
WeaponTrail:AddBone(bone)
local bone = {
	Number = 7,
	BoneName = "Weapon_00",
	AddAngle = Angle(180,0,0),
	AngleType = 2, -- 0 = GetUp(), 1 = GetRight(), 2 = GetForward()
	Trail_Time = 0.2 -- Default 0.1 Longer this time, longer is the trajectory.
}
WeaponTrail:AddBone(bone)
local bone = {
	Number = 8,
	BoneName = "Weapon_02",
	AddAngle = Angle(180,0,0),
	AngleType = 2, -- 0 = GetUp(), 1 = GetRight(), 2 = GetForward()
	Trail_Time = 0.1 -- Default 0.1 Longer this time, longer is the trajectory.
}
WeaponTrail:AddBone(bone)
