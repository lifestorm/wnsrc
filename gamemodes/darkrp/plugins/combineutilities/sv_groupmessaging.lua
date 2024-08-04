--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


netstream.Hook("AddGroupMessageComputer", function(client, message, groupID, name)
	if client:GetCharacter():GetGroupID() != groupID then return false end
	
	local timestamp = os.date( "%d.%m.%Y" )
	local queryObj = mysql:Insert("ix_comgroupmessages")
		queryObj:Insert("message_text", message)
		queryObj:Insert("message_date", timestamp)
		queryObj:Insert("message_poster", name)
		queryObj:Insert("message_groupid", groupID)
	queryObj:Execute()
end)

netstream.Hook("AddGroupReplyComputer", function(client, message, groupID, name, parent)
	if client:GetCharacter():GetGroupID() != groupID then return false end
	
	local timestamp = os.date( "%d.%m.%Y" )
	local queryObj = mysql:Insert("ix_comgroupreplies")
		queryObj:Insert("reply_text", message)
		queryObj:Insert("reply_date", timestamp)
		queryObj:Insert("reply_poster", name)
		queryObj:Insert("reply_groupid", groupID)
		queryObj:Insert("reply_parent", parent)
	queryObj:Execute()
end)