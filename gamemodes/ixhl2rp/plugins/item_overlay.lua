--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Item Overlay"
PLUGIN.description = "Allows items to to create overlays on players' screens."
PLUGIN.author = "DrodA"

ix.option.Add("enableOverlay", ix.type.bool, true, {category = "Appearance"})
ix.option.Add("overlayAlpha", ix.type.number, 1, {category = "Appearance", min = 0.1, max = 1, decimals = 1})

ix.lang.AddTable("english", {
	optEnableOverlay = "Enable Item Overlay",
	optdEnableOverlay = "Whether items can display an overlay on your screen.",
	optOverlayAlpha = "Overlay Alpha",
	optdOverlayAlpha = "The alpha of the overlay."
})

if (SERVER) then return end

function PLUGIN:ItemHasOverlay(client)
	local overlay = false

	if (!client:GetCharacter()) then return end

	for _, item in pairs(client:GetItems()) do
		if (!item.overlay or !item:GetData("equip")) then continue end

		overlay = ix.util.GetMaterial(item.overlay)

		break
	end

	return overlay
end

function PLUGIN:RenderScreenspaceEffects()
	local frametime = FrameTime()
	local client = LocalPlayer()

	if (!IsValid(client) or !client:GetCharacter()) then return	end

	local overlay = self:ItemHasOverlay(client)

	if (!overlay or !ix.option.Get("enableOverlay")) then return end

	render.UpdateScreenEffectTexture()
	overlay:SetFloat("$alpha", 1 * ix.option.Get("overlayAlpha"))
	overlay:SetInt("$ignorez", 1)
	render.SetMaterial(overlay)
	render.DrawScreenQuad()
end
