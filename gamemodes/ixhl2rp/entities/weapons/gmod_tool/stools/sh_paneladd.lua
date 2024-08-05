--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


TOOL.Category = "HL2RP Staff QoL"
TOOL.Name = "Panel Add"
TOOL.RequiresTraceHit = true

TOOL.ClientConVar[ "url" ] = ""
TOOL.ClientConVar[ "scale" ] = 1
TOOL.ClientConVar[ "brightness" ] = 100

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
	{ name = "reload" }
}

function TOOL:LeftClick( trace )
	if (SERVER) then
		if !CAMI.PlayerHasAccess(self:GetOwner(), "Helix - Manage Panels") then return false end
		
		local position = trace.HitPos
		local angles = trace.HitNormal:Angle()
		angles:RotateAroundAxis(angles:Up(), 90)
		angles:RotateAroundAxis(angles:Forward(), 90)

		if !ix.plugin.list then return end
		if !ix.plugin.list["3dpanel"] then return end
		if !ix.plugin.list["3dpanel"].AddPanel then return end

		local url = self:GetClientInfo( "url", "" )
		local scale = self:GetClientNumber( "scale", 0 )
		local brightness = self:GetClientNumber( "brightness", 0 )

		ix.plugin.list["3dpanel"]:AddPanel(position + angles:Up() * 0.1, angles, url, scale, brightness)

		return "@panelAdded"
	end
end

function TOOL:RightClick( trace )
	if !ix.plugin.list then return end
	if !ix.plugin.list["3dpanel"] then return end
	if !ix.plugin.list["3dpanel"].RemovePanel then return end

	local position = trace.HitPos
	-- Remove the panel(s) and get the amount removed.
	local amount = ix.plugin.list["3dpanel"]:RemovePanel(position, false)

	return "@panelRemoved", amount
end

function TOOL.BuildCPanel( CPanel )
	CPanel:AddControl( "Header", { Description = "Enter URL!" } )
	CPanel:AddControl( "textbox", { Label = "URL", Command = "sh_paneladd_url", Help = false } )
	CPanel:AddControl( "Slider", { Label = "Scale", Command = "sh_paneladd_scale", Type = "Float", Min = 0.001, Max = 5, Help = false } )
	CPanel:AddControl( "Slider", { Label = "Brightness", Command = "sh_paneladd_brightness", Type = "Float", Min = 0, Max = 255, Help = false } )
end

if CLIENT then
	language.Add( "Tool.sh_paneladd.name", "Panel Add" )
	language.Add( "Tool.sh_paneladd.desc", "Same as /paneladd" )
	language.Add( "Tool.sh_paneladd.left", "Primary: Add Panel" )
	language.Add( "Tool.sh_paneladd.right", "Right Click: Remove Panel" )
	language.Add( "Tool.sh_paneladd.reload", "Nothing." )
end
