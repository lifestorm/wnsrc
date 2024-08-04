--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

TOOL.Category = "Effects"
TOOL.Name = "Tesla"
TOOL.Command = nil
TOOL.ConfigName = ""

//Default values
TOOL.ClientConVar["dischargeradius"] = 256
TOOL.ClientConVar["dischargeinterval"] = 1.5
TOOL.ClientConVar["beamcount"] = 2
TOOL.ClientConVar["beamthickness"] = 6
TOOL.ClientConVar["beamlifetime"] = 0.052
TOOL.ClientConVar["sound"] = 1
TOOL.ClientConVar["key"] = 5
TOOL.ClientConVar["numpadcontrol"] = 0
TOOL.ClientConVar["toggle"] = 0

//List of all spawned tesla entities
TOOL.Discharges = {}

//Add language descriptions
if (CLIENT) then
language.Add("Tool.tesla.name", "Tesla Discharge Tool")
language.Add("Tool.tesla.desc", "Creates electric discharges")
language.Add("Tool.tesla.0", "Left-Click: Create an electric discharge  Right-Click: Remove discharge")
language.Add("Cleanup_discharges", "Tesla Discharges")
language.Add("Cleaned_discharges", "Cleaned up all Discharges")
language.Add("SBoxLimit_discharges", "You've hit the Discharges limit!")
language.Add("Undone_discharge", "Tesla Discharge undone")
end

//Sandbox-related stuff
cleanup.Register("discharges")
CreateConVar("sbox_maxdischarges", 4, FCVAR_NOTIFY)


//Create discharge
function TOOL:LeftClick(trace)

//Clients don't need to know about any of this
if (CLIENT) then return true end

//Check current spawnlimits
if (!self:GetSWEP():CheckLimit("discharges")) then return false end

//Retreive settings
local dischargeradius = math.Round(math.Clamp(self:GetClientNumber("dischargeradius"), 1, 2048))
local dischargeinterval = math.Clamp(self:GetClientNumber("dischargeinterval"), 0.012, 8)
local beamcount = math.Clamp(self:GetClientNumber("beamcount"), 1, 32)
local beamthickness = math.Clamp(self:GetClientNumber("beamthickness"), 0.12, 16)
local beamlifetime = math.Clamp(self:GetClientNumber("beamlifetime"), 0.052, 8)

//Create discharge and assign settings
local discharge = ents.Create("point_tesla")
if !discharge || !discharge:IsValid() then return false end
discharge:SetPos(trace.HitPos)
discharge:SetKeyValue("texture", "trails/laser.vmt")
discharge:SetKeyValue("m_Color", "255 255 255")
discharge:SetKeyValue("m_flRadius", tostring(dischargeradius))
discharge:SetKeyValue("interval_min", tostring(dischargeinterval * 0.75))
discharge:SetKeyValue("interval_max", tostring(dischargeinterval * 1.25))
discharge:SetKeyValue("beamcount_min", tostring(math.Round(beamcount * 0.75)))
discharge:SetKeyValue("beamcount_max", tostring(math.Round(beamcount * 1.25)))
discharge:SetKeyValue("thick_min", tostring(beamthickness * 0.75))
discharge:SetKeyValue("thick_max", tostring(beamthickness * 1.25))
discharge:SetKeyValue("lifetime_min", tostring(beamlifetime * 0.75))
discharge:SetKeyValue("lifetime_max", tostring(beamlifetime * 1.25))

//Emit sounds
if math.Round(math.Clamp(self:GetClientNumber("sound"), 0, 1)) == 1 then
discharge:SetKeyValue("m_SoundName", tostring("weapons/physcannon/superphys_small_zap" .. math.random(1,4) .. ".wav"))
if self:GetClientNumber("numpadcontrol") == 0 then
sound.Play( "ambient/energy/weld" .. math.random(1,2) .. ".wav", trace.HitPos, 64, 100 )
discharge:Fire("DoSpark", "", 0)
end
end

//Spawn discharge
discharge:Spawn()
discharge:Activate()
if trace && trace.Entity && trace.Entity:IsValid() && trace.Entity:GetPhysicsObject():IsValid() && !trace.Entity:IsPlayer() && !trace.Entity:IsWorld() then discharge:SetParent(trace.Entity) end
if self:GetClientNumber("numpadcontrol") == 0 then discharge:Fire("TurnOn", "", 0) end

//Add to relevant lists
self:GetOwner():AddCount("discharges", discharge)
table.insert(self.Discharges, discharge)

//Make sure we can undo
undo.Create("discharge")
undo.AddEntity(discharge)
undo.SetPlayer(self:GetOwner())
undo.Finish()
cleanup.Add(self:GetOwner(), "discharges", discharge)

//Make sure we can control it with numpad
if self:GetClientNumber("numpadcontrol") == 1 then
self:SetupNumpadControls(discharge)
end

return true

end


//Setup numpad controls
function TOOL:SetupNumpadControls(discharge)

//Safeguards
if !discharge || !discharge:IsValid() || self:GetClientInfo("key") == nil || self:GetClientInfo("key") == -1 then return false end

//If not toggled
if self:GetClientNumber("toggle") == 0 then

	//Create KeyDown numpad functions
	local function StartEmitDischarge(ply, discharge)
	if !discharge || !discharge:IsValid() then return end

		//Start discharge
		discharge:Fire("DoSpark", "", 0)
		discharge:Fire("TurnOn", "", 0)

	end

	//Register KeyDown functions
	numpad.Register("StartEmitDischarge", StartEmitDischarge)
	numpad.OnDown(self:GetOwner(), self:GetClientNumber("key"), "StartEmitDischarge", discharge)

	//Create KeyUp numpad functions
	local function StopEmitDischarge(ply, discharge)
	if !discharge || !discharge:IsValid() then return end

		//Stop discharge
		discharge:Fire("TurnOff", "", 0)

	end

	//Register KeyUp functions
	numpad.Register("StopEmitDischarge", StopEmitDischarge)
	numpad.OnUp(self:GetOwner(), self:GetClientNumber("key"), "StopEmitDischarge", discharge)

end

//If toggled
if self:GetClientNumber("toggle") == 1 then
	
	discharge.Toggle = false

	//Create KeyDown numpad functions
	local function ToggleEmitDischarge(ply, discharge)
	if !discharge || !discharge:IsValid() then return end

		//Start discharge
		if !discharge.Toggle then
		discharge:Fire("TurnOn", "", 0)
		discharge.Toggle = true
		return
		end

		//Stop discharge
		if discharge.Toggle then
		discharge:Fire("TurnOff", "", 0)
		discharge.Toggle = false
		return
		end

	end

	//Register KeyDown functions
	numpad.Register("ToggleEmitDischarge", ToggleEmitDischarge)
	numpad.OnDown(self:GetOwner(), self:GetClientNumber("key"), "ToggleEmitDischarge", discharge)

end

return true

end


//Remove discharges in radius
function TOOL:RightClick(trace)

//Clients don't need to know about any of this
if (CLIENT) then return false end

//Find discharges in radius
local finddischarges = ents.FindInSphere(trace.HitPos, 16)
for _, discharge in pairs(finddischarges) do

	//Remove
	if discharge && discharge:IsValid() && !discharge:GetPhysicsObject():IsValid() && discharge:GetClass() == "point_tesla" && !discharge:IsPlayer() && !discharge:IsNPC() && !discharge:IsWorld() then
	discharge:Fire("DoSpark", "", 0)
	discharge:Fire("Kill", "", 0)
	end
end

end


//Remove all discharges
function TOOL:Reload()

//Clients don't need to know about any of this
if (CLIENT) then return false end

//Get all discharges
for x = 1, table.getn(self.Discharges) do
local discharge = self.Discharges[x]

	//Remove
	if discharge && discharge:IsValid() then
	discharge:Fire("Kill", "", 0)
	end
end

end


//Precache all sounds
function TOOL:Precache()
util.PrecacheSound("weapons/physcannon/superphys_small_zap1.wav")
util.PrecacheSound("weapons/physcannon/superphys_small_zap2.wav")
util.PrecacheSound("weapons/physcannon/superphys_small_zap3.wav") 
util.PrecacheSound("weapons/physcannon/superphys_small_zap4.wav")
util.PrecacheSound("ambient/energy/weld1.wav")
util.PrecacheSound("ambient/energy/weld2.wav")
end


//Build Tool Menu
function TOOL.BuildCPanel(panel)

//Header
panel:AddControl( "Header", { Text = "#Tool.tesla.name", Description = "#Tool.tesla.desc" } )

//Build preset menu and declare default preset
local params = { Label = "#Presets", MenuButton = 1, Folder = "tesla", Options = {}, CVars = {} }

	//Declare default preset
	params.Options.default = {
	tesla_dischargeradius	= 256,
	tesla_dischargeinterval	= 1.5,
	tesla_beamcount		= 2,
	tesla_beamthickness	= 6,
	tesla_beamlifetime		= 0.052,
	tesla_sound		= 1,
				}

	//Declare console variables
	table.insert( params.CVars, "tesla_dischargeradius" )
	table.insert( params.CVars, "tesla_dischargeinterval" )
	table.insert( params.CVars, "tesla_beamcount" )
	table.insert( params.CVars, "tesla_beamthickness" )
	table.insert( params.CVars, "tesla_beamlifetime" )
	table.insert( params.CVars, "tesla_sound" )

//All done
panel:AddControl( "ComboBox", params )

//Discharge radius
panel:AddControl( "Slider", { Label = "Discharge Radius", Type = "Float", Min = "1", Max = "2048", Command ="tesla_dischargeradius" } )
//Discharge Interval
panel:AddControl( "Slider", { Label = "Discharge Interval", Type = "Float", Min = "0", Max = "8", Command ="tesla_dischargeinterval" } )
//Beam Count
panel:AddControl( "Slider", { Label = "Beam Count", Type = "Float", Min = "1", Max = "32", Command ="tesla_beamcount" } )
//Beam Thickness
panel:AddControl( "Slider", { Label = "Beam Thickness", Type = "Float", Min = "0", Max = "16", Command ="tesla_beamthickness" } )
//Beam Lifetime
panel:AddControl( "Slider", { Label = "Beam Lifetime", Type = "Float", Min = "0", Max = "8", Command ="tesla_beamlifetime" } )
//Sound
panel:AddControl( "CheckBox", { Label = "Sound", Description = "", Command = "tesla_sound" } )

//-------------
panel:AddControl( "Label", { Text = "________________________________________", Description = "" } )

//Numpad menu
panel:AddControl( "Numpad", { Label = "Activate/Deactivate", Command = "tesla_key", ButtonSize = 22 } )
//Use numpad check
panel:AddControl( "CheckBox", { Label = "Use keyboard", Description = "", Command = "tesla_numpadcontrol" } )
//Toggle check
panel:AddControl( "CheckBox", { Label = "Toggle", Description = "", Command = "tesla_toggle" } )

end