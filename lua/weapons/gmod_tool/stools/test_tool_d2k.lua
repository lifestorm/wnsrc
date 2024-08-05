--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if game.SinglePlayer || !game.SinglePlayer() then TOOL.AddToMenu = false return end //Example file, don't run it

//Generic entity spawning script used for testing whether they work or not

TOOL.AddToMenu = false //We're not testing anything right now

TOOL.Category = "Effects"
TOOL.Name = "TESTING"
TOOL.Command = nil
TOOL.ConfigName = ""

//Add language descriptions
if (CLIENT) then
language.Add("Tool.test.name", "Testing Tool")
language.Add("Tool.test.desc", "Creates random stuff")
language.Add("Tool.test.0", "Left-Click: Make something")
language.Add("Cleanup_test", "Test Entities")
language.Add("Cleaned_test", "Cleaned up all Test Entities")
language.Add("Undone_test", "Test Entity undone")
end

//Sandbox-related stuff
cleanup.Register("test")


//Make a test entity
function TOOL:LeftClick(trace)

//Clients don't need to know about any of this
if (CLIENT) then return true end

//Create entity and assign settings
local entity = ents.Create("env_smoketrail")
if !entity || !entity:IsValid() then return false end
entity:SetPos(trace.HitPos)
entity:SetKeyValue("angles", tostring(trace.HitNormal:Angle()))
entity:SetKeyValue("opacity", "0.52") //Float
entity:SetKeyValue("spawnrate", "16") //Float
entity:SetKeyValue("lifetime", "2") //Float
entity:SetKeyValue("startcolor", "255 255 255")
entity:SetKeyValue("endcolor", "255 255 255")
entity:SetKeyValue("emittime", "16384") //Float
entity:SetKeyValue("minspeed", "4") //Float
entity:SetKeyValue("maxspeed", "16") //Float
entity:SetKeyValue("mindirectedspeed", "16") //Float
entity:SetKeyValue("maxdirectedspeed", "64") //Float
entity:SetKeyValue("startsize", "32") //Float
entity:SetKeyValue("endsize", "100") //Float
entity:SetKeyValue("spawnradius", "16") //Float
entity:SetKeyValue("firesprite", "effects/muzzleflash2")
entity:SetKeyValue("smokesprite", "particle/smokesprites_0001.vmt")

//Spawn it
entity:Spawn()
entity:Activate()
//entity:Fire("Start","",0)
//entity:Fire("TurnOn","",0)

//Parent if needed
if trace && trace.Entity && trace.Entity:IsValid() && trace.Entity:GetPhysicsObject():IsValid() && !trace.Entity:IsPlayer() && !trace.Entity:IsWorld() then entity:SetParent(trace.Entity) end

//Make sure we can undo
undo.Create("Test")
undo.AddEntity(entity)
undo.SetPlayer(self:GetOwner())
undo.Finish()
cleanup.Add(self:GetOwner(), "Test", entity)

return true

end


//Build Tool Menu
function TOOL.BuildCPanel(panel)
panel:AddControl( "Header", { Text = "#Tool.test.name", Description = "#Tool.test.desc" } )
end