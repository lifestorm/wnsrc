--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if !game.SinglePlayer() then TOOL.AddToMenu = false return end //Not available in Multiplayer

TOOL.Category = "Effects"
TOOL.Name = "Starfield"
TOOL.Command = nil
TOOL.ConfigName = ""

//Default values
TOOL.ClientConVar["magnitude"] = 4

//Add language descriptions
if (CLIENT) then
language.Add("Tool.starfield.name", "Starfield Tool")
language.Add("Tool.starfield.desc", "Creates a starfield effect")
language.Add("Tool.starfield.0", "Left-Click: Update starfield layer  Right-Click: Remove effect")
language.Add("Cleanup_starfields", "Starfield Effects")
language.Add("Cleaned_starfields", "Cleaned up all Starfield Effects")
language.Add("Undone_starfield", "Starfield Effect undone")
end

//Sandbox-related stuff
cleanup.Register("starfields")

//Add starfield layer
function TOOL:LeftClick(trace)

//Only serverside now
if (CLIENT) then return false end

//Get all entities on the level
for _, fire in pairs(ents.GetAll()) do

	//Kill all starfields
	if fire && fire:IsValid() && !fire:GetPhysicsObject():IsValid() && fire:GetClass() == "env_starfield" && !fire:IsPlayer() && !fire:IsNPC() && !fire:IsWorld() then
	fire:Fire("Kill", "", 0)
	end

end

//Retreive settings
local magnitude = math.Clamp(self:GetClientNumber("magnitude"), 1, 128)

//Create effect layer and assign settings
local starfield = ents.Create("env_starfield")
if !starfield || !starfield:IsValid() then return false end
starfield:SetPos(self:GetOwner():GetPos())
//starfield:SetParent(self:GetOwner())

//Spawn effect
starfield:Spawn()
starfield:Activate()
starfield:Fire("SetDensity", tostring(magnitude), 0)
starfield:Fire("TurnOn", "", 0)

//Make sure we can undo
undo.Create("starfield")
undo.AddEntity(starfield)
undo.SetPlayer(self:GetOwner())
undo.Finish()
cleanup.Add(self:GetOwner(), "starfields", starfield)

return false

end


//Extinguish fire in radius
function TOOL:RightClick(trace)

//Only serverside now
if (CLIENT) then return false end

//Get all entities on the level
for _, fire in pairs(ents.GetAll()) do

	//Kill all starfields
	if fire && fire:IsValid() && !fire:GetPhysicsObject():IsValid() && fire:GetClass() == "env_starfield" && !fire:IsPlayer() && !fire:IsNPC() && !fire:IsWorld() then
	fire:Fire("Kill", "", 0)
	end

end

end

//Build Tool Menu
function TOOL.BuildCPanel(panel)

//Header
panel:AddControl( "Header", { Text = "#Tool.starfield.name", Description = "#Tool.starfield.desc" } )

//Magnitude
panel:AddControl( "Slider", { Label = "Magnitude", Type = "Integer", Min = "1", Max = "128", Command ="starfield_magnitude" } )

end