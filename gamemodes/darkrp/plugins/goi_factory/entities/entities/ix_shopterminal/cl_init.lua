--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:CreateStartScreen()
	local shopMenu = ix.factoryPanels:CreatePanel("ixShopTerminal", self)
	shopMenu:BuildShopPanel({
		shopName = self:GetShop(),
		cost = self:GetShopCost(),
		scReq = self:GetShopSocialCreditReq(),
		rent = self:GetNetVar("Rent", 0)
	})
end

function ENT:PurgeScreenPanels(muteSound)
	ix.factoryPanels:PurgeEntityPanels(self)
end

function ENT:OnRemove()
	self:PurgeScreenPanels(true)
end

ENT.vguiLocalizedTransform = {
	vec = Vector(13, -6.7, 20),
	ang = Angle(0, 90, 90),
	res = 0.01
}

function ENT:DrawTranslucent()
	self:DrawModel()

	vgui.Start3D2D( self:LocalToWorld(self.vguiLocalizedTransform.vec), self:LocalToWorldAngles(self.vguiLocalizedTransform.ang), self.vguiLocalizedTransform.res )
		if self.terminalPanel then
			self.terminalPanel:Paint3D2D()
		end
	vgui.End3D2D()

end

function ENT:Initialize()
	self:CreateStartScreen()
end