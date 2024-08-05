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

ix.crystals = ix.crystals or {}

--[[

The POWAAAH
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣠⡶⠀⣸⣇⠀⢶⣄⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢀⣠⣾⣿⠃⢠⣿⣿⡄⠘⣿⣷⣄⡀⠀⠀⠀
⠀⢀⣴⣿⣿⣿⡿⠀⣼⣿⣿⣧⠀⢿⣿⣿⣿⣦⡀⠀
⠠⣈⠙⠻⢿⣿⠃⢰⣿⣿⣿⣿⡆⠘⣿⡿⠟⠋⣁⠄
⠀⣿⣿⣶⣤⡀⠀⠉⠉⠉⠉⠉⠉⠀⢀⣤⣶⣿⣿⠀
⠀⢹⣿⣿⣿⣧⠀⣿⣿⣿⣿⣿⣿⠀⣼⣿⣿⣿⡏⠀
⠀⢸⣿⣿⣿⣿⠀⣿⣿⣿⣿⣿⣿⠀⣿⣿⣿⣿⡇⠀
⠀⠈⣿⣿⣿⣿⠀⣿⣿⣿⣿⣿⣿⠀⣿⣿⣿⣿⠁⠀
⠀⠀⢻⣿⣿⣿⠀⣿⣿⣿⣿⣿⣿⠀⣿⣿⣿⡟⠀⠀
⠀⠀⢸⣿⣿⣿⠀⣿⣿⣿⣿⣿⣿⠀⣿⣿⣿⡇⠀⠀
⠀⠀⠘⣿⣿⣿⠀⣿⣿⣿⣿⣿⣿⠀⣿⣿⣿⠃⠀⠀
⠀⠀⠀⢻⣿⣿⠀⢹⣿⣿⣿⣿⡏⠀⣿⣿⡟⠀⠀⠀
⠀⠀⠀⠀⠙⢿⠀⢸⣿⣿⣿⣿⡇⠀⡿⠋⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀
]]--

hook.Add("EntityRemoved", "StopCrystalSound", function(ent)
	if (ent.isCrystal) then
		ent:StopSound(ent.loopSound)
	end
end)

function ix.crystals:OnTakeDamage(ent, damageInfo) 
    local player = damageInfo:GetAttacker()

    if IsValid(player) and player:IsPlayer() then
        ent:TriggerReaction(damageInfo) 

        if player:GetActiveWeapon():GetClass() == "tfa_nmrih_pickaxe" then
            
         
            if !ent.oreLeft then
                ent.oreLeft = math.random(4, 6);
            end
            
            if !ent.strikesRequired then
                ent.strikesRequired = math.random(2, 3);
            end
            
            ent.strikesRequired = ent.strikesRequired - 1;
            
            
            if ent.strikesRequired <= 0 then
                local entPos = ent:GetPos();
                local character = player:GetCharacter()
                local inventory = character:GetInventory()
                local pickaxe = inventory:HasItem("pickaxe") 

                if (pickaxe and pickaxe:GetData("equip")) then
                    pickaxe:DamageDurability(1)
                end 

                if (!character:GetInventory():Add(istable(ent.LootCrystal) and table.Random(ent.LootCrystal) or ent.LootCrystal)) then
                    ix.item.Spawn(ent.LootCrystal and table.Random(ent.LootCrystal) or ent.LootCrystal, player) 
                end
                
                player:Notify("You harvest some shards from the crystal.")
                ent:EmitSound(table.Random({"vj_hlr/fx/glass1.wav","vj_hlr/fx/glass2.wav","vj_hlr/fx/glass3"}));

                ent.oreLeft = ent.oreLeft - 1;
                ent.strikesRequired = math.random(4, 6);
            end
            
            if ent.oreLeft <= 0 then
                ent:EmitSound(table.Random({"vj_hlr/fx/glass1.wav","vj_hlr/fx/glass2.wav","vj_hlr/fx/glass3"}));
                ent:OnDestroyed() 
            end
        end
    end
end 

function ix.crystals:OnUse(ent, activator, caller)
end 

function ix.crystals:OnRemove(ent, activator, caller)
end 

function ix.crystals:StartEffect(ent)
    if ent.loopEffect then 
        ParticleEffect(ent.loopEffect, ent:GetPos(), Angle(0, 0, 0), ent)
    end 

    local entityID = ent:EntIndex()  
    timer.Create("EffectTimer_" .. entityID, 1, 0, function()
        if not IsValid(ent) then
            timer.Remove("EffectTimer_" .. entityID)
            return
        end


    end)
end

function ix.crystals:StopEffect(ent)
    local entityID = ent:EntIndex()
    if timer.Exists("EffectTimer_" .. entityID) then
        timer.Remove("EffectTimer_" .. entityID)
    end
end

function ix.crystals:OnInitialize(ent)
    ix.crystals:StartEffect(ent)
    ent:OnInitialize() 
end

