--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local table = table
local ents = ents
local timer = timer
local IsValid = IsValid
local hook = hook
local ix = ix
local EffectData = EffectData
local util = util
local math = math
local VectorRand = VectorRand

local PLUGIN = PLUGIN

function PLUGIN:OnNPCKilled(entity, attacker, inflictor)
  local drop = self.npcs[entity:GetClass()]

  if (drop and !table.IsEmpty(drop)) then
    local corpse = ents.Create("prop_ragdoll")
    corpse:SetModel(entity:GetModel())
    corpse:PrecacheGibs()
    corpse:SetSkin(entity:GetSkin())
    --corpse:SetBodyGroups(entity:GetBodyGroups()) This is all kinds of wrong. No clue why facepunch made it like this. GetBodyGroups gives a table, SetBodyGroups wants a string
    corpse:SetPos(entity:GetPos())
    corpse:SetAngles(entity:GetAngles())
    corpse:SetNetVar("drop", table.Copy(drop))

    corpse:SetColor(entity:GetColor())

    entity:Remove()

    corpse:Spawn()
    corpse:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)

    timer.Simple(180, function()
      if (IsValid(corpse)) then
        corpse:Remove()
      end
    end)
  end
end

local tools = {
  ["tfa_nmrih_kknife"] = true,
  ["tfa_nmrih_cleaver"] = true,
  ["tfa_nmrih_machete"] = true,
  ["tfa_nmrih_fireaxe"] = true,
  ["tfa_nmrih_hatchet"] = true
}

function PLUGIN:EntityTakeDamage(entity, damageInfo)
  local drop = entity:GetNetVar("drop")

  if (drop) then
    local attacker = damageInfo:GetAttacker()
    local noTool = hook.Run("CanButcherWithoutTool", attacker, entity, drop)

    if (noTool or IsValid(attacker) and attacker:IsPlayer()) then
      local weapon = attacker:GetActiveWeapon()

      if (noTool or IsValid(weapon) and tools[weapon:GetClass()]) then
        local inventory = attacker:GetCharacter():GetInventory()
        local amount, uniqueID = table.Random(drop)
        local itemTable = ix.item.Get(uniqueID)

        if (itemTable) then
          if (!inventory:Add(uniqueID, 1)) then
            attacker:NotifyLocalized("You do not have enough space in your inventory, "..itemTable:GetName().." was dropped.")
            ix.item.Spawn(uniqueID, damageInfo:GetDamagePosition())
          else
            attacker:NotifyLocalized("You butchered "..itemTable:GetName())
          end

          drop[uniqueID] = amount > 1 and amount - 1 or nil
        end

        local pos = entity:GetPos()
        local effect = EffectData()
          effect:SetStart(pos)
          effect:SetOrigin(pos)
          effect:SetScale(6)
          effect:SetFlags(3)
          effect:SetColor(0)
        util.Effect("bloodspray", effect)

        if (table.IsEmpty(drop)) then
          entity:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav")
          entity:GibBreakClient(VectorRand())
          entity:Remove()
        else
          entity:EmitSound("physics/flesh/flesh_squishy_impact_hard"..math.random(1, 4)..".wav")
          entity:SetNetVar("drop", drop)
        end
      end
    end
  end
end
