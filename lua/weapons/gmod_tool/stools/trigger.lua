--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

// STool by Nekres ( 4ndy )
TOOL.Category = "Half-Life 2"
TOOL.Name = "#tool.trigger"
TOOL.Command = nil
TOOL.ConfigName = ""

TOOL.ClientConVar["type"] = "0"
TOOL.ClientConVar["toggle_type"] = "0"

TOOL.ClientConVar["allow_players"] = "1"
TOOL.ClientConVar["allow_npcs"] = "0"
TOOL.ClientConVar["allow_props"] = "0"

TOOL.ClientConVar["output1"] = "0"
TOOL.ClientConVar["output2"] = "0"

TOOL.ClientConVar["target_index"] = "0"
TOOL.ClientConVar["target_input"] = "Break"
TOOL.ClientConVar["target_parameter"] = "<none>"
TOOL.ClientConVar["target_delay"] = "0.001"

TOOL.ClientConVar["solid"] = "37"

cleanup.Register("prop_trigger")

if (CLIENT) then
	language.Add("tool.trigger", "Trigger")
	language.Add("tool.trigger.name", "Trigger Tool")
	language.Add("tool.trigger.desc", "Turn a prop into a trigger")
	language.Add("tool.trigger.0", "Left click to turn a prop into a trigger. Right to set an entity's index as target.")

	language.Add("tool.trigger.type", "Trigger Type:")
	language.Add("tool.trigger.toggle_type", "Toggle Type:")

	language.Add("tool.trigger.output1", "Output 1")
	language.Add("tool.trigger.output2", "Output 2")
	
	language.Add("tool.trigger.solid", "Toggle Solid")

	language.Add("Cleanup_prop_trigger", "Prop Trigger")
	language.Add("Cleaned_prop_trigger", "Cleaned up all Prop Trigger")
	language.Add("SBoxLimit_prop_trigger", "You've hit the Prop Trigger limit!")
	language.Add("Undone_prop_trigger", "Prop Trigger undone")

	language.Add("trigger", "Prop Trigger")
	language.Add("tool.trigger.trigger_multiple", "Multiple")
	language.Add("tool.trigger.trigger_once", "Once")
	
	language.Add("tool.trigger.toggle_none", "Do Not Toggle")
	language.Add("tool.trigger.toggle_touch", "Active While Touching")
	language.Add("tool.trigger.toggle_always", "On / Off Switch")

	language.Add("tool.trigger.target", "Target Index:")
	language.Add("tool.trigger.target_input", "Input To Fire:")
	language.Add("tool.trigger.target_parameter", "Parameter:")
	language.Add("tool.trigger.target_delay", "Delay:")
	language.Add("tool.trigger.target_delay.help", "After a Delay in Seconds of ..")

	language.Add("tool.trigger.allow_players", "Trigger On Player")
	language.Add("tool.trigger.allow_npcs", "Trigger On NPCs")
	language.Add("tool.trigger.allow_props", "Trigger On Props")
	language.Add("tool.trigger.reset", "Reset Settings")

	concommand.Add("trigger_reset", function(ply)
		RunConsoleCommand("trigger_type", "0")
		RunConsoleCommand("trigger_toggle_type", "0")
		RunConsoleCommand("trigger_allow_players", "1")
		RunConsoleCommand("trigger_allow_npcs", "0")
		RunConsoleCommand("trigger_allow_props", "0")
		RunConsoleCommand("trigger_output1", "0")
		RunConsoleCommand("trigger_output2", "0")
		RunConsoleCommand("trigger_solid", "37")
		RunConsoleCommand("trigger_target_index", "0")
		RunConsoleCommand("trigger_target_input", "\r")
		RunConsoleCommand("trigger_target_parameter", "<none>")
		RunConsoleCommand("trigger_target_delay", "0.001")
	end)
end
if (SERVER) then
	CreateConVar("sbox_maxtriggers", 10)

	numpad.Register("trigger_solid", function(ply, prop_trigger, activate)
		if (!IsValid(prop_trigger)) then return false end
		if (prop_trigger.solid) then
			prop_trigger:DrawShadow(false)
			prop_trigger:SetNotSolid(true)
			prop_trigger:SetNoDraw(true)
	
			prop_trigger:SetTrigger(true)
			prop_trigger.solid = false
		else
			prop_trigger:DrawShadow(true)
			prop_trigger:SetNotSolid(false)
			prop_trigger:SetNoDraw(false)

			prop_trigger:SetTrigger(false)
			prop_trigger.solid = true
		end
	end)

	function MakePropTrigger(ply, pos, ang, model, keySolid, settings)
		if (!ply:CheckLimit("triggers")) then return false end
	
		local prop_trigger = ents.Create("prop_trigger")
		if (!prop_trigger:IsValid()) then return false end

		prop_trigger:Initialize(model)

		prop_trigger:SetOwner(ply)
		prop_trigger:SetPos(pos)
		prop_trigger:SetAngles(ang)

		prop_trigger:Spawn()
		prop_trigger:Activate()
		prop_trigger.solid = true
		prop_trigger.ToggleSolid = numpad.OnDown(ply, keySolid, "trigger_solid", prop_trigger)

		table.Merge(prop_trigger:GetTable(), {
			ply = ply,
			model = model,
			keySolid = keySolid,
			settings = settings,
		})

		ply:AddCount("triggers", prop_trigger)

		DoPropSpawnedEffect(prop_trigger)

		return prop_trigger
	end
	
	duplicator.RegisterEntityClass("prop_trigger", MakeNpcCrate, "pos", "ang", "model", "keySolid", "settings")
end

function TOOL:LeftClick(trace)
	if (trace.HitSky or !trace.HitPos or IsValid(trace.Entity) and (trace.Entity:IsPlayer() or trace.Entity:IsNPC())) then return false end
	if (CLIENT) then return true end

	if (trace.Entity:GetClass() != "prop_physics") then return false end

	local Tbl = { }
		Tbl["type"] = self:GetClientInfo("type")
		Tbl["toggle_type"] = self:GetClientInfo("toggle_type")
		Tbl["allow_players"] = self:GetClientInfo("allow_players")
		Tbl["allow_npcs"] = self:GetClientInfo("allow_npcs")
		Tbl["allow_props"] = self:GetClientInfo("allow_props")
		Tbl["output1"] = self:GetClientInfo("output1")
		Tbl["output2"] = self:GetClientInfo("output2")
		Tbl["tar_index"] = self:GetClientInfo("target_index")
		Tbl["tar_input"] = self:GetClientInfo("target_input")
		Tbl["tar_param"] = self:GetClientInfo("target_parameter")
		Tbl["tar_delay"] = self:GetClientInfo("target_delay")

	local ply = self:GetOwner()
	local model = trace.Entity:GetModel()

	// Update existing Prop Trigger
	if (trace.Entity:GetClass() == "prop_trigger") then
		trace.Entity:SetOwner(ply)
		table.Merge(trace.Entity:GetTable(), {
			ply = ply,
			model = model,
			settings = Tbl,
		})
		return true
	end

	// Create a new Prop Trigger
	local ang = trace.HitNormal:Angle()
	ang.pitch = ang.pitch - 270

	local prop_trigger = MakePropTrigger(ply, trace.Entity:GetPos(), trace.Entity:GetAngles(), model, self:GetClientNumber("solid"), Tbl)
	trace.Entity:Remove()

	undo.Create("prop_trigger")
		undo.AddEntity(prop_trigger)
		undo.SetPlayer(ply)
	undo.Finish()

	ply:AddCleanup("prop_trigger", prop_trigger)

	return true
end
function TOOL:RightClick(trace)
	if (trace.HitSky or trace.HitWorld or !trace.HitPos or IsValid(trace.Entity) and (trace.Entity:IsPlayer() or trace.Entity:GetClass() == "prop_trigger")) then return false end
	if (CLIENT) then return true end

	local ply = self:GetOwner()
	local index = trace.Entity:EntIndex()
	ply:ConCommand("trigger_target_index ".. tostring(index))
	ply:SendLua("GAMEMODE:AddNotify('Target index set to ".. tostring(index) .."!', NOTIFY_GENERIC, 5)")

	return true
end
function TOOL.BuildCPanel(panel)
	panel:AddControl("Numpad", { 	Label = "#tool.trigger.solid",
									 Command = "trigger_solid",
									 ButtonSize = "22"})
	panel:ControlHelp( "Toggle the Trigger visible and disabled." )
	panel:AddControl("ComboBox", {Label = "#tool.trigger.type", MenuButton = "0", Options = list.Get("PropTriggerTypes")})
	panel:AddControl("Numpad", { 	Label = "#tool.trigger.output1",
									 Label2 = "#tool.trigger.output2",
									 Command = "trigger_output1",
									Command2 = "trigger_output2",
									 ButtonSize = "22"})
	panel:ControlHelp("Keys To Simulate while triggered.")
	panel:AddControl("ComboBox", {Label = "#tool.trigger.toggle_type", MenuButton = "0", Options = list.Get("PropTriggerToggleTypes")})
	panel:AddControl("Checkbox", {Label = "#tool.trigger.allow_players", Command = "trigger_allow_players"})
	panel:AddControl("Checkbox", {Label = "#tool.trigger.allow_npcs", Command = "trigger_allow_npcs"})
	panel:AddControl("Checkbox", {Label = "#tool.trigger.allow_props", Command = "trigger_allow_props"})
	panel:Help("Advanced Settings (Output 3):")
	panel:AddControl( "TextBox", { Label = "#tool.trigger.target",
									 MaxLenth = "5",
									 Command = "trigger_target_index" } )
	panel:ControlHelp("Target's Entity Index ..")
	panel:AddControl( "TextBox", { Label = "#tool.trigger.target_input",
									 MaxLenth = "20",
									 Command = "trigger_target_input" } )
	panel:ControlHelp("Via this Input ..")
	panel:AddControl( "TextBox", { Label = "#tool.trigger.target_parameter",
									 MaxLenth = "20",
									 Command = "trigger_target_parameter" } )
	panel:ControlHelp("With a Parameter Override of ..")
	panel:AddControl("Slider", {Label = "#tool.trigger.target_delay", Type = "Integer", Min = 0.001, Max = 10, Command = "trigger_target_delay", Help = true})
	panel:AddControl("Button", {Label = "#tool.trigger.reset", Command = "trigger_reset"})
	panel:Help("What is a Trigger?")
	panel:ControlHelp( "A Trigger can be used to activate / to fire the Inputs of other Entities. For example: Thrusters, Dynamites or Motors." )
	panel:Help("Where are they used?")
	panel:ControlHelp( "Throughout the whole Campaign of the Half-Life 2 series and other source engine based Games." )
	panel:Help("What is their purpose?")
	panel:ControlHelp( "To make a Game look more fascinating and random. It's used to create a Chain of Events happening without the Player pressing anything." )
	panel:Help("Things I should consider?")
	panel:ControlHelp("- Always move your Prop to the desired Position, before you turn it into a non-solid Trigger!")
	panel:ControlHelp("- Disable all 'toggle' or similar Options of Entities from other STools. Otherwise they get in conflict with the 'toggle' Options from this STool!")
end
list.Set("PropTriggerTypes", "#tool.trigger.trigger_multiple", {trigger_type = "0"})
list.Set("PropTriggerTypes", "#tool.trigger.trigger_once", {trigger_type = "1"})

list.Set("PropTriggerToggleTypes", "#tool.trigger.toggle_none", {trigger_toggle_type = "0"})
list.Set("PropTriggerToggleTypes", "#tool.trigger.toggle_touch", {trigger_toggle_type = "1"})
list.Set("PropTriggerToggleTypes", "#tool.trigger.toggle_always", {trigger_toggle_type = "2"})