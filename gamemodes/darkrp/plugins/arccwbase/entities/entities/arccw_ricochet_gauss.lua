--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()

-- Ugly way to get around some engine limitations
ENT.PrintName = "Ricochet"
ENT.Spawnable = false
ENT.Type = "anim"


if CLIENT then
    function ENT:Draw()

    end
    return
end

function ENT:Initialize()
    self:SetModel("models/Combine_Helicopter/helicopter_bomb01.mdl")
    self:DrawShadow(false)
    self:SetNoDraw(true)
end

function ENT:Think()
    if self.FireTime < CurTime() then
        local ricsleft = self.RicsLeft or 40
        self:FireBullets({
            Attacker = self.Owner,
            Damage = self.Damage,
            Force = 0,
            Distance = 5000,
            Num = 1,
            Tracer = 1,
            TracerName = "ToolTracer",
            Dir = self.Direction,
            Spread = Vector(0.025,0.025,0),
            Src = self:GetPos(),
            --IgnoreEntity = self.Owner,
            Callback = function(attacker, tr, dmginfo)
                if IsValid(self.Inflictor) then dmginfo:SetInflictor(self.Inflictor) end
                if ricsleft > 0 and self.Damage > 1 then
                    local dir = tr.Normal - 2 * (tr.Normal:Dot(tr.HitNormal)) * tr.HitNormal
                    for _, ent in pairs(ents.FindInCone(tr.HitPos, dir, 2000, math.cos(math.pi * 0.25))) do
                        if ((ent:IsPlayer() and ent ~= self.Owner) or ent:IsNPC() or ent:IsNextBot())
                                and util.QuickTrace(tr.HitPos, ent:WorldSpaceCenter() - tr.HitPos).Entity == ent then
                            dir = (ent:WorldSpaceCenter() - tr.HitPos):GetNormalized()
                            break
                        end
                    end
                    local r = ents.Create("arccw_ricochet_gauss")
                    r.FireTime = CurTime()
                    r.Owner = self.Owner
                    r.Damage = math.ceil(self.Damage * (tr.HitNonWorld and 0.9 or 0.99))
                    r.Direction = dir
                    r.Inflictor = self.Inflictor
                    r.RicsLeft = ricsleft - 1
                    r:SetPos(tr.HitPos)
                    r:Spawn()
                end
            end
        })
        self:EmitSound("weapons/fx/rics/ric" .. math.random(1,5) .. ".wav", 70, 100)
        self:Remove()
    end
end