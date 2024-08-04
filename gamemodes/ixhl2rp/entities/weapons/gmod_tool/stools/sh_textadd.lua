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
TOOL.Name = "Text Add"
TOOL.RequiresTraceHit = true

TOOL.ClientConVar[ "text" ] = ""
TOOL.ClientConVar[ "scale" ] = 1

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
	{ name = "reload" }
}

function TOOL:LeftClick( trace )
	if (SERVER) then
		if !CAMI.PlayerHasAccess(self:GetOwner(), "Helix - Basic Admin Commands") then return false end
		
		local position = trace.HitPos
		local angles = trace.HitNormal:Angle()
		angles:RotateAroundAxis(angles:Up(), 90)
		angles:RotateAroundAxis(angles:Forward(), 90)

		if !ix.plugin.list then return end
		if !ix.plugin.list["3dtext"] then return end
		if !ix.plugin.list["3dtext"].AddText then return end

		local text = self:GetClientInfo( "text", "" )
		local scale = self:GetClientNumber( "scale", 0 )

		local index = ix.plugin.list["3dtext"]:AddText(position + angles:Up() * 0.1, angles, text, scale)

		undo.Create("ix3dText")
			undo.SetPlayer(self:GetOwner())
			undo.AddFunction(function()
				if (ix.plugin.list["3dtext"]:RemoveTextByID(index)) then
					ix.log.Add(self:GetOwner(), "undo3dText")
				end
			end)
		undo.Finish()

		return "@textAdded"
	end
end

function TOOL:RightClick( trace )
	if !ix.plugin.list then return end
	if !ix.plugin.list["3dtext"] then return end
	if !ix.plugin.list["3dtext"].RemoveText then return end

	local position = trace.HitPos + trace.HitNormal * 2
	local amount = ix.plugin.list["3dtext"]:RemoveText(position, false)

	return "@textRemoved", amount
end

function TOOL.BuildCPanel( CPanel )
	CPanel:AddControl( "Header", { Description = "Enter Text!" } )
	CPanel:AddControl( "textbox", { Label = "Text", Command = "sh_textadd_text", Help = false } )
	CPanel:AddControl( "Slider", { Label = "Scale", Command = "sh_textadd_scale", Type = "Float", Min = 0.001, Max = 5, Help = false } )
end

if CLIENT then
	language.Add( "Tool.sh_textadd.name", "Text Add" )
	language.Add( "Tool.sh_textadd.desc", "Same as /textadd" )
	language.Add( "Tool.sh_textadd.left", "Primary: Add Text" )
	language.Add( "Tool.sh_textadd.right", "Right Click: Remove Text." )
	language.Add( "Tool.sh_textadd.reload", "Nothing." )
end