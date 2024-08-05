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
TOOL.Name = "Smoke - Trail"
TOOL.Command = nil
TOOL.ConfigName = ""

//Default values
TOOL.ClientConVar["color_r"] = 132
TOOL.ClientConVar["color_g"] = 132
TOOL.ClientConVar["color_b"] = 132
TOOL.ClientConVar["color_a"] = 142
TOOL.ClientConVar["spawnradius"] = 8
TOOL.ClientConVar["lifetime"] = 3
TOOL.ClientConVar["startsize"] = 32
TOOL.ClientConVar["endsize"] = 52
TOOL.ClientConVar["minspeed"] = 4
TOOL.ClientConVar["maxspeed"] = 8
TOOL.ClientConVar["mindirectedspeed"] = 0
TOOL.ClientConVar["maxdirectedspeed"] = 0
TOOL.ClientConVar["spawnrate"] = 16

//List of all spawned smoke trail entities
TOOL.Smokes = {}

//Add language descriptions
if (CLIENT) then
language.Add("Tool.smoke_trail.name", "Smoke Trail Tool")
language.Add("Tool.smoke_trail.desc", "Creates customizable smoke trails")
language.Add("Tool.smoke_trail.0", "Left-Click: Attach smoke trail  Right-Click: Remove trail")
language.Add("Cleanup_smoketrails", "Smoke Trails")
language.Add("Cleaned_smoketrail", "Cleaned up all Smoke Trails")
language.Add("SBoxLimit_smoketrails", "You've hit the Smoke Trails limit!")
language.Add("Undone_smoketrail", "Smoke Trail undone")
end

//Sandbox-related stuff
cleanup.Register("smoketrails")
CreateConVar("sbox_maxsmoketrails", 6, FCVAR_NOTIFY)


//Create smoke
function TOOL:LeftClick(trace)

//Clients don't need to know about any of this
if (CLIENT) then return true end

//Check current spawnlimits
if (!self:GetSWEP():CheckLimit("smoketrails")) then return false end

//Retreive settings
local color_r = math.Round(math.Clamp(self:GetClientNumber("color_r"), 0, 255))
local color_g = math.Round(math.Clamp(self:GetClientNumber("color_g"), 0, 255))
local color_b = math.Round(math.Clamp(self:GetClientNumber("color_b"), 0, 255))
local color_a = math.Clamp((math.Round(self:GetClientNumber("color_a")) / 255), 0, 255)
local spawnradius = math.Clamp(self:GetClientNumber("spawnradius"), 0, 128)
local lifetime = math.Clamp(self:GetClientNumber("lifetime"), 1, 16)
local startsize = math.Clamp(self:GetClientNumber("startsize"), 0, 128)
local endsize = math.Clamp(self:GetClientNumber("endsize"), 0, 128)
local minspeed = math.Clamp(self:GetClientNumber("minspeed"), 0, 128)
local maxspeed = math.Clamp(self:GetClientNumber("maxspeed"), 0, 128)
local mindirectedspeed = math.Clamp(self:GetClientNumber("mindirectedspeed"), 0, 256)
local maxdirectedspeed = math.Clamp(self:GetClientNumber("maxdirectedspeed"), 0, 256)
local spawnrate = math.Clamp(self:GetClientNumber("spawnrate"), 1, 128)

//Create smoke trail and assign settings
local smoke = ents.Create("env_smoketrail")
if !smoke || !smoke:IsValid() then return false end
smoke:SetPos(trace.HitPos)
smoke:SetKeyValue("angles", tostring(trace.HitNormal:Angle()))
smoke:SetKeyValue("emittime", "16384")
smoke:SetKeyValue("startcolor", "" .. tostring(color_r) .. " " .. tostring(color_g) .. " " .. tostring(color_b) .. "")
smoke:SetKeyValue("endcolor", "" .. tostring(color_r) .. " " .. tostring(color_g) .. " " .. tostring(color_b) .. "")
smoke:SetKeyValue("opacity", tostring(color_a))
smoke:SetKeyValue("spawnradius", tostring(spawnradius))
smoke:SetKeyValue("lifetime", tostring(lifetime))
smoke:SetKeyValue("startsize", tostring(startsize))
smoke:SetKeyValue("endsize", tostring(endsize))
smoke:SetKeyValue("minspeed", tostring(minspeed))
smoke:SetKeyValue("maxspeed", tostring(maxspeed))
smoke:SetKeyValue("mindirectedspeed", tostring(mindirectedspeed))
smoke:SetKeyValue("maxdirectedspeed", tostring(maxdirectedspeed))
smoke:SetKeyValue("spawnrate", tostring(spawnrate))

//Spawn trail
smoke:Spawn()
smoke:Activate()
if trace && trace.Entity && trace.Entity:IsValid() && trace.Entity:GetPhysicsObject():IsValid() && !trace.Entity:IsPlayer() && !trace.Entity:IsWorld() then smoke:SetParent(trace.Entity) end

//Add to relevant lists
self:GetOwner():AddCount("smoketrails", smoke)
table.insert(self.Smokes, smoke)

//Make sure we can undo
undo.Create("smoketrail")
undo.AddEntity(smoke)
undo.SetPlayer(self:GetOwner())
undo.Finish()
cleanup.Add(self:GetOwner(), "smoketrails", smoke)

return true

end


//Remove trails in radius
function TOOL:RightClick(trace)

//Clients don't need to know about any of this
if (CLIENT) then return false end

//Find smoke in radius
local findsmoke = ents.FindInSphere(trace.HitPos, 64)
for _, smoke in pairs(findsmoke) do

	//Remove
	if smoke && smoke:IsValid() && !smoke:GetPhysicsObject():IsValid() && smoke:GetClass() == "env_smoketrail" && !smoke:IsPlayer() && !smoke:IsNPC() && !smoke:IsWorld() then
	smoke:Fire("Kill", "", 0)
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
	smoke:Fire("Kill", "", 0)
	end
end

end


//Build Tool Menu
function TOOL.BuildCPanel(panel)

//Header
panel:AddControl( "Header", { Text = "#Tool.smoke_trail.name", Description = "#Tool.smoke_trail.desc" } )

//Build preset menu and declare default preset
local params = { Label = "#Presets", MenuButton = 1, Folder = "smoke_trail", Options = {}, CVars = {} }

	//Declare default preset
	params.Options.default = {
	smoke_trail_color_r 		= 132,
	smoke_trail_color_g			= 132,
	smoke_trail_color_b 		= 132,
	smoke_trail_color_a 		= 142,
	smoke_trail_spawnradius 		= 8,
	smoke_trail_lifetime 		= 3,
	smoke_trail_startsize 		= 32,
	smoke_trail_endsize 		= 52,
	smoke_trail_minspeed 		= 4,
	smoke_trail_maxspeed 		= 8,
	smoke_trail_mindirectedspeed 	= 0,
	smoke_trail_maxdirectedspeed 	= 0,
	smoke_trail_spawnrate 		= 16,
				}

	//Declare console variables
	table.insert( params.CVars, "smoke_trail_color_r" )
	table.insert( params.CVars, "smoke_trail_color_g" )
	table.insert( params.CVars, "smoke_trail_color_b" )
	table.insert( params.CVars, "smoke_trail_color_a" )
	table.insert( params.CVars, "smoke_trail_spawnradius" )
	table.insert( params.CVars, "smoke_trail_lifetime" )
	table.insert( params.CVars, "smoke_trail_startsize" )
	table.insert( params.CVars, "smoke_trail_endsize" )
	table.insert( params.CVars, "smoke_trail_minspeed" )
	table.insert( params.CVars, "smoke_trail_maxspeed" )
	table.insert( params.CVars, "smoke_trail_mindirectedspeed" )
	table.insert( params.CVars, "smoke_trail_maxdirectedspeed" )
	table.insert( params.CVars, "smoke_trail_spawnrate" )

//All done
panel:AddControl( "ComboBox", params )

//Color picker
panel:AddControl( "Color", { Label = "Smoke color", Red = "smoke_trail_color_r", Green = "smoke_trail_color_g", Blue = "smoke_trail_color_b", Alpha = "smoke_trail_color_a", ShowAlpha = "1", ShowHSV = "1", ShowRGB = "1", Multiplier = "255" } )

//Spread base
panel:AddControl( "Slider", { Label = "Spread base", Type = "Integer", Min = "0", Max = "32", Command ="smoke_trail_spawnradius" } )
//Trail length
panel:AddControl( "Slider", { Label = "Trail length", Type = "Integer", Min = "1", Max = "8", Command ="smoke_trail_lifetime" } )
//Particle start size
panel:AddControl( "Slider", { Label = "Particle start size", Type = "Integer", Min = "0", Max = "128", Command ="smoke_trail_startsize" } )
//Particle end size
panel:AddControl( "Slider", { Label = "Particle end size", Type = "Integer", Min = "0", Max = "128", Command ="smoke_trail_endsize" } )
//Minimum particle spread
panel:AddControl( "Slider", { Label = "Minimum particle spread", Type = "Integer", Min = "0", Max = "64", Command ="smoke_trail_minspeed" } )
//Maximum particle spread
panel:AddControl( "Slider", { Label = "Maximum particle spread", Type = "Integer", Min = "0", Max = "64", Command ="smoke_trail_maxspeed" } )
//Minimum directional speed
panel:AddControl( "Slider", { Label = "Minimum directional speed", Type = "Integer", Min = "0", Max = "256", Command ="smoke_trail_mindirectedspeed" } )
//Maximum directional speed
panel:AddControl( "Slider", { Label = "Maximum directional speed", Type = "Integer", Min = "0", Max = "256", Command ="smoke_trail_maxdirectedspeed" } )
//Number of particles
panel:AddControl( "Slider", { Label = "Number of particles", Type = "Integer", Min = "1", Max = "32", Command ="smoke_trail_spawnrate" } )

end