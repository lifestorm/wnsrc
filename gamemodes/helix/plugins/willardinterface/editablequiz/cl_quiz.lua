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

function PLUGIN:AddQuiz(question, answers, bPermanent)
	netstream.Start("AddQuiz", question, answers, bPermanent)
end

function PLUGIN:RemoveQuiz(id)
	netstream.Start("RemoveQuiz", id)
end

function PLUGIN:EditQuiz(id, question, answers, bPermanent)
	netstream.Start("EditQuiz", id, question, answers, bPermanent)
end

-- Hooks
netstream.Hook("SyncQuiz", function(list)
	PLUGIN.quizlist = list
	if IsValid(ix.gui.quizAnswering) then
		if (ix.gui.quizAnswering.CreateQuizContent) then
			ix.gui.quizAnswering:CreateQuizContent()
		end
	end

	if IsValid(ix.gui.quizMenu) then
		if (ix.gui.quizMenu.CreateLeftSide) then
			ix.gui.quizMenu:CreateLeftSide()
		end
	end
end)