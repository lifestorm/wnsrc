--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

VyHub.groups_mapped = VyHub.groups_mapped or nil

net.Receive("vyhub_group_data", function()
	local num = net.ReadUInt(8)
	local groups_mapped_new = {}

	for i=1, num do
		-- Currently only the name and color of the group is transferred
		local name_game = net.ReadString()
		local name = net.ReadString()
		local color = net.ReadString()

		groups_mapped_new[name_game] = {
			name = name,
			color = color,
		}
	end

	VyHub.groups_mapped = groups_mapped_new
end)