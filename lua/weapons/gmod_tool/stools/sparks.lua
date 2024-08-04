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
TOOL.Name = "Sparks"
TOOL.Command = nil
TOOL.ConfigName = ""

//Default values
TOOL.ClientConVar["maxdelay"] = 2
TOOL.ClientConVar["magnitude"] = 2
TOOL.ClientConVar["traillength"] = 2
TOOL.ClientConVar["glow"] = 1
TOOL.ClientConVar["makesound"] = 1
TOOL.ClientConVar["key"] = 5
TOOL.ClientConVar["numpadcontrol"] = 0
TOOL.ClientConVar["toggle"] = 0

//List of all spawned spark entities
TOOL.Sparks = {}

//Add language descriptions
if (CLIENT) then
language.Add("Tool.sparks.name", "Sparks Tool")
language.Add("Tool.sparks.desc", "Creates customizable sparks")
language.Add("Tool.sparks.0", "Left-Click: Create sparks  Right-Click: Remove sparks")
language.Add("Cleanup_sparks", "Sparks")
language.Add("Cleaned_sparks", "Cleaned up all Sparks")
language.Add("SBoxLimit_sparks", "You've hit the Sparks limit!")
language.Add("Undone_sparks", "Sparks undone")
end

//Sandbox-related stuff
cleanup.Register("sparks")
CreateConVar("sbox_maxsparks", 6, FCVAR_NOTIFY)


//Create sparks
function TOOL:LeftClick(trace)

//Clients don't need to know about any of this
if (CLIENT) then return true end

//Check current spawnlimits
if (!self:GetSWEP():CheckLimit("sparks")) then return false end

//Retreive settings
local spawnflags = 512 //Directional
if self:GetClientNumber("numpadcontrol") == 0 then spawnflags = spawnflags + 64 end
local maxdelay = math.Round(math.Clamp(self:GetClientNumber("maxdelay"), .12, 120)) //Integer
local magnitude = math.Round(math.Clamp(self:GetClientNumber("magnitude"), .5, 15)) //Integer
local traillength = math.Round(math.Clamp(self:GetClientNumber("traillength"), .12, 15)) //Float or Integer?
if math.Round(math.Clamp(self:GetClientNumber("glow"), 0, 1)) == 1 then spawnflags = spawnflags + 128 end
if math.Round(math.Clamp(self:GetClientNumber("makesound"), 0, 1)) == 0 then spawnflags = spawnflags + 256 end

//Create sparks and assign settings
local sparks = ents.Create("env_spark")
if !sparks || !sparks:IsValid() then return false end
sparks:SetPos(trace.HitPos)
sparks:SetKeyValue("angles", tostring(trace.HitNormal:Angle()))
sparks:SetKeyValue("MaxDelay", tostring(maxdelay))
sparks:SetKeyValue("Magnitude", tostring(magnitude))
sparks:SetKeyValue("TrailLength", tostring(traillength))
sparks:SetKeyValue("spawnflags", tostring(spawnflags))

//Spawn sparks
sparks:Spawn()
sparks:Activate()
if trace && trace.Entity && trace.Entity:IsValid() && trace.Entity:GetPhysicsObject():IsValid() && !trace.Entity:IsPlayer() && !trace.Entity:IsWorld() then sparks:SetParent(trace.Entity) end

//Add to relevant lists
self:GetOwner():AddCount("sparks", sparks)
table.insert(self.Sparks, sparks)

//Make sure we can undo
undo.Create("sparks")
undo.AddEntity(sparks)
undo.SetPlayer(self:GetOwner())
undo.Finish()
cleanup.Add(self:GetOwner(), "sparks", sparks)

//Make sure we can control it with numpad
if self:GetClientNumber("numpadcontrol") == 1 then
self:SetupNumpadControls(sparks)
end

return true

end


//Setup numpad controls
function TOOL:SetupNumpadControls(sparks)

//Safeguards
if !sparks || !sparks:IsValid() || self:GetClientInfo("key") == nil || self:GetClientInfo("key") == -1 then return false end

//If not toggled
if self:GetClientNumber("toggle") == 0 then

	//Create KeyDown numpad functions
	local function StartEmitSparks(ply, sparks)
	if !sparks || !sparks:IsValid() then return end

		//Start sparks
		sparks:Fire("SparkOnce", "", 0)
		sparks:Fire("StartSpark", "", 0)

	end

	//Register KeyDown functions
	numpad.Register("StartEmitSparks", StartEmitSparks)
	numpad.OnDown(self:GetOwner(), self:GetClientNumber("key"), "StartEmitSparks", sparks)

	//Create KeyUp numpad functions
	local function StopEmitSparks(ply, sparks)
	if !sparks || !sparks:IsValid() then return end

		//Stop sparks
		sparks:Fire("StopSpark", "", 0)

	end

	//Register KeyUp functions
	numpad.Register("StopEmitSparks", StopEmitSparks)
	numpad.OnUp(self:GetOwner(), self:GetClientNumber("key"), "StopEmitSparks", sparks)

end

//If toggled
if self:GetClientNumber("toggle") == 1 then
	
	sparks.Toggle = false

	//Create KeyDown numpad functions
	local function ToggleEmitSparks(ply, sparks)
	if !sparks || !sparks:IsValid() then return end

		//Start sparks
		if !sparks.Toggle then
		sparks:Fire("StartSpark", "", 0)
		sparks.Toggle = true
		return
		end

		//Stop sparks
		if sparks.Toggle then
		sparks:Fire("StopSpark", "", 0)
		sparks.Toggle = false
		return
		end

	end

	//Register KeyDown functions
	numpad.Register("ToggleEmitSparks", ToggleEmitSparks)
	numpad.OnDown(self:GetOwner(), self:GetClientNumber("key"), "ToggleEmitSparks", sparks)

end

return true

end


//Remove sparks in radius
function TOOL:RightClick(trace)

//Clients don't need to know about any of this
if (CLIENT) then return false end

//Find sparks in radius
local findsparks = ents.FindInSphere(trace.HitPos, 32)
for _, sparks in pairs(findsparks) do

	//Remove
	if sparks && sparks:IsValid() && !sparks:GetPhysicsObject():IsValid() && sparks:GetClass() == "env_spark" && !sparks:IsPlayer() && !sparks:IsNPC() && !sparks:IsWorld() then
	sparks:Fire("SparkOnce","",0)
	sparks:Fire("Kill", "", 0)
	end
end

end


//Remove all sparks
function TOOL:Reload()

//Clients don't need to know about any of this
if (CLIENT) then return false end

//Get all sparks
for x = 1, table.getn(self.Sparks) do
local sparks = self.Sparks[x]

	//Remove
	if sparks && sparks:IsValid() then
	sparks:Fire("Kill", "", 0)
	end
end

end


//Build Tool Menu
function TOOL.BuildCPanel(panel)

//Header
panel:AddControl( "Header", { Text = "#Tool.sparks.name", Description = "#Tool.sparks.desc" } )

//Build preset menu and declare default preset
local params = { Label = "#Presets", MenuButton = 1, Folder = "sparks", Options = {}, CVars = {} }

	//Declare default preset
	params.Options.default = {
	sparks_maxdelay		= 2,
	sparks_magnitude		= 2,
	sparks_traillength		= 2,
	sparks_glow		= 1,
	sparks_makesound		= 1,
				}

	//Declare console variables
	table.insert( params.CVars, "sparks_maxdelay" )
	table.insert( params.CVars, "sparks_magnitude" )
	table.insert( params.CVars, "sparks_traillength" )
	table.insert( params.CVars, "sparks_glow" )
	table.insert( params.CVars, "sparks_makesound" )

//All done
panel:AddControl( "ComboBox", params )

//Max delay
panel:AddControl( "Slider", { Label = "Max Delay", Type = "Float", Min = "0", Max = "30", Command ="sparks_maxdelay" } )
//Magnitude
panel:AddControl( "Slider", { Label = "Magnitude", Type = "Float", Min = "0", Max = "10", Command ="sparks_magnitude" } )
//Trail length
panel:AddControl( "Slider", { Label = "Trail Length", Type = "Float", Min = "0", Max = "10", Command ="sparks_traillength" } )
//Glow
panel:AddControl( "CheckBox", { Label = "Glow", Description = "", Command = "sparks_glow" } )
//Sound
panel:AddControl( "CheckBox", { Label = "Sound", Description = "", Command = "sparks_makesound" } )

//-------------
panel:AddControl( "Label", { Text = "________________________________________", Description = "" } )

//Numpad menu
panel:AddControl( "Numpad", { Label = "Start/Stop", Command = "sparks_key", ButtonSize = 22 } )
//Use numpad check
panel:AddControl( "CheckBox", { Label = "Use keyboard", Description = "", Command = "sparks_numpadcontrol" } )
//Toggle check
panel:AddControl( "CheckBox", { Label = "Toggle", Description = "", Command = "sparks_toggle" } )

end