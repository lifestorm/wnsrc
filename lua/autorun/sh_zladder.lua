--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if (SERVER) then
	function SaveLadders()
		file.CreateDir("ladders");
		file.CreateDir("ladders/ladders");
		file.CreateDir("ladders/dismounts");
		local ladders = ents.FindByClass("func_useableladder");
		local buffer = {};

		for _, v in pairs(ladders) do
			if (v:GetName():lower():find("zladder") and v:GetNWBool("saved", false)) then
				local index = #buffer + 1;

				buffer[index] = {
					origin = v:GetPos(),
					angles = v:GetAngles(),
					point0 = v:GetSaveTable().point0,
					point1 = v:GetSaveTable().point1,
					propTable = v.propTable,
					model = v.model,
					normal = v.normal
				};
			end;
		end;

		if (buffer and table.Count(buffer) > 0) then
			local JSONData = util.TableToJSON(buffer);

			file.Write("ladders/ladders/" .. game.GetMap() .. ".txt", JSONData);
		else
			file.Delete("ladders/ladders/" .. game.GetMap() .. ".txt");
		end;
	end;

	function SaveDismounts()
		file.CreateDir("ladders");
		file.CreateDir("ladders/ladders");
		file.CreateDir("ladders/dismounts");
		local buffer = {};

		for k, v in pairs(ents.FindByClass("func_useableladder")) do
			if (v:GetNWBool("saved", false) and v:GetName():lower():find("zladder")) then
				for _, dismount in pairs(ents.FindInSphere(v:GetPos() + v:GetSaveTable().point0, 200)) do
					if (IsValid(dismount) and dismount:GetClass() == "info_ladder_dismount" and dismount:GetName():lower():find("zdismount") and !dismount.saved) then
						buffer[#buffer + 1] = dismount:GetPos();
						dismount.saved = true;
					end;
				end;

				for _, dismount in pairs(ents.FindInSphere(v:GetPos() + v:GetSaveTable().point1, 200)) do
					if (IsValid(dismount) and dismount:GetClass() == "info_ladder_dismount" and dismount:GetName():lower():find("zdismount") and !dismount.saved) then
						buffer[#buffer + 1] = dismount:GetPos();
						dismount.saved = true;
					end;
				end;
			end;
		end;

		for k, v in pairs(ents.FindByClass("info_ladder_dismount")) do
			v.saved = nil;
		end;

		if (buffer and table.Count(buffer) > 0) then
			local JSONData = util.TableToJSON(buffer);

			file.Write("ladders/dismounts/" .. game.GetMap() .. ".txt", JSONData);
		else
			file.Delete("ladders/dismounts/" .. game.GetMap() .. ".txt");
		end;
	end;

	function LoadLadders()
		if (!file.Exists("ladders/ladders/" .. game.GetMap() .. ".txt", "DATA")) then return; end;

		local buffer = file.Read("ladders/ladders/" .. game.GetMap() .. ".txt", false);

		if (buffer:len() > 1) then
			buffer = util.JSONToTable(buffer);

			if (!buffer) then return; end;

			for _, data in pairs(buffer) do
				if (!data.propTable) then continue; end;

				local ladder = ents.Create("func_useableladder");
				ladder:SetPos(data.origin);
				ladder:SetAngles(data.angles);
				ladder:SetKeyValue("point0", tostring(data.origin + data.point0));
				ladder:SetKeyValue("point1", tostring(data.origin + data.point1));
				ladder:SetKeyValue("targetname", "zladder_" .. ladder:EntIndex());
				ladder:Spawn();
				ladder:SetNWBool("saved", true);
				ladder.model = data.model;
				ladder.props = {};
				ladder.propTable = {};

				for _, info in pairs(data.propTable) do
					local ladderProp = ents.Create("prop_physics");
					ladderProp:SetPos(info.origin);
					ladderProp:SetAngles(info.angles);
					ladderProp:SetModel(data.model);
					ladderProp:Spawn();
					ladderProp:DeleteOnRemove(ladder);
					ladderProp:GetPhysicsObject():EnableMotion(false);
					ladderProp:PhysicsDestroy();
					ladderProp.ladder = ladder;
					ladderProp:SetNWEntity("ladder", ladder);
					ladderProp:DrawShadow(false);
					ladderProp:SetCollisionGroup(COLLISION_GROUP_WORLD);

					table.insert(ladder.propTable, {
						origin = info.origin,
						angles = info.angles
					});

					table.insert(ladder.props, ladderProp);
				end;

				ladder:CallOnRemove("cleanup", function(ladder)
					if (!ladder.props) then return; end;

					for k, v in pairs(ladder.props) do
						SafeRemoveEntity(v);
					end;
				end);

				if (!ladder.model or !ladder.propTable or !ladder.props) then
					SafeRemoveEntity(ladder);
				end;
			end;
		end;
	end;

	function LoadDismounts()
		if (!file.Exists("ladders/dismounts/" .. game.GetMap() .. ".txt", "DATA")) then return; end;

		local buffer = file.Read("ladders/dismounts/" .. game.GetMap() .. ".txt", false);

		if (buffer:len() > 1) then
			buffer = util.JSONToTable(buffer);

			if (!buffer) then return; end;

			for _, pos in pairs(buffer) do
				local dismount = ents.Create("info_ladder_dismount");

				if (!IsValid(dismount)) then continue; end;

				dismount:SetPos(pos);
				dismount:Spawn();
				dismount:SetName("zdismount_" .. dismount:EntIndex());
			end;

			for k, v in pairs(ents.FindByClass("func_useableladder")) do
				if (IsValid(v) and v:GetName():lower():find("zladder_")) then
					-- CFuncLadder::Activate, so dismount points for ladders are updated.
					v:Activate();

					for _, dismount in pairs(ents.FindInSphere(v:GetPos() + v:GetSaveTable().point0, 120)) do
						if (IsValid(dismount) and dismount:GetClass() == "info_ladder_dismount" and dismount:GetName():lower():find("zdismount") and !IsValid(dismount:GetParent())) then
							dismount:SetParent(v);
						end;
					end;

					for _, dismount in pairs(ents.FindInSphere(v:GetPos() + v:GetSaveTable().point1, 120)) do
						if (IsValid(dismount) and dismount:GetClass() == "info_ladder_dismount" and dismount:GetName():lower():find("zdismount") and !IsValid(dismount:GetParent())) then
							dismount:SetParent(v);
						end;
					end;
				end;
			end;
		end;
	end;

	timer.Create("ladder_SaveData", 180, 0, function()
		file.CreateDir("ladders");
		file.CreateDir("ladders/ladders");
		file.CreateDir("ladders/dismounts");

		SaveLadders();
		SaveDismounts();
	end);

	hook.Add("InitPostEntity", "zladder_SaveLadders", function()
		timer.Simple(5, function()
			local win, msg = pcall(LoadLadders);
			if (!win) then
				ErrorNoHalt("[LADDER TOOL] Something happened while loading ladders!")
				print(msg);
			end;

			local win, msg = pcall(LoadDismounts);
			if (!win) then
				ErrorNoHalt("[LADDER TOOL] Something happened while loading dismounts!")
				print(msg);
			end;
		end);
	end);
end;

hook.Add("FindUseEntity", "zladder", function(player, ent)
	if (IsValid(ent) and IsValid(ent.ladder)) then
		return false;
	end;
end);

properties.Add("ladder_persist", {
	MenuLabel = "Save Ladder",
	MenuIcon = "icon16/disk.png",
	Order = 1,

	Filter = function(self, ent, player)
		if (!IsValid(ent)) then return false; end;
		if (!player:IsSuperAdmin()) then return false; end;
		if (ent:GetClass() != "prop_physics") then return false; end;
		if (!IsValid(ent:GetNWEntity("ladder", nil))) then return false; end;

		return !ent:GetNWEntity("ladder", nil):GetNWBool("saved", false);
	end,

	Action = function(self, ent)
		self:MsgStart();
		net.WriteEntity(ent);
		self:MsgEnd();
	end,

	Receive = function(self, length, player)
		local ent = net.ReadEntity();

		if (!self:Filter(ent, player)) then return; end;

		ent.ladder:SetNWBool("saved", true);
		SaveLadders();
		SaveDismounts();
	end,
});

properties.Add("ladder_persist_end", {
	MenuLabel = "Un-Save Ladder",
	MenuIcon = "icon16/arrow_undo.png",
	Order = 1,

	Filter = function(self, ent, player)
		if (!IsValid(ent)) then return false; end;
		if (!player:IsSuperAdmin()) then return false; end;
		if (ent:GetClass() != "prop_physics") then return false; end;
		if (!IsValid(ent:GetNWEntity("ladder", nil))) then return false; end;

		return ent:GetNWEntity("ladder", nil):GetNWBool("saved", false);
	end,

	Action = function(self, ent)
		self:MsgStart();
		net.WriteEntity(ent);
		self:MsgEnd();
	end,

	Receive = function(self, length, player)
		local ent = net.ReadEntity();

		if (!self:Filter(ent, player)) then return; end;

		ent.ladder:SetNWBool("saved", false);
		SaveLadders();
		SaveDismounts();
	end,
});