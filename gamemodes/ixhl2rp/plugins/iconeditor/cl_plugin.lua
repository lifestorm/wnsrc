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

concommand.Add('ix_icon_editor', function()
    if IsValid(ix.gui.iconEditor) then
        ix.gui.iconEditor:Remove()
    end

    ix.gui.iconEditor = vgui.Create('ixIconEditor')
end)
