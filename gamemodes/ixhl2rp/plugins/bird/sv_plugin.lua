--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

util.AddNetworkString("toggleBuildingNest")
util.AddNetworkString("BirdMountRequest")
util.AddNetworkString("BirdMountAllow")
util.AddNetworkString("BirdMountDecline")
util.AddNetworkString("BirdMountTimeout")
util.AddNetworkString("birdEggHatch")

local angleLookup = {
	["models/willardnetworks/citizens/male_"] = {
		bone = "ValveBiped.Bip01_R_Trapezius",
		upOffset = 1.8,
		forwardOffset = 1.5,
		rightOffset = -1.3,
		forwardAxisRot = -110,
		rightAxisRot = -90
	},
	["models/thomask_110/male_"] = {
		bone = "ValveBiped.Bip01_R_Trapezius",
		upOffset = 1.8,
		forwardOffset = 1.5,
		rightOffset = -1.3,
		forwardAxisRot = -110,
		rightAxisRot = -90
	},
	["models/willardnetworks/citizens/female_"] = {
		bone = "ValveBiped.Bip01_R_Trapezius",
		upOffset = 0,
		forwardOffset = 0.5,
		rightOffset = 0,
		forwardAxisRot = -100,
		rightAxisRot = -90
	},
	["models/thomask_110/female_"] = {
		bone = "ValveBiped.Bip01_R_Trapezius",
		upOffset = 0,
		forwardOffset = 0.5,
		rightOffset = 0,
		forwardAxisRot = -100,
		rightAxisRot = -90
	},
	["models/wn7new/metropolice/male_"] = {
		bone = "ValveBiped.Bip01_R_Clavicle",
		upOffset = 0.8,
		forwardOffset = 1.5,
		rightOffset = 4.5,
		forwardAxisRot = -100,
		rightAxisRot = -90
	},
	["models/wn7new/metropolice/female_"] = {
		bone = "ValveBiped.Bip01_R_Clavicle",
		upOffset = 0.8,
		forwardOffset = 1.5,
		rightOffset = 4.5,
		forwardAxisRot = -100,
		rightAxisRot = -90
	},
	["models/wn7new/metropolice_c8/male_"] = {
		bone = "ValveBiped.Bip01_R_Clavicle",
		upOffset = 0.8,
		forwardOffset = 1.5,
		rightOffset = 4.5,
		forwardAxisRot = -100,
		rightAxisRot = -90
	},
	["models/wn7new/metropolice_c8/female_"] = {
		bone = "ValveBiped.Bip01_R_Clavicle",
		upOffset = 0.8,
		forwardOffset = 1.5,
		rightOffset = 4.5,
		forwardAxisRot = -100,
		rightAxisRot = -90
	},
	["models/wichacks/"] = {
		bone = "ValveBiped.Bip01_R_Clavicle",
		upOffset = 0.5,
		forwardOffset = 1.5,
		rightOffset = 4,
		forwardAxisRot = -110,
		rightAxisRot = -90
	},
	["models/models/army/female_"] = {
		bone = "ValveBiped.Bip01_R_Clavicle",
		upOffset = -0.5,
		forwardOffset = 1.5,
		rightOffset = 3.8,
		forwardAxisRot = -100,
		rightAxisRot = -90
	},
	["models/willardnetworks/vortigau"] = { -- lol
		bone = "ValveBiped.neck1",
		upOffset = 3.5,
		forwardOffset = 0,
		rightOffset = 0,
		forwardAxisRot = 90,
		rightAxisRot = 0
	}
}

function PLUGIN:BirdMountCharacter(bird, human, state)
	if (state) then
		local model = human:GetModel()
		local isConscript = string.find(model, "wichacks") -- They just HAD to NOT name them properly, didn't they?
		local modelData = isConscript and angleLookup["models/wichacks/"] or angleLookup[string.Left(model, #model - 6)]

		if (!modelData) then
			client:Notify("You cannot mount this character!")

			return
		end

		local humanPos = human:GetPos()

		bird.fakeBird = ents.Create("prop_dynamic")
		bird.fakeBird:SetModel(bird:GetModel())
		bird.fakeBird:ResetSequence("idle01")

		local boneID = human:LookupBone(modelData.bone)

		local bonePos = human:GetBonePosition(boneID)

		if (bonePos == humanPos) then
			bonePos = human:GetBoneMatrix(boneID):GetTranslation()
		end

		bird.fakeBird:FollowBone(human, boneID)
		bird.fakeBird:SetPos(bonePos + human:GetUp() * modelData.upOffset + human:GetForward() * modelData.forwardOffset + human:GetRight() * modelData.rightOffset)

		local humanAngles = human:GetAngles()
		humanAngles:RotateAroundAxis(human:GetForward(), modelData.forwardAxisRot)
		humanAngles:RotateAroundAxis(human:GetRight(), modelData.rightAxisRot)
		bird.fakeBird:SetAngles(humanAngles)

		bird:StripWeapons()
		bird:SetMoveType(MOVETYPE_OBSERVER)
		bird:SetNoDraw(true)
		bird:SetNotSolid(true)
		bird:Spectate(OBS_MODE_CHASE)
		bird:SpectateEntity(human)

		bird:SetNetVar("ixBirdMounting", human)
		human:SetNetVar("ixBirdMounted", bird)

		local timerName = "ixBirdPosFix_" .. bird:SteamID()
		timer.Create(timerName, 5, 0, function() -- I don't like this, but helix does it for ragdolls, so, meh.
			if (IsValid(human) and IsValid(bird)) then
				bird:SetPos(human:GetPos())
			else
				timer.Remove(timerName)
			end
		end)
	else
		bird:SetMoveType(MOVETYPE_WALK)
		bird:SetNoDraw(false)
		bird:SetNotSolid(false)
		bird:Spectate(OBS_MODE_NONE)
		bird:UnSpectate()

		if (human and IsValid(human)) then
			human:SetNetVar("ixBirdMounted", false)
		end

		bird:SetNetVar("ixBirdMounting", false)

		local timerName = "ixBirdPosFix_" .. bird:SteamID()

		if (timer.Exists(timerName)) then
			timer.Remove(timerName)
		end

		local fakeBird = bird.fakeBird

		if (fakeBird and IsValid(fakeBird)) then
			bird:SetPos(fakeBird:GetPos() + Vector(0, 0, 15))

			fakeBird:Remove()
			bird.fakeBird = nil
		end
	end
end

net.Receive("BirdMountAllow", function(_, client)
	local requester = client.ixBirdMountRequester

	if (!IsValid(requester)) then return end

	PLUGIN:BirdMountCharacter(requester, client, true)
	client.ixBirdMountRequester = nil
end)

net.Receive("BirdMountDecline", function(_, client)
	local requester = client.ixBirdMountRequester

	if (!IsValid(requester)) then return end

	requester:Notify(hook.Run("GetCharacterName", client, "ic") or client:GetName() .. " declined your mount request.")
	client.ixBirdMountRequester = nil
end)

net.Receive("BirdMountTimeout", function(_, client)
	local requester = client.ixBirdMountRequester

	if (!IsValid(requester)) then return end

	requester:Notify(hook.Run("GetCharacterName", client, "ic") or client:GetName() .. " did not respond to your mount request.")
	client.ixBirdMountRequester = nil
end)

net.Receive("birdEggHatch", function(_, client)
	if (client:Team() != FACTION_BIRD) then return end

	local egg = client:GetCharacter():GetInventory():HasItem("birdegg")

	local receiver = net.ReadEntity()

	if (!egg or !receiver:IsPlayer()) then return end

	if (client == receiver) then
		client:Notify("You cannot target yourself!")

		return
	end

	local receiverWhitelists = receiver:GetData("whitelists", {})

	if (receiverWhitelists[FACTION_BIRD]) then
		client:Notify("This player already has a bird whitelist!")

		return
	end

	local payload = {
		canread = true,
		description = "A regular bird surviving on scrap and food.",
		faction = "bird",
		gender = "female",
		glasses = false,
		model = client:GetModel(),
		name = "Bird #" .. math.random(111, 999),
		steamID = receiver:SteamID64()
	}

	ix.char.Create(payload, function(id)
		if (IsValid(receiver)) then
			ix.char.loaded[id]:SetData("babyBird", os.time() + 86400) -- 24 hours
			ix.char.loaded[id]:SetData("pos", {client:GetPos(), client:EyeAngles(), game.GetMap()})
			ix.char.loaded[id]:Sync(receiver)

			net.Start("ixCharacterAuthed")
			net.WriteUInt(id, 32)
			net.WriteUInt(#receiver.ixCharList, 6)

			for _, v in ipairs(receiver.ixCharList) do
				net.WriteUInt(v, 32)
			end

			net.Send(receiver)

			egg:Remove()

			receiver:Notify(client:SteamName() .. " has selected you to receive a single-life bird whitelist. A character has automatically been created for you.")
			MsgN("Created bird character '" .. id .. "' for " .. receiver:SteamName() .. ".")
			hook.Run("OnCharacterCreated", receiver, ix.char.loaded[id])
		end
	end)
end)
