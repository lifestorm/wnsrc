--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Skill Book"
ITEM.model = Model("models/props_c17/BriefCase001a.mdl")
ITEM.description = "Uhh thats the skill book thing yeah."
ITEM.functions.Read = { 
	name = "Read",
	tip = "unequipTip",
	icon = "icon16/tick.png",
	OnRun = function(item)
		if (item.player) then
            local skill = ix.skill:Find(item.skillCat)
            local character = item.player:GetCharacter()
            local isAddingSkills = true
            if item.player:GetCharacter():GetTotalSkillLevel() >= 121 then 
                item.player:NotifyLocalized("You have reached the limit of skills!")
            end
            if (item.vol) then
                if ix.books:ValidateReading(item.skillCat, item.vol, character) then
                    item.player:SetNetVar("staticAction", "Is currently reading something...")
                    item.player:Freeze(true)
                    item.player.isReading = true 
                    ix.books:ProceedReading(item.skillCat, item.vol, character, item)
                end
            end
            if not isAddingSkills then
                item.player:NotifyLocalized("It seems that the information from the book is of no use to me.")           
            end
            return false
        end
	end,
	OnCanRun = function(item)
		local client = item.player
        local skill = ix.skill:Find(item.skillCat)
        if not item.skillCat or not item.vol then return item.player:NotifyLocalized("Looks like there's something wrong with the book.") end
    end
}
ITEM.functions.UnRead = {
	name = "Stop Reading",
	tip = "unequipTip",
	icon = "icon16/delete.png",
	OnRun = function(item)
		if (item.player) then
            if (item.player.isReading) then
                item.player:SetNetVar("staticAction", nil)
                item.player:Freeze(false)
                item.player.isReading = nil
            else
                return false, item.player:NotifyLocalized("I don't read anything.")
            end
            return false
        end
	end
}

function ITEM:GetExtendedInfo()
	local extendedInfo = {}
    if (self.vol) then

        if self.vol == 1 then
            extendedInfo[#extendedInfo + 1] = "\nVolume: " .. self.vol .. "st" 
        elseif self.vol == 2 then
            extendedInfo[#extendedInfo + 1] = "\nVolume: " .. self.vol .. "nd"
        elseif self.vol == 3 then
            extendedInfo[#extendedInfo + 1] = "\nVolume: " .. self.vol .. "rd"
        else
            extendedInfo[#extendedInfo + 1] = "\nVolume: " .. self.vol .. "th"
        end

        local reading = LocalPlayer():GetCharacter():GetReading()
        local remainingPages -- With this we avoid the --190 pages left
        if reading[self.skillCat][self.vol]["readed"] then
            remainingPages = 0
        else
            remainingPages = reading[self.skillCat][self.vol]["pages"]
        end

        extendedInfo[#extendedInfo + 1] = "\nThis book covers the following skill: " .. self.skillCat
        extendedInfo[#extendedInfo + 1] = "\nAdds FIVE skill points for each volume read in chronological order."
        extendedInfo[#extendedInfo + 1] = "\nPages left: " .. remainingPages
        if reading[self.skillCat][self.vol]["readed"] then
            extendedInfo[#extendedInfo + 1] = "\nYOU HAVE ALREADY READ THIS BOOK."
        else
            extendedInfo[#extendedInfo + 1] = "\nYOU HAVE NOT READ THIS BOOK."
        end
    end

	return table.concat(extendedInfo, "")
end
function ITEM:GetColorAppendix()
	if self.vol then
		return {["green"] = self:GetExtendedInfo()}
	end
end