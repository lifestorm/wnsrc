--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Willard Factory"
PLUGIN.author = "Aspect™"
PLUGIN.description = "Adds various features and machinery used in workshifts."

PLUGIN.chargeIndicatorColors = {
	[0] = Color(255, 0, 0),
	[1] = Color(255, 150, 0),
	[2] = Color(255, 0, 255),
	[3] = Color(150, 0, 255),
	[4] = Color(255, 255, 0),
	[5] = Color(150, 255, 0),
	[6] = Color(0, 255, 0),
	[7] = Color(0, 0, 255),
	[8] = Color(0, 100, 255),
	[9] = Color(0, 255, 150),
	[10] = Color(0, 255, 255)
}

ix.command.Add("LinkShopTerminal", {
	description = "Link shop terminal to an actual shop.",
	arguments = {
        ix.type.text,
    },
	adminOnly = true,
	OnRun = function(self, client, shop)
		local tr = client:GetEyeTrace()
		local terminal = tr.Entity

		if !IsValid(terminal) or terminal:GetClass() != "ix_shopterminal" then
			return client:NotifyLocalized("You must look on a shop terminal!")
		end

		local successCheck = terminal:SetShop(shop)
		if successCheck then
			client:NotifyLocalized(successCheck)
		else
			client:NotifyLocalized("Success!")
		end
	end
})

ix.command.Add("SetShopTerminalSC", {
	description = "Manage shop terminal's social credits requirement.",
	arguments = {
        ix.type.number,
    },
	adminOnly = true,
	OnRun = function(self, client, sc)
		local tr = client:GetEyeTrace()
		local terminal = tr.Entity

		if !IsValid(terminal) or terminal:GetClass() != "ix_shopterminal" then
			return client:NotifyLocalized("You must look on a shop terminal!")
		end

		local successCheck = terminal:SetShopSocialCreditReq(sc)
		if successCheck then
			client:NotifyLocalized(successCheck)
		else
			client:NotifyLocalized("Success!")
		end
	end
})

ix.command.Add("SetShopTerminalCost", {
	description = "Manage shop terminal's first pay cost.",
	arguments = {
        ix.type.number,
    },
	adminOnly = true,
	OnRun = function(self, client, cost)
		local tr = client:GetEyeTrace()
		local terminal = tr.Entity

		if !IsValid(terminal) or terminal:GetClass() != "ix_shopterminal" then
			return client:NotifyLocalized("You must look on a shop terminal!")
		end

		local successCheck = terminal:SetShopCost(cost)
		if successCheck then
			client:NotifyLocalized(successCheck)
		else
			client:NotifyLocalized("Success!")
		end
	end
})

ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")
ix.util.IncludeDir(PLUGIN.folder .. "/3d2d", true)
ix.util.IncludeDir(PLUGIN.folder .. "/meta", true)
ix.util.Include("sh_fabrication_list.lua")

ix.config.Add("broadcastSound", "ambience/3d-sounds/alarms/workshiftalarm.ogg", "The sound that should play when someone broadcasts via CWU terminal.", nil, {
	category = "City Fund"
})