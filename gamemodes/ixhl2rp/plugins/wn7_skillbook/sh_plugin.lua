--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

PLUGIN.name = "Skill books"
PLUGIN.author = "Naast"
PLUGIN.description = "Adds the book thing into WN, yeah."

ix.books = ix.books or {}

ix.char.RegisterVar("reading", {
	field = "reading",
    fieldType = ix.type.text,
	default = {
        ["medicine"] = {
            [1] = {readed = false, pages = 60}, 
            [2] = {readed = false, pages = 50},
            [3] = {readed = false, pages = 75},
            [4] = {readed = false, pages = 45},
            [5] = {readed = false, pages = 70}
        },
        ["crafting"] = {
            [1] = {readed = false, pages = 45},
            [2] = {readed = false, pages = 60},
            [3] = {readed = false, pages = 64},
            [4] = {readed = false, pages = 67},
            [5] = {readed = false, pages = 150}
        },
        ["cooking"] = {
            [1] = {readed = false, pages = 20},
            [2] = {readed = false, pages = 50},
            [3] = {readed = false, pages = 100},
            [4] = {readed = false, pages = 80},
            [5] = {readed = false, pages = 90}
        },
        ["contraband"] = {
            [1] = {readed = false, pages = 120},
            [2] = {readed = false, pages = 120},
            [3] = {readed = false, pages = 120},
            [4] = {readed = false, pages = 120},
            [5] = {readed = false, pages = 120}
        },
        ["guns"] = {
            [1] = {readed = false, pages = 100},
            [2] = {readed = false, pages = 45},
            [3] = {readed = false, pages = 60},
            [4] = {readed = false, pages = 35},
            [5] = {readed = false, pages = 24}
        }
    },
	bNoDisplay = true
})

function ix.books:ValidateReading(skill, vol, character)
    local readTbl = character:GetReading()
    if not readTbl[skill] then return false, character:GetPlayer():NotifyLocalized("There is no skill for this guide.") end 
    if readTbl[skill][vol].readed then return false, character:GetPlayer():NotifyLocalized("I already read this book.") end 
    if not readTbl[skill][vol].readed then  
        local curVol = vol
        local lastVol = vol - 1
        if lastVol != 0 then 
            for k, v in ipairs(readTbl[skill]) do   
                if k < curVol and not v.readed then 
                    return false, character:GetPlayer():NotifyLocalized("I don't get anything... I need to read the previous volume.")
                end 
                if k > curVol then 
                    break 
                end
            end 
        end
    end
    if readTbl then 
        return true 
    end
end
function ix.books:ProceedReading(skill, vol, character, item)
    local skillVar = ix.skill:Find(skill)
    local readTbl = character:GetReading()
	local uniqueID = "CheckIfStillReading_" .. character:GetPlayer():SteamID64()
    character:GetPlayer():SetAction("You are reading a book.", readTbl[skill][vol]["pages"], function()
        readTbl[skill][vol].readed = true
        character:SetReading(readTbl)
        character:AddSkillLevel(skillVar.uniqueID, 5)
        character:GetPlayer():Freeze(false)
        character:GetPlayer():SetNetVar("staticAction", nil)
        character:GetPlayer().isReading = nil
        timer.Remove(uniqueID)
        item:Remove()
    
    end)
	timer.Create(uniqueID, 1, 0, function()
		if (IsValid(character:GetPlayer()) and character:GetPlayer().isReading) then	
            readTbl[skill][vol]["pages"] = readTbl[skill][vol]["pages"] - 1
            character:SetReading(readTbl)
        else			
			timer.Remove(uniqueID)
            character:GetPlayer():Freeze(false)
            character:GetPlayer():SetAction(false)
        end
	end)
end