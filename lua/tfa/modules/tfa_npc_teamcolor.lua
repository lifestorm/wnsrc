--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local ENTMETA = FindMetaTable("Entity")
local PLYMETA = FindMetaTable("Player")
local NPCMETA = FindMetaTable("NPC")

local IsValid = ENTMETA.IsValid

local Alive = PLYMETA.Alive
local GetActiveWeapon = PLYMETA.GetActiveWeapon
local GetAimVector = PLYMETA.GetAimVector
local GetShootPos = PLYMETA.GetShootPos

local Disposition = NPCMETA.Disposition

local util_TraceLine = util.TraceLine
local MASK_SHOT = MASK_SHOT

if SERVER then
	util.AddNetworkString("TFA_NPC_DISP")

	local NPCDispCacheSV = {}
	local function PlayerPostThink(ply)
		if not Alive(ply) then return end

		local wep = GetActiveWeapon(ply)
		if not IsValid(wep) or not wep.IsTFAWeapon then return end

		if not NPCDispCacheSV[ply] then
			NPCDispCacheSV[ply] = {}
		end

		local tr = {}
		tr.start = GetShootPos(ply)
		tr.endpos = tr.start + GetAimVector(ply) * 0xffff
		tr.filter = ply
		tr.mask = MASK_SHOT
		local targent = util_TraceLine(tr).Entity

		if IsValid(targent) and type(targent) == "NPC" then
			local disp = Disposition(targent, ply)

			if not NPCDispCacheSV[ply][targent] or NPCDispCacheSV[ply][targent] ~= disp then
				NPCDispCacheSV[ply][targent] = disp

				net.Start("TFA_NPC_DISP")
				net.WriteEntity(targent)
				net.WriteUInt(disp, 3)
				net.Send(ply)
			end
		end
	end

	hook.Add("PlayerPostThink", "TFA_NPCDispositionSync", PlayerPostThink)
else
	local NPCDispCacheSV = {}
	net.Receive("TFA_NPC_DISP", function()
		local ent = net.ReadEntity()
		local disp = net.ReadUInt(3)

		NPCDispCacheSV[ent] = disp
	end)

	function TFA.GetNPCDisposition(ent)
		return NPCDispCacheSV[ent]
	end
end