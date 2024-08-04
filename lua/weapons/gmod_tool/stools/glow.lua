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
TOOL.Name = "Glow"
TOOL.Command = nil
TOOL.ConfigName = ""

//Default values
TOOL.ClientConVar["color_r"] = 255
TOOL.ClientConVar["color_g"] = 255
TOOL.ClientConVar["color_b"] = 255
TOOL.ClientConVar["verticalsize"] = 32
TOOL.ClientConVar["horizontalsize"] = 32
TOOL.ClientConVar["mindist"] = 16
TOOL.ClientConVar["maxdist"] = 256
TOOL.ClientConVar["outermaxdist"] = 2048
TOOL.ClientConVar["glowthrough"] = 0
TOOL.ClientConVar["toobject"] = 0

//List of all spawned glow entities
TOOL.Glows = {}

//Add language descriptions
if (CLIENT) then
language.Add("Tool.glow.name", "Glow Tool")
language.Add("Tool.glow.desc", "Creates customizable light glow")
language.Add("Tool.glow.0", "Left-Click: Create glow  Right-Click: Remove glow")
language.Add("Cleanup_glows", "Glow Effects")
language.Add("Cleaned_glows", "Cleaned up all Glow Effects")
language.Add("SBoxLimit_glows", "You've hit the Glow Effects limit!")
language.Add("Undone_glow", "Glow undone")
end

//Sandbox-related stuff
cleanup.Register("glows")
CreateConVar("sbox_maxglows", 8, FCVAR_NOTIFY)


//Create sparks
function TOOL:LeftClick(trace)

//Clients don't need to know about any of this
if (CLIENT) then return true end

//Check current spawnlimits
if (!self:GetSWEP():CheckLimit("glows")) then return false end

//Find and remove attached glows
if math.Round(math.Clamp(self:GetClientNumber("toobject"), 0, 1)) == 1 && trace.Entity && trace.Entity:IsValid() && !trace.Entity:IsPlayer() && !trace.Entity:IsWorld() && trace.Entity.Glow && trace.Entity.Glow:IsValid() then
trace.Entity.Glow:Fire("Kill", "", 0)
end

//Retreive settings
local color_r = math.Round(math.Clamp(self:GetClientNumber("color_r"), 0, 255))
local color_g = math.Round(math.Clamp(self:GetClientNumber("color_g"), 0, 255))
local color_b = math.Round(math.Clamp(self:GetClientNumber("color_b"), 0, 255))
local verticalsize = math.Round(math.Clamp(self:GetClientNumber("verticalsize"), 1, 256))
local horizontalsize = math.Round(math.Clamp(self:GetClientNumber("horizontalsize"), 1, 256))
local mindist = math.Round(math.Clamp(self:GetClientNumber("mindist"), 1, 8192))
local maxdist = math.Round(math.Clamp(self:GetClientNumber("maxdist"), 1, 8192))
local outermaxdist = math.Round(math.Clamp(self:GetClientNumber("outermaxdist"), 1, 8192))

//Original distance formula
//local mindist = maxdist / 16
//local outermaxdist = maxdist * 8

//Create glow and assign settings
local glow = ents.Create("env_lightglow")
if !glow || !glow:IsValid() then return false end
glow:SetPos(trace.HitPos)
//glow:SetAngles(self:GetOwner():GetAngles())
glow:SetKeyValue("HDRColorScale", "1")
glow:SetKeyValue("rendercolor", "" .. tostring(color_r) .. " " .. tostring(color_g) .. " " .. tostring(color_b) .. "")
glow:SetKeyValue("VerticalGlowSize", tostring(verticalsize))
glow:SetKeyValue("HorizontalGlowSize", tostring(horizontalsize))
glow:SetKeyValue("MaxDist", tostring(maxdist))
glow:SetKeyValue("MinDist", tostring(mindist))
glow:SetKeyValue("OuterMaxDist", tostring(outermaxdist))
if math.Round(math.Clamp(self:GetClientNumber("glowthrough"), 0, 1)) == 1 then glow:SetKeyValue("GlowProxySize", tostring( (verticalsize + horizontalsize) / 3 )) else glow:SetKeyValue("GlowProxySize", "0") end
//glow:SetKeyValue("spawnflags", "1")

//Center to object if told to
if math.Round(math.Clamp(self:GetClientNumber("toobject"), 0, 1)) == 1 && trace.Entity && trace.Entity:IsValid() && !trace.Entity:IsPlayer() && !trace.Entity:IsWorld() then
glow:SetPos(trace.Entity:LocalToWorld(trace.Entity:OBBCenter()))
glow:SetKeyValue("GlowProxySize", tostring(trace.Entity:BoundingRadius()))
trace.Entity.Glow = glow
end

//Spawn glow
glow:Spawn()
glow:Activate()
if trace && trace.Entity && trace.Entity:IsValid() && trace.Entity:GetPhysicsObject():IsValid() && !trace.Entity:IsPlayer() && !trace.Entity:IsWorld() then glow:SetParent(trace.Entity) end
//sound.Play( "weapons/ar2/ar2_reload_push.wav", trace.HitPos, 72, 100 )

//Add to relevant lists
self:GetOwner():AddCount("glows", glow)
table.insert(self.Glows, glow)

//Make sure we can undo
undo.Create("glow")
undo.AddEntity(glow)
undo.SetPlayer(self:GetOwner())
undo.Finish()
cleanup.Add(self:GetOwner(), "glows", glow)

return true

end


//Remove sparks in radius
function TOOL:RightClick(trace)

//Clients don't need to know about any of this
if (CLIENT) then return false end

//Find and remove attached glows
if trace.Entity && trace.Entity:IsValid() && trace.Entity.Glow && trace.Entity.Glow:IsValid() then
trace.Entity.Glow:Fire("Kill", "", 0)
end

//Find glows in radius
local findglows = ents.FindInSphere( trace.HitPos, ((math.Round(math.Clamp(self:GetClientNumber("verticalsize"), 1, 256)) + math.Round(math.Clamp(self:GetClientNumber("horizontalsize"), 1, 256)))/2) )
for _, glow in pairs(findglows) do

	//Remove
	if glow && glow:IsValid() && !glow:GetPhysicsObject():IsValid() && glow:GetClass() == "env_lightglow" && !glow:IsPlayer() && !glow:IsNPC() && !glow:IsWorld() then
	glow:Fire("Kill", "", 0)
	end
end

end


//Remove all sparks
function TOOL:Reload()

//Clients don't need to know about any of this
if (CLIENT) then return false end

//Get all glows
for x = 1, table.getn(self.Glows) do
local glow = self.Glows[x]

	//Remove
	if glow && glow:IsValid() then
	glow:Fire("Kill", "", 0)
	end
end

end


//Build Tool Menu
function TOOL.BuildCPanel(panel)

//Header
panel:AddControl( "Header", { Text = "#Tool.glow.name", Description = "#Tool.glow.desc" } )

//Build preset menu and declare default preset
local params = { Label = "#Presets", MenuButton = 1, Folder = "glow", Options = {}, CVars = {} }

	//Declare default preset
	params.Options.default = {
	glow_color_r		= 255,
	glow_color_g		= 255,
	glow_color_b		= 255,
	glow_verticalsize		= 32,
	glow_horizontalsize		= 32,
	glow_mindist		= 16,
	glow_maxdist		= 256,
	glow_outermaxdist		= 2048,
				}

	//Declare console variables
	table.insert( params.CVars, "glow_color_r" )
	table.insert( params.CVars, "glow_color_g" )
	table.insert( params.CVars, "glow_color_b" )
	table.insert( params.CVars, "glow_verticalsize" )
	table.insert( params.CVars, "glow_horizontalsize" )
	table.insert( params.CVars, "glow_mindist" )
	table.insert( params.CVars, "glow_maxdist" )
	table.insert( params.CVars, "glow_outermaxdist" )

//All done
panel:AddControl( "ComboBox", params )

//Color picker
panel:AddControl( "Color", { Label = "Glow color", Red = "glow_color_r", Green = "glow_color_g", Blue = "glow_color_b", ShowAlpha = "0", ShowHSV = "1", ShowRGB = "1", Multiplier = "255" } )
//Vertical Size
panel:AddControl( "Slider", { Label = "Vertical Size", Type = "Float", Min = "1", Max = "256", Command ="glow_verticalsize" } )
//Horizontal Size
panel:AddControl( "Slider", { Label = "Horizontal Size", Type = "Float", Min = "1", Max = "256", Command ="glow_horizontalsize" } )
//Minimum Distance Scale
panel:AddControl( "Slider", { Label = "Minimum Visibility Distance", Type = "Float", Min = "1", Max = "1024", Command ="glow_mindist" } )
//Visibility Distance Scale
panel:AddControl( "Slider", { Label = "Optimal Visibility Distance", Type = "Float", Min = "1", Max = "1024", Command ="glow_maxdist" } )
//Maximum Distance Scale
panel:AddControl( "Slider", { Label = "Maximum Visibility Distance", Type = "Float", Min = "1", Max = "1024", Command ="glow_outermaxdist" } )
//Glow through object
panel:AddControl( "CheckBox", { Label = "Glow through object", Description = "", Command = "glow_glowthrough" } )
//Center to object
panel:AddControl( "CheckBox", { Label = "Center to object", Description = "", Command = "glow_toobject" } )

end