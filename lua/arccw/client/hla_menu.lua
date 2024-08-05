--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Now I stole yo shit

hook.Add( "PopulateToolMenu", "ArcCW_HLA_Options", function()
    spawnmenu.AddToolMenuOption( "Options", "ArcCW", "ArcCW_HLA_Options", "HL:A", "", "", ArcCW_HLA_Options)
end )

function ArcCW_HLA_Options( CPanel )

    CPanel:AddControl("Header", {Description = "Balancing options"})
    
    CPanel:AddControl("Checkbox", {Label = "Buffs the AR1", Command = "ordinal_buff" })

    CPanel:AddControl("Label", {Text = "This option require a restart to take effect."})

end