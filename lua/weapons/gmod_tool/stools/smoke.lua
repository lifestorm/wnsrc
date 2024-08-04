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
TOOL.Name = "Smoke"
TOOL.Command = nil
TOOL.ConfigName = ""

//Default values
TOOL.ClientConVar["color_r"] = 0
TOOL.ClientConVar["color_g"] = 0
TOOL.ClientConVar["color_b"] = 0
TOOL.ClientConVar["color_a"] = 21
TOOL.ClientConVar["material"] = "particle/smokesprites_0001.vmt"
TOOL.ClientConVar["spreadbase"] = 6
TOOL.ClientConVar["spreadspeed"] = 8
TOOL.ClientConVar["speed"] = 32
TOOL.ClientConVar["startsize"] = 32
TOOL.ClientConVar["endsize"] = 32
TOOL.ClientConVar["roll"] = 8
TOOL.ClientConVar["numparticles"] = 32
TOOL.ClientConVar["jetlength"] = 256
TOOL.ClientConVar["twist"] = 6
TOOL.ClientConVar["key"] = 5
TOOL.ClientConVar["numpadcontrol"] = 0
TOOL.ClientConVar["toggle"] = 0

//List of all spawned smoke entities
TOOL.Smokes = {}

//Add language descriptions
if (CLIENT) then
language.Add("Tool.smoke.name", "Smoke Tool")
language.Add("Tool.smoke.desc", "Creates customizable smoke")
language.Add("Tool.smoke.0", "Left-Click: Create smoke  Right-Click: Remove smoke")
language.Add("Cleanup_smokes", "Smoke")
language.Add("Cleaned_smokes", "Cleaned up all Smoke")
language.Add("SBoxLimit_smokes", "You've hit the Smoke limit!")
language.Add("Undone_smoke", "Smoke undone")
end

//Sandbox-related stuff
cleanup.Register("smokes")
CreateConVar("sbox_maxsmokes", 6, FCVAR_NOTIFY)


//Create smoke
function TOOL:LeftClick(trace)

//Clients don't need to know about any of this
if (CLIENT) then return true end

//Check current spawnlimits
if (!self:GetSWEP():CheckLimit("smokes")) then return false end

//Retreive settings
local color_r = math.Round(math.Clamp(self:GetClientNumber("color_r"), 0, 255))
local color_g = math.Round(math.Clamp(self:GetClientNumber("color_g"), 0, 255))
local color_b = math.Round(math.Clamp(self:GetClientNumber("color_b"), 0, 255))
local color_a = math.Round(math.Clamp(self:GetClientNumber("color_a"), 0, 255))
local basespread = math.Clamp(self:GetClientNumber("spreadbase"), 0, 1024)
local spreadspeed = math.Round(math.Clamp(self:GetClientNumber("spreadspeed"), 0, 1024))
local speed = math.Round(math.Clamp(self:GetClientNumber("speed"), 0, 2048))
local startsize = math.Clamp(self:GetClientNumber("startsize"), 0, 512)
local endsize = math.Clamp(self:GetClientNumber("endsize"), 0, 512)
local roll = math.Clamp(self:GetClientNumber("roll"), 0, 1024)
local rate = math.Round(math.Clamp(self:GetClientNumber("numparticles"), 0, 512))
local jetlength = math.Round(math.Clamp(self:GetClientNumber("jetlength"), 0, 4096))
local twist = math.Clamp(self:GetClientNumber("twist"), 0, 1024)

//Create smoke and assign settings
local smoke = ents.Create("env_smokestack")
if !smoke || !smoke:IsValid() then return false end
smoke:SetPos(trace.HitPos)
if self:GetClientNumber("numpadcontrol") == 0 then smoke:SetKeyValue("InitialState", "1") else smoke:SetKeyValue("InitialState", "0") end
smoke:SetKeyValue("WindAngle", "0 0 0")
smoke:SetKeyValue("WindSpeed", "0")
smoke:SetKeyValue("rendercolor", "" .. tostring(color_r) .. " " .. tostring(color_g) .. " " .. tostring(color_b) .. "")
smoke:SetKeyValue("renderamt", "" .. tostring(color_a) .. "")
smoke:SetKeyValue("SmokeMaterial", self:GetClientInfo("material"))
smoke:SetKeyValue("BaseSpread", tostring(basespread))
smoke:SetKeyValue("SpreadSpeed", tostring(spreadspeed))
smoke:SetKeyValue("Speed", tostring(speed))
smoke:SetKeyValue("StartSize", tostring(startsize))
smoke:SetKeyValue("EndSize", tostring(endsize))
smoke:SetKeyValue("roll", tostring(roll))
smoke:SetKeyValue("Rate", tostring(rate))
smoke:SetKeyValue("JetLength", tostring(jetlength))
smoke:SetKeyValue("twist", tostring(twist))

//Spawn smoke
smoke:Spawn()
smoke:Activate()
if trace && trace.Entity && trace.Entity:IsValid() && trace.Entity:GetPhysicsObject():IsValid() && !trace.Entity:IsPlayer() && !trace.Entity:IsWorld() then smoke:SetParent(trace.Entity) end

//Add to relevant lists
self:GetOwner():AddCount("smokes", smoke)
table.insert(self.Smokes, smoke)

//Make sure we can undo
undo.Create("smoke")
undo.AddEntity(smoke)
undo.SetPlayer(self:GetOwner())
undo.Finish()
cleanup.Add(self:GetOwner(), "smokes", smoke)

//Make sure we can control it with numpad
if self:GetClientNumber("numpadcontrol") == 1 then
self:SetupNumpadControls(smoke)
end

return true

end


//Setup numpad controls
function TOOL:SetupNumpadControls(smoke)

//Safeguards
if !smoke || !smoke:IsValid() || self:GetClientInfo("key") == nil || self:GetClientInfo("key") == -1 then return false end

//If not toggled
if self:GetClientNumber("toggle") == 0 then

	//Create KeyDown numpad functions
	local function StartEmitSmoke(ply, smoke)
	if !smoke || !smoke:IsValid() then return end

		//Start smoke
		smoke:Fire("TurnOn", "", 0)

	end

	//Register KeyDown functions
	numpad.Register("StartEmitSmoke", StartEmitSmoke)
	numpad.OnDown(self:GetOwner(), self:GetClientNumber("key"), "StartEmitSmoke", smoke)

	//Create KeyUp numpad functions
	local function StopEmitSmoke(ply, smoke)
	if !smoke || !smoke:IsValid() then return end

		//Stop smoke
		smoke:Fire("TurnOff", "", 0)

	end

	//Register KeyUp functions
	numpad.Register("StopEmitSmoke", StopEmitSmoke)
	numpad.OnUp(self:GetOwner(), self:GetClientNumber("key"), "StopEmitSmoke", smoke)

end

//If toggled
if self:GetClientNumber("toggle") == 1 then
	
	smoke.Toggle = false

	//Create KeyDown numpad functions
	local function ToggleEmitSmoke(ply, smoke)
	if !smoke || !smoke:IsValid() then return end

		//Start smoke
		if !smoke.Toggle then
		smoke:Fire("TurnOn", "", 0)
		smoke.Toggle = true
		return
		end

		//Stop smoke
		if smoke.Toggle then
		smoke:Fire("TurnOff", "", 0)
		smoke.Toggle = false
		return
		end

	end

	//Register KeyDown functions
	numpad.Register("ToggleEmitSmoke", ToggleEmitSmoke)
	numpad.OnDown(self:GetOwner(), self:GetClientNumber("key"), "ToggleEmitSmoke", smoke)

end

return true

end


//Remove smoke in radius
function TOOL:RightClick(trace)

//Clients don't need to know about any of this
if (CLIENT) then return false end

//Find smoke in radius
local findsmoke = ents.FindInSphere(trace.HitPos, 128)
for _, smoke in pairs(findsmoke) do

	//Remove
	if smoke && smoke:IsValid() && !smoke:GetPhysicsObject():IsValid() && smoke:GetClass() == "env_smokestack" && !smoke:IsPlayer() && !smoke:IsNPC() && !smoke:IsWorld() then
	smoke:Fire("TurnOff", "", 0)
	smoke:Fire("Kill", "", 6)
	end
end

end


//Remove all smoke
function TOOL:Reload()

//Clients don't need to know about any of this
if (CLIENT) then return false end

//Get all smoke
for x = 1, table.getn(self.Smokes) do
local smoke = self.Smokes[x]

	//Remove
	if smoke && smoke:IsValid() then
	smoke:Fire("TurnOff", "", 0)
	smoke:Fire("Kill", "", 6)
	end
end

end


//Build Tool Menu
function TOOL.BuildCPanel(panel)

//Header
panel:AddControl( "Header", { Text = "#Tool.smoke.name", Description = "#Tool.smoke.desc" } )

//Build preset menu and declare default preset
local params = { Label = "#Presets", MenuButton = 1, Folder = "smoke", Options = {}, CVars = {} }

	//Declare default preset
	params.Options.default = {
	smoke_color_r 		= 0,
	smoke_color_g		= 0,
	smoke_color_b 		= 0,
	smoke_color_a 		= 21,
	smoke_material 		= "particle/smokesprites_0001.vmt",
	smoke_spreadbase		= 6,
	smoke_spreadspeed 	= 8,
	smoke_speed 		= 32,
	smoke_startsize 		= 32,
	smoke_endsize 		= 32,
	smoke_roll 		= 8,
	smoke_numparticles		= 32,
	smoke_jetlength		= 256,
	smoke_twist 		= 6,
				}

	//Declare console variables
	table.insert( params.CVars, "smoke_color_r" )
	table.insert( params.CVars, "smoke_color_g" )
	table.insert( params.CVars, "smoke_color_b" )
	table.insert( params.CVars, "smoke_color_a" )
	table.insert( params.CVars, "smoke_material" )
	table.insert( params.CVars, "smoke_spreadbase" )
	table.insert( params.CVars, "smoke_spreadspeed" )
	table.insert( params.CVars, "smoke_speed" )
	table.insert( params.CVars, "smoke_startsize" )
	table.insert( params.CVars, "smoke_endsize" )
	table.insert( params.CVars, "smoke_roll" )
	table.insert( params.CVars, "smoke_numparticles" )
	table.insert( params.CVars, "smoke_jetlength" )
	table.insert( params.CVars, "smoke_twist" )

//All done
panel:AddControl( "ComboBox", params )

//Color picker
panel:AddControl( "Color", { Label = "Smoke color", Red = "smoke_color_r", Green = "smoke_color_g", Blue = "smoke_color_b", Alpha = "smoke_color_a", ShowAlpha = "1", ShowHSV = "1", ShowRGB = "1", Multiplier = "255" } )
//Smoke base size
panel:AddControl( "Slider", { Label = "Smoke base size", Type = "Integer", Min = "0", Max = "64", Command ="smoke_spreadbase" } )
//Spread speed
panel:AddControl( "Slider", { Label = "Spread speed", Type = "Integer", Min = "0", Max = "32", Command ="smoke_spreadspeed" } )
//Particle speed
panel:AddControl( "Slider", { Label = "Particle speed", Type = "Integer", Min = "0", Max = "128", Command ="smoke_speed" } )
//Particle start size
panel:AddControl( "Slider", { Label = "Particle start size", Type = "Integer", Min = "0", Max = "64", Command ="smoke_startsize" } )
//Particle end size
panel:AddControl( "Slider", { Label = "Particle end size", Type = "Integer", Min = "0", Max = "64", Command ="smoke_endsize" } )
//Particle roll
panel:AddControl( "Slider", { Label = "Particle roll", Type = "Integer", Min = "0", Max = "256", Command ="smoke_roll" } )
//Number of particles
panel:AddControl( "Slider", { Label = "Number of particles", Type = "Integer", Min = "0", Max = "64", Command ="smoke_numparticles" } )
//Height
panel:AddControl( "Slider", { Label = "Height", Type = "Integer", Min = "0", Max = "512", Command ="smoke_jetlength" } )
//Twist effect
panel:AddControl( "Slider", { Label = "Twist effect", Type = "Integer", Min = "0", Max = "256", Command ="smoke_twist" } )
//Material Picker
local materials = {"particle/smokesprites_0001.vmt", "particle/particle_smokegrenade.vmt", "particle/SmokeStack.vmt"}
panel:MatSelect( "smoke_material", materials, true, 0.33, 0.33 )

//-------------
panel:AddControl( "Label", { Text = "________________________________________", Description = "" } )

//Numpad menu
panel:AddControl( "Numpad", { Label = "Start/Stop", Command = "smoke_key", ButtonSize = 22 } )
//Use numpad check
panel:AddControl( "CheckBox", { Label = "Use keyboard", Description = "", Command = "smoke_numpadcontrol" } )
//Toggle check
panel:AddControl( "CheckBox", { Label = "Toggle", Description = "", Command = "smoke_toggle" } )

end