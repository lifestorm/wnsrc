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
	name = "Czytaj",
	tip = "unequipTip",
	icon = "icon16/tick.png",
	OnRun = function(item)
		if (item.player) then
            local skill = ix.skill:Find(item.skillCat)
            local character = item.player:GetCharacter()
            local isAddingSkills = true
            if item.player:GetCharacter():GetTotalSkillLevel() >= 121 then 
                item.player:NotifyLocalized("Osiągnąłeś limit umiejętności!")
            end
            if (item.vol) then
                if ix.books:ValidateReading(item.skillCat, item.vol, character) then
                    item.player:SetNetVar("staticAction", "Obecnie coś czyta...")
                    item.player:Freeze(true)
                    item.player.isReading = true 
                    ix.books:ProceedReading(item.skillCat, item.vol, character, item)
                end
            end
            if not isAddingSkills then
                item.player:NotifyLocalized("Wygląda na to, że informacje z książki są dla mnie bezużyteczne.")
            end
            return false
        end
	end,
	OnCanRun = function(item)
		local client = item.player
        local skill = ix.skill:Find(item.skillCat)
        if not item.skillCat or not item.vol then return item.player:NotifyLocalized("Wygląda na to, że coś jest nie tak z książką.") end
    end
}
ITEM.functions.UnRead = {
	name = "Przestań czytać",
	tip = "unequipTip",
	icon = "icon16/delete.png",
	OnRun = function(item)
		if (item.player) then
            if (item.player.isReading) then
                item.player:SetNetVar("staticAction", nil)
                item.player:Freeze(false)
                item.player.isReading = nil
            else
                return false, item.player:NotifyLocalized("Niczego nie czytam.")
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

        extendedInfo[#extendedInfo + 1] = "\nTa książka obejmuje następujące umiejętności: " .. self.skillCat
        extendedInfo[#extendedInfo + 1] = "\nDodaje PIĘĆ punktów umiejętności za każdy tom przeczytany w kolejności chronologicznej."
        extendedInfo[#extendedInfo + 1] = "\nPozostałe strony: " .. remainingPages
        if reading[self.skillCat][self.vol]["readed"] then
            extendedInfo[#extendedInfo + 1] = "\nPRZECZYTAŁEŚ JUŻ TĘ KSIĄŻKĘ."
        else
            extendedInfo[#extendedInfo + 1] = "\nNIE CZYTAŁEŚ TEJ KSIĄŻKI."
        end
    end

	return table.concat(extendedInfo, "")
end
function ITEM:GetColorAppendix()
	if self.vol then
		return {["green"] = self:GetExtendedInfo()}
	end
end