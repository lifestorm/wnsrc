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

if SERVER then 
    util.AddNetworkString("ixTeslaDamage")

    net.Receive("ixTeslaDamage", function(len, ply)
        if not ply:IsAdmin() then
            return
        end

        local pos = net.ReadVector()
        local radius = net.ReadFloat()
        local damage = net.ReadFloat()
        local attacker = net.ReadEntity()

        if not IsValid(attacker) then
            attacker = game.GetWorld()
        end

        local entities = ents.FindInSphere(pos, radius)
        for _, ent in ipairs(entities) do
            if IsValid(ent) then
                if (ent:GetClass() == "ix_item" or ent:IsRagdoll()) and not ent:IsPlayer() then
                    ent:Dissolve(1, 2)
                    ent:EmitSound("ambient/energy/zap1.wav")
                end

                if ent:IsPlayer() or ent:IsNPC() then
                    if ent:IsPlayer() then
                       
                        if ent and ent:HasPPE() then
                            return
                        end
                    
                        if character and character:IsCombine() and ix.config.Get("disableSuits", false) then
                            local suit = ent:GetActiveCombineSuit()
                            if suit then
                                suit:SetData("suitActive", false)
                            end
                        end
                    
                        if character then
                            local inventory = character:GetInventory()
                            if inventory then
                                local radio = inventory:HasItem("handheld_radio") or inventory:HasItem("old_radio")
                                if radio then
                                    radio:Remove()
                                    
                                    if not inventory:Add("broken_radio") then
                                        ix.item.Spawn("broken_radio", ent:GetPos())
                                    end
                                end
                            end
                        end
                    
                        ent:ScreenFade(SCREENFADE.IN, Color(173, 216, 230, 128), 0.2, 0)
                    end
                    
                    
                    local damageInfo = DamageInfo()
                    damageInfo:SetDamage(damage)
                    damageInfo:SetDamageType(DMG_SHOCK)
                    damageInfo:SetAttacker(attacker)
                    damageInfo:SetInflictor(attacker)
                    ent:TakeDamageInfo(damageInfo)
            
                    local effectPos = ent:GetPos() + VectorRand() * 10
                    local tesla = ents.Create("point_tesla")
                    if not IsValid(tesla) then return end
                
                    tesla:SetPos(effectPos)
                    tesla:SetKeyValue("m_SoundName", "ambient/energy/zap1.wav")
                    tesla:SetKeyValue("texture", "sprites/laserbeam.spr")
                    tesla:SetKeyValue("m_Color", "104 160 176")
                    tesla:SetKeyValue("m_flRadius", "300")
                    tesla:SetKeyValue("beamcount_min", "5")
                    tesla:SetKeyValue("beamcount_max", "8")
                    tesla:SetKeyValue("thick_min", "2")
                    tesla:SetKeyValue("thick_max", "4")
                    tesla:SetKeyValue("lifetime_min", "0.1")
                    tesla:SetKeyValue("lifetime_max", "0.2")
                    tesla:SetKeyValue("interval_min", "0.05")
                    tesla:SetKeyValue("interval_max", "0.1")
                    tesla:Spawn()
                    tesla:Activate()
                
                    tesla:Fire("DoSpark", "", 0)

                    timer.Simple(0.2, function()
                        if IsValid(tesla) then
                            tesla:Remove()
                        end
                    end)
                end
            end
        end
    end)
end
