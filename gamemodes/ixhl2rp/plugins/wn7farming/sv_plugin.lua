--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

function PLUGIN:SaveCrops() -- this actually saves the garden beds, go figure? 
	local crops = {}

	for k, v in pairs(ents.FindByClass("wn_crop")) do
		crops[#crops + 1] = {
			v:GetAngles(),
			v:GetPos()		
		}
	end

	ix.data.Set("crops", crops)
end
function PLUGIN:LoadCrops()
	local crops = ix.data.Get("crops")

	if crops then
		for k, v in pairs(crops) do
			local entity = ents.Create("wn_crop")
			entity:SetAngles(v[1])
			entity:SetPos(v[2])
			entity:Spawn()
		end
	end
end
function PLUGIN:SavePlants() -- need to work with mysql later cuz this might get heavy
    local data = {}

    for _, v in pairs(ents.FindByClass("cw_plant")) do
        data[#data + 1] = {
            position = v:GetPos(),
            angles = v:GetAngles(),
            grow = v.GrowTime,
            initialgrow = v.InitialGrowTime,
            harvest = v.Harvest,
            baseharvest = v.baseHarvest,
            growthPercent = v.GrowthPercent,
            isRuined = v.isRuined,
            hydration = v.Hydration,
            fertilizer = v.Fertilizer,
            model = v:GetModel()            
        }
    end 

    ix.data.Set("wn7farming", data)
end

function PLUGIN:LoadPlants()
    local plantsData = ix.data.Get("wn7farming")

    if plantsData then
        for _, data in pairs(plantsData) do
            local entity = ents.Create("cw_plant")

            entity:SetPos(data.position)
            entity:SetAngles(data.angles)
            entity.GrowTime = data.grow
            entity.InitialGrowTime = data.initialgrow
            entity.Harvest = data.harvest
            entity.baseHarvest = data.baseharvest
            entity.GrowthPercent = data.growthPercent
            entity.isRuined = data.isRuined or false
            entity.Hydration = data.hydration or 10
            entity.Fertilizer = data.fertilizer or 0
            entity:Spawn()

            entity:SetModel(data.model)
        end
    end
end



function PLUGIN:SaveData()
	self:SaveCrops()
    self:SavePlants()
end

function PLUGIN:LoadData()
	self:LoadCrops()
    self:LoadPlants()
end