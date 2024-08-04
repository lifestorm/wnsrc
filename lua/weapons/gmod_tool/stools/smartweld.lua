--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

--[[
Smart Weld
Created by: Stalker (STEAM_0:1:18093014)		- Contact for support
Originally by Duncan Stead (Dunk)				- Dont contact for support
]]

TOOL.AllowedClasses = {
	prop_physics 				= true,
	prop_physics_multiplayer	= true,
	prop_ragdoll 				= true,
	prop_effect 				= true,
	prop_vehicle 				= true,
	prop_vehicle_jeep 			= true,
	prop_vehicle_airboat 		= true,
	prop_vehicle_apc 			= true,
	prop_vehicle_crane 			= true,
	prop_vehicle_prisoner_pod	= true
}

TOOL.AllowedBaseClasses = {
	base_anim 					= true,
	base_entity 				= true,
	base_gmodentity 			= true,
	base_wire_entity 			= true,	-- Wiremod
	sent_sakarias_scar_base		= true,	-- SCars
	base_rd3_entity				= true	-- Spacebuild
}

TOOL.Category 						= "Constraints"
TOOL.Name 							= "Weld - Smart"
TOOL.ClientConVar["selectradius"] 	= 100
TOOL.ClientConVar["nocollide"] 		= 1
TOOL.ClientConVar["freeze"] 		= 0
TOOL.ClientConVar["clearwelds"]		= 1
TOOL.ClientConVar["strength"] 		= 0
TOOL.ClientConVar["world"] 			= 0
TOOL.ClientConVar["maxweldsperprop"]= 10 -- Only for when you weld more than 127 props at once
TOOL.ClientConVar["color_r"] 		= 0
TOOL.ClientConVar["color_g"] 		= 255
TOOL.ClientConVar["color_b"] 		= 0
TOOL.ClientConVar["color_a"] 		= 255
TOOL.SelectedProps = {}

-- These don't exist on the server in singleplayer but we need them there.
if game.SinglePlayer() then
	NOTIFY_GENERIC = 0
	NOTIFY_ERROR = 1
	NOTIFY_UNDO = 2
	NOTIFY_HINT = 3
	NOTIFY_CLEANUP = 4
end

cleanup.Register("smartweld")

if CLIENT then
	TOOL.Information = {
		{name = "left"},
		{name = "leftuse"},
		{name = "right", stage = 2},
		{name = "rightuse", stage = 2},
		{name = "reload", stage = 2},
	}

	language.Add("tool.smartweld.name", "Weld - Smart")
	language.Add("tool.smartweld.desc", "Automatically welds selected props")

	language.Add("tool.smartweld.left", "Select or deselect a prop")
	language.Add("tool.smartweld.leftuse", "Auto-Selects the props in a set radius")
	language.Add("tool.smartweld.right", "Welds the selected props")
	language.Add("tool.smartweld.rightuse", "Welds all the props to the one you\'re looking at")
	language.Add("tool.smartweld.reload", "Clears the current selection")
	
	language.Add("tool.smartweld.selectoutsideradius", "Auto-Select Radius:")
	language.Add("tool.smartweld.selectoutsideradius.help", "The auto-select radius, anything beyond this value wont be selected.")
	language.Add("tool.smartweld.maxweldsperprop", "Max welds per prop")
	language.Add("tool.smartweld.maxweldsperprop.help", "The maximum welds per prop. This only works if you are welding more than 127 props at once. Higher than 10 not recommended, 15 maximum.")
	language.Add("tool.smartweld.strength", "Force Limit:")
	language.Add("tool.smartweld.strength.help", "The strength of the welds created. Use 0 for unbreakable welds.")
	language.Add("tool.smartweld.world", "Weld everything to world")
	language.Add("tool.smartweld.world.help", "Turning this on will weld everything to the world. Useful for making something totally immovable.")
	language.Add("tool.smartweld.nocollide", "No-collide")
	language.Add("tool.smartweld.nocollide.help", "Whether all props should no-collide each other when welded.")
	language.Add("tool.smartweld.freeze", "Auto-freeze")
	language.Add("tool.smartweld.freeze.help", "Whether all selected props should be frozen after the weld.")
	language.Add("tool.smartweld.clearwelds", "Remove old welds")
	language.Add("tool.smartweld.clearwelds.help", "If a selected prop has any welds already on it this will remove them first.")
	language.Add("tool.smartweld.color", "Selection color")
	language.Add("tool.smartweld.color.help", "Modify the selection color, it\'s useful for grouping.")
	language.Add("Undone_smartweld", "Undone Smart-Weld")
	language.Add("Cleanup_smartweld", "Smart Welds")
	language.Add("Cleaned_smartweld", "Smart-Welds Cleared")
end

function TOOL.BuildCPanel(panel)
	panel:SetName("Smart Weld")

	panel:AddControl("Header", {
		Text = "",
		Description = "Automatically welds selected props."
	})

	-- Outside Radius
	panel:AddControl("Slider", {
		Label = "#tool.smartweld.selectoutsideradius",
		Help = "#tool.smartweld.selectoutsideradius",
		Type = "float",
		Min = "0",
		Max = "1000",
		Command = "smartweld_selectradius"
	})

	-- Force Limit
	panel:AddControl("Slider", {
		Label = "#tool.smartweld.strength",
		Help = "#tool.smartweld.strength",
		Type = "float",
		Min = "0",
		Max = "10000",
		Command = "smartweld_strength"
	})

	-- Max Welds Per Prop
	panel:AddControl("Slider", {
		Label = "#tool.smartweld.maxweldsperprop",
		Help = "#tool.smartweld.maxweldsperprop",
		Type = "Integer",
		Min = "1",
		Max = "10",
		Command = "smartweld_maxweldsperprop"
	})

	-- Weld to each other or all to world
	panel:AddControl("Checkbox", {
		Label = "#tool.smartweld.world",
		Help = "#tool.smartweld.world",
		Command = "smartweld_world"
	})

	-- No-Collide Props While Welding
	panel:AddControl("Checkbox", {
		Label = "#tool.smartweld.nocollide",
		Help = "#tool.smartweld.nocollide",
		Command = "smartweld_nocollide"
	})

	-- Freeze Props When Welded
	panel:AddControl("Checkbox", {
		Label = "#tool.smartweld.freeze",
		Help = "#tool.smartweld.freeze",
		Command = "smartweld_freeze"
	})

	-- Clear Previous Welds Before Welding
	panel:AddControl("Checkbox", {
		Label = "#tool.smartweld.clearwelds",
		Help = "#tool.smartweld.clearwelds",
		Command = "smartweld_clearwelds"
	})

	-- Color
	panel:AddControl("Color", {
		Label = "#tool.smartweld.color",
		Help = "#tool.smartweld.color",
		Red = "smartweld_color_r",
		Green = "smartweld_color_g",
		Blue = "smartweld_color_b",
		Alpha = "smartweld_color_a"
	})
end

-- Micro Optimizations!
local ipairs = ipairs
local IsValid = IsValid
local Weld = constraint.Weld
local AddEntity = undo.AddEntity
local Cleanup = cleanup.Add

-- Clears selected props when you die or holster the tool.
function TOOL:Holster()
	if CLIENT or game.SinglePlayer() then
		for k, v in ipairs(self.SelectedProps) do
			if IsValid(v.ent) then
				v.ent:SetColor(v.col)
			end
		end
	end
	self.SelectedProps = {}
	self:SetStage(1)
end

-- Pretty much deselects all
function TOOL:Reload()
	if IsFirstTimePredicted() and self.SelectedProps and #self.SelectedProps > 0 then
		self:Holster()
		self:Notify("Prop Selection Cleared", NOTIFY_CLEANUP)
	end
end

-- Does some validity checks then either selects or deselects the prop.
function TOOL:LeftClick(tr)
	if IsFirstTimePredicted() and IsValid(tr.Entity) and not tr.Entity:IsPlayer() then
		if SERVER and not util.IsValidPhysicsObject(tr.Entity, tr.PhysicsBone) then
			return false 
		end

		if self:GetOwner():KeyDown(IN_USE) then
			return self:AutoSelect(tr.Entity)
		end

		return self:HandleProp(tr)
	end
	return false
end

-- Auto-selects props
function TOOL:AutoSelect(ent)
	if not IsValid(ent) then return false end
	local preAutoSelect = #self.SelectedProps

	local selectRadius = self:GetClientNumber("selectradius")
	local radiusProps = ents.FindInSphere(ent:GetPos(), selectRadius)
	if #radiusProps < 1 then return false end

	local numNearProps = 0

	for i = 1, #radiusProps do
		if self:IsAllowedEnt(ent) and not self:PropHasBeenSelected(radiusProps[i]) then
			self:SelectProp(radiusProps[i])

			numNearProps = numNearProps + 1
		end
	end

	self:Notify(#self.SelectedProps-preAutoSelect .." prop(s) have been auto-selected.", NOTIFY_GENERIC)
end

-- Decides if we should select or deselect the specified entity.
function TOOL:HandleProp(tr)
	if #self.SelectedProps == 0 then
		self:SelectProp(tr.Entity, tr.PhysicsBone)
	else
		for k, v in ipairs(self.SelectedProps) do
			if v.ent == tr.Entity then
				self:DeselectProp(tr.Entity)

				return true
			end
		end
		self:SelectProp(tr.Entity, tr.PhysicsBone)
	end

	return true
end

-- Deselects the chosen prop.
function TOOL:DeselectProp(ent)
	for k, v in ipairs(self.SelectedProps) do
		if v.ent == ent then
			if CLIENT or game.SinglePlayer() then
				ent:SetColor(v.col)
			end
			table.remove(self.SelectedProps, k)
		end
	end

	return true
end

-- Adds prop to props table and sets its color.
function TOOL:SelectProp(entity, hitBoneNum)
	if self:IsAllowedEnt(entity) then
		if #self.SelectedProps == 0 then
			self:SetStage(2)
		end

		local boneNum = entity:IsRagdoll() and hitBoneNum or 0

		table.insert(self.SelectedProps, {
			ent = entity,
			col = entity:GetColor(),
			bone = boneNum
		})

		if CLIENT or game.SinglePlayer() then
			entity:SetColor(Color(self:GetClientNumber("color_r", 0), self:GetClientNumber("color_g", 0), self:GetClientNumber("color_b", 0), self:GetClientNumber("color_a", 255)))
		end
		return true
	end
	return false
end

-- Handles the welding
function TOOL:RightClick(tr)
	if #self.SelectedProps <= 1 then
		self:Notify((#self.SelectedProps == 1 and "Select at least one more prop to weld." or "No props selected!"), NOTIFY_GENERIC)
		return false
	end

	if SERVER then
		undo.Create("smartweld")

			self:PreWeld()
			self:PerformWeld(tr)	

			undo.SetPlayer(self:GetOwner())
		undo.Finish()
	end

	self:FinishWelding(tr.Entity)
	return false
end

-- Does stuff that should happen before welding such as clearing old welds or freezing all the props.
function TOOL:PreWeld()
	local freezeProps = self:GetClientNumber("freeze")
	local removeOldWelds = self:GetClientNumber("clearwelds")

	for k, v in ipairs(self.SelectedProps) do
		if IsValid(v.ent) then
			if removeOldWelds == 1 then
				constraint.RemoveConstraints(v.ent, "Weld") 
			end

			if freezeProps == 1 then
				local physobj = v.ent:GetPhysicsObject()
				if IsValid(physobj) then
					physobj:EnableMotion(false)
					self:GetOwner():AddFrozenPhysicsObject(v.ent, physobj)
				end
			end
		end
	end
end

-- Decides what kind of weld to perform and then does it.
function TOOL:PerformWeld(tr)
	local weldToWorld = tobool(self:GetClientNumber("world"))
	local nocollide = tobool(self:GetClientNumber("nocollide"))
	local weldForceLimit = math.floor(self:GetClientNumber("strength"))
	local ply = self:GetOwner()

	if #self.SelectedProps < 2 then
		return
	end

	if weldToWorld then
		local world = game.GetWorld()
		
		for _, v in ipairs(self.SelectedProps) do
			local weld = Weld(v.ent, world, 0, 0, weldForceLimit, nocollide, false)
			AddEntity(weld)
			Cleanup(ply, "smartweld", weld)
		end
	elseif self:GetOwner():KeyDown(IN_USE) then 	-- Weld all to one
		for _, v in ipairs(self.SelectedProps) do
			local weld = Weld(v.ent, tr.Entity, v.bone, tr.PhysicsBone, weldForceLimit, nocollide, false)
			AddEntity(weld)
			Cleanup(ply, "smartweld", weld)
		end
	elseif #self.SelectedProps < 128 then
		for i = 1, #self.SelectedProps do
			local firstprop = self.SelectedProps[i]

			for k = i+1, #self.SelectedProps do
				local secondprop = self.SelectedProps[k]

				if IsValid(firstprop.ent) and IsValid(secondprop.ent) then
					local weld = Weld(firstprop.ent, secondprop.ent, firstprop.bone, secondprop.bone, weldForceLimit, nocollide, false)
					AddEntity(weld)
					Cleanup(ply, "smartweld", weld)
				end
			end
		end
	else	-- There is a source engine limit with welding more than 127 props so we have to work around it by welding to the closest props.
		local function AreLinked(prop_one, prop_two)
			return self.SelectedProps[prop_two][prop_one] == true or self.SelectedProps[prop_one][prop_two] == true
		end

		local function LinkProps(id_one, prop_one, id_two)
			local weld = Weld(prop_one.ent, self.SelectedProps[id_two].ent, 0, 0, weldForceLimit, nocollide, false)
			AddEntity(weld)
			Cleanup(ply, "smartweld", weld)

			-- This kinda makes a mess in the SelectedProps table but we clear it right after this function anyways.
			self.SelectedProps[id_one][id_two] = true
			self.SelectedProps[id_two][id_one] = true
		end

		local maxweldsperprop = math.min(self:GetClientNumber("maxweldsperprop"), 15)

		for i, v in ipairs(self.SelectedProps) do
			self.SelectedProps[i][i] = true

			for _ = 1, maxweldsperprop do
				local closestdistance = math.huge
				local closestprop_id = -1

				for j, d in ipairs(self.SelectedProps) do
					if not AreLinked(i, j) then
						local distance = (v.ent:GetPos() - d.ent:GetPos()):LengthSqr()
						if distance < closestdistance then
							closestdistance = distance
							closestprop_id = j
						end
					end
				end

				if closestprop_id ~= -1 then
					LinkProps(i, v, closestprop_id)
				end
			end
		end
	end
end

function TOOL:FinishWelding(entity)
	if CLIENT or game.SinglePlayer() then
		local numProps = 0

		for k, v in ipairs(self.SelectedProps) do
			if IsValid(v.ent) then
				v.ent:SetColor(v.col)
				numProps = numProps + 1
			end
		end

		if self:GetOwner():KeyDown(IN_USE) then	-- If they chose to weld all to one prop this will correct the count.
			if not self:PropHasBeenSelected(entity) then
				numProps = numProps + 1
			end
			self:Notify("Weld complete! ".. numProps .." props have been welded to a single prop.", NOTIFY_GENERIC)
		elseif tobool(self:GetClientNumber("world")) then
			self:Notify("Weld complete! ".. numProps .." props have been welded to the world.", NOTIFY_GENERIC)
		else
			self:Notify("Weld complete! ".. numProps .." props have been welded to each other.", NOTIFY_GENERIC)
		end
	end
	self.SelectedProps = {}
	self:SetStage(1)
end

-- Checks if a prop has already been selected.
function TOOL:PropHasBeenSelected(ent)
	for k, v in ipairs(self.SelectedProps) do
		if ent == v.ent then
			return true
		end
	end

	return false
end

-- Decides if we want to weld the entity or not.
function TOOL:IsAllowedEnt(ent)
	if IsValid(ent) then
		local ply = SERVER and self:GetOwner() or self.Owner
		local class = ent:GetClass()
		local tr = ply:GetEyeTrace()
		tr.Entity = ent

		if (not hook.Run("CanTool", ply, tr, "smartweld")) or ((not self.AllowedBaseClasses[ent.Base]) and (not self.AllowedClasses[class])) then
			return false
		end

		return true
	end
	
	return false
end

-- Puts one of those annoying notifications to the lower right of the screen.
function TOOL:Notify(text, notifyType)
	if IsFirstTimePredicted() then
		if CLIENT and IsValid(self.Owner) then
			notification.AddLegacy(text, notifyType, 5)
			surface.PlaySound("buttons/button15.wav")
		elseif game.SinglePlayer() then
			self:GetOwner():SendLua("GAMEMODE:AddNotify(\"".. text .."\", ".. tostring(notifyType) ..", 5)")	-- Because singleplayer is doodoo.
			self:GetOwner():SendLua("surface.PlaySound(\"buttons/button15.wav\")")
		end
	end
end
