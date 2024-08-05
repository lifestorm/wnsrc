--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Lighter"
ITEM.base = "base_tools"
ITEM.model = Model("models/willardnetworks/cigarettes/lighter.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.description = "Handheld device designed to spark a flame to light things on fire."

function ITEM:OnRunLight()
	local client = self.player
	if !client then return end
	if !client:Alive() then return end

	if client.cigarette and IsEntity(client.cigarette) and client.cigarette.cigaretteItem and
	client.cigarette.cigaretteItem.GetID and ix.item.instances[client.cigarette.cigaretteItem:GetID()] then
		client.cigarette.isLit = true
		netstream.Start(client, "CigaretteSetClientEntity", client.cigarette.cigaretteItem:GetID(), client.cigarette, true)
	end

	client:NotifyLocalized("You begin smoking the cigarette.")
	client:EmitSound(self.useSound)

	self:DamageDurability(1)
end

function ITEM:OnCanRunLight()
	local client = self.player
	if !client then return end
	if !client:Alive() then return end

	if client.cigarette and !client.cigarette.isLit then return true end

	return false
end

ITEM.functions.light = {
    name = "Light Cigarette",
	tip = "Light a cigarette",
	icon = "icon16/brick_add.png",
	OnRun = function(item)
        item:OnRunLight()

        return false
    end,

    OnCanRun = function(item)
        if item:OnCanRunLight() then return true end

        return false
    end
}
