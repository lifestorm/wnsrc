--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Does what compat.lua used to without being so aggressive about compatability.
-- If another addon wants to break things, IT CAN!
AddCSLuaFile()

-- This will let us use the noclip key to exit morphs,
-- while letting other mods that disable noclip do their thing.
if CLIENT then
    local noclip_btns = {}

    for i = KEY_FIRST, BUTTON_CODE_LAST do
        if input.LookupKeyBinding(i) == "noclip" then
            table.insert(noclip_btns, i)
        end
    end

    hook.Add("CreateMove", "momo_exit_check", function()
        if vgui.GetKeyboardFocus() == nil and not gui.IsGameUIVisible() then
            for _, key in pairs(noclip_btns) do
                if input.WasKeyPressed(key) then
                    timer.Simple(0, function()
                        RunConsoleCommand("pk_pill_restore")
                    end)

                    break
                end
            end
        end
    end)
end

-- Still dont let people noclip while morphed
hook.Add("PlayerNoClip", "momo_block_noclip", function(ply)
    if IsValid(pk_pills.getMappedEnt(ply)) then return false end
end)

-- Them hooks
hook.Add("CalcView", "momo_calcview", function(ply, pos, ang, fov, nearZ, farZ)
    local ent = pk_pills.getMappedEnt(LocalPlayer())

    if IsValid(ent) and ply:GetViewEntity() == ply then
        local startpos

        if ent.formTable.type == "phys" then
            startpos = ent:LocalToWorld(ent.formTable.camera and ent.formTable.camera.offset or Vector(0, 0, 0))
        else
            startpos = pos
        end

        if pk_pills.convars.cl_thirdperson:GetBool() then
            local dist

            if ent.formTable.type == "phys" and ent.formTable.camera and ent.formTable.camera.distFromSize then
                dist = ent:BoundingRadius() * 5
            else
                dist = ent.formTable.camera and ent.formTable.camera.dist or 100
            end

            local underslung = ent.formTable.camera and ent.formTable.camera.underslung
            local offset = LocalToWorld(Vector(-dist, 0, underslung and -dist / 5 or dist / 5), Angle(0, 0, 0), Vector(0, 0, 0), ang)

            local tr = util.TraceHull({
                start = startpos,
                endpos = startpos + offset,
                filter = ent.camTraceFilter,
                mins = Vector(-5, -5, -5),
                maxs = Vector(5, 5, 5),
                mask = MASK_VISIBLE
            })

            local view = {}
            view.origin = tr.HitPos
            view.angles = ang
            view.fov = fov
            view.drawviewer = true
            --[[else
            local view = {}
            view.origin = startpos
            view.angles = ang
            view.fov = fov
            return view]]

            return view
        end
    end
end)
--[[
hook.Add("CalcViewModelView","momo_calcviewmodel",function(wep,vm,oldPos,oldAng,pos,ang)
    local ent = pk_pills.getMappedEnt(LocalPlayer())
    local ply = wep.Owner
    if (IsValid(ent) and ply:GetViewEntity()==ply and pk_pills.convars.cl_thirdperson:GetBool()) then
        return oldPos+oldAng:Forward()*-1000,ang
    end
end)]]
