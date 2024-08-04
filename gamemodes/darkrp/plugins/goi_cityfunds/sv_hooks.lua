--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

function PLUGIN:SaveData()
	if timer.Exists("ixCityFund") then
		ix.data.Set("cityFundTimer", timer.TimeLeft("ixCityFund"))
	end
	ix.factionBudget:SaveBudgets()
end

function PLUGIN:LoadData()
	ix.factionBudget:LoadBudgets()
end

function PLUGIN:InitPostEntity()
	self:SetupProductionTimer()
end