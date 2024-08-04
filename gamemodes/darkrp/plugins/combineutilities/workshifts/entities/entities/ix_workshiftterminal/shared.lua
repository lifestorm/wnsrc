--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ENT.Type = "anim"
ENT.PrintName		= "Poste de Travail"
ENT.Base = "ix_terminal"
ENT.Author			= "Fruity"
ENT.Contact			= "Willard Networks"
ENT.Purpose			= "Start and stop workshifts via an entity."
ENT.Instructions	= "Appuyez sur E pour entrer votre CID. Appuyez sur le bouton pour pour démarrer ou stopper."
ENT.Category = "HL2 RP"

ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true
ENT.model = "models/willard/combine/checkin.mdl"
ENT.workshiftStarted = false
ENT.participants = {}

ENT.Displays = {
	[1] = {"EN ATTENTE DE CID", Color( 255, 255, 180 ), true},
	[2] = {"VÉRIFICATION", Color(255, 200, 0)},
	[3] = {"DÉBUT DU TRAVAIL", Color(0, 255, 0)},
	[4] = {"RECHARGEMENT", Color(255, 200, 0)},
	[5] = {"HORS-LIGNE", Color(255, 0, 0), true},
	[6] = {"SUCCÈS", Color( 0, 255, 180 )},
	[7] = {"FIN DU TRAVAIL", Color(255, 0, 0)},
	[8] = {"AUCUNE INFO.", Color(0, 255, 0)},
	[9] = {"POSTE INACTIF", Color(255, 0, 0)},
	[10] = {"DÉJÀ PARTICIPÉ", Color(255, 0, 0)},
	[11] = {"INSCRIPTION INTERROMPUE", Color(255, 0, 0)}
}

ENT.buttons = {}

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Display")
end

function ENT:GetNearestButton(client)
	client = client or (CLIENT and LocalPlayer())

	if (self.buttons) then
		if (SERVER) then
			local position = self:GetPos()
			local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()

			self.buttons[1] = position + f*-5.6 + r*5.6 + u*46
		end

		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local trace = util.TraceLine(data)
		local hitPos = trace.HitPos

		if (hitPos) then
			for k, v in pairs(self.buttons) do
				if (v:Distance(hitPos) <= 2) then
					return k
				end
			end
		end
	end
end