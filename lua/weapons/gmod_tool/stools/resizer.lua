--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


TOOL.Category		= "Poser"
TOOL.Name			= "#Resizer"
TOOL.Command		= nil
TOOL.ConfigName		= ""

if (CLIENT) then

language.Add("Tool.resizer.name","Resizer")
language.Add("Tool.resizer.desc","Resizes props/ragdolls/NPCs")
language.Add("Tool.resizer.0","Click on an object to resize it. Right click to reset.")

CreateClientConVar( "resizer_xsize", "2", false, true )
CreateClientConVar( "resizer_ysize", "2", false, true )
CreateClientConVar( "resizer_zsize", "2", false, true )
CreateClientConVar( "resizer_xyzsize", "2", false, false )
CreateClientConVar( "resizer_allbones", "0", false, true )

local function _resizer_xyzcallback(cvar, prevValue, newValue)
	RunConsoleCommand("resizer_xsize", newValue);
	RunConsoleCommand("resizer_ysize", newValue);
	RunConsoleCommand("resizer_zsize", newValue);
end
cvars.AddChangeCallback("resizer_xyzsize", _resizer_xyzcallback)

end --[[ if (CLIENT) then ]]--

local _resizer_double_fix = false

function TOOL:RightClick( trace )
	if (trace.HitNonWorld && trace.Entity != nil && trace.Entity != 0) then
		if (SERVER) then
		
			//props | ragdolls | npcs
			if (trace.Entity:GetClass() == "prop_physics" || trace.Entity:GetClass() == "prop_ragdoll" || trace.Entity:IsNPC()) then
				for i=0, trace.Entity:GetBoneCount() do
					trace.Entity:ManipulateBoneScale( i, Vector(1, 1, 1) )
				end
			end
		
		end
		return true
	end
	return false
end

function TOOL:LeftClick( trace )
	if (trace.HitNonWorld && trace.Entity != nil && trace.Entity != 0) then
		if (SERVER) then
			local scale = Vector( tonumber( self:GetOwner():GetInfo("resizer_xsize")),
								  tonumber( self:GetOwner():GetInfo("resizer_ysize")),
								  tonumber( self:GetOwner():GetInfo("resizer_zsize")) )
		
			//props
			if (trace.Entity:GetClass() == "prop_physics") then
				for i=0, trace.Entity:GetBoneCount() do
					trace.Entity:ManipulateBoneScale( i, scale )
				end
			end
			
			//ragdolls and npcs
			if (trace.Entity:GetClass() == "prop_ragdoll" || trace.Entity:IsNPC()) then
				if ( tonumber(self:GetOwner():GetInfo("resizer_allbones")) > 0 ) then
					for i=0, trace.Entity:GetBoneCount() do
						trace.Entity:ManipulateBoneScale( i, scale )
					end
				else
					local Bone = trace.Entity:TranslatePhysBoneToBone( trace.PhysicsBone )
					trace.Entity:ManipulateBoneScale( Bone, scale )
				end
			end
			
		end
		return true
	end
	return false
end

function TOOL.BuildCPanel( CPanel )

	CPanel:AddControl( "Header", { Text = "Resizer", Description	= "Does not resize the hitbox or shadow." }  )

	CPanel:AddControl( "ComboBox", { 

			Label = "#tool.presets",
			MenuButton = 1,
			Folder = "resizer",
			Options =	{ Default = {	resizer_xsize = '1',		resizer_ysize='1',		resizer_zsize='1',		resizer_xyzsize='1'} },
			CVars =		{				"resizer_xsize",			"resizer_ysize",			"resizer_zsize", 		"resizer_xyzsize"} 
			})
			
	CPanel:AddControl( "Slider", 		{ Label = "X size",		Type = "Float", 	Command = "resizer_xsize", 		Min = "0.01", 	Max = "10" }  )	
	CPanel:AddControl( "Slider", 		{ Label = "Y size",		Type = "Float", 	Command = "resizer_ysize", 		Min = "0.01", 	Max = "10" }  )		
	CPanel:AddControl( "Slider", 		{ Label = "Z size",		Type = "Float", 	Command = "resizer_zsize", 		Min = "0.01", 	Max = "10" }  )	
	CPanel:AddControl( "Slider", 		{ Label = "XYZ",		Type = "Float", 	Command = "resizer_xyzsize", 		Min = "0.01", 	Max = "10" }  )		

	CPanel:AddControl( "Checkbox", { Label = "Resize all bones of ragdolls/NPCs at once", Command = "resizer_allbones" } )	
end