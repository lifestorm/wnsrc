--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()

CreateConVar("WheelMagic", 1, bit.bor(FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE), "Prevent the entire hook script from running")
CreateConVar("WheelMagic_RunWithoutEngineActive", 0, bit.bor(FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE), "If it should run when vehicles engine is off (may cause lag)")
CreateConVar("WheelMagic_WheelForce", 30, bit.bor(FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE), "With how much force the wheels are being pushed down")
CreateConVar("WheelMagic_ChassiForce", 0, bit.bor(FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE), "With how much force the chassi is being pushed down")
CreateConVar("WheelMagic_UseChassiAngleForWheelForce", 0, bit.bor(FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE), "If the wheels should define down from the vehicle, instead of world")
CreateConVar("WheelMagic_UseChassiAngleForChassiForce", 0, bit.bor(FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE), "If the chassi should define down from the vehicle, instead of world")
CreateConVar("WheelMagic_KeepChassiUprightForce", 10, bit.bor(FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE), "With how much force it should align the chassi to the preferred angle")
CreateConVar("WheelMagic_KeepChassiPitch", 1, bit.bor(FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE), "Decides whenever it should align the pitch of the chassi or not")
CreateConVar("WheelMagic_KeepChassiRoll", 1, bit.bor(FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE), "Decides whenever it should align the roll of the chassi or not")
CreateConVar("WheelMagic_ForceWheelsInAirDown", 1, bit.bor(FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE), "Should it push down wheels as soon as they leave the ground?")
CreateConVar("WheelMagic_AirWheelForce", 50, bit.bor(FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE), "With how much force the wheels are being pushed down when in air")

hook.Add( "Tick", "ForceWheelsOnGround", function()
	if util.tobool(GetConVar("WheelMagic"):GetInt() or 1) then
		for k,ent in pairs(ents.FindByClass("gmod_sent_vehicle_fphysics_base")) do
			if util.tobool(GetConVar("WheelMagic_RunWithoutEngineActive"):GetInt() or 1) or ent:GetActive() == true then
				if util.tobool(GetConVar("WheelMagic_UseChassiAngleForWheelForce"):GetInt() or 1) then
					for i = 1, table.Count(ent.Wheels) do
						local Wheel = ent.Wheels[i]
						local angle = -ent:GetUp() * GetConVar("WheelMagic_WheelForce"):GetInt() or 30
						local phys = Wheel:GetPhysicsObject()
						if IsValid( phys ) then
							phys:Wake()
							phys:ApplyForceCenter( phys:GetMass()*angle/2 )
						end
					end
				else
					for i = 1, table.Count(ent.Wheels) do
						local Wheel = ent.Wheels[i]
						if IsValid(Wheel) then
							local angle = -Entity(0):GetUp() * GetConVar("WheelMagic_WheelForce"):GetInt() or 30
							local phys = Wheel:GetPhysicsObject()
							if IsValid( phys ) then
								phys:Wake()
								phys:ApplyForceCenter( phys:GetMass()*angle/2 )
							end
						end
					end
				end
				if util.tobool(GetConVar("WheelMagic_UseChassiAngleForChassiForce"):GetInt() or 1) then
					local angle = -ent:GetUp() * GetConVar("WheelMagic_ChassiForce"):GetInt() or 0
					local phys = ent:GetPhysicsObject()
					if IsValid( phys ) then
						phys:Wake()
						phys:ApplyForceCenter( phys:GetMass()*angle/2 )
					end
				else
					local angle = -Entity(0):GetUp() * GetConVar("WheelMagic_ChassiForce"):GetInt() or 0
					local phys = ent:GetPhysicsObject()
					if IsValid( phys ) then
						phys:Wake()
						phys:ApplyForceCenter( phys:GetMass()*angle/2 )
					end
				end
				if util.tobool(GetConVar("WheelMagic_KeepChassiPitch"):GetInt() or 1) or util.tobool(GetConVar("WheelMagic_KeepChassiRoll"):GetInt() or 1) then
					local phys = ent:GetPhysicsObject()
					if IsValid( phys ) then
						local EntAng = phys:GetAngles()
						local P,Y,R = 0,0,0
							
						if util.tobool(GetConVar("WheelMagic_KeepChassiPitch"):GetInt() or 1) then
							P = math.rad(math.AngleDifference(EntAng.p,P))
						end
						--Y = math.rad(math.AngleDifference(EntAng.y,Y))*math.cos(math.rad(EntAng.p))
						if util.tobool(GetConVar("WheelMagic_KeepChassiRoll"):GetInt() or 1) then
							R = math.rad(math.AngleDifference(EntAng.r,R))
						end
						local DivAng = Vector(P,Y,0)
						DivAng:Rotate(Angle(0,-EntAng.r,0))
						phys:AddAngleVelocity((-Vector(R,DivAng.x,DivAng.y)*GetConVar("WheelMagic_KeepChassiUprightForce"):GetInt() or 10)-(phys:GetAngleVelocity()*0.001))
					end
				end
			end
		end
		
		for k,ent in pairs(ents.FindByClass("gmod_sent_vehicle_fphysics_wheel")) do
			if util.tobool(GetConVar("WheelMagic_RunWithoutEngineActive"):GetInt() or 1) or ent:GetBaseEnt():GetActive() == true then
				if util.tobool(GetConVar("WheelMagic_ForceWheelsInAirDown"):GetInt() or 1) then
					if ent:GetOnGround() == 0 then
						local angle = -ent:GetBaseEnt():GetUp() * GetConVar("WheelMagic_AirWheelForce"):GetInt() or 50
						local phys = ent:GetPhysicsObject()
						if IsValid( phys ) then
							phys:Wake()
							phys:ApplyForceCenter( phys:GetMass()*angle/2 )
						end
					end
				end
			end
		end
	end
end)