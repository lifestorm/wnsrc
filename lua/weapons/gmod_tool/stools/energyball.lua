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
TOOL.Name = "Energy Ball"
TOOL.Command = nil
TOOL.ConfigName = ""

//Default values
TOOL.ClientConVar["scale"] = 2
TOOL.ClientConVar["emitparticles"] = 1
TOOL.ClientConVar["sound"] = 0
TOOL.ClientConVar["key"] = 5
TOOL.ClientConVar["numpadcontrol"] = 0
TOOL.ClientConVar["toggle"] = 0

//List of all spawned energy ball entities
TOOL.EnergyBalls = {}

//Add language descriptions
if (CLIENT) then
language.Add("Tool.energyball.name", "Energy Ball Tool")
language.Add("Tool.energyball.desc", "Creates a customizable ball of energy")
language.Add("Tool.energyball.0", "Left-Click: Create/Charge energy ball  Right-Click: Remove energy balls")
language.Add("Cleanup_energyballs", "Energy Balls")
language.Add("Cleaned_energyballs", "Cleaned up all Energy Balls")
language.Add("SBoxLimit_energyballs", "You've hit the Energy Balls limit!")
language.Add("Undone_energyball", "Energy Ball undone")
end

//Sandbox-related stuff
cleanup.Register("energyballs")
CreateConVar("sbox_maxenergyballs", 8, FCVAR_NOTIFY)


//Make an energy ball
function TOOL:LeftClick(trace)

//Clients don't need to know about any of this
if (CLIENT) then return true end

//Charge existing balls if there are any
local scale = math.Round(math.Clamp(self:GetClientNumber("scale"), .32, 15)) //Let's just retreive this here
local findenergyballs = ents.FindInSphere( trace.HitPos, scale * scale )
local success = false
for _, energyball in pairs(findenergyballs) do

	//Charge or discharge current ball
	if energyball && energyball:IsValid() && !energyball:GetPhysicsObject():IsValid() && energyball:GetClass() == "env_citadel_energy_core" && !energyball:IsPlayer() && !energyball:IsNPC() && !energyball:IsWorld() then

	local DontRunTwice = false

		//Charge
		if !energyball.Charged then
		energyball:Fire("StartCharge", "4", 0)
		energyball.Charged = true
		DontRunTwice = true
		if energyball.SFX_Sound then
		energyball.SFX_Sound:Stop()
		sound.Play( "HL1/ambience/port_suckout1.wav", trace.HitPos, 72, 100 )
		timer.Simple( 2.62, function() if energyball && energyball.SFX_Sound then energyball.SFX_Sound:Stop() energyball.SFX_Sound = CreateSound(energyball, Sound("npc/combine_gunship/dropship_onground_loop1.wav")) energyball.SFX_Sound:PlayEx(0.72, 100) end end )
		end
		end

		//Discharge
		if !DontRunTwice && energyball.Charged then
		energyball:Fire("StartDischarge", "2", 0)
		energyball.Charged = false
		if energyball.SFX_Sound then
		energyball.SFX_Sound:Stop()
		sound.Play( "HL1/ambience/port_suckin1.wav", trace.HitPos, 72, 100 )
		energyball.SFX_Sound = CreateSound(energyball, Sound("npc/combine_gunship/engine_rotor_loop1.wav"))
		energyball.SFX_Sound:PlayEx(0.62, 100)
		end
		end

	success = true

	end

end
if success then return true end //Don't spawn anything if charging

//Check current spawnlimits
if (!self:GetSWEP():CheckLimit("energyballs")) then return false end

//Retreive settings
local spawnflags = 0
if self:GetClientNumber("numpadcontrol") == 0 then spawnflags = 2 end
if math.Round(math.Clamp(self:GetClientNumber("emitparticles"), 0, 1)) == 0 then spawnflags = spawnflags + 1 end

//Create energy ball and assign settings
local energyball = ents.Create("env_citadel_energy_core")
if !energyball || !energyball:IsValid() then return false end
energyball:SetPos(trace.HitPos)
energyball:SetKeyValue("angles", tostring(trace.HitNormal:Angle()))
energyball:SetKeyValue("scale", tostring(scale))
energyball:SetKeyValue("spawnflags", tostring(spawnflags))

//Spawn energy ball
energyball:Spawn()
energyball:Activate()
energyball.Charged = false
if trace && trace.Entity && trace.Entity:IsValid() && trace.Entity:GetPhysicsObject():IsValid() && !trace.Entity:IsPlayer() && !trace.Entity:IsWorld() then energyball:SetParent(trace.Entity) end

//Emit sounds
if math.Round(math.Clamp(self:GetClientNumber("sound"), 0, 1)) == 1 then
if self:GetClientNumber("numpadcontrol") == 0 then sound.Play( "weapons/physcannon/superphys_small_zap" .. math.random(1,4) .. ".wav", trace.HitPos, 52, 100 ) end
energyball.SFX_Sound = CreateSound(energyball, Sound("npc/combine_gunship/engine_rotor_loop1.wav"))
if self:GetClientNumber("numpadcontrol") == 0 then energyball.SFX_Sound:PlayEx(0.62, 100) end
end

//Add to relevant lists
self:GetOwner():AddCount("energyballs", energyball)
table.insert(self.EnergyBalls, energyball)

//Make sure we can undo
undo.Create("energyball")
undo.AddEntity(energyball)
undo.SetPlayer(self:GetOwner())
undo.Finish()
cleanup.Add(self:GetOwner(), "energyballs", energyball)

//Make sure we can control it with numpad
if self:GetClientNumber("numpadcontrol") == 1 then
self:SetupNumpadControls(energyball)
end

return true

end


//Setup numpad controls
function TOOL:SetupNumpadControls(energyball)

//Safeguards
if !energyball || !energyball:IsValid() || self:GetClientInfo("key") == nil || self:GetClientInfo("key") == -1 then return false end

//If not toggled
if self:GetClientNumber("toggle") == 0 then

	//Create KeyDown numpad functions
	local function StartEmitPlasma(ply, energyball)
	if !energyball || !energyball:IsValid() then return end

		//Start energy discharge
		if energyball.Charged then energyball:Fire("StartCharge", "1", 0) end
		if !energyball.Charged then energyball:Fire("StartDischarge", "1", 0) end

		//Start related sounds
		if energyball.SFX_Sound then
			energyball.SFX_Sound:Stop()
			if !energyball.Charged then energyball.SFX_Sound = CreateSound(energyball, Sound("npc/combine_gunship/engine_rotor_loop1.wav")) energyball.SFX_Sound:PlayEx(0.62, 100) end
			if energyball.Charged then energyball.SFX_Sound = CreateSound(energyball, Sound("npc/combine_gunship/dropship_onground_loop1.wav")) energyball.SFX_Sound:PlayEx(0.72, 100) end
		end

	end

	//Register KeyDown functions
	numpad.Register("StartEmitPlasma", StartEmitPlasma)
	numpad.OnDown(self:GetOwner(), self:GetClientNumber("key"), "StartEmitPlasma", energyball)

	//Create KeyUp numpad functions
	local function StopEmitPlasma(ply, energyball)
	if !energyball || !energyball:IsValid() then return end

		//Stop energy discharge and related sounds
		if energyball.SFX_Sound then energyball.SFX_Sound:Stop() end
		energyball:Fire("Stop", "0.32", 0)

	end

	//Register KeyUp functions
	numpad.Register("StopEmitPlasma", StopEmitPlasma)
	numpad.OnUp(self:GetOwner(), self:GetClientNumber("key"), "StopEmitPlasma", energyball)

end

//If toggled
if self:GetClientNumber("toggle") == 1 then
	
	energyball.Toggle = false

	//Create KeyDown numpad functions
	local function ToggleEmitPlasma(ply, energyball)
	if !energyball || !energyball:IsValid() then return end

		//Start energy discharge
		if !energyball.Toggle then

			//Energy discharge
			if energyball.Charged then energyball:Fire("StartCharge", "1", 0) end
			if !energyball.Charged then energyball:Fire("StartDischarge", "1", 0) end

			//Related sounds
			if energyball.SFX_Sound then
				energyball.SFX_Sound:Stop()
				if !energyball.Charged then energyball.SFX_Sound = CreateSound(energyball, Sound("npc/combine_gunship/engine_rotor_loop1.wav")) energyball.SFX_Sound:PlayEx(0.62, 100) end
				if energyball.Charged then energyball.SFX_Sound = CreateSound(energyball, Sound("npc/combine_gunship/dropship_onground_loop1.wav")) energyball.SFX_Sound:PlayEx(0.72, 100) end
			end

		energyball.Toggle = true
		return
		end

		//Stop energy discharge and related sounds
		if energyball.Toggle then
		if energyball.SFX_Sound then sound.Play( "HL1/ambience/port_suckin1.wav", energyball:GetPos(), 62, 100 ) energyball.SFX_Sound:Stop() end
		energyball:Fire("Stop", "0.32", 0)
		energyball.Toggle = false
		return
		end

	end

	//Register KeyDown functions
	numpad.Register("ToggleEmitPlasma", ToggleEmitPlasma)
	numpad.OnDown(self:GetOwner(), self:GetClientNumber("key"), "ToggleEmitPlasma", energyball)

end

return true

end


//Remove energy balls in radius
function TOOL:RightClick(trace)

//Clients don't need to know about any of this
if (CLIENT) then return false end

//Find energy balls in radius
local scale = math.Round(math.Clamp(self:GetClientNumber("scale"), .32, 15))
local findenergyballs = ents.FindInSphere(trace.HitPos, scale * scale)
for _, energyball in pairs(findenergyballs) do

	//Remove
	if energyball && energyball:IsValid() && !energyball:GetPhysicsObject():IsValid() && energyball:GetClass() == "env_citadel_energy_core" && !energyball:IsPlayer() && !energyball:IsNPC() && !energyball:IsWorld() then
	if energyball.SFX_Sound then energyball.SFX_Sound:Stop() sound.Play( "HL1/ambience/port_suckin1.wav", energyball:GetPos(), 62, 100 ) end
	energyball:Fire("StartCharge", "2", 0)
	energyball:Fire("Kill", "", 0.21)
	end
end

end


//Remove all energy balls
function TOOL:Reload()

//Clients don't need to know about any of this
if (CLIENT) then return false end

//Get all energy balls
for x = 1, table.getn(self.EnergyBalls) do
local energyball = self.EnergyBalls[x]

	//Remove
	if energyball && energyball:IsValid() then
	if energyball.SFX_Sound then energyball.SFX_Sound:Stop() sound.Play( "HL1/ambience/port_suckin1.wav", energyball:GetPos(), 62, 100 ) end
	energyball:Fire("StartCharge", "2", 0)
	energyball:Fire("Kill", "", 0.21)
	end
end

end


//Precache all sounds
function TOOL:Precache()
util.PrecacheSound("weapons/physcannon/superphys_small_zap1.wav")
util.PrecacheSound("weapons/physcannon/superphys_small_zap2.wav")
util.PrecacheSound("weapons/physcannon/superphys_small_zap3.wav") 
util.PrecacheSound("weapons/physcannon/superphys_small_zap4.wav")
util.PrecacheSound("HL1/ambience/port_suckin1.wav")
util.PrecacheSound("npc/combine_gunship/dropship_onground_loop1.wav")
util.PrecacheSound("npc/combine_gunship/engine_rotor_loop1.wav")
end


//Build Tool Menu
function TOOL.BuildCPanel(panel)

//Header
panel:AddControl( "Header", { Text = "#Tool.energyball.name", Description = "#Tool.energyball.desc" } )
//Max delay
panel:AddControl( "Slider", { Label = "Scale", Type = "Integer", Min = "1", Max = "15", Command ="energyball_scale" } )
//Emit particles
panel:AddControl( "CheckBox", { Label = "Particles", Description = "", Command = "energyball_emitparticles" } )
//Make sounds
panel:AddControl( "CheckBox", { Label = "Sound", Description = "", Command = "energyball_sound" } )

//-------------
panel:AddControl( "Label", { Text = "________________________________________", Description = "" } )

//Numpad menu
panel:AddControl( "Numpad", { Label = "Activate/Deactive", Command = "energyball_key", ButtonSize = 22 } )
//Use numpad check
panel:AddControl( "CheckBox", { Label = "Use keyboard", Description = "", Command = "energyball_numpadcontrol" } )
//Toggle check
panel:AddControl( "CheckBox", { Label = "Toggle", Description = "", Command = "energyball_toggle" } )

end