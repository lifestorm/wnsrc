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

PLUGIN.quizlist = PLUGIN.quizlist or {}

function PLUGIN:DatabaseConnected()
    local query = mysql:Create("ix_storedquiz")
    query:Create("quiz_id", "INT(11) UNSIGNED NOT NULL AUTO_INCREMENT")
    query:Create("quiz_question", "TEXT")
	query:Create("quiz_answers", "TEXT")
	query:Create("quiz_permanent", "TEXT")
    query:PrimaryKey("quiz_id")
	query:Callback(function()
		local quizQuery = mysql:Select("ix_storedquiz")
		quizQuery:Callback(function(quizResult)
			if (!istable(quizResult) or #quizResult == 0) then
				return
			end

			for _, v in ipairs(quizResult) do
				self.quizlist[tonumber(v["quiz_id"])] = {v["quiz_question"], util.JSONToTable(v["quiz_answers"]), v["quiz_permanent"]}
			end
		end)

		quizQuery:Execute()
	end)
    query:Execute()
end

function PLUGIN:RandomQuizzes(client, newQuizList)
	-- Thanks Gr4Ss
	client.sentQuizIDs = {}

	local keys = {}
	local quiz = {}
	for k, v in pairs(newQuizList) do
		if (v[3] == true) then
			quiz[#quiz + 1] = v
			client.sentQuizIDs[#quiz] = k
		else
			keys[#keys + 1] = k
		end
	end

	while (#quiz < 6 and #keys > 0) do
		local winner = math.random(#keys)
		quiz[#quiz + 1] = newQuizList[keys[winner]]
		client.sentQuizIDs[#quiz] = keys[winner]
		table.remove(keys, winner)
	end

	netstream.Start(client, "SyncQuiz", quiz)
end

function PLUGIN:ReplyQuizzes(client, bAdmin)
	if (bAdmin) then
		if (client:IsAdmin()) then
			self:SyncFullQuizList(client)
		else
			ix.log.Add(client, "luaHack", "access the full quizlist without admin")
			client:Kick("You're not an admin ruski.")
		end

		return false
	end

    local newQuizList = {}
    for oldKey, tQuestion in pairs(self.quizlist) do
        newQuizList[oldKey] = {tQuestion[1], {}, tQuestion[3]}

        for answer, _ in pairs(tQuestion[2]) do
            newQuizList[oldKey][2][#newQuizList[oldKey][2] + 1] = answer
        end
    end

    self:RandomQuizzes(client, newQuizList)
end

function PLUGIN:SyncFullQuizList(client)
	netstream.Start(client, "SyncQuiz", self.quizlist)
end

netstream.Hook("RequestQuizzes", function(client, bAdmin)
	PLUGIN:ReplyQuizzes(client, bAdmin)
end)

function PLUGIN:AddQuiz(client, question, answers, bPermanent)
	if (!client:IsAdmin()) then
		ix.log.Add(client, "luaHack", "access QuizAdd")
		client:Kick("You're not an admin ruski.")
		return false
	end

	PLUGIN.quizlist[#PLUGIN.quizlist + 1] = {question, answers, bPermanent}

    local queryAdd = mysql:Insert("ix_storedquiz")
		queryAdd:Insert("quiz_question", question)
		queryAdd:Insert("quiz_answers", util.TableToJSON(answers))
		queryAdd:Insert("quiz_permanent", bPermanent)
    queryAdd:Execute()

	self:SyncFullQuizList(client)
end

function PLUGIN:RemoveQuiz(client, id)
	if (!client:IsAdmin()) then
		ix.log.Add(client, "luaHack", "access QuizRemove")
		client:Kick("You're not an admin ruski.")
		return false
	end

	PLUGIN.quizlist[id] = nil

    local queryDelete = mysql:Delete("ix_storedquiz")
        queryDelete:Where("quiz_id", id)
    queryDelete:Execute()

	self:SyncFullQuizList(client)
end

function PLUGIN:EditQuiz(client, id, question, answers, bPermanent)
	if !client:IsAdmin() then
		ix.log.Add(client, "luaHack", "access QuizEdit")
		client:Kick("You're not an admin ruski.")
		return false
	end

	PLUGIN.quizlist[id] = {question, answers, bPermanent}

    local queryEdit = mysql:Update("ix_storedquiz")
        queryEdit:Where("quiz_id", id)
        queryEdit:Update("quiz_question", question)
		queryEdit:Update("quiz_answers", util.TableToJSON(answers))
		queryEdit:Update("quiz_permanent", bPermanent)
    queryEdit:Execute()

	self:SyncFullQuizList(client)
end

function PLUGIN:CheckIfAnswersAreRight(client, answers)
    if !client.sentQuizIDs then return false end

    for sendID, actualAnswer in pairs(answers) do
        local realID = client.sentQuizIDs[sendID]
        if (!realID) then
            ix.log.Add(client, "luaHack", "change what quiz questions are being asked")
            return false
        end

        local question = self.quizlist[realID]
		local bAnswerFound = false
		if question then
			for answer, bRightAnswer in pairs(question[2]) do
				if (answer == actualAnswer) then
					if (bRightAnswer != true) then
						return false
					else
						bAnswerFound = true
						break
					end
				end
			end
		end

        if (!bAnswerFound) then return false end
    end

    return true
end

function PLUGIN:AnswersMissing(client, answers)
	if (!client.sentQuizIDs) then
		return true
	end

	if (table.Count(answers) != #client.sentQuizIDs) then
		return true
	end

	return false
end

function PLUGIN:CanPlayerCreateCharacter(client)
	if (!client:GetData("QuizCompleted", false)) then
		ix.log.Add(client, "luaHack", "bypass character creation quiz check")
		return false, "Nice try ruski"
	end
end

function PLUGIN:CompleteQuiz(client, answers)
	if (self:AnswersMissing(client, answers)) then
		netstream.Start(client, "SendCharacterPanelNotify", "You are still missing answering some questions!")
		return false
	end

	if (!self:CheckIfAnswersAreRight(client, answers)) then
		local quizAttempts = client:GetNetVar("quizAttempts", 3)

		if (quizAttempts > 1) then
			local remainingAttempts = quizAttempts - 1
			local notification = string.format("One or more of your answers were incorrect. Please read the rules and guidelines and try again. You have %d attempt%s left.", remainingAttempts, remainingAttempts > 1 and "s" or "")
			netstream.Start(client, "SendCharacterPanelNotify", notification)

			client:SetNetVar("quizAttempts", remainingAttempts)
		else
			client:Kick("Unfortunately you did not answer correctly. Please read the rules and guidelines at https://willard.network/forums/ and try again")
		end

		return false
	end

	client:SetData("QuizCompleted", true)
	client.sentQuizIDs = nil
	netstream.Start(client, "SendCharacterPanelNotify", "Success, you've answered correctly and can now create a character!")
	netstream.Start(client, "RemoveQuizUI")
end

-- Hooks
netstream.Hook("AddQuiz", function(client, question, answers, bPermanent)
	PLUGIN:AddQuiz(client, question, answers, bPermanent)
end)

netstream.Hook("RemoveQuiz", function(client, id)
	PLUGIN:RemoveQuiz(client, id)
end)

netstream.Hook("EditQuiz", function(client, id, question, answers, bPermanent)
	PLUGIN:EditQuiz(client, id, question, answers, bPermanent)
end)

netstream.Hook("CompleteQuiz", function(client, answers)
	PLUGIN:CompleteQuiz(client, answers)
end)