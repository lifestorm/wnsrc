--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

function JBUmatTranspose3x3(matrix)
    local tb = matrix:ToTable()
    local tb1 = {
        {tb[1][1], tb[2][1], tb[3][1], 0},
        {tb[1][2], tb[2][2], tb[3][2], 0},
        {tb[1][3], tb[2][3], tb[3][3], 0},
        {0, 0, 0, 0},
    }

    return Matrix(tb1)
end

function JBUApproachVector(v1, v2, delta)
    local x = math.Approach(v1.x, v2.x, delta)
    local y = math.Approach(v1.y, v2.y, delta)
    local z = math.Approach(v1.z, v2.z, delta)

    return Vector(x,y,z)
end

function JBUFindTheEntInConstraints(_ent, _constraintname, _classname)
    local tbl = {}
    if(istable(_classname)) then
        tbl = _classname
    else
        tbl[_classname] = true
    end

    local _const = constraint.FindConstraints(_ent, _constraintname)
    for k, v in pairs(_const) do
        local ent = NULL

        if(tbl[v.Ent1:GetClass()]) then
            ent = v.Ent1
        elseif(tbl[v.Ent1:GetClass()]) then
            ent = v.Ent2
        end

        if(IsValid(ent)) then return ent end
    end
end

if(SERVER) then
    __BakuVehicleTableAR3 = __BakuVehicleTableAR3 or {}
    __BakuManTableAR3 = __BakuManTableAR3 or {}

    __BakuRegisteredMannableClasses = __BakuRegisteredMannableClasses or {}

    hook.Add("PlayerEnteredVehicle", "MannableTurretsBaku", function(ply, veh, role)
        local mannedgun = __BakuManTableAR3[ply:EntIndex()]
        if(IsValid(mannedgun)) then
            mannedgun:AR3Deactivate()
        end

        local gun = __BakuVehicleTableAR3[veh:EntIndex()] or JBUFindTheEntInConstraints(veh, "Weld", __BakuRegisteredMannableClasses)

        if(!IsValid(gun)) then __BakuVehicleTableAR3[veh:EntIndex()] = nil return end

        gun._DriveMode = true
        gun._Vehicle = veh

        __BakuVehicleTableAR3[veh:EntIndex()] = gun

        gun._User = ply
        
        gun:AR3Activate()
    end)

    hook.Add("PlayerLeaveVehicle", "MannableTurretsBaku", function(ply, veh)
        local gun = __BakuVehicleTableAR3[veh:EntIndex()] or JBUFindTheEntInConstraints(veh, "Weld", __BakuRegisteredMannableClasses)

        if(!IsValid(gun)) then return end

        gun:AR3Deactivate()
    end)
end