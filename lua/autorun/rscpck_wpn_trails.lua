--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

WeaponTrail = WeaponTrail or {}
if SERVER then
    AddCSLuaFile("effect/trail.lua")
	AddCSLuaFile("effect/trail.Bone_Set.lua")
    util.AddNetworkString("weapontrail.PlayEffect" )
    util.AddNetworkString("weapontrail.StopEffect" )
elseif CLIENT then
    include("effect/trail.lua")
	include("effect/trail.Bone_Set.lua")
    WeaponTrail.EffectList = WeaponTrail.EffectList or {}


    hook.Add( "PostDrawOpaqueRenderables", "WeaponTrail.Effect", function()
        local EffectList = WeaponTrail.EffectList
        local ply = LocalPlayer()
        for v, k in pairs(EffectList) do
            if k.Owner:IsValid() then
                if k.Draw then
                    k:Draw()
                    if k.Draw == false then
                    table.remove(WeaponTrail.EffectList, v)
                        if k.EndEffect then
                            k:EndEffect(ply)
                        end
                    end

                end
                if k.DieTime - CurTime() <= 0 then

                    table.remove(WeaponTrail.EffectList, v)
                    if k.EndEffect then
                        k:EndEffect(ply)
                    end
                end
            else
                table.remove(WeaponTrail.EffectList, v)
            end
        end

    end)
    hook.Add("Think", "WeaponTrail.EffectThink", function()
    end)
end

local meta = FindMetaTable("Entity")

function meta:SetWeaponTrail(mat, _time, size, flag)
    local data = {}
    data.Mat = mat
    data.Owner = self
    data.Time = _time
    data.Size = size
    data.Flag = flag

    net.Start("weapontrail.PlayEffect")
        net.WriteTable(data)
    net.Broadcast()
end
function meta:StopWeaponTrail()
    local data = {}
    data.Owner = self
    net.Start("weapontrail.StopEffect")
        net.WriteTable(data)
    net.Broadcast()
end
net.Receive("weapontrail.PlayEffect", function(len)
    local Data = net.ReadTable()
    local effect = WeaponTrail.Eff
    if effect then
        effect.Owner = Data.Owner
        effect.Mat = Data.Mat
        effect.CustomTime = Data.Time
        effect.Size = Data.Size
        effect.Flag = Data.Flag
        effect.DieTime = Data.Time + CurTime()
        if Data.Owner:IsValid() then
            effect:InitEffect()
        end
        if Data.Time != -1 then
            WeaponTrail.EffectList[#WeaponTrail.EffectList+1] = table.Copy( effect )
        end
    end
end)
net.Receive("weapontrail.StopEffect", function(len)
    local Data = net.ReadTable()
    local EffectList = WeaponTrail.EffectList
    for v, k in pairs(EffectList) do
        if !Data.Other or Data.Other == false then
            if k.Owner == Data.Owner then
                table.remove(WeaponTrail.EffectList, v)
            end
        elseif Data.Other == true then
            k.EndTime = 0
        end
    end
end)
