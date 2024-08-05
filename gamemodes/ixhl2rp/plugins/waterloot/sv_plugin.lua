--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

function PLUGIN:CanPlaceCookingPot(client)
    if !client then return false end
    if !client:Alive() then return false end

    local targetEnt = client:GetEyeTraceNoCursor().Entity
    for _, v in pairs(ents.FindInSphere(client:GetPos(), 50)) do
        if v:GetClass() != "ix_campfire" then continue end

        targetEnt = v
        break
    end

    if !targetEnt then client:Notify("The cooking pot needs to be on a campfire or an oven!") return false end
    if !IsValid(targetEnt) then client:Notify("The cooking pot needs to be on a campfire or an oven!") return false end
    if targetEnt.HasPotPlaced then client:Notify("There is already a cooking pot on this campfire or oven!") return false end
    local entClass = targetEnt:GetClass()

    if entClass == "ix_campfire" then return targetEnt, "ix_campfire" end
    if entClass != "ix_item" then client:Notify("The cooking pot needs to be on a campfire or an oven!") return false end
    if entClass == "ix_item" and !targetEnt:GetItemTable() then client:Notify("The cooking pot needs to be on a campfire or an oven!") return false end
    local itemTable = targetEnt:GetItemTable()
    local allowedTools = {"tool_oven_rusty", "tool_oven"}

    if entClass == "ix_item" and table.HasValue(allowedTools, itemTable.uniqueID) then return targetEnt, itemTable.uniqueID end
end

function PLUGIN:PlaceCookingPot(client, item)
    local cookingSurfaceEnt, uniqueID = self:CanPlaceCookingPot(client)
    if !cookingSurfaceEnt or (cookingSurfaceEnt and !IsValid(cookingSurfaceEnt)) then return false end

    local bSuccess, error = item:Transfer(nil, nil, nil, item.player)
    if (!bSuccess and isstring(error)) then
        client:Notify("Could not drop the cooking pot and place it.")
        return
    end

    local potEntity = bSuccess
    local normPos = 45
    local rustyPos = 25
    local campPos = 32
    local zPos = (uniqueID == "ix_campfire" and campPos or uniqueID =="tool_oven_rusty" and rustyPos or normPos)

    potEntity:SetAngles(cookingSurfaceEnt:GetAngles())
    potEntity:SetPos(cookingSurfaceEnt:GetPos() + cookingSurfaceEnt:GetUp() * zPos)
    constraint.Weld( potEntity, cookingSurfaceEnt, 0, 0, 0, true, true )
    local physObj = potEntity:GetPhysicsObject()
    if !physObj then return end
    physObj:EnableMotion(false)

    cookingSurfaceEnt.HasPotPlaced = true
    item.cookingPlatform = cookingSurfaceEnt
    potEntity.isFiltrating = false
    potEntity.cookingPlatform = cookingSurfaceEnt
    client:EmitSound("physics/metal/metal_barrel_impact_soft1.wav")
end

function PLUGIN:TargetError(client, type)
    client:Notify("You are not looking at a "..type.."!")
end

function PLUGIN:CanFiltrateWater(client, item)
    if !client then return false end
    if !client:Alive() then return false end
    if item:GetData("filtrated", false) then client:Notify("This water is already filtrated!") return false end
    if !item:GetData("water") then client:Notify("There is no water in the bottle!") return false end
    local currentWaterAmount = item:GetData("water", 0)
    if currentWaterAmount <= 0 then client:Notify("There is not enough water to filtrate in the bottle!") return false end

    local targetEnt = client:GetEyeTraceNoCursor().Entity
    if !targetEnt then self:TargetError(client, "cooking pot") return false end
    if !IsValid(targetEnt) then self:TargetError(client, "cooking pot") return false end
    local entClass = targetEnt:GetClass()
    if entClass != "ix_item" then self:TargetError(client, "cooking pot") return false end
    if entClass == "ix_item" and !targetEnt:GetItemTable() then self:TargetError(client, "cooking pot") return false end
    local itemTable = targetEnt:GetItemTable()

    if itemTable.uniqueID != "tool_cookingpot" then
        client:Notify("You need to be looking at a cooking pot to filtrate this water.")
        return false
    end

    local itemID = targetEnt.ixItemID
    itemTable = ix.item.instances[itemID]

    if targetEnt.isFiltrating then client:Notify("This cooking pot is already filtrating water!") return false end

    local parent = targetEnt.cookingPlatform
    if !IsValid(parent) then client:Notify("The cooking pot needs to be on a campfire or an oven!") return false end
    local parentClass = parent:GetClass()
    if parentClass == "ix_campfire" then return targetEnt, currentWaterAmount, itemTable end
    if parentClass == "ix_item" and !parent:GetItemTable() then client:Notify("The cooking pot needs to be on a campfire or an oven!") return false end
    local allowedTools = {"tool_oven_rusty", "tool_oven"}
    if table.HasValue(allowedTools, parent:GetItemTable().uniqueID) then return targetEnt, currentWaterAmount, itemTable end

    client:Notify("The cooking pot needs to be on a campfire or an oven!")
    return false
end

function PLUGIN:FiltrateWater(client, item)
    local cookingPot, currentWaterAmount, potItem = self:CanFiltrateWater(client, item)
    if !cookingPot or cookingPot and !IsValid(cookingPot) or !currentWaterAmount then return false end
    potItem:SetData("durability", math.max(0, potItem:GetDurability() - 1))

    if (potItem:GetDurability() == 0) then
        if cookingPot.cookingPlatform then
            cookingPot.cookingPlatform.HasPotPlaced = false
        end
        cookingPot:EmitSound("weapons/crowbar/crowbar_impact"..math.random(1, 2)..".wav", 65)
        cookingPot:Remove()

        return
    end

    cookingPot.currentWaterAmount = currentWaterAmount
    item:SetData("water", 0)

	local smoke = ents.Create( "env_smokestack" )
    smoke:SetPos(cookingPot:GetPos())
    smoke:SetAngles(cookingPot:GetAngles())

	smoke:SetKeyValue("InitialState", "1")
    smoke:SetKeyValue("WindAngle", "0 0 0")
    smoke:SetKeyValue("WindSpeed", "0")
    smoke:SetKeyValue("rendercolor", "255 255 255")
    smoke:SetKeyValue("renderamt", "50") -- alpha
    smoke:SetKeyValue("SmokeMaterial", "particle/smokesprites_0001.vmt")
    smoke:SetKeyValue("BaseSpread", "1")
    smoke:SetKeyValue("SpreadSpeed", "3")
    smoke:SetKeyValue("Speed", "11")
    smoke:SetKeyValue("StartSize", "8")
    smoke:SetKeyValue("EndSize", "9")
    smoke:SetKeyValue("roll", "8")
    smoke:SetKeyValue("Rate", "24")
    smoke:SetKeyValue("JetLength", "46")
    smoke:SetKeyValue("twist", "6")
	smoke:Spawn()
    smoke:SetParent(cookingPot)
	smoke:Activate()

    if (!IsValid(cookingPot.spark)) then
        cookingPot.spark = ents.Create("env_splash")
    end
    cookingPot.spark:SetPos(cookingPot:GetPos())
    cookingPot.spark:SetKeyValue( "scale", 3 )
    cookingPot.spark:Fire("Splash")
    cookingPot:DeleteOnRemove(cookingPot.spark)
    cookingPot.spark:SetParent(cookingPot)

    if IsValid(cookingPot.cookingPlatform) then
        cookingPot.cookingPlatform:EmitSound( "ambient/levels/canals/water_flow_loop1.wav", 75, 100, 1, CHAN_AUTO )
    end

    cookingPot:DeleteOnRemove(smoke)
    cookingPot.finished = false
    cookingPot.isFiltrating = true

    netstream.Start(client, "ixWaterLootCreateProgressTextCookingPot", cookingPot:EntIndex())

    local timerName = "ixWaterLootFiltrationTimer_"..cookingPot:EntIndex()
    timer.Create(timerName, ix.config.Get("waterFiltrationTimeNeeded", 1) * 60, 1, function()
        if !IsValid(cookingPot) then timer.Remove(timerName) return end
        if !item or item and !item.GetID then return false end

        if IsValid(cookingPot.cookingPlatform) then
            cookingPot.cookingPlatform:StopSound( "ambient/levels/canals/water_flow_loop1.wav" )
        end

        netstream.Start(client, "ixWaterLootCreateProgressTextCookingPot", cookingPot:EntIndex(), true)
        cookingPot.finished = true
        cookingPot.isFiltrating = false

        if !IsValid(smoke) then return end
        smoke:Remove()
    end)
end

function PLUGIN:IsWaterDeepEnough(client)
    local pos = client:GetPos() + Vector(0, 0, 15)
    local trace = {}
    trace.start = pos
    trace.endpos = pos + Vector(0, 0, 1)
    trace.mask = bit.bor( MASK_WATER )
    local tr = util.TraceLine(trace)

    return tr.Hit
end

function PLUGIN:FillWaterError(client)
    client:Notify("You are not looking at a water cache, a cooking pot with filtrated water or you are not deep enough in water!")
end

function PLUGIN:CanFillWaterCannister(client)
    if self:IsWaterDeepEnough(client) then return true end

    local targetEnt = client:GetEyeTraceNoCursor().Entity
    if !targetEnt then self:FillWaterError(client) return false end
    if !IsValid(targetEnt) then self:FillWaterError(client) return false end
    local entClass = targetEnt:GetClass()

    if entClass == "ix_watercache" and !targetEnt.HasPotPlaced then client:Notify("There is no valve on the cache to help take water!") return false end
    if entClass == "ix_watercache" and targetEnt.HasPotPlaced then return targetEnt end
    if entClass != "ix_item" then self:FillWaterError(client) return false end
    if entClass == "ix_item" and !targetEnt:GetItemTable() then self:FillWaterError(client) return false end
    local itemTable = targetEnt:GetItemTable()
    if itemTable.uniqueID != "tool_cookingpot" then
        self:FillWaterError(client)
        return false
    else
        return targetEnt
    end
end

function PLUGIN:FillEmptyWaterCannister(client, item)
    if item:GetData("water", 0) >= 100 then client:Notify("This water bottle is already full.") return false end
    local target = self:CanFillWaterCannister(client)
    if !target then return false end

    if isbool(target) or target:GetClass() == "ix_watercache" then
        local newValue = math.Clamp(item:GetData("water", 0) + ix.config.Get("waterFillPerRefill", 100), 0, 100)
        client:Notify("You've refilled the "..item:GetName().." to "..newValue.."%")

        item:SetData("filtrated", false)
        item:SetData("water", newValue)
        client:EmitSound("ambient/water/water_spray1.wav")

        local leechChance = ix.config.Get("chanceToGetLeech", 5)
        if self:CalcLeechChance(leechChance) then
            local itemTable = ix.item.list["ing_raw_leech"]
            local character = client:GetCharacter()
            local inventory = character:GetInventory()
            if IsValid(client) and character and inventory then
                if (!inventory:FindEmptySlot(itemTable.width, itemTable.height)) then
                    return false
                end

                inventory:Add("ing_raw_leech")
            end
        end

        item:DamageDurability(1)

        return
    end

    if IsEntity(target) then
        if !target.currentWaterAmount then client:Notify("There is no water in this cooking pot!") return false end
        if !target.finished then client:Notify("This cooking pot has not boiled yet!") return false end
        if item:GetData("water", 0) > 0 and !item:GetData("filtrated", false) then client:Notify("There is unfiltrated water in this bottle!") return false end

        item:SetData("water", target.currentWaterAmount)
        item:SetData("filtrated", true)

        netstream.Start(client, "ixWaterLootCreateProgressTextCookingPot", target:EntIndex(), false)
        target.currentWaterAmount = nil
        target.finished = false
        client:EmitSound("ambient/water/water_spray1.wav")

        if (!IsValid(target.spark)) then
            target.spark = ents.Create("env_splash")
        end

        target.spark:SetPos(target:GetPos())
        target.spark:SetKeyValue( "scale", 3 )
        target.spark:Fire("Splash")
        target:DeleteOnRemove(target.spark)
        target.spark:SetParent(target)
    end
end

function PLUGIN:CalcLeechChance(percentage)
    return math.random() < percentage / 100
end

function PLUGIN:EmptyWaterCannister(client, item)
    if !client then return false end
    if !client:Alive() then return false end

    if item:GetData("water", 0) > 0 then
        item:SetData("water", 0)
        client:EmitSound("ambient/water/water_spray1.wav")
    else
        client:Notify("There is no water in this bottle to empty!")
    end
end

function PLUGIN:CanDrinkWater(client, item)
    if !client then return false end
    if !client:Alive() then return false end
    if !item:GetData("water") then client:Notify("There is no water in this bottle!") return false end
    if item:GetData("water", 0) <= 0 then client:Notify("There is not enough water in this bottle!") return false end

    if (ix.faction.Get(client:Team()).bDrinkUnfilteredWater) then return true end

    if !item:GetData("filtrated", false) then client:Notify("This water is not filtrated!") return false end

    return item:GetData("filtrated", false)
end

function PLUGIN:DrinkWater(client, itemID, waterAmount)
    if !ix.item.instances[itemID] then return false end
    local item = ix.item.instances[itemID]

    local character = client:GetCharacter()
    if !character then return false end

    local inventory = character:GetInventory()
    if !inventory then return false end

    if !inventory:GetItems()[itemID] then
        local targetEnt = client:GetEyeTraceNoCursor().Entity
        if !targetEnt then return false end
        if !IsValid(targetEnt) then return false end
        if targetEnt:GetClass() != "ix_item" then return false end
        if targetEnt.ixItemID and targetEnt.ixItemID != itemID then return false end
    end

    if !self:CanDrinkWater(client, item) then return false end
    if item:GetData("water", 0) < waterAmount then client:Notify("You are trying to drink more water than there is in the bottle!") return false end

    item:SetData("water", item:GetData("water", 0) - waterAmount)
    character:SetThirst(math.Clamp(character:GetThirst() - math.ceil(waterAmount), 0, 100))
    client:EmitSound("npc/barnacle/barnacle_gulp2.wav")
end

function PLUGIN:RequestDrinkWater(client, item)
    if !self:CanDrinkWater(client, item) then return false end
    netstream.Start(client, "ixWaterLootDrinkWater", item:GetID(), item:GetData("water", 0))
end

function PLUGIN:CanPlaceValve(client, item)
    if !client then return false end
    if !client:Alive() then return false end

    local targetEnt = client:GetEyeTraceNoCursor().Entity
    if !targetEnt then client:Notify("You are not looking at a water cache!") return false end
    if !IsValid(targetEnt) then client:Notify("You are not looking at a water cache!") return false end
    local entClass = targetEnt:GetClass()
    if entClass != "ix_watercache" then client:Notify("You are not looking at a water cache!") return false end
    if targetEnt.HasPotPlaced then client:Notify("There is already a valve on this water cache!") return false end

    return targetEnt
end

function PLUGIN:PlaceValve(client, item)
    local waterCacheEnt = self:CanPlaceValve(client, item)
    if !waterCacheEnt or (waterCacheEnt and !IsValid(waterCacheEnt)) then return false end

    local bSuccess, error = item:Transfer(nil, nil, nil, item.player)
    if (!bSuccess and isstring(error)) then
        client:Notify("Could not drop the water valve and place it.")
        return
    end

    local waterValve = bSuccess
	local rotation = Vector(90, 0, 0)
    local angle = waterCacheEnt:GetAngles()
	angle:RotateAroundAxis(angle:Up(), rotation.x)

    waterValve:SetAngles(angle)
    waterValve:SetPos(waterCacheEnt:GetPos() + waterCacheEnt:GetUp() * -12.5)
    constraint.Weld( waterValve, waterCacheEnt, 0, 0, 0, true, true )
    local physObj = waterValve:GetPhysicsObject()
    if !physObj then return end
    physObj:EnableMotion(false)

    waterCacheEnt.HasPotPlaced = true
    item.waterCache = waterCacheEnt
end

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("ix_watercache", true, true, true, {
		OnSave = function(entity, data) --OnSave
            return {pos = data.pos, angles = data.angles + Angle(0, 180, 0), motion = false}
		end,
	})
end

function PLUGIN:LoadWaterCaches()
    if (!ix.config.Get("SaveEntsOldLoadingEnabled")) then return end

	local waterCaches = ix.data.Get("watercaches")
	if waterCaches then
		for _, v in pairs(waterCaches) do
			local entity = ents.Create("ix_watercache")
			entity:SetAngles(v.angles)
			entity:SetPos(v.position)
			entity:Spawn()

			local physicsObject = entity:GetPhysicsObject()
			if (IsValid(physicsObject)) then
				physicsObject:EnableMotion(false)
			end
		end
		MsgC(Color(0, 255, 0), "[WATER LOOT] Water Caches Loaded.\n")
	else
		MsgC(Color(0, 255, 0), "[WATER LOOT] No Water Caches Loaded.\n")
	end
end

-- A function to save the static props.
function PLUGIN:SaveWaterCaches()
	local waterCaches = {}

	for _, v in pairs(ents.FindByClass("ix_watercache")) do
		waterCaches[#waterCaches + 1] = {
			angles = v:GetAngles(),
			position = v:GetPos()
		}
	end

	ix.data.Set("watercaches", waterCaches)
end

-- Called when Helix has loaded all of the entities.
function PLUGIN:InitPostEntity()
	self:LoadWaterCaches()
end

-- Called just after data should be saved.
function PLUGIN:SaveData()
	self:SaveWaterCaches()
end

netstream.Hook("ixWaterLootDrinkWater", function(client, itemID, waterAmount)
    PLUGIN:DrinkWater(client, itemID, waterAmount)
end)