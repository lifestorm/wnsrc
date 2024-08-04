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

function ENT:Initialize()
    self:SetModel("models/props_junk/PopCan01a.mdl")
    self:DrawShadow(false)

    if SERVER then
        self:SetName("pill_target_" .. self:EntIndex())
    end
end

function ENT:Draw()
end
--[[
function ENT:SetupDataTables()
	self:NetworkVar("Entity",0,"Owner")
end

function ENT:Initialize()
	local owner = self:GetOwner()
	owner.pill_cam = self

	if SERVER then
		owner:SetViewEntity(self)
		self:SetPos(owner:GetPos())
		self:SetParent(owner)
	end
end



function ENT:Think() 
	local owner = self:GetOwner()
	local ent = pk_pills.getMappedEnt(owner)

	if IsValid(ent) then
		if CLIENT then
			local mv_diff = owner:GetPos()-owner:GetNetworkOrigin()

			local startpos
			if ent.formTable.type=="phys" then
				startpos = ent:LocalToWorld(ent.formTable.camera&&ent.formTable.camera.offset||Vector(0,0,0))
			else
				startpos=owner:EyePos()
			end
			//startpos=startpos-mv_diff


			local angles = owner:EyeAngles()

			if pk_pills.var_thirdperson:GetBool() then
				local dist
				if ent.formTable.type=="phys"&&ent.formTable.camera&&ent.formTable.camera.distFromSize then
					dist = ent:BoundingRadius()*5
				else
					dist = ent.formTable.camera&&ent.formTable.camera.dist||100
				end

				local offset = LocalToWorld(Vector(-dist,0,dist/5),Angle(0,0,0),Vector(0,0,0),angles)
				local basevel
				if ent.formTable.type=="phys" then
					basevel=ent:GetVelocity()
				else
					basevel = owner:GetVelocity()
				end

				local tr = util.TraceHull({
					start=startpos,
					endpos=startpos+offset,
					filter=ent.camTraceFilter,
					mins=Vector(-10,-10,-10),
					maxs=Vector(10,10,10),
					mask=MASK_VISIBLE
				})
				//PrintTable(ent.camTraceFilter)
				local troffset = -tr.HitNormal:Dot(basevel*FrameTime())*1.2
				self:SetNetworkOrigin(tr.HitPos+tr.HitNormal*troffset)
				//view.vm_origin = view.origin+view.angles:Forward()*-500

			else
				self:SetNetworkOrigin(startpos)
			end
			self:SetAngles(angles)
		else
			//self:SetNetworkOrigin(ent:GetPos())
		end
	elseif SERVER then
		self:Remove()
		owner.pill_cam=nil

		if SERVER then
			owner:SetViewEntity()
		end
	end

	self:NextThink(CurTime())
	return true
end

/*
hook.Add("Think","pk_pill_cam_position",function()
	local camera = CLIENT and LocalPlayer().pill_cam
	if IsValid(camera) then
		camera:MoveCam()
	end
end)

function ENT:MoveCam()
	local owner = self:GetOwner()
	local ent = pk_pills.getMappedEnt(owner)

	if IsValid(ent) then
		//if CLIENT then
			local startpos
			if ent.formTable.type=="phys" then
				startpos = ent:LocalToWorld(ent.formTable.camera&&ent.formTable.camera.offset||Vector(0,0,0))
			else
				startpos=owner:EyePos()
			end

			local angles = owner:EyeAngles()

			if pk_pills.var_thirdperson:GetBool() then
				local dist
				if ent.formTable.type=="phys"&&ent.formTable.camera&&ent.formTable.camera.distFromSize then
					dist = ent:BoundingRadius()*5
				else
					dist = ent.formTable.camera&&ent.formTable.camera.dist||100
				end

				local offset = LocalToWorld(Vector(-dist,0,dist/5),Angle(0,0,0),Vector(0,0,0),angles)
				local tr = util.TraceHull({
					start=startpos,
					endpos=startpos+offset,
					filter=ent.camTraceFilter,
					mins=Vector(-5,-5,-5),
					maxs=Vector(5,5,5),
					mask=MASK_VISIBLE
				})
				//PrintTable(ent.camTraceFilter)

				self:SetNetworkOrigin(tr.HitPos)
				
				//view.vm_origin = view.origin+view.angles:Forward()*-500

			else
				self:SetNetworkOrigin(startpos)
			end

			self:SetAngles(angles)
		//end
	end
end
]]
