--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local ents = ents
local tonumber = tonumber
local netstream = netstream
local timer = timer
local IsValid = IsValid
local IsEntity = IsEntity
local string = string
local tostring = tostring
local math = math
local Vector = Vector
local CurTime = CurTime


local PLUGIN = PLUGIN

function PLUGIN:CreateCigarette(item, client)
    local entity = ents.Create("ix_cigarette")
    entity:SetOwner(client)
    entity:SetParent(client)
    entity:Fire("SetParentAttachment", "cigarette", 0.01)

	entity:SetModel( "models/willardnetworks/cigarettes/cigarette.mdl" )
	entity:SetModelScale(0.7)

	entity:CreateJetLengthTimer()
    entity:ChangeSkinStateTimer()

	entity:Spawn()

    local length = item:GetData("length", 0)
    entity:SetFlexWeight(entity.flexIndexLength, tonumber(length))

	client.cigarette = entity
    item.cigaretteEnt = entity
    entity.cigaretteItem = item
    netstream.Start(client, "CigaretteSetClientEntity", item:GetID(), entity, false)
end

function PLUGIN:CreateCigaretteSmoke(entity)
	entity.smoke = ents.Create( "env_smokestack" )
	entity.smoke:SetParent(entity:GetParent())
	entity.smoke:Fire("SetParentAttachment", "cigarette_glow", 0.01)

	entity.smoke:SetKeyValue("InitialState", "1")
    entity.smoke:SetKeyValue("WindAngle", "90 0 0")
    entity.smoke:SetKeyValue("WindSpeed", "0.6")
    entity.smoke:SetKeyValue("rendercolor", "162 162 162")
    entity.smoke:SetKeyValue("renderamt", "6") -- alpha
    entity.smoke:SetKeyValue("SmokeMaterial", "particle/smokesprites_0001.vmt")
    entity.smoke:SetKeyValue("BaseSpread", "0.2")
    entity.smoke:SetKeyValue("SpreadSpeed", "0.4")
    entity.smoke:SetKeyValue("Speed", "1.4")
    entity.smoke:SetKeyValue("StartSize", "0.3")
    entity.smoke:SetKeyValue("EndSize", "1.5")
    entity.smoke:SetKeyValue("roll", "32")
    entity.smoke:SetKeyValue("Rate", "24")
    entity.smoke:SetKeyValue("twist", "32")

	entity:DeleteOnRemove(entity.smoke)

	entity.smoke:Spawn()
	entity.smoke:Activate()

	timer.Simple(0.25, function()
		if !IsValid(entity) then return end
		if !IsEntity(entity) then return end
		if entity.cigaretteItem and entity.cigaretteItem.GetID and ix.item.instances[entity.cigaretteItem:GetID()] then
			local lastSmokePos = tonumber(string.Right(tostring(math.Round(entity:GetFlexWeight(entity.flexIndexLength), 2)), 2))
			if entity.cigaretteItem:GetData("length", 0) > 0 then
				self:ChangeSmokePos(entity, entity:GetParent(), lastSmokePos)
			end
		end
	end)
end

function PLUGIN:ChangeSkinStateTimer(entity)
	if timer.Exists("ChangeSkinStateCigarette_"..entity:EntIndex()) then timer.Remove("ChangeSkinStateCigarette_"..entity:EntIndex()) end

	timer.Create("ChangeSkinStateCigarette_"..entity:EntIndex(), math.random(3, 7), 0, function()
		if !IsValid(entity) then timer.Remove("ChangeSkinStateCigarette_"..entity:EntIndex()) return end

		local parent = entity:GetParent()
		if !IsValid(parent) then timer.Remove("ChangeSkinStateCigarette_"..entity:EntIndex()) return end
        if parent.Alive and !parent:Alive() then timer.Remove("ChangeSkinStateCigarette_"..entity:EntIndex()) return end

		if !entity.state then entity.state = 1 end
		if (entity.state or 0) != 2 then
			timer.Adjust("ChangeSkinStateCigarette_"..entity:EntIndex(), 2, 0, nil)
		else
			timer.Adjust("ChangeSkinStateCigarette_"..entity:EntIndex(), math.random(3, 7), 0, nil)
		end

		entity.state = ((entity.state or 0) > 1 and 1 or 2)

		entity:SetSkin(entity.state)
		if entity.cigaretteItem and entity.cigaretteItem.GetID and ix.item.instances[entity.cigaretteItem:GetID()] then
            local length = entity:GetFlexWeight(entity.flexIndexLength)
            entity.cigaretteItem:SetData("length", length)
		end
	end)
end

function PLUGIN:CreateJetLengthTimer(entity)
	if timer.Exists("ChangeJetLengthCigarette_"..entity:EntIndex()) then timer.Remove("ChangeJetLengthCigarette_"..entity:EntIndex()) end

	timer.Create("ChangeJetLengthCigarette_"..entity:EntIndex(), 0.2, 0, function()
		if !IsValid(entity) then timer.Remove("ChangeJetLengthCigarette_"..entity:EntIndex()) return end

		local parent = entity:GetParent()
		if !IsValid(parent) then timer.Remove("ChangeJetLengthCigarette_"..entity:EntIndex()) return end
        if parent.Alive and !parent:Alive() then timer.Remove("ChangeJetLengthCigarette_"..entity:EntIndex()) return end

		if IsValid(entity.smoke) and parent:GetMoveType() == 8 then entity.smoke:Remove() return end
		if IsValid(entity) and (!IsValid(entity.smoke) or (IsValid(entity.smoke) and !entity.smoke:GetInternalVariable("JetLength"))) then
			if parent.cigarette and parent.cigarette.isLit then self:CreateCigaretteSmoke(entity) return end
		end

		if IsValid(entity.smoke) then
			if parent:GetVelocity():Length2D() > parent:GetWalkSpeed() then
				if math.Round(tonumber(entity.smoke:GetInternalVariable("JetLength")), 1) != 0.2 then entity.smoke:SetKeyValue("JetLength", "0.2") end
			else
				if tonumber(entity.smoke:GetInternalVariable("JetLength")) != 10 then entity.smoke:SetKeyValue("JetLength", "10") end
			end
		end

		if entity.cigaretteItem and entity.cigaretteItem.GetID and ix.item.instances[entity.cigaretteItem:GetID()] then
			if !parent then return end
			if !entity.cigaretteItem:CheckIfModelAllowed(parent) then entity.cigaretteItem:OnRunStopSmoke(parent) end
		end
	end)

end

function PLUGIN:ChangeSmokePos(entity, parent, fixedPos)
	if (IsValid(entity) and IsEntity(entity) and entity) then
        if (entity.smoke and IsEntity(entity.smoke) and parent and IsValid(parent)) then
            if parent:GetMoveType() != 8 then
                if fixedPos then
                    fixedPos = (fixedPos * 0.001) * 10
                    entity.smoke:SetPos(entity.smoke:GetPos() + Vector(-fixedPos * parent:GetForward(), 0, 0))
					return
				end

                entity.smoke:SetPos(entity.smoke:GetPos() + Vector(-0.001 * parent:GetForward(), 0, 0))
            end
        end
	end
end

function PLUGIN:CigaretteThink(entity)
	local currentWeightLength = entity:GetFlexWeight( entity.flexIndexLength )
    local parent = entity:GetParent()

	if !parent.cigarette then return end
	if !parent.cigarette.isLit then return end

	if currentWeightLength >= entity.maxValueLength then
		if (SERVER) then
            if IsValid(entity) and IsEntity(entity) then
                if entity.cigaretteItem and entity.cigaretteItem.SmokingFinished then
                    entity.cigaretteItem:SmokingFinished(entity:GetParent(), 1)
                end
            end
		end

		return
	end

	if CurTime() < entity.smokeDelay then return end
	if parent and parent:GetMoveType() == 8 then return end
    if parent and !parent:Alive() or !parent then
        if (SERVER) then
            if IsValid(entity) and IsEntity(entity) then
                entity:Remove()
            end
        end

        return
    end

    self:ChangeSmokePos(entity, parent)

	-- Length
	entity:SetFlexWeight( entity.flexIndexLength, entity:GetLengthValue(currentWeightLength) )

	-- Ashes
	entity:SetFlexWeight( entity.flexIndexAshes, entity:GetAshesValue() )

	entity.smokeDelay = CurTime() + 3

	entity:NextThink( CurTime() ) -- Set the next think to run as soon as possible, i.e. the next frame.
	return true -- Apply NextThink call
end

-- Cigarette gets smaller over time and ashes effect
function PLUGIN:GetAshesValue(entity)
	local currentWeightAshes = entity:GetFlexWeight( entity.flexIndexAshes )

	if currentWeightAshes < 0.5 or currentWeightAshes < 0.1 then
		return math.Clamp( currentWeightAshes + entity.addValueAshes, entity.minValueAshes, entity.maxValueAshes)
	else
		return 0.1
	end
end

function PLUGIN:GetLengthValue(entity, currentLength)
	return math.Clamp( currentLength + entity.addValueLength, entity.minValueLength, entity.maxValueLength )
end

function PLUGIN:PlayerDisconnected(client)
	if (client.cigarette) then
		local cigaretteItem = client.cigarette.cigaretteItem
		if cigaretteItem then
			cigaretteItem:OnRunStopSmoke()
		end
	end
end

function PLUGIN:CanPlayerUseCharacter(client, character)
	if (client.cigarette and IsValid(client.cigarette)) then
		return false, "You currently have a cigarette in your mouth, you cannot switch characters whilst having so!"
	end
end

function PLUGIN:PlayerDeath(client)
	if (client.cigarette) then
		local cigaretteItem = client.cigarette.cigaretteItem

		if (cigaretteItem) then
			cigaretteItem:OnRunStopSmoke()

			if (cigaretteItem.cigaretteEnt) then cigaretteItem.cigaretteEnt:Remove() end
			if (client.cigarette) then client.cigarette = nil end
		end
	end
end