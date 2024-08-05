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
TOOL.Name = "Steam"
TOOL.Command = nil
TOOL.ConfigName = ""

//Default values
TOOL.ClientConVar["color_r"] = 150
TOOL.ClientConVar["color_g"] = 150
TOOL.ClientConVar["color_b"] = 150
TOOL.ClientConVar["color_a"] = 200
TOOL.ClientConVar["jetlength"] = 150
TOOL.ClientConVar["spreadspeed"] = 21
TOOL.ClientConVar["speed"] = 200
TOOL.ClientConVar["startsize"] = 16
TOOL.ClientConVar["endsize"] = 32
TOOL.ClientConVar["rate"] = 32
TOOL.ClientConVar["rollspeed"] = 12
TOOL.ClientConVar["emissive"] = 1
TOOL.ClientConVar["heatwave"] = 1
TOOL.ClientConVar["makesound"] = 1
TOOL.ClientConVar["key"] = 5
TOOL.ClientConVar["numpadcontrol"] = 0
TOOL.ClientConVar["toggle"] = 0

//List of all spawned steam entities
TOOL.Steams = {}

//Add language descriptions
if (CLIENT) then
language.Add("Tool.steam.name", "Steam Tool")
language.Add("Tool.steam.desc", "Creates customizable steam")
language.Add("Tool.steam.0", "Left-Click: Create steam  Right-Click: Remove steam")
language.Add("Cleanup_steams", "Steam")
language.Add("Cleaned_steams", "Cleaned up all Steam")
language.Add("SBoxLimit_steams", "You've hit the Steam limit!")
language.Add("Undone_steam", "Steam undone")
end

//Sandbox-related stuff
cleanup.Register("steams")
CreateConVar("sbox_maxsteams", 8, FCVAR_NOTIFY)


//Create steam
function TOOL:LeftClick(trace)

//Clients don't need to know about any of this
if (CLIENT) then return true end

//Check current spawnlimits
if (!self:GetSWEP():CheckLimit("steams")) then return false end

//Retreive settings
local color_r = math.Round(math.Clamp(self:GetClientNumber("color_r"), 0, 255))
local color_g = math.Round(math.Clamp(self:GetClientNumber("color_g"), 0, 255))
local color_b = math.Round(math.Clamp(self:GetClientNumber("color_b"), 0, 255))
local color_a = math.Round(math.Clamp(self:GetClientNumber("color_a"), 0, 255))
local jetlength = math.Round(math.Clamp(self:GetClientNumber("jetlength"), 8, 1024))
local spreadspeed = math.Round(math.Clamp(self:GetClientNumber("spreadspeed"), 0, 1024))
local speed = math.Round(math.Clamp(self:GetClientNumber("speed"), 0, 4096))
local startsize = math.Round(math.Clamp(self:GetClientNumber("startsize"), 0, 128))
local endsize = math.Round(math.Clamp(self:GetClientNumber("endsize"), 0, 128))
local rate = math.Round(math.Clamp(self:GetClientNumber("rate"), 1, 2048))
local rollspeed = math.Clamp(self:GetClientNumber("rollspeed"), 0, 128)

//Create steam and assign settings
local steam = ents.Create("env_steam")
if !steam || !steam:IsValid() then return false end
steam:SetPos(trace.HitPos)
if self:GetClientNumber("numpadcontrol") == 0 then steam:SetKeyValue("InitialState", "1") else steam:SetKeyValue("InitialState", "0") end
steam:SetKeyValue("angles", tostring(trace.HitNormal:Angle()))
steam:SetKeyValue("rendercolor", "" .. tostring(color_r) .. " " .. tostring(color_g) .. " " .. tostring(color_b) .. "")
steam:SetKeyValue("renderamt", "" .. tostring(color_a) .. "")
steam:SetKeyValue("JetLength", tostring(jetlength))
steam:SetKeyValue("SpreadSpeed", tostring(spreadspeed))
steam:SetKeyValue("Speed", tostring(speed))
steam:SetKeyValue("StartSize", tostring(startsize))
steam:SetKeyValue("EndSize", tostring(endsize))
steam:SetKeyValue("Rate", tostring(rate))
steam:SetKeyValue("rollspeed", tostring(rollspeed))
if math.Round(math.Clamp(self:GetClientNumber("emissive"), 0, 1)) == 1 then steam:SetKeyValue("spawnflags", "1") end
if math.Round(math.Clamp(self:GetClientNumber("heatwave"), 0, 1)) == 1 then steam:SetKeyValue("type", "1") else steam:SetKeyValue("type", "0") end

//Make steam emit hissing sounds
if math.Round(math.Clamp(self:GetClientNumber("makesound"), 0, 1)) == 1 then
steam.MakesSound = true
if math.Round(math.Clamp(self:GetClientNumber("heatwave"), 0, 1)) == 1 then steam.Heatwave = true steam.SFX_Sound = CreateSound(steam, Sound("ambient/gas/cannister_loop.wav")) else steam.SFX_Sound = CreateSound(steam, Sound("ambient/gas/steam2.wav")) end
if self:GetClientNumber("numpadcontrol") == 0 then sound.Play( "HL1/ambience/steamburst1.wav", trace.HitPos, 60, 100 ) steam.SFX_Sound:PlayEx(0.42, 100) end
end

//Spawn steam
steam:Spawn()
steam:Activate()
if trace && trace.Entity && trace.Entity:IsValid() && trace.Entity:GetPhysicsObject():IsValid() && !trace.Entity:IsPlayer() && !trace.Entity:IsWorld() then steam:SetParent(trace.Entity) end

//Add to relevant lists
self:GetOwner():AddCount("steams", steam)
table.insert(self.Steams, steam)

//Make sure we can undo
undo.Create("steam")
undo.AddEntity(steam)
undo.SetPlayer(self:GetOwner())
undo.Finish()
cleanup.Add(self:GetOwner(), "steams", steam)

//Make sure we can control it with numpad
if self:GetClientNumber("numpadcontrol") == 1 then
self:SetupNumpadControls(steam)
end

return true

end


//Setup numpad controls
function TOOL:SetupNumpadControls(steam)

//Safeguards
if !steam || !steam:IsValid() || self:GetClientInfo("key") == nil || self:GetClientInfo("key") == -1 then return false end

//If not toggled
if self:GetClientNumber("toggle") == 0 then

	//Create KeyDown numpad functions
	local function StartEmitSteam(ply, steam)
	if !steam || !steam:IsValid() then return end

		//Start steam and related sounds
		if steam.MakesSound then
			if steam.SFX_Sound then steam.SFX_Sound:Stop() end
			if steam.Heatwave then steam.SFX_Sound = CreateSound(steam, Sound("ambient/gas/cannister_loop.wav")) end
			if !steam.Heatwave then steam.SFX_Sound = CreateSound(steam, Sound("ambient/gas/steam2.wav")) end
			steam.SFX_Sound:PlayEx(0.42, 100)
		end
		steam:Fire("TurnOn", "", 0)

	end

	//Register KeyDown functions
	numpad.Register("StartEmitSteam", StartEmitSteam)
	numpad.OnDown(self:GetOwner(), self:GetClientNumber("key"), "StartEmitSteam", steam)

	//Create KeyUp numpad functions
	local function StopEmitSteam(ply, steam)
	if !steam || !steam:IsValid() then return end

		//Stop steam and related sounds
		if steam.SFX_Sound then steam.SFX_Sound:Stop() end
		steam:Fire("TurnOff", "", 0)

	end

	//Register KeyUp functions
	numpad.Register("StopEmitSteam", StopEmitSteam)
	numpad.OnUp(self:GetOwner(), self:GetClientNumber("key"), "StopEmitSteam", steam)

end

//If toggled
if self:GetClientNumber("toggle") == 1 then
	
	steam.Toggle = false

	//Create KeyDown numpad functions
	local function ToggleEmitSteam(ply, steam)
	if !steam || !steam:IsValid() then return end

		//Start steam and related sounds
		if !steam.Toggle then
		if steam.MakesSound then
			if steam.SFX_Sound then steam.SFX_Sound:Stop() end
			if steam.Heatwave then steam.SFX_Sound = CreateSound(steam, Sound("ambient/gas/cannister_loop.wav")) end
			if !steam.Heatwave then steam.SFX_Sound = CreateSound(steam, Sound("ambient/gas/steam2.wav")) end
			sound.Play( "HL1/ambience/steamburst1.wav", steam:GetPos(), 60, 100 )
			steam.SFX_Sound:PlayEx(0.42, 100)
		end
		steam:Fire("TurnOn", "", 0)
		steam.Toggle = true
		return
		end

		//Stop steam and related sounds
		if steam.Toggle then
		if steam.SFX_Sound then steam.SFX_Sound:Stop() end
		steam:Fire("TurnOff", "", 0)
		steam.Toggle = false
		return
		end

	end

	//Register KeyDown functions
	numpad.Register("ToggleEmitSteam", ToggleEmitSteam)
	numpad.OnDown(self:GetOwner(), self:GetClientNumber("key"), "ToggleEmitSteam", steam)

end

return true

end


//Remove steam in radius
function TOOL:RightClick(trace)

//Clients don't need to know about any of this
if (CLIENT) then return false end

//Find steam in radius
local findsteam = ents.FindInSphere(trace.HitPos, 32)
for _, steam in pairs(findsteam) do

	//Remove
	if steam && steam:IsValid() && !steam:GetPhysicsObject():IsValid() && steam:GetClass() == "env_steam" && !steam:IsPlayer() && !steam:IsNPC() && !steam:IsWorld() then
	if steam.SFX_Sound then steam.SFX_Sound:Stop() end
	steam:Fire("TurnOff", "", 0)
	steam:Fire("Kill", "", 6)
	end
end

end


//Remove all steam
function TOOL:Reload()

//Clients don't need to know about any of this
if (CLIENT) then return false end

//Get all steam objects
for x = 1, table.getn(self.Steams) do
local steam = self.Steams[x]

	//Remove
	if steam && steam:IsValid() then
	if steam.SFX_Sound then steam.SFX_Sound:Stop() end
	steam:Fire("TurnOff", "", 0)
	steam:Fire("Kill", "", 6)
	end
end

end


//Precache all sounds
function TOOL:Precache()
util.PrecacheSound("HL1/ambience/steamburst1.wav")
util.PrecacheSound("ambient/gas/cannister_loop.wav")
util.PrecacheSound("ambient/gas/steam2.wav")
end


//Build Tool Menu
function TOOL.BuildCPanel(panel)

//Header
panel:AddControl( "Header", { Text = "#Tool.steam.name", Description = "#Tool.steam.desc" } )

//Build preset menu and declare default preset
local params = { Label = "#Presets", MenuButton = 1, Folder = "steam", Options = {}, CVars = {} }

	//Declare default preset
	params.Options.default = {
	steam_color_r 		= 150,
	steam_color_g		= 150,
	steam_color_b 		= 150,
	steam_color_a 		= 200,
	steam_jetlength 		= 150,
	steam_spreadspeed		= 21,
	steam_speed 		= 200,
	steam_startsize 		= 16,
	steam_endsize 		= 32,
	steam_rate 		= 32,
	steam_rollspeed 		= 12,
	steam_emissive		= 1,
	steam_heatwave		= 1,
	steam_makesound 		= 1,
				}

	//Declare console variables
	table.insert( params.CVars, "steam_color_r" )
	table.insert( params.CVars, "steam_color_g" )
	table.insert( params.CVars, "steam_color_b" )
	table.insert( params.CVars, "steam_color_a" )
	table.insert( params.CVars, "steam_jetlength" )
	table.insert( params.CVars, "steam_spreadspeed" )
	table.insert( params.CVars, "steam_speed" )
	table.insert( params.CVars, "steam_startsize" )
	table.insert( params.CVars, "steam_endsize" )
	table.insert( params.CVars, "steam_rate" )
	table.insert( params.CVars, "steam_rollspeed" )
	table.insert( params.CVars, "steam_emissive" )
	table.insert( params.CVars, "steam_heatwave" )
	table.insert( params.CVars, "steam_makesound" )

//All done
panel:AddControl( "ComboBox", params )

//Color picker
panel:AddControl( "Color", { Label = "Steam color", Red = "steam_color_r", Green = "steam_color_g", Blue = "steam_color_b", Alpha = "steam_color_a", ShowAlpha = "1", ShowHSV = "1", ShowRGB = "1", Multiplier = "255" } )
//Jet length
panel:AddControl( "Slider", { Label = "Jet length", Type = "Integer", Min = "1", Max = "512", Command ="steam_jetlength" } )
//Spread speed
panel:AddControl( "Slider", { Label = "Spread speed", Type = "Integer", Min = "0", Max = "128", Command ="steam_spreadspeed" } )
//Linear speed
panel:AddControl( "Slider", { Label = "Linear speed", Type = "Integer", Min = "0", Max = "4096", Command ="steam_speed" } )
//Particle start size
panel:AddControl( "Slider", { Label = "Particle start size", Type = "Integer", Min = "0", Max = "128", Command ="steam_startsize" } )
//Particle end size
panel:AddControl( "Slider", { Label = "Particle end size", Type = "Integer", Min = "0", Max = "128", Command ="steam_endsize" } )
//Particle spawn rate
panel:AddControl( "Slider", { Label = "Particle spawn rate", Type = "Integer", Min = "1", Max = "64", Command ="steam_rate" } )
//Particle roll speed
panel:AddControl( "Slider", { Label = "Particle roll speed", Type = "Integer", Min = "0", Max = "32", Command ="steam_rollspeed" } )
//Emissive
panel:AddControl( "CheckBox", { Label = "Emissive", Description = "", Command = "steam_emissive" } )
//Heatwave
panel:AddControl( "CheckBox", { Label = "Heatwave", Description = "", Command = "steam_heatwave" } )
//Sound
panel:AddControl( "CheckBox", { Label = "Sound", Description = "", Command = "steam_makesound" } )

//-------------
panel:AddControl( "Label", { Text = "________________________________________", Description = "" } )

//Numpad menu
panel:AddControl( "Numpad", { Label = "Start/Stop", Command = "steam_key", ButtonSize = 22 } )
//Use numpad check
panel:AddControl( "CheckBox", { Label = "Use keyboard", Description = "", Command = "steam_numpadcontrol" } )
//Toggle check
panel:AddControl( "CheckBox", { Label = "Toggle", Description = "", Command = "steam_toggle" } )

end