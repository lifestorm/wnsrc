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
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false

function ENT:Draw()
self:DrawModel()
end

function ENT:Initialize()
	if SERVER then
		self:SetModel( "models/weapons/arccw_go/w_eq_incendiarygrenade_thrown.mdl" )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetCollisionGroup( COLLISION_GROUP_NONE )
		self:DrawShadow( false )

		self.fireEntities = {}
	end
	self:EmitSound("TFA_CSGO_IncGrenade.Throw")
	self.ActiveTimer = CurTime() + 1.5
	self.IgniteEnd = 0
	self.IgniteEndTimer = CurTime()
	self.IgniteStage = 0
	self.IgniteStageTimer = CurTime()
	ParticleEffectAttach("incgrenade_thrown_trail",PATTACH_POINT_FOLLOW,self,1)
	self:PhysicsInitSphere( 8 )
end

function ENT:PhysicsCollide(data, phys)
    if (SERVER and self.ActiveTimer > CurTime() or data.Speed >= 150) then
        self:EmitSound("TFA_CSGO_SmokeGrenade.Bounce")
    end

    local ang = data.HitNormal:Angle()
    ang.p = math.abs(ang.p)
    ang.y = math.abs(ang.y)
    ang.r = math.abs(ang.r)

    if (ang.p > 90 or ang.p < 60) then
        self.Entity:EmitSound(Sound("TFA_CSGO_SmokeGrenade.Bounce"))

        local impulse = (data.OurOldVelocity - 2 * data.OurOldVelocity:Dot(data.HitNormal) * data.HitNormal) * 0.25
        phys:ApplyForceCenter(impulse)
    else
        if (SERVER) then
            local delayedTrigger = false
            local client = self.Owner

            for k, v in pairs(ents.FindInSphere(self:GetPos(), 150)) do
                if (v:IsPlayer() or v:IsNPC()) then
                    hook.Run("InitializeGrenade", client, self, true)
                    delayedTrigger = true
                    break
                end
            end

            local molotovfire = ents.Create("arccw_go_fire")
            molotovfire:SetPos(self:GetPos())
            molotovfire:SetOwner(self.Owner)
            molotovfire:Spawn()

            if (!self.noRemove) then
                SafeRemoveEntityDelayed(molotovfire, 8)
            end

            table.insert(self.fireEntities, molotovfire)

			ParticleEffectAttach("fire_large_01", PATTACH_ABSORIGIN_FOLLOW, molotovfire, 0)

            -- Schedule the removal of physics and collision settings after a short delay
            timer.Simple(0.1, function()
                if (IsValid(self)) then
                    self:SetMoveType(MOVETYPE_NONE)
                    self:SetSolid(SOLID_NONE)
                    self:PhysicsInit(SOLID_NONE)
                    self:SetCollisionGroup(COLLISION_GROUP_NONE)
                    self:SetRenderMode(RENDERMODE_TRANSALPHA)
                    self:SetColor(Color(255, 255, 255, 0))
                    self:DrawShadow(false)
                    self:StopParticles()
                end
            end)
        end

        self:EmitSound("TFA_CSGO_IncGrenade.Start")
        self.IgniteEnd = 1
        self.IgniteEndTimer = CurTime() + 7
        self.IgniteStage = 1
        self.IgniteStageTimer = CurTime() + 0.1
    end

    if (!self.noRemove) then
		SafeRemoveEntityDelayed(self, 8)
	end
end


function ENT:OnRemove()
	if (self.fireEntities and !table.IsEmpty(self.fireEntities)) then
		for k, v in pairs(self.fireEntities) do
			if (IsValid(v)) then
				v:Remove()
			end
		end
	end

	if (timer.Exists("GrenadesCleanup"..self:EntIndex())) then
		timer.Remove("GrenadesCleanup"..self:EntIndex())
	end
end