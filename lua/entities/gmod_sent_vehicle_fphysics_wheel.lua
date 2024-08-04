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

ENT.Type            = "anim"

ENT.Spawnable       = false
ENT.AdminSpawnable  = false

ENT.DoNotDuplicate = true

ENT.RenderGroup = RENDERGROUP_BOTH 

function ENT:SetupDataTables()
	self:NetworkVar( "Float", 0, "Radius")
	self:NetworkVar( "Float", 1, "OnGround" )
	self:NetworkVar( "Float", 2, "RPM" )
	self:NetworkVar( "Float", 3, "GripLoss" )
	self:NetworkVar( "Float", 4, "Speed" )
	self:NetworkVar( "Float", 5, "SkidSound" )
	self:NetworkVar( "String", 2, "SurfaceMaterial" )
	self:NetworkVar( "Bool", 1, "Damaged" )
	self:NetworkVar( "Entity", 1, "BaseEnt" )

	if SERVER then
		self:NetworkVarNotify( "Damaged", self.OnDamaged )
	end
end

function ENT:GetWidth()
	return 3
end

function ENT:VelToRPM( speed )
	if not speed then return 0 end

	return speed * 60 / math.pi / (self:GetRadius() * 2)
end

function ENT:RPMToVel( rpm )
	if not rpm then return 0 end

	return (math.pi * rpm * self:GetRadius() * 2) / 60
end

if SERVER then
	function ENT:Initialize()	
		self:SetModel( "models/props_vehicles/tire001c_car.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetCollisionGroup( COLLISION_GROUP_WEAPON  ) 
		self:SetUseType( SIMPLE_USE )
		self:AddFlags( FL_OBJECT )
		self:AddEFlags( EFL_NO_PHYSCANNON_INTERACTION )

		self:DrawShadow( false )

		self.OldMaterial = ""
		self.OldMaterial2 = ""
		self.OldVar = 0
		self.OldVar2 = 0
	
		local Color = self:GetColor()
		local dot = Color.r * Color.g * Color.b * Color.a
		self.OldColor = dot
	end
	
	function ENT:Use( ply )
		local base = self:GetBaseEnt()

		if not IsValid( base ) then return end

		base:Use( ply )
	end

	function ENT:Think()
		if self.GhostEnt then
			local Color = self:GetColor()
			local dot = Color.r * Color.g * Color.b * Color.a
			if dot ~= self.OldColor then
				if IsValid( self.GhostEnt ) then
					self.GhostEnt:SetColor( Color )
					self.GhostEnt:SetRenderMode( self:GetRenderMode() )
				end
				self.OldColor = dot
			end
		end

		self:NextThink( CurTime() + 0.15 )

		return true
	end

	function ENT:FixTire()
		self:SetDamaged( false )

		if not self.PreBreak then return end

		self.PreBreak:Stop()
		self.PreBreak = nil
	end

	function ENT:OnRemove()
		if self.PreBreak then
			self.PreBreak:Stop()
		end
	end

	function ENT:PhysicsCollide( data, physobj )
		if data.Speed > 100 and data.DeltaTime > 0.2 then
			if data.Speed > 400 then 
				self:EmitSound( "Rubber_Tire.ImpactHard" )
				self:EmitSound( "simulated_vehicles/suspension_creak_".. math.random(1,6) ..".ogg" )
			else 
				self:EmitSound( "Rubber.ImpactSoft" )
			end
		end
	end

	function ENT:OnTakeDamage( dmginfo )
		local BaseEnt = self:GetBaseEnt()

		if IsValid( BaseEnt ) and dmginfo:IsDamageType( DMG_AIRBOAT + DMG_BULLET ) then
			BaseEnt:OnTakeDamage( dmginfo )
		end

		if self:GetDamaged() or not simfphys.DamageEnabled then return end

		local Damage = dmginfo:GetDamage() 
		local DamagePos = dmginfo:GetDamagePosition() 

		if not IsValid( BaseEnt ) or BaseEnt:GetBulletProofTires() or Damage <= 1 then return end

		if not self.PreBreak then
			self.PreBreak = CreateSound(self, "ambient/gas/cannister_loop.wav")
			self.PreBreak:PlayEx(0.5,100)

			timer.Simple(math.Rand(0.5,5), function() 
				if IsValid(self) and not self:GetDamaged() then
					self:SetDamaged( true )
					if self.PreBreak then
						self.PreBreak:Stop()
						self.PreBreak = nil
					end
				end
			end)
		else
			self:SetDamaged( true )
			self.PreBreak:Stop()
			self.PreBreak = nil
		end
	end

	function ENT:OnDamaged( name, old, new)
		if new == old then return end

		if new == true then
			self.dRadius = self:BoundingRadius() * 0.28

			self:EmitSound( "simulated_vehicles/sfx/tire_break.ogg" )

			if IsValid( self.GhostEnt ) then
				self.GhostEnt:SetParent( nil )
				self.GhostEnt:GetPhysicsObject():EnableMotion( false )
				self.GhostEnt:SetPos( self:LocalToWorld( Vector(0,0,-self.dRadius) ) )
				self.GhostEnt:SetParent( self )
			end
		else
			if IsValid( self.GhostEnt ) then
				self.GhostEnt:SetParent( nil )
				self.GhostEnt:GetPhysicsObject():EnableMotion( false )
				self.GhostEnt:SetPos( self:LocalToWorld( Vector(0,0,0) ) )
				self.GhostEnt:SetParent( self )
			end
		end

		local BaseEnt = self:GetBaseEnt()

		if not IsValid( BaseEnt ) then return end

		BaseEnt:SetSuspension( self.Index , new )
	end

	return
end

ENT.SkidmarkTraceAdd = Vector(0,0,10)
ENT.SkidmarkDelay = 0.05
ENT.SkidmarkLifetime = 10

ENT.SkidmarkRed = 0
ENT.SkidmarkGreen = 0
ENT.SkidmarkBlue = 0
ENT.SkidmarkAlpha = 150

ENT.SkidmarkSurfaces = {
	["concrete"] = true,
	["tile"] = true,
	["metal"] = true,
	["boulder"] = true,
	["default"] = true,
}

ENT.DustEffectSurfaces = {
	["sand"] = true,
	["dirt"] = true,
	["grass"] = true,
	["antlionsand"] = true,
}

function ENT:Initialize()
	self.FadeHeat = 0

	timer.Simple( 0.01, function()
		if not IsValid( self ) then return end
		self.Radius = self:BoundingRadius()
	end)
end

function ENT:Think()
	self:ManageSmoke()

	local T = CurTime()

	if (self.fxTimer or 0) < T then
		self:CalcWheelSlip()

		self.fxTimer = T + 0.1
	end

	self:SetNextClientThink( CurTime() + 0.005 )

	return true
end

function ENT:ManageSmoke()
	local BaseEnt = self:GetBaseEnt()

	if not IsValid( BaseEnt ) then return end

	if LocalPlayer():GetPos():DistToSqr(self:GetPos()) > 6000 * 6000 or not BaseEnt:GetActive() then return end

	local WheelOnGround = self:GetOnGround()
	local GripLoss = self:GetGripLoss()
	local Material = self:GetSurfaceMaterial()

	if WheelOnGround > 0 and (Material == "concrete" or Material == "rock" or Material == "tile") and GripLoss > 0 then
		self.FadeHeat = math.Clamp( self.FadeHeat + GripLoss * 0.06,0,10)
	else
		self.FadeHeat = self.FadeHeat * 0.995
	end

	local Scale = self.FadeHeat ^ 3 * 0.001
	local SmokeOn = (self.FadeHeat >= 7)
	local DirtOn = GripLoss > 0.05
	local lcolor = BaseEnt:GetTireSmokeColor() * 255
	local Speed = self:GetVelocity():Length()
	local OnRim = self:GetDamaged()

	local Forward = self:GetForward()
	local Dir = (BaseEnt:GetGear() < 2) and Forward or -Forward

	local WheelSize = self.Radius or 0
	local Pos = self:GetPos()

	if SmokeOn and not OnRim then
		local effectdata = EffectData()
			effectdata:SetOrigin( Pos )
			effectdata:SetNormal( Dir )
			effectdata:SetMagnitude( Scale ) 
			effectdata:SetRadius( WheelSize ) 
			effectdata:SetStart( Vector( lcolor.r, lcolor.g, lcolor.b ) )
		util.Effect( "simfphys_tiresmoke", effectdata )
	end

	if WheelOnGround == 0 then return end

	if (Speed > 150 or DirtOn) and OnRim then
		self:MakeSparks( GripLoss, Dir, Pos, WheelSize )
	end
end

function ENT:MakeSparks( Scale, Dir, Pos, WheelSize )
	self.NextSpark = self.NextSpark or 0
	
	if self.NextSpark < CurTime() then
	
		self.NextSpark = CurTime() + 0.1
		local effectdata = EffectData()
			effectdata:SetOrigin( Pos - Vector(0,0,WheelSize * 0.5) )
			effectdata:SetNormal( (Dir + Vector(0,0,0.5)) * Scale * 0.5)
		util.Effect( "manhacksparks", effectdata, true, true )
	end
end

function ENT:Draw()
end

function ENT:DrawTranslucent()
	self:CalcWheelEffects()
end

function ENT:OnRemove()
	self:StopWheelEffects()
end

function ENT:CalcWheelSlip()
	local Base = self:GetBaseEnt()

	if not IsValid( Base ) then return end

	local Vel = self:GetVelocity()
	local VelLength = Vel:Length()

	local rpmTheoretical = self:VelToRPM( VelLength )
	local rpm = math.abs( self:GetRPM() )

	self._WheelSlip = math.max( rpm - rpmTheoretical - 250, 0 ) ^ 2 + math.max( math.abs( Base:VectorSplitNormal( self:GetRight(), Vel * 4 ) ) - VelLength, 0 )
	self._WheelSkid = VelLength + self._WheelSlip
end

function ENT:GetSlip()
	return (self._WheelSlip or 0)
end

function ENT:GetSkid()
	return (self._WheelSkid or 0)
end


function ENT:StopWheelEffects()
	if not self._DoingWheelFx then return end

	self._DoingWheelFx = nil

	self:FinishSkidmark()
end

function ENT:StartWheelEffects( Base, trace, traceWater )
	self:DoWheelEffects( Base, trace, traceWater )

	if self._DoingWheelFx then return end

	self._DoingWheelFx = true
end

function ENT:DoWheelEffects( Base, trace, traceWater )
	if not trace.Hit then self:FinishSkidmark() return end

	local SurfacePropName = util.GetSurfacePropName( trace.SurfaceProps )
	local SkidValue = self:GetSkid()

	if traceWater.Hit then
		local Scale = math.min( 0.3 + (SkidValue - 100) / 4000, 1 ) ^ 2

		local effectdata = EffectData()
		effectdata:SetOrigin( trace.HitPos )
		effectdata:SetEntity( Base )
		effectdata:SetNormal( trace.HitNormal )
		effectdata:SetMagnitude( Scale )
		effectdata:SetFlags( 1 )
		util.Effect( "simfphys_physics_wheeldust", effectdata, true, true )

		self:FinishSkidmark()

		return
	end

	if self.SkidmarkSurfaces[ SurfacePropName ] then
		local Scale = math.min( 0.3 + SkidValue / 4000, 1 ) ^ 2

		if Scale > 0.2 then
			self:StartSkidmark( trace.HitPos )
			self:CalcSkidmark( trace, Base:GetCrosshairFilterEnts() )
		else
			self:FinishSkidmark()
		end

		local effectdata = EffectData()
		effectdata:SetOrigin( trace.HitPos )
		effectdata:SetEntity( Base )
		effectdata:SetNormal( trace.HitNormal )
		util.Effect( "simfphys_physics_wheelsmoke", effectdata, true, true )
	else
		self:FinishSkidmark()
	end

	if not LVS.ShowEffects then return end

	if self.DustEffectSurfaces[ SurfacePropName ] then
		local Scale = math.min( 0.3 + (SkidValue - 100) / 4000, 1 ) ^ 2

		local effectdata = EffectData()
		effectdata:SetOrigin( trace.HitPos )
		effectdata:SetEntity( Base )
		effectdata:SetNormal( trace.HitNormal )
		effectdata:SetMagnitude( Scale )
		effectdata:SetFlags( 0 )
		util.Effect( "simfphys_physics_wheeldust", effectdata, true, true )
	end
end

function ENT:CalcWheelEffects()
	local T = CurTime()

	if (self._NextFx or 0) > T then return end

	self._NextFx = T + 0.05

	local Base = self:GetBaseEnt()

	if not IsValid( Base ) then return end

	local Radius = Base:GetUp() * (self:GetRadius() + 1)

	local Pos =  self:GetPos() + self:GetVelocity() * 0.025
	local StartPos = Pos + Radius
	local EndPos = Pos - Radius

	local trace = util.TraceLine( {
		start = StartPos,
		endpos = EndPos,
		filter = Base:GetCrosshairFilterEnts(),
	} )

	local traceWater = util.TraceLine( {
		start = StartPos,
		endpos = EndPos,
		filter = Base:GetCrosshairFilterEnts(),
		mask = MASK_WATER,
	} )

	self:CalcWheelSounds( Base, trace, traceWater )

	if traceWater.Hit and trace.HitPos.z < traceWater.HitPos.z then 
		if math.abs( self:GetRPM() ) > 25 then
			local effectdata = EffectData()
				effectdata:SetOrigin(  traceWater.Fraction > 0.5 and traceWater.HitPos or Pos )
				effectdata:SetEntity( Base )
				effectdata:SetMagnitude( self:BoundingRadius() )
				effectdata:SetFlags( 0 )
			util.Effect( "simfphys_physics_wheelwatersplash", effectdata )
		end
	end

	if self:GetSlip() < 500 or self:GetDamaged() then self:StopWheelEffects() return end

	self:StartWheelEffects( Base, trace, traceWater )
end

function ENT:CalcWheelSounds( Base, trace, traceWater )
	if not trace.Hit then return end

	-- TODO: fix reason for this workaround
	if trace.Entity == self then
		if istable( Base.CrosshairFilterEnts ) and #Base.CrosshairFilterEnts > 1 then
			Base.CrosshairFilterEnts = nil
		end

		return
	end

	local RPM = math.abs( self:GetRPM() )

	if RPM > 50 then
		if traceWater.Hit then
			Base:DoTireSound( "roll_wet" )

			return
		end

		if self:GetDamaged() then
			Base:DoTireSound( "roll_damaged" )

			return
		end

		local surface = self.DustEffectSurfaces[ util.GetSurfacePropName( trace.SurfaceProps ) ] and "_dirt" or ""
		local snd_type = (self:GetSlip() > 500) and "skid" or "roll"

		if (istable( StormFox ) or istable( StormFox2 )) and surface ~= "_dirt" then
			local Rain = false

			if StormFox then
				Rain = StormFox.IsRaining()
			end

			if StormFox2 then
				Rain = StormFox2.Weather:IsRaining()
			end

			if Rain then
				local effectdata = EffectData()
					effectdata:SetOrigin( trace.HitPos )
					effectdata:SetEntity( Base )
					effectdata:SetMagnitude( self:BoundingRadius() )
					effectdata:SetFlags( 1 )
				util.Effect( "lvs_physics_wheelwatersplash", effectdata )

				Base:DoTireSound( snd_type.."_wet" )

				return
			end
		end
	
		Base:DoTireSound( snd_type..surface )
	end
end

function ENT:GetSkidMarks()
	if not istable( self._activeSkidMarks ) then
		self._activeSkidMarks = {}
	end

	return self._activeSkidMarks
end

function ENT:StartSkidmark( pos )
	if self:GetWidth() <= 0 or self._SkidMarkID or not LVS.ShowTraileffects then return end

	local ID = 1
	for _,_ in ipairs( self:GetSkidMarks() ) do
		ID = ID + 1
	end

	self._activeSkidMarks[ ID ] = {
		active = true,
		startpos = pos + self.SkidmarkTraceAdd,
		delay = CurTime() + self.SkidmarkDelay,
		positions = {},
	}

	self._SkidMarkID = ID
end

function ENT:FinishSkidmark()
	if not self._SkidMarkID then return end

	self._activeSkidMarks[ self._SkidMarkID ].active = false

	self._SkidMarkID = nil
end

function ENT:RemoveSkidmark( id )
	if not id then return end

	self._activeSkidMarks[ id ] = nil
end

function ENT:CalcSkidmark( trace, Filter )
	local T = CurTime()
	local CurActive = self:GetSkidMarks()[ self._SkidMarkID ]

	if not CurActive or not CurActive.active or CurActive.delay >= T then return end

	CurActive.delay = T + self.SkidmarkDelay

	local W = self:GetWidth()

	local cur = trace.HitPos + self.SkidmarkTraceAdd * 0.5

	local prev = CurActive.positions[ #CurActive.positions ]

	if not prev then
		local sub = cur - CurActive.startpos

		local L = sub:Length() * 0.5
		local C = (cur + CurActive.startpos) * 0.5

		local Ang = sub:Angle()
		local Forward = Ang:Right()
		local Right = Ang:Forward()

		local p1 = C + Forward * W + Right * L
		local p2 = C - Forward * W + Right * L

		local t1 = util.TraceLine( { start = p1, endpos = p1 - self.SkidmarkTraceAdd } )
		local t2 = util.TraceLine( { start = p2, endpos = p2 - self.SkidmarkTraceAdd } )

		prev = {
			px = CurActive.startpos,
			p1 = t1.HitPos + t1.HitNormal,
			p2 = t2.HitPos + t2.HitNormal,
			lifetime = T + self.SkidmarkLifetime - self.SkidmarkDelay,
			alpha = 0,
		}
	end

	local sub = cur - prev.px

	local L = sub:Length() * 0.5
	local C = (cur + prev.px) * 0.5

	local Ang = sub:Angle()
	local Forward = Ang:Right()
	local Right = Ang:Forward()

	local p1 = C + Forward * W + Right * L
	local p2 = C - Forward * W + Right * L

	local t1 = util.TraceLine( { start = p1, endpos = p1 - self.SkidmarkTraceAdd, filter = Filter, } )
	local t2 = util.TraceLine( { start = p2, endpos = p2 - self.SkidmarkTraceAdd, filter = Filter, } )

	local nextID = #CurActive.positions + 1

	CurActive.positions[ nextID ] = {
		px = cur,
		p1 = t1.HitPos + t1.HitNormal,
		p2 = t2.HitPos + t2.HitNormal,
		lifetime = T + self.SkidmarkLifetime,
		alpha = math.min( nextID / 10, 1 ),
	}
end

function ENT:RenderSkidMarks()
	local T = CurTime()

	for id, skidmark in pairs( self:GetSkidMarks() ) do
		local prev
		local AmountDrawn = 0

		for markID, data in pairs( skidmark.positions ) do
			if not prev then

				prev = data

				continue
			end

			local Mul = math.max( data.lifetime - CurTime(), 0 ) / self.SkidmarkLifetime

			if Mul > 0 then
				AmountDrawn = AmountDrawn + 1
				render.DrawQuad( data.p2, data.p1, prev.p1, prev.p2, Color( self.SkidmarkRed, self.SkidmarkGreen, self.SkidmarkBlue, math.min(255 * Mul * data.alpha,self.SkidmarkAlpha) ) )
			end

			prev = data
		end

		if not skidmark.active and AmountDrawn == 0 then
			self:RemoveSkidmark( id )
		end
	end
end

hook.Add( "PreDrawTranslucentRenderables", "!!!!lvs_fakephysics_skidmarks", function( bDepth, bSkybox )
	if bSkybox then return end

	render.SetColorMaterial()

	for _, wheel in ipairs( ents.FindByClass("gmod_sent_vehicle_fphysics_wheel") ) do
		wheel:RenderSkidMarks()
	end
end)
