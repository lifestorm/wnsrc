--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

TOOL.Category = "Jakub Baku Mannables"
TOOL.Name = "#tool.mannable_changemodel.name"

TOOL.ClientConVar[ "model" ] = "models/airboatgun.mdl"
TOOL.ClientConVar[ "hidegun" ] = 0
TOOL.ClientConVar[ "bone" ] = 0

TOOL.ClientConVar[ "posx" ] = 0
TOOL.ClientConVar[ "posy" ] = 0
TOOL.ClientConVar[ "posz" ] = 0
TOOL.ClientConVar[ "scalex" ] = 0
TOOL.ClientConVar[ "scaley" ] = 0
TOOL.ClientConVar[ "scalez" ] = 0
TOOL.ClientConVar[ "rotx" ] = 0
TOOL.ClientConVar[ "roty" ] = 0
TOOL.ClientConVar[ "rotz" ] = 0

if(CLIENT) then
	language.Add("tool.mannable_changemodel.name", "Change Emplacement Model" )
	language.Add("tool.mannable_changemodel.desc", "Left click to select entity, right click to sample, reload to apply" )
	language.Add("tool.mannable_changemodel.0", "REMEMBER TO APPLY (RELOAD)" )
	language.Add("tool.mannable_changemodel.help", "Edit the settings" )

	local functions = {
		["retrieve"] = function()
			local ent = net.ReadEntity()

			if(!IsValid(ent)) then return end

			if(IsValid(ent._CustomGunModel)) then
				RunConsoleCommand("mannable_changemodel_model", ent._CustomGunModel:GetModel())
			end

			local mat = ent._GunModelMatrix

			if(mat) then
				local pos = mat:GetTranslation()
				local scale = mat:GetScale()
				local rot = mat:GetAngles()

				RunConsoleCommand("mannable_changemodel_posx", tostring(pos.x))
				RunConsoleCommand("mannable_changemodel_posy", tostring(pos.y))
				RunConsoleCommand("mannable_changemodel_posz", tostring(pos.z))
				RunConsoleCommand("mannable_changemodel_scalex", tostring(scale.x))
				RunConsoleCommand("mannable_changemodel_scaley", tostring(scale.y))
				RunConsoleCommand("mannable_changemodel_scalez", tostring(scale.z))
				RunConsoleCommand("mannable_changemodel_rotx", tostring(rot.pitch))
				RunConsoleCommand("mannable_changemodel_roty", tostring(rot.yaw))
				RunConsoleCommand("mannable_changemodel_rotz", tostring(rot.roll))
			end
		end,
		["updent"] = function()
			local ent = net.ReadEntity()
			local mdl = net.ReadString()
			local mat = net.ReadMatrix()
			local bone = net.ReadInt(32)

			if(!IsValid(ent) or ent.Base != "ent_mannable_bakubase") then return end

			ent:SetupCustomModel(mdl, bone)
			ent._GunModelMatrix = mat
		end
	}

	net.Receive("mannable_tool_changemodel", function(len, ply)
		local command = net.ReadString()

		if(isfunction(functions[command])) then
			functions[command]()
		end
	end)

	function TOOL:Think()
		local ent = self:GetWeapon():GetNWEntity("ent")
		if(!IsValid(ent) or ent.Base != "ent_mannable_bakubase") then return end

		local mat = Matrix()
		mat:SetTranslation(Vector(
			self:GetClientNumber("posx"),
			self:GetClientNumber("posy"),
			self:GetClientNumber("posz")
			))
		mat:SetScale(Vector(self:GetClientNumber("scalex"),
			self:GetClientNumber("scaley"),
			self:GetClientNumber("scalez")))
		mat:SetAngles(Angle(self:GetClientNumber("rotx"),
			self:GetClientNumber("roty"),
			self:GetClientNumber("rotz")))

		ent._GunModelMatrix = mat
	end

	local FacePoser = surface.GetTextureID( "gui/faceposer_indicator" )

	function TOOL:DrawHUD()

		if ( GetConVarNumber( "gmod_drawtooleffects" ) == 0 ) then return end

		local selected = self:GetWeapon():GetNWEntity("ent")

		if ( !IsValid( selected ) ) then return end

		local pos = selected:GetPos()

		local scrpos = pos:ToScreen()
		if ( !scrpos.visible ) then return end

		-- Work out the side distance to give a rough headsize box..
		local player_eyes = LocalPlayer():EyeAngles()
		local side = ( pos + player_eyes:Right() * 20 ):ToScreen()
		local size = math.abs( side.x - scrpos.x ) * 0.5

		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetTexture( FacePoser )
		surface.DrawTexturedRect( scrpos.x - size, scrpos.y - size, size * 2, size * 2 )

	end
else
	util.AddNetworkString("mannable_tool_changemodel")

	function TOOL:ApplySettings()
		local ent = self:GetWeapon():GetNWEntity("ent")

		if(!IsValid(ent) or ent.Base != "ent_mannable_bakubase") then return end

		local mdl = self:GetClientInfo("model")
		local mat = Matrix()
		mat:SetTranslation(Vector(
			self:GetClientNumber("posx"),
			self:GetClientNumber("posy"),
			self:GetClientNumber("posz")
			))
		mat:SetScale(Vector(self:GetClientNumber("scalex"),
			self:GetClientNumber("scaley"),
			self:GetClientNumber("scalez")))
		mat:SetAngles(Angle(self:GetClientNumber("rotx"),
			self:GetClientNumber("roty"),
			self:GetClientNumber("rotz")))
		local bone = self:GetClientNumber("bone")

		net.Start("mannable_tool_changemodel")
		net.WriteString("updent")
		net.WriteEntity(ent)
		net.WriteString(mdl)
		net.WriteMatrix(mat)
		net.WriteInt(bone, 32)
		net.Broadcast()

		ent._HideGunModel = self:GetClientNumber("hidegun") > 0

		if(ent._HideGunModel) then
			ent:SetModel("models/props_combine/bunker_gun01_nogun.mdl")
		end
	end
end
 
function TOOL:LeftClick( trace )
	if(!IsValid(trace.Entity) or trace.Entity.Base != "ent_mannable_bakubase") then return false end
	if(CLIENT) then return true end
	
	net.Start("mannable_tool_changemodel")
	net.WriteString("retrieve")
	net.WriteEntity(trace.Entity)
	net.Send(self:GetOwner())

	self:GetWeapon():SetNWEntity("ent", trace.Entity)

	return true
end
 
function TOOL:RightClick( trace )
	if(!IsValid(trace.Entity) or trace.Entity.Base != "ent_mannable_bakubase") then return false end
	if(CLIENT) then return true end

	net.Start("mannable_tool_changemodel")
	net.WriteString("retrieve")
	net.WriteEntity(trace.Entity)
	net.Send(self:GetOwner())

	return true
end

function TOOL:Reload(trace)
	if(!IsValid(trace.Entity) or self:GetWeapon():GetNWEntity("ent") != trace.Entity) then return false end
	if(CLIENT) then return true end

	self:ApplySettings()

	return true
end

local ConVarsDefault = TOOL:BuildConVarList()
 
function TOOL.BuildCPanel( CPanel )
	CPanel:AddControl( "Header", { Description = "#tool.mannable_changemodel.help" } )

	CPanel:AddControl( "ComboBox", { MenuButton = 1, Folder = "mannable_changemodel", Options = { [ "#preset.default" ] = ConVarsDefault }, CVars = table.GetKeys( ConVarsDefault ) } )
	CPanel:AddControl( "CheckBox", { Label = "Hide gun model", Command = "mannable_changemodel_hidegun" } )

	CPanel:AddControl( "TextBox", { Label = "Custom gun model", Command = "mannable_changemodel_model" } )
	CPanel:AddControl( "Label", { text = "Position, rotation, scale" } )
	CPanel:AddControl( "Slider", { Label = "Pos X", Command = "mannable_changemodel_posx", min = -50, max = 50, type = "float" } )
	CPanel:AddControl( "Slider", { Label = "Pos Y", Command = "mannable_changemodel_posy", min = -50, max = 50, type = "float" } )
	CPanel:AddControl( "Slider", { Label = "Pos Z", Command = "mannable_changemodel_posz", min = -50, max = 50, type = "float" } )
	CPanel:AddControl( "Slider", { Label = "Scale X", Command = "mannable_changemodel_scalex", min = -50, max = 50, type = "float" } )
	CPanel:AddControl( "Slider", { Label = "Scale Y", Command = "mannable_changemodel_scaley", min = -50, max = 50, type = "float" } )
	CPanel:AddControl( "Slider", { Label = "Scale Z", Command = "mannable_changemodel_scalez", min = -50, max = 50, type = "float" } )
	CPanel:AddControl( "Slider", { Label = "Rotation X", Command = "mannable_changemodel_rotx", min = 0, max = 360, type = "float" } )
	CPanel:AddControl( "Slider", { Label = "Rotation Y", Command = "mannable_changemodel_roty", min = 0, max = 360, type = "float" } )
	CPanel:AddControl( "Slider", { Label = "Rotation Z", Command = "mannable_changemodel_rotz", min = 0, max = 360, type = "float" } )
end