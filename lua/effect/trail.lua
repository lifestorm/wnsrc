--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

WeaponTrail.Eff = {}
local iSteps = 10
local Eff = {}
local mat = Material( "down/vs/trail")
Eff.Time = 10
function Eff:InitEffect()
	self.DieTime = CurTime() + (self.CustomTime or 5)
    self.Flag	 = self.Flag or 0
	self.Size = self.Size or 100

    local lastseq = self.Owner:GetSequenceName(self.Owner:GetSequence())//self.Owner:GetNW2Int("Anim_Name")
    if  self.Seq != "none" then
        self.Seq = lastseq or "none"
    end
	self.Mat = Material(self.Mat or "")

	self.TrailData = {}

	self.Mesh = Mesh()


	local BoneData = WeaponTrail.BoneSet[self.Flag]
	local ply = self.Owner
	local pos, ang = ply:GetBonePosition(ply:LookupBone(BoneData.BoneName or "" ) or 0)
	ang = ang + BoneData.AddAngle or Angle()


	local basePos = pos
	local curPos = pos + ang:Up() * self.Size

	if BoneData.AngleType == 0 then
		curPos = pos + ang:Up() * self.Size
	end
	if BoneData.AngleType == 1 then
		curPos = pos + ang:Right() * self.Size
	end
	if BoneData.AngleType == 2 then
		curPos = pos + ang:Forward() * self.Size
	end
	if self.DieTime - CurTime() >= 0 then

		self.TrailData[#self.TrailData+1] = {
			basePos = basePos,
			curPos =  curPos,
			_Time = BoneData.Trail_Time  + CurTime(),
		}
	end

end
function Eff:Think()

end
function Eff:EndEffect()
end

function Eff:Draw(_call)
	if !self.Owner:IsValid() then
		return

	end
		local ply = self.Owner
		local BoneData = WeaponTrail.BoneSet[self.Flag]

		local pos, ang = ply:GetBonePosition(ply:LookupBone(BoneData.BoneName or "" ) or 0)
		ang = ang + BoneData.AddAngle or ""


		local basePos = pos
		local curPos = pos + ang:Up() * self.Size

		if BoneData.AngleType == 0 then
			curPos = pos + ang:Up() * self.Size
		end
		if BoneData.AngleType == 1 then
			curPos = pos + ang:Right() * self.Size
		end
		if BoneData.AngleType == 2 then
			curPos = pos + ang:Forward() * self.Size
		end
		if self.DieTime - CurTime() >= 0 then

			self.TrailData[#self.TrailData+1] = {
				basePos = basePos,
				curPos =  curPos,
				_Time = BoneData.Trail_Time  + CurTime(),
			}
		end

		local vMesh = {}
		local icount = iSteps
		for v, k in pairs(self.TrailData) do
			if self.TrailData[v-1] and self.TrailData[v-2] and v % 2 == 0 then
				local p = self.TrailData[v-1]
				local p2 = self.TrailData[v-2]

				local ppos = k.curPos
				local ppos2 = k.basePos
				for i = 1, icount do
					local t = (i/icount)
					local count_1 = (1/#self.TrailData) * t
					local pos = math.Beizer(k.curPos, p.curPos, p2.curPos, t)
					local pos2 = math.Beizer(k.basePos, p.basePos, p2.basePos, t)
					local fUvRatio = (v / (#self.TrailData))
					local U = fUvRatio - count_1
					local a = #vMesh


					vMesh[a+1] = {pos = pos2, u = U, v = 1}
					vMesh[a+2] = {pos = pos, u = U, v = 0}
					vMesh[a+3] = {pos = ppos, u = U, v = 0}

					vMesh[a+4] = {pos = pos2, u = U, v = 1}
					vMesh[a+5] = {pos = ppos, u = U, v = 0}
					vMesh[a+6] = {pos = ppos2, u = U, v = 1}

					ppos = pos
					ppos2 = pos2
				end
			end
			if k._Time - CurTime() <= 0 then
				table.remove(self.TrailData, v)
			end
		end
		self.vMesh = vMesh
		if #self.TrailData <= 0 and self.DieTime - CurTime() <= 0 then
			return false
		end
		local lastseq = self.Owner:GetSequenceName(self.Owner:GetSequence())//self.Owner:GetNW2Int("Anim_Name")
		if self.Seq != "none" and self.Seq != lastseq then
			self.Seq = "none"
			return false
		end

	render.SetMaterial(self.Mat)
	local imesh = Mesh()
	if #self.TrailData > 1 and self.vMesh then
		imesh:BuildFromTriangles(self.vMesh)
	end
	imesh:Draw()
	imesh:Destroy()
	return true
end

WeaponTrail.Eff = Eff

function math.Beizer(p0, p1, p2, t)
	return LerpVector(t, LerpVector(t, p0, p1), LerpVector(t, p1, p2))
end
