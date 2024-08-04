--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

eProtect = eProtect or {}
eProtect.overrides = eProtect.overrides or {}

if vgui and !eProtect.overrides["vguiCreate"] then
    local oldFunc = vgui.Create

    vgui.Create = function(...)
        local pnl = oldFunc(...)

        hook.Run("eP:PostInitPanel", pnl)

        return pnl
    end

    eProtect.overrides["vguiCreate"] = true
end

if MsgC and !eProtect.overrides["MsgC"] then
    local oldFunc = MsgC

    MsgC = function(...)
        local pnl = oldFunc(...)

        hook.Run("eP:MsgCExecuted", {...})

        return pnl
    end

    eProtect.overrides["MsgC"] = true
end