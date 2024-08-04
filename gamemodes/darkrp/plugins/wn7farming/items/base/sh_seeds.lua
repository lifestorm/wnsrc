--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Seeds Base"
ITEM.category = "Farming"
ITEM.model = "models/props_lab/box01a.mdl"
ITEM.useSound = {"player/footsteps/dirt1.wav", "player/footsteps/dirt2.wav", "player/footsteps/dirt3.wav", "player/footsteps/dirt4.wav"}
ITEM.PlantModel = "models/props/de_inferno/claypot03_damage_01.mdl"
ITEM.GrowTime = {14400, 14600}
ITEM.Harvest = "fruit_apple"
ITEM.baseHarvest = {5, 15}
ITEM.outlineColor = Color(0, 255, 0, 100)
ITEM.functions.plant = {
    name = "Plant",
    icon = "icon16/brick_add.png",
    OnRun = function(item)
        local client = item.player
        local trace = client:GetEyeTraceNoCursor()
		if (trace.HitPos:DistToSqr(client:GetShootPos()) > 192 * 192) then
			client:Notify("You can't plant it that far away!")
			return false
		end
		
		if (trace.Entity:GetModel() != "models/wn7new/advcrates/n7_planter_dirt.mdl") then
			client:Notify("This can only be planted in suitable soil.")
			return false
		end
		
		local check = true
		
		for k, v in pairs(ents.FindInSphere(trace.HitPos, 10)) do
			if v:GetClass() == "cw_plant" then
				check = false
			end
		end
		
		if (!check) then
			client:Notify("You can't plant this close to another plant!")
			return false
		end
		
		local seed = ents.Create("cw_plant")
		local growtimeItem = math.random(item.GrowTime[1], item.GrowTime[2])
		local baseHarvest = math.random(item.baseHarvest[1], item.baseHarvest[2])
		local character = client:GetCharacter()
		local cookingSkill = character:GetSkillLevel("cooking")
		local growtime = growtimeItem - (cookingSkill * 10)
		character:DoAction("plant_seed")
		
		seed:SetPos(trace.HitPos + trace.HitNormal + trace.Entity:GetUp() * -3)
		seed.Harvest = item.Harvest
		seed.baseHarvest = baseHarvest
		seed.GrowthPercent = 0
		seed.GrowTime = growtime
		seed.InitialGrowTime = growtime
		seed.BaseHarvest = baseHarvest
		seed.Fertilizer = 0
		seed.Hydration = 10
		seed:Spawn()
		
		seed:SetModel(item.PlantModel)
		
		client:Notify("You have successfully planted the seeds")
		
		local startPos = seed:GetPos() + Vector(0, 0, 10)
		local endPos = startPos + Vector(0, 0, 32768)
		local skyCheckTrace = util.TraceLine({
			start = startPos,
			endpos = endPos,
			mask = MASK_SOLID_BRUSHONLY
		})
		
		seed.HasSun = skyCheckTrace.HitSky 
		
		for _, ent in pairs(ents.FindInSphere(self:GetPos(), 1500)) do
			if IsValid(ent) and ent:GetClass() == "wn_sunlamp" and ent:GetNetVar("enabled") then
				seed.HasSun = true
				break
			end
		end

		
		if !seed.HasSun then 
			client:ChatNotify("The plant won't survive for long as it's not in an open area with sunlight.")
		end 
		return true 
    end,
    OnCanRun = function(item)
        if (IsValid(item.entity)) then
			return false
		end
	
		return true
    end
}

function ITEM:PopulateTooltip(tooltip)
	local data = tooltip:AddRow("data")
	data:SetBackgroundColor(derma.GetColor("Error", tooltip))
	data:SetText("You can plant these seeds in a special garden.")
	data:SizeToContents()
end


-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end
