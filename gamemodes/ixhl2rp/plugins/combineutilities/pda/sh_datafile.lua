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
PLUGIN.file = {}

ix.flag.Add("T", "Bypass PDA Transaction Logs.")

ix.config.Add("TransactionLogDaysDatafile", 14, "How many days to show transaction logs for.", nil, {
	data = {min = 1, max = 31},
	category = "Datafile"
})

ix.command.Add("SetDatafilePoints", {
	description = "Set datafile loyalty points.",
	adminOnly = true,
	arguments = {
		ix.type.character,
		ix.type.number
	},
	OnRun = function(self, client, target, amount)
		if (target) then
			local genericData = target:GetGenericdata()
			if genericData.socialCredits then
				genericData.socialCredits = !genericData.combine and math.Clamp(amount, 0, 200) or amount

				target:SetGenericdata(genericData)
				target:Save()
			end
			client:NotifyLocalized("Set "..target.player:Name().."'s points to "..amount)
		end
	end
})

ix.command.Add("Datafile", {
	description = "Open datafile as Overwatch or OTA.",
	OnCheckAccess = function(self, client)
		local faction = ix.faction.Get(client:Team())
		if (faction.alwaysDatafile or client:GetCharacter():HasFlags("U")) then
			return true
		elseif (client:HasActiveCombineSuit() and client:GetCharacter():GetInventory():HasItem("pda")) then
			return true
		end

		return false
	end,
	arguments = {
		ix.type.string
	},
	OnRun = function(self, client, text)
		if (self:OnCheckAccess(client)) then
			PLUGIN:Refresh(client, text)
		else
			client:NotifyLocalized("Nie masz dostępu do datapadu")
		end
	end
})

ix.char.RegisterVar("genericdata", {
	field = "genericdata",
	fieldType = ix.type.text,
	default = {},
	bNoDisplay = true,
	isLocal = true,
	OnSet = function(self, value)
		local client = self:GetPlayer()

		if (IsValid(client)) then
			self.vars.genericdata = value

			net.Start("ixCharacterVarChanged")
				net.WriteUInt(self:GetID(), 32)
				net.WriteString("genericdata")
				net.WriteType(self.vars.genericdata)
			net.Send(client)
		end
	end,
	OnGet = function(self, default)
		local genericdata = self.vars.genericdata

		return genericdata
	end,
	OnAdjust = function(self, client, data, value, newData)
		newData.genericdata = value
	end
})

ix.char.RegisterVar("datafilelogs", {
	field = "datafilelogs",
	fieldType = ix.type.text,
	default = {},
	bNoDisplay = true,
	bNoNetworking = true,
})

ix.char.RegisterVar("datafileviolations", {
	field = "datafileviolations",
	fieldType = ix.type.text,
	default = {},
	bNoDisplay = true,
	bNoNetworking = true,
})

ix.char.RegisterVar("datafilemedicalrecords", {
	field = "datafilemedicalrecords",
	fieldType = ix.type.text,
	default = {},
	bNoDisplay = true,
	bNoNetworking = true,
})

ix.char.RegisterVar("datapadnotes", {
	field = "datapadnotes",
	fieldType = ix.type.text,
	default = "",
	bNoDisplay = true,
	bNoNetworking = true,
	OnSet = function(self, value)
		self.vars.datapadnotes = value
	end,
	OnGet = function(self, default)
		local datapadnotes = self.vars.datapadnotes

		return datapadnotes
	end,
	OnAdjust = function(self, client, data, value, newData)
		newData.datapadnotes = value
	end
})