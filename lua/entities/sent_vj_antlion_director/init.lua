--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Antlion = {
	"npc_vj_hla_antlion"
}

ENT.previousNodes = {} -- Leave this here, for some reason it doesn't work in the initialize
ENT.HordeSpawnRate = 0.19 -- The difference in time between each spawned Horde
ENT.SkipOnRemove = false

function ENT:Initialize()
	local i = 0
	for k, v in ipairs(ents.GetAll()) do
		if v:GetClass() == "sent_vj_antlion_director" then
			i = i + 1
			if i > 1 then PrintMessage(HUD_PRINTTALK, "Only one A.I. Director can be present in the map.") self.SkipOnRemove = true self:Remove() return end
		end
	end
	
	if table.Count(VJ_ANT_NODEPOS) <= 0 then
		error("No nodegraph detected! Play on a noded map to use the director. Nodes made using the nodegraph editor are undetectable as they're not actually nodes")
		self:Remove()
		return
	end
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetPos(Vector(0,0,0))
	self:SetNoDraw(true)
	self:DrawShadow(false)
	
	self.IsActivated = tobool(GetConVarNumber("vj_antlion_director_enabled"))
	self.Antlion_SpawnDistance = GetConVarNumber("vj_antlion_director_spawnmax")
	self.Antlion_SpawnDistanceClose = GetConVarNumber("vj_antlion_director_spawnmin")
	self.Antlion_HordeChance = GetConVarNumber("vj_antlion_director_hordechance")
	self.Antlion_HordeCooldownMin = GetConVarNumber("vj_antlion_director_hordecooldownmin")
	self.Antlion_HordeCooldownMax = GetConVarNumber("vj_antlion_director_hordecooldownmax")
	self.Antlion_MaxAntlions = GetConVarNumber("vj_antlion_director_max")
	self.Antlion_MaxHordeSpawn = GetConVarNumber("vj_antlion_director_hordecount")
	self.tbl_SpawnedNPCs = {}
	self.tbl_NPCsWithEnemies = {}
	self.NextAICheckTime = CurTime() +5
	self.NextAntlionSpawnTime = CurTime() +1
	self.NextHordeSpawnTime = CurTime() +math.Rand(self.Antlion_HordeCooldownMin,self.Antlion_HordeCooldownMax)
end

function ENT:OnRemove()
	if self.SkipOnRemove == true then return end
	for index,object in ipairs(self.tbl_SpawnedNPCs) do
		if IsValid(object) then
			object:Remove()
		end
	end
end

function ENT:Think()
	self.IsActivated = tobool(GetConVarNumber("vj_antlion_director_enabled"))
	if self.IsActivated then
		self:ManageVars()
		self:ManageAI()
	end
end

function ENT:ManageVars()
	self.Antlion_SpawnDistance = GetConVarNumber("vj_antlion_director_spawnmax")
	self.Antlion_SpawnDistanceClose = GetConVarNumber("vj_antlion_director_spawnmin")
	self.Antlion_HordeChance = GetConVarNumber("vj_antlion_director_hordechance")
	self.Antlion_HordeCooldownMin = GetConVarNumber("vj_antlion_director_hordecooldownmin")
	self.Antlion_HordeCooldownMax = GetConVarNumber("vj_antlion_director_hordecooldownmax")
	self.Antlion_MaxAntlions = GetConVarNumber("vj_antlion_director_max")
	self.Antlion_MaxHordeSpawn = GetConVarNumber("vj_antlion_director_hordecount")
	self.AI_RefreshTime = GetConVarNumber("vj_l4d_director_refreshrate")
end

function ENT:CheckSurvivorDistance(ent)
	local survivors = self:FindSurvivors(ent:GetPos())
	local farthestSurvivor = survivors[table.Count(survivors)]
	if ent:GetPos():Distance(farthestSurvivor:GetPos()) >= GetConVarNumber("vj_antlion_director_spawnmax") +750 && !ent:Visible(farthestSurvivor) then
		ent:Remove()
	end
end

function ENT:ManageAI()
	-- Checks for inactive AI
	if CurTime() > self.NextAICheckTime then
		if #self.tbl_SpawnedNPCs <= 0 then return end
		for _,v in ipairs(self.tbl_SpawnedNPCs) do
			if IsValid(v) then
				self:CheckSurvivorDistance(v)
				if IsValid(v:GetEnemy()) && !table.HasValue(self.tbl_NPCsWithEnemies,v) then
					table.insert(self.tbl_NPCsWithEnemies,v)
				elseif !IsValid(v:GetEnemy()) then
					if table.HasValue(self.tbl_NPCsWithEnemies,v) then
						table.remove(self.tbl_NPCsWithEnemies,self.tbl_NPCsWithEnemies[v])
					end
				end
			end
		end
		table.Empty(self.previousNodes) -- Reset the previously spawned-on nodes to refresh spawn positions
		self.previousNodes = {}
		self.NextAICheckTime = CurTime() +5
	end

	-- Spawns AI
	if CurTime() > self.NextAntlionSpawnTime then
		if table.Count(self.tbl_SpawnedNPCs) >= self.Antlion_MaxAntlions -self.Antlion_MaxHordeSpawn then return end -- Makes sure that we can at least spawn a Horde when it's time
		self:SpawnAntlion(VJ_PICKRANDOMTABLE(self.Antlion),self:FindClearArea(false))
		self.NextAntlionSpawnTime = CurTime() + math.Rand(GetConVarNumber("vj_antlion_director_delaymin"),GetConVarNumber("vj_antlion_director_delaymax"))
	end

	-- Spawns Hordes
	if CurTime() > self.NextHordeSpawnTime && math.random(1,self.Antlion_HordeChance) == 1 then
		for i = 1,self.Antlion_MaxHordeSpawn do
			timer.Simple(self.HordeSpawnRate *i,function() -- Help with lag when spawning
				if IsValid(self) then
					self:SpawnAntlion(VJ_PICKRANDOMTABLE(self.Antlion),self:FindClearArea(true),true)
				end
			end)
		end
		self.NextHordeSpawnTime = CurTime() + math.Rand(self.Antlion_HordeCooldownMin,self.Antlion_HordeCooldownMax)
	end
end

function ENT:CheckNodeVisibility(pos,survivor)
	local nodeCheck = ents.Create("prop_vj_animatable")
	nodeCheck:SetModel("models/cpthazama/l4d1/common/common_patient_male01.mdl")
	nodeCheck:SetPos(pos)
	nodeCheck:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	nodeCheck:Spawn()
	nodeCheck:Activate()
	nodeCheck:SetNoDraw(true)
	nodeCheck:DrawShadow(false)
	timer.Simple(0.02,function()
		if IsValid(nodeCheck) then
			nodeCheck:Remove()
		end
	end)
	return nodeCheck:Visible(survivor)
end

function ENT:ConfigureNodeTable(tbl)
	local newTable = {}
	local ply = self:PickRandomSurvivor()
	for _,v in pairs(tbl) do
		newTable[v] = v:Distance(ply:GetPos())
	end
	return table.SortByKey(newTable,true)
end

function ENT:FindClearArea(getClosest)
	if table.Count(self.tbl_SpawnedNPCs) >= self.Antlion_MaxAntlions then return end
	if getClosest then
		if table.Count(VJ_ANT_NODEPOS) > 0 then
			for _,i in ipairs(self:ConfigureNodeTable(VJ_ANT_NODEPOS)) do
				local nodePos = i
				local survivor = self:FindSurvivors(nodePos)[1]
				if nodePos:Distance(survivor:GetPos()) <= self.Antlion_SpawnDistance && nodePos:Distance(survivor:GetPos()) > self.Antlion_SpawnDistanceClose then
					if !self:CheckNodeVisibility(nodePos,survivor) then
						table.insert(self.previousNodes,nodePos)
						return nodePos
					end
				end
			end
		end
	else
		if table.Count(VJ_ANT_NODEPOS) > 0 then
			for _,i in ipairs(self:ConfigureNodeTable(VJ_ANT_NODEPOS)) do
				local nodePos = i
				local survivor = self:FindSurvivors(nodePos)[1]
				if self.previousNodes[nodePos] then return end
				if nodePos:Distance(survivor:GetPos()) <= self.Antlion_SpawnDistance && nodePos:Distance(survivor:GetPos()) > self.Antlion_SpawnDistanceClose then
					-- if !survivor:VisibleVec(nodePos) then
					if !self:CheckNodeVisibility(nodePos,survivor) then
						if table.HasValue(self.previousNodes,nodePos) then return end
						table.insert(self.previousNodes,nodePos)
						return nodePos
					end
				end
			end
		end
	end
end

function ENT:PickRandomSurvivor()
	local tbl = {}
	for _,v in ipairs(player.GetAll()) do
		table.insert(tbl,v)
	end
	return VJ_PICKRANDOMTABLE(tbl)
end

function ENT:FindSurvivors(vec)
	local tb = {}
	if vec then
		for _,v in pairs(player.GetAll()) do
			tb[v] = v:GetPos():Distance(vec)
		end
		return table.SortByKey(tb,true)
	else
		for _,v in pairs(player.GetAll()) do
			table.insert(tb,v)
		end
		return tb
	end
end

function ENT:SpawnAntlion(ent,pos,isHorde)
	if pos == nil then /*MsgN("AI Director: Could not spawn Antlion, no position specified!")*/ return end
	if table.Count(self.tbl_SpawnedNPCs) >= self.Antlion_MaxAntlions then return end
	local Antlion = ents.Create(ent)
	Antlion:SetPos(pos)
	Antlion:Spawn()
	Antlion:Activate()
	table.insert(self.tbl_SpawnedNPCs,Antlion)
	Antlion:VJ_ACT_PLAYACTIVITY("UnBurrow01",true,false,false)
	if isHorde then
		Antlion.FindEnemy_UseSphere = true
		Antlion.FindEnemy_CanSeeThroughWalls = true
		Antlion:DrawShadow(false)
		timer.Simple(0.02,function()
			if IsValid(Antlion) then
				Antlion:DrawShadow(false)
			end
		end)
	end
	Antlion.AI_Director = self
	function Antlion:CustomOnRemove()
		if IsValid(self.AI_Director) then
			table.remove(self.AI_Director.tbl_SpawnedNPCs,self.AI_Director.tbl_SpawnedNPCs[self])
			if table.HasValue(self.AI_Director.tbl_NPCsWithEnemies,self) then table.remove(self.AI_Director.tbl_NPCsWithEnemies,self.AI_Director.tbl_NPCsWithEnemies[self]) end
		end
	end
	Antlion.EntitiesToNoCollide = {
		"npc_vj_hla_antlion"
	}
end