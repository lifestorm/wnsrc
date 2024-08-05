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
TOOL.Name = "Fire"
TOOL.Command = nil
TOOL.ConfigName = ""

//Default values
TOOL.ClientConVar["lifetime"] = 4
TOOL.ClientConVar["infinite"] = 0
TOOL.ClientConVar["size"] = 64
TOOL.ClientConVar["varysize"] = 0
TOOL.ClientConVar["smoke"] = 1
TOOL.ClientConVar["glow"] = 1
TOOL.ClientConVar["makesound"] = 1
TOOL.ClientConVar["drop"] = 1
TOOL.ClientConVar["key"] = 5
TOOL.ClientConVar["numpadcontrol"] = 0

//List of all spawned fire entities
TOOL.Fires = {}

//Add language descriptions
if (CLIENT) then
language.Add("Tool.fire.name", "Fire Tool")
language.Add("Tool.fire.desc", "Creates customizable fire")
language.Add("Tool.fire.0", "Left-Click: Make a fire  Right-Click: Extinguish fire")
language.Add("Cleanup_fires", "Fires")
language.Add("Cleaned_fires", "Cleaned up all Fires")
language.Add("SBoxLimit_fires", "You've hit the Fires limit!")
language.Add("Undone_fire", "Fire undone")
end

//Sandbox-related stuff
cleanup.Register("fires")
CreateConVar("sbox_maxfires", 16, FCVAR_NOTIFY)


//Make a fire
function TOOL:LeftClick(trace)

//Clients don't need to know about any of this
if (CLIENT) then return true end

//Check current spawnlimits
if (!self:GetSWEP():CheckLimit("fires")) then return false end

//Retreive settings
local spawnflags = 128 //Delete on extinguish
local lifetime = math.Round(math.Clamp(self:GetClientNumber("lifetime"), 1, 512))
local size = math.Round(math.Clamp(self:GetClientNumber("size"), 32, 128))
if math.Round(math.Clamp(self:GetClientNumber("infinite"), 0, 1)) == 1 then spawnflags = spawnflags + 1 end
if math.Round(math.Clamp(self:GetClientNumber("smoke"), 0, 1)) == 0 then spawnflags = spawnflags + 2 end
if math.Round(math.Clamp(self:GetClientNumber("glow"), 0, 1)) == 0 then spawnflags = spawnflags + 32 end
if math.Round(math.Clamp(self:GetClientNumber("drop"), 0, 1)) == 0 then spawnflags = spawnflags + 16 end

//Vary in size if enabled
if math.Round(math.Clamp(self:GetClientNumber("varysize"), 0, 1)) == 1 then
size = math.Round(math.Clamp(size + math.random(-size*0.42,size*0.42), 32, 128))
if size == 32 then size = size + math.random(0,16) end
if size == 128 then size = size - math.random(0,32) end
end

//Create fire and assign settings
local fire = ents.Create("env_fire")
if !fire || !fire:IsValid() then return false end
fire:SetPos(trace.HitPos)
fire:SetKeyValue("health", tostring(lifetime))
fire:SetKeyValue("firesize", tostring(size))
fire:SetKeyValue("fireattack", tostring(math.random(0.72,1.32)))
fire:SetKeyValue("damagescale", "-1")
fire:SetKeyValue("ignitionpoint", "1200") //Don't ignite from nearby fire
fire:SetKeyValue("spawnflags", tostring(spawnflags))

//Spawn fire
fire:Spawn()
fire:Activate()
if math.Round(math.Clamp(self:GetClientNumber("numpadcontrol"), 0, 1)) == 0 then fire:Fire("StartFire","",0) end
if trace && trace.Entity && trace.Entity:IsValid() && trace.Entity:GetPhysicsObject():IsValid() && !trace.Entity:IsPlayer() && !trace.Entity:IsWorld() then fire:SetParent(trace.Entity) end

//Make fire emit burning sounds
if math.Round(math.Clamp(self:GetClientNumber("makesound"), 0, 1)) == 1 then
if math.Round(math.Clamp(self:GetClientNumber("numpadcontrol"), 0, 1)) == 0 then sound.Play( "ambient/fire/ignite.wav", trace.HitPos, 72, 100 ) end
fire.SFX_Sound = CreateSound(fire, Sound("ambient/fire/fire_small_loop" .. math.random(1,2) .. ".wav"))
if math.Round(math.Clamp(self:GetClientNumber("numpadcontrol"), 0, 1)) == 0 then fire.SFX_Sound:PlayEx(0.82, 100) end
if math.Round(math.Clamp(self:GetClientNumber("infinite"), 0, 1)) == 0 then timer.Simple( (lifetime+1), function() if fire && fire:IsValid() then fire.SFX_Sound:Stop() end end ) end
end

//Add to relevant lists
self:GetOwner():AddCount("fires", fire)
table.insert(self.Fires, fire)

//Make sure we can undo
undo.Create("fire")
undo.AddEntity(fire)
undo.SetPlayer(self:GetOwner())
undo.Finish()
cleanup.Add(self:GetOwner(), "fires", fire)

//Make sure we can control it with numpad
if math.Round(math.Clamp(self:GetClientNumber("numpadcontrol"), 0, 1)) == 1 then
self:SetupNumpadControls(fire)
end

return true

end


//Setup numpad controls
function TOOL:SetupNumpadControls(fire)

//Safeguards
if !fire || !fire:IsValid() || self:GetClientInfo("key") == nil || self:GetClientInfo("key") == -1 then return false end

//Retrieve tool settings
local infinite = math.Round(math.Clamp(self:GetClientNumber("infinite"), 0, 1))
local lifetime = math.Round(math.Clamp(self:GetClientNumber("lifetime"), 1, 512))

	//Create KeyDown numpad functions
	local function StartEmitFire(ply, fire, infinite, lifetime)
	if fire.Started || !fire || !fire:IsValid() then return end

		//Start fire and related sounds
		if fire.SFX_Sound then fire.SFX_Sound:Stop() end
		sound.Play( "ambient/fire/ignite.wav", fire:GetPos(), 72, 100 )
		fire.SFX_Sound = CreateSound(fire, Sound("ambient/fire/fire_small_loop" .. math.random(1,2) .. ".wav"))
		if infinite == 0 then timer.Simple( (lifetime+1), function() if fire && fire:IsValid() then fire.SFX_Sound:Stop() end end ) end
		fire.SFX_Sound:PlayEx(0.82, 100)
		fire:Fire("StartFire", "", 0)

	fire.Started = true

	end

	//Register KeyDown functions
	numpad.Register("StartEmitFire", StartEmitFire)
	numpad.OnDown(self:GetOwner(), self:GetClientNumber("key"), "StartEmitFire", fire, infinite, lifetime)

return true

end


//Extinguish fire in radius
function TOOL:RightClick(trace)

//Clients don't need to know about any of this
if (CLIENT) then return false end

//Find fire in radius
local findfire = ents.FindInSphere(trace.HitPos, 42)
for _, fire in pairs(findfire) do

	//Extinguish
	if fire && fire:IsValid() && !fire:GetPhysicsObject():IsValid() && fire:GetClass() == "env_fire" && !fire:IsPlayer() && !fire:IsNPC() && !fire:IsWorld() then
	if fire.SFX_Sound then sound.Play( "ambient/levels/canals/toxic_slime_sizzle3.wav", fire:GetPos(), 68, 100 ) fire.SFX_Sound:Stop() end
	fire:Fire("Extinguish", "", 0)
	end
end

end


//Extinguish all fires
function TOOL:Reload()

//Clients don't need to know about any of this
if (CLIENT) then return false end

//Get all on-going fires
for x = 1, table.getn(self.Fires) do
local fire = self.Fires[x]

	//Extinguish
	if fire && fire:IsValid() then
	if fire.SFX_Sound then sound.Play( "ambient/levels/canals/toxic_slime_sizzle3.wav", fire:GetPos(), 64, 100 ) fire.SFX_Sound:Stop() end
	fire:Fire("Extinguish", "", 0)
	end
end

end


//Precache all sounds
function TOOL:Precache()
util.PrecacheSound("ambient/fire/ignite.wav")
util.PrecacheSound("ambient/fire/fire_small_loop1.wav")
util.PrecacheSound("ambient/fire/fire_small_loop2.wav")
util.PrecacheSound("ambient/levels/canals/toxic_slime_sizzle3.wav")
end


//Build Tool Menu
function TOOL.BuildCPanel(panel)

//Header
panel:AddControl( "Header", { Text = "#Tool.fire.name", Description = "#Tool.fire.desc" } )
//Lifetime
panel:AddControl( "Slider", { Label = "Lifetime", Type = "Integer", Min = "1", Max = "60", Command ="fire_lifetime" } )
//Infite lifetime
panel:AddControl( "CheckBox", { Label = "Infinite", Description = "Burn infinitely", Command = "fire_infinite" } )
//Size
panel:AddControl( "Slider", { Label = "Size", Type = "Integer", Min = "32", Max = "128", Command ="fire_size" } )
//Variable Size
panel:AddControl( "CheckBox", { Label = "Variable Size", Description = "", Command = "fire_varysize" } )
//----
panel:AddControl( "Label", { Text = "", Description = "" } )
//Smoke
panel:AddControl( "CheckBox", { Label = "Smoke", Description = "", Command = "fire_smoke" } )
//Glow
panel:AddControl( "CheckBox", { Label = "Glow", Description = "", Command = "fire_glow" } )
//Sound
panel:AddControl( "CheckBox", { Label = "Sound", Description = "", Command = "fire_makesound" } )
//Drop to ground
panel:AddControl( "CheckBox", { Label = "Drop to ground", Description = "", Command = "fire_drop" } )

//-------------
panel:AddControl( "Label", { Text = "________________________________________", Description = "" } )

//Numpad menu
panel:AddControl( "Numpad", { Label = "Ignite", Command = "fire_key", ButtonSize = 22 } )
//Use numpad check
panel:AddControl( "CheckBox", { Label = "Ignite with keyboard", Description = "", Command = "fire_numpadcontrol" } )

end