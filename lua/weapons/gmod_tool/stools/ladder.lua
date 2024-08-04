--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile();

TOOL.Category = "Construction"
TOOL.Name = "Ladders"
TOOL.ClientConVar["laddername"] = "";
TOOL.ClientConVar["model"] = "models/props_c17/metalladder001.mdl";
TOOL.Information = {
	{name = "left", stage = 0},
	{name = "right", stage = 0},
	{name = "left_next", stage = 1, icon = "gui/lmb.png"}
};

/*
	ladderOptions is a list of approved models that can be used in the tool.
	Prevents people from using console to set the model to something that won't work.

	Parameters:
		- origin: Where is the origin of the ladder in relation to the bottom? If the ladder's :GetPos() is in the center, find the unit distance between the bottom and center.
			See the third ladder in the table.
		- height: How many units tall is this ladder?
		- ladderOffset: How many units away from the wall should the ladder entity be placed?
		- propOffset: How many units away from the wall should the ladder props be placed?
*/

local ladderOptions = {
	["models/props_c17/metalladder001.mdl"] = {
		origin = vector_origin,
		height = 127.5,
		ladderOffset = 25,
		propOffset = 2.5
	},

	["models/props_c17/metalladder002.mdl"] = {
		origin = vector_origin,
		height = 127.5,
		ladderOffset = 30
	},

	["models/props/cs_militia/ladderrung.mdl"] = {
		origin = Vector(0, 0, 63.75),
		height = 127.5,
		ladderOffset = 25
	},

	["models/props/cs_militia/ladderwood.mdl"] = {
		origin = Vector(0, 0, 74),
		height = 147,
		ladderOffset = 20,
		propOffset = 1
	},
};

cleanup.Register("ladders");
cleanup.Register("ladder_dismounts");

if (SERVER) then
	if (!ConVarExists("sbox_maxladders")) then
		CreateConVar("sbox_maxladders", 5, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Maximum number of ladders which can be created by users.");
	end;

	if (!ConVarExists("sbox_maxladder_dismounts")) then
		CreateConVar("sbox_maxladder_dismounts", 10, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Maximum number of dismount points which can be created by users. Recommended to be double the number of ladders (two for each ladder).");
	end;
end;

/*
	Helper function to get segments on a line.
*/

local function GetSegments(p1, p2, segLength, bInclusive)
	local points = {};
	local distance = p1:Distance(p2);
	local norm = (p2 - p1):GetNormalized();

	local total = math.floor(distance / segLength);
	local nextPos = p1;

	if (bInclusive) then
		table.insert(points, p1);
	end;

	for i = 1, total do
		nextPos = nextPos + norm * segLength;
		table.insert(points, nextPos);
	end;

	if (bInclusive) then
		table.insert(points, p2);
	end;

	return points;
end;

/*
	Ladder Creation
*/
do
	local dismountHull = {
		mins = Vector(-16, -16, 0),
		maxs = Vector(16, 16, 4)
	};

	function TOOL:LeftClick(trace)
		if (IsValid(trace.Entity) and trace.Entity:IsPlayer()) then return false; end;
		if (CLIENT) then return true; end;
		if (!self:GetOwner():CheckLimit("ladders")) then return false; end;

		-- If we haven't selected a first point...
		if (self:GetStage() == 0) then
			-- Retrieve the physics object of any hit entity. Made useless by previous code, but /something/ needs to go into SetObject...
			-- As well, retrieve a modified version of the surface normal. This normal is always horizontal and only rotates around the Y axis. Yay straight ladders.
			local physObj = trace.Entity:GetPhysicsObjectNum(trace.PhysicsBone);
			local normal = Angle(0, trace.HitNormal:Angle().y, 0):Forward();

			-- Clear out any junk that could possibly be left over, and store our data.
			self:ClearObjects();
			self:SetObject(1, trace.Entity, trace.HitPos, physObj, trace.PhysicsBone, normal);

			-- Move to the next stage.
			self:SetStage(1);
		else
			-- Same as before, and check how far away the ladder entity needs to be created, based on which model we're using.
			local physObj = trace.Entity:GetPhysicsObjectNum(trace.PhysicsBone);
			local normal = Angle(0, trace.HitNormal:Angle().y, 0):Forward();
			local model = self:GetClientInfo("model");

			-- If the user is being maLICIOUS and trying to use a model not on the list, default to the standard ladder.
			if (!ladderOptions[model]) then
				model = "models/props_c17/metalladder001.mdl";
			end;

			local options = ladderOptions[model];
			local offset = options.ladderOffset;

			-- Store the data of our second click.
			self:SetObject(2, trace.Entity, trace.HitPos, physObj, trace.PhysicsBone, normal);

			-- Define the top and bottom points of our func_useableladder.
			local top = self:GetPos(1) + self:GetNormal(1) * offset;
			local bottom = Vector(self:GetPos(1).x, self:GetPos(1).y, self:GetPos(2).z + 5) + self:GetNormal(1) * offset;

			-- Create a table to hold all of the created prop_physics. This is used later for undo.AddEntity, and for dismount parenting.
			-- Then, retrieve all of the segment points in a straight line from top to bottom of the ladder.
			local ladderProps = {};
			local fixOffset = options.height - options.origin.z;
			local topPos = self:GetPos(1) - Vector(0, 0, fixOffset);
			local bottomPos = Vector(self:GetPos(1).x, self:GetPos(1).y, self:GetPos(2).z) + options.origin + Vector(0, 0, 1);
			local points = GetSegments(topPos, bottomPos, options.height, true);

			-- If our bottom point manages to be higher than our top, remove it.
			if (topPos.z < bottomPos.z) then
				table.remove(points);
			end;

			-- Start our undo stack.
			undo.Create("Ladder");

			-- If a point is too close for whatever reason, remove it.
			for i = 1, #points do
				if (points[i - 1]) then
					if (points[i - 1]:Distance(points[i]) < 30) then
						table.remove(points, i);
					end;
				end;
			end;

			-- For every point in our table of segments, create a prop_physics, destroy its physics object, and add it to the undo stack.
			for k, pos in pairs(points) do
				local ladder = ents.Create("prop_physics");
				ladder:SetPos(pos + self:GetNormal(1) * (options.propOffset or 0));
				ladder:SetAngles(self:GetNormal(1):Angle());
				ladder:SetModel(model);
				ladder:Spawn();

				ladder:GetPhysicsObject():EnableMotion(false);
				ladder:PhysicsDestroy();

				table.insert(ladderProps, ladder);
				undo.AddEntity(ladder);
			end;

			-- Create the actual ladder entity.
			local ladderEnt = ents.Create("func_useableladder");
			ladderEnt:SetPos(LerpVector(0.5, top, bottom));
			ladderEnt:SetKeyValue("point0", tostring(bottom));
			ladderEnt:SetKeyValue("point1", tostring(top));

			local targetName = self:GetClientInfo("laddername");

			if (!targetName or targetName == "") then
				targetName = ladderEnt:EntIndex();
			end;

			ladderEnt:SetKeyValue("targetname", "zladder_" .. targetName);
			ladderEnt:SetParent(ladderProps[1]);
			ladderEnt:Spawn();

			ladderEnt:CallOnRemove("cleanup", function(ladder)
				if (!ladder.props) then return; end;

				for k, v in pairs(ladder.props) do
					SafeRemoveEntity(v);
				end;
			end);

			-- Store all the props on the ladder entity.
			ladderEnt.propTable = {};
			ladderEnt.props = {};
			ladderEnt.model = model;

			-- Store our normal on the ladder.
			ladderEnt.normal = self:GetNormal(1);

			-- Let our hook inside lua/autorun know that the props here have a ladder attached, so disallow +USE on them.
			for k, v in pairs(ladderProps) do
				v.ladder = ladderEnt;

				v:DrawShadow(false);
				v:SetCollisionGroup(COLLISION_GROUP_WORLD);

				table.insert(ladderEnt.propTable, {
					origin = v:GetPos(),
					angles = v:GetAngles()
				});

				table.insert(ladderEnt.props, v);

				v:SetNWEntity("ladder", ladderEnt);
			end;

			local topTrace = util.TraceHull({
				start = self:GetPos(1) - self:GetNormal(1) * 17 + Vector(0, 0, 5),
				endpos = self:GetPos(1) - self:GetNormal(1) * 17 - Vector(0, 0, 15),
				mins = dismountHull.mins,
				maxs = dismountHull.maxs,
				filter = function(ent) if (ent:IsPlayer() or ent:IsNPC()) then return false; else return true; end; end;
			});

			if (topTrace.Hit and !topTrace.AllSolid and !topTrace.StartSolid) then
				local topDismount = ents.Create("info_ladder_dismount");
				topDismount:SetPos(topTrace.HitPos);
				topDismount:Spawn();
				topDismount:SetParent(ladderEnt);
				topDismount:SetName("zdismount_" .. topDismount:EntIndex());
			end;

			local bottomTrace = util.TraceHull({
				start = bottom + self:GetNormal(1) * 34 + Vector(0, 0, 5),
				endpos = bottom + self:GetNormal(1) * 34 - Vector(0, 0, 15),
				mins = dismountHull.mins,
				maxs = dismountHull.maxs,
				filter = function(ent) if (ent:IsPlayer() or ent:IsNPC()) then return false; else return true; end; end;
			});

			if (bottomTrace.Hit and !bottomTrace.AllSolid and !bottomTrace.StartSolid) then
				local bottomDismount = ents.Create("info_ladder_dismount");
				bottomDismount:SetPos(bottomTrace.HitPos);
				bottomDismount:Spawn();
				bottomDismount:SetParent(ladderEnt);
				bottomDismount:SetName("zdismount_" .. bottomDismount:EntIndex());
			end;

			-- Push the ladder entity onto our undo stack.
			undo.AddEntity(ladderEnt);

			-- Set the undo owner, the text, and close the stack.
			undo.SetPlayer(self:GetOwner());
			undo.SetCustomUndoText("Undone Ladder");
			undo.Finish();

			-- Calling CFuncLadder::Activate will force the ladder to search for dismount points near the top and bottom.
			ladderEnt:Activate();

			-- We've finished making our ladder, so go back to stage 0, clear any objects, and add 1 to our cleanup count.
			self:SetStage(0);
			self:ClearObjects();

			self:GetOwner():AddCount("ladders", ladderEnt);
			self:GetOwner():AddCleanup("ladders", ladderEnt);
		end;

		return true;
	end;

	/*
		Dismount Placing
	*/

	function TOOL:RightClick(trace)
		if (IsValid(trace.Entity) and trace.Entity:IsPlayer()) then return false; end;
		if (self:GetStage() > 0) then return false; end;
		if (CLIENT) then return true; end;
		if (!self:GetOwner():CheckLimit("ladder_dismounts")) then return false; end;

		-- Perform a hull trace the size of a dismount spot to determine a safe place to put it. If the dismount is intersecting with ANY geometry-
		-- the engine will consider it blocked, and the player cannot use it.
		local hullTrace = util.TraceHull({
			start = trace.HitPos + trace.HitNormal * 16,
			endpos = trace.HitPos - trace.HitNormal * 10,
			mins = dismountHull.mins,
			maxs = dismountHull.maxs
		});

		if (!hullTrace.Hit) then return false; end;

		-- targetName will be the name of the ladder this dismount is going to attach to.
		local targetName = self:GetClientInfo("laddername");
		local dismount = ents.Create("info_ladder_dismount");
		dismount:SetPos(hullTrace.HitPos);
		dismount:SetKeyValue("targetname", "zdismount_" .. dismount:EntIndex());

		-- If targetName was specified, set the key value. m_target tells the engine that this dismount spot only works for ladders whose names equal this.
		if (targetName and targetName != "") then
			dismount:SetKeyValue("target", "zladder_" .. targetName);
		end;

		dismount:Spawn();

		-- Loop through all entities on the map. If it's a ladder, and it has our custom prefix, then check if its entity name is equal to our current name.
		-- If so, parent it, so that when the ladder is removed, it cleans up the dismount.
		for k, v in pairs(ents.GetAll()) do
			if (v:GetClass() == "func_useableladder" and v:GetName():find("zladder_")) then
				if (targetName and targetName != "") then
					if (v:GetName() == "zladder_" .. targetName) then
						dismount:SetParent(v);
					end;
				end;

				-- CFuncLadder::Activate, so dismount points for ladders are updated.
				v:Activate();
			end;
		end;

		-- Create our undo stack, push the dismount point, assign ownership, then finish.
		undo.Create("Ladder Dismount");
			undo.AddEntity(dismount);
			undo.SetPlayer(self:GetOwner());
			undo.SetCustomUndoText("Undone Ladder Dismount");
		undo.Finish();

		-- Add the dismount point to our cleanup count.
		self:GetOwner():AddCount("ladder_dismounts", dismount);
		self:GetOwner():AddCleanup("ladder_dismounts", dismount);

		return true;
	end;
end;

function TOOL:Think()
end

/*
	Holster
	Clear stored objects and reset state
*/

function TOOL:Holster()
	self:ClearObjects();
	self:SetStage(0);
end;

/*
	Control Panel
*/

function TOOL.BuildCPanel(CPanel)
	local modelTable = {};

	for k, v in pairs(ladderOptions) do
		modelTable[k] = {};
	end;

	CPanel:AddControl("Header", {
		Description = "#tool.ladder.desc"
	});

	CPanel:AddControl("TextBox", {
		Label = "Ladder Name",
		Command = "ladder_laddername"
	});

	CPanel:AddControl("PropSelect", {
		Label = "Select a model to use",
		ConVar = "ladder_model",
		Height = 1,
		Width = 3,
		Models = modelTable
	});

end;

/*
	Language strings
*/

if (CLIENT) then
	language.Add("tool.ladder.name", "Ladders");
	language.Add("tool.ladder.left", "Select the top point for your ladder.");
	language.Add("tool.ladder.right", "Place a dismount point.");
	language.Add("tool.ladder.left_next", "Now left click anywhere lower than your first point to determine the height.");
	language.Add("tool.ladder.desc", "Create ladders, duh.");

	language.Add("Cleaned_ladders", "Cleaned up all Ladders");
	language.Add("Cleanup_ladders", "Ladders");

	language.Add("Cleaned_ladder_dismounts", "Cleaned up all Ladder Dismounts");
	language.Add("Cleanup_ladder_dismounts", "Ladder Dismounts");
end;