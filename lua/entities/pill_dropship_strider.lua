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
ENT.PrintName = "Dropship Strider"
ENT.Category = "Pill Pack Entities"
ENT.Spawnable = true
ENT.AdminSpawnable = true

--ENT.AutomaticFrameAdvance = true
function ENT:Initialize()
    if SERVER then
        --Physics
        --self:SetModel("models/Combine_Strider.mdl")
        self:SetModel("models/Combine_Dropship_Container.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        local phys = self:GetPhysicsObject()

        if (phys:IsValid()) then
            phys:Wake()
        end

        self:SetRenderMode(RENDERMODE_NONE)
        self:DrawShadow(false)
        --self:SetSequence(self:LookupSequence("carried"))
        self.strider = ents.Create("prop_dynamic")
        self.strider:SetModel("models/Combine_Strider.mdl")
        self.strider:SetParent(self)
        self.strider:SetLocalPos(Vector(0, 0, -140))
        self.strider:SetLocalAngles(Angle(0, 0, 0))
        self.strider:Spawn()
        self.strider:SetSequence(self.strider:LookupSequence("carried"))
    end
    --self:SetPlaybackRate(1)
end

function ENT:Think()
    if self.droppedfrom then
        local angs = self:GetAngles()
        angs.p = 0
        angs.r = 0
        self.strider:SetAngles(angs)
        local trace = util.QuickTrace(self:GetPos(), Vector(0, 0, -600), {self, self.droppedfrom})

        if trace.Hit then
            self:Remove()
            local stridernpc = ents.Create("npc_strider")
            stridernpc:SetPos(self:GetPos())
            stridernpc:SetAngles(angs)
            stridernpc:Spawn()
        end
    end
end

function ENT:Deploy()
    self.strider:ResetSequence(self.strider:LookupSequence("deploy"))

    timer.Simple(2, function()
        if not IsValid(self) then return end
        self:EmitSound("npc/strider/striderx_alert2.wav")
    end)

    timer.Simple(3, function()
        if not IsValid(self) then return end
        local dropship = self:GetParent()
        if not IsValid(dropship) then return end
        dropship.container = nil
        self.droppedfrom = dropship
        self:SetParent()
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        --self:SetPos(dropship:GetPos())
        --self:SetAngles(dropship:GetAngles())
        self:GetPhysicsObject():Wake()
        self.strider:SetLocalPos(Vector(0, 0, 0))
    end)
    --[[local dropship = self:GetParent()

	if !self.full then dropship:PillSound("alert_empty") return end
	self.full=false

	self:SetSequence(self:LookupSequence("open"))
	dropship:PillLoopSound("deploy")

	local doClose = function()
		if !IsValid(self) then return end
		self:SetSequence(self:LookupSequence("close"))

		if IsValid(dropship)&&self:GetParent()==dropship then
			dropship:PillLoopStop("deploy")
		end
	end

	if self.mode!=6 then
		local mode = self.mode 
		timer.Simple(12,doClose)

		local doDeploy=function()
			if !IsValid(self) then return end

			local m = mode==5&&math.random(1,4)||mode

			local startAngPos = self:GetAttachment(self:LookupAttachment("deploy_landpoint"))
			local combine = ents.Create("pill_jumper_combine")
			combine:SetPos(startAngPos.Pos)
			combine:SetAngles(self:GetAngles())

			combine.myNpc= m==4&&"npc_metropolice"||"npc_combine_s"
			combine.myWeapon= m==2&&"weapon_shotgun"||m==4&&"weapon_smg1"||"weapon_ar2"

			if m==1 or m==2 then
				combine:SetModel("models/combine_soldier.mdl")
			elseif m==3 then
				combine:SetModel("models/Combine_Super_Soldier.mdl")
			elseif m==4 then
				combine:SetModel("models/police.mdl")
			end

			if m==2 then
				combine:SetSkin(1)
			end

			combine:SetParent(self)
			combine:Spawn()
		end

		for i=1,5 do
			timer.Simple(i*2,doDeploy)
		end
	else
		timer.Simple(5.5,doClose)

		local doDeploy=function()
			if !IsValid(self) then return end
			
			local mine = ents.Create("npc_rollermine")
			mine:SetPos(self:LocalToWorld(Vector(100,0,0)))
			mine:Spawn()
			mine:GetPhysicsObject():SetVelocity(self:GetAngles():Forward()*500)
		end

		for i=1,10 do
			timer.Simple(i/2,doDeploy)
		end
	end

	return true]]
end

function ENT:SpawnFunction(ply, tr, ClassName)
    if (not tr.Hit) then return end
    local SpawnPos = tr.HitPos + tr.HitNormal * 100
    local ent = ents.Create(ClassName)
    ent:SetPos(SpawnPos)
    ent:Spawn()
    ent:Activate()

    return ent
end
