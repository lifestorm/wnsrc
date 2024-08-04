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

do
	for _, proxy in pairs(PLUGIN.proxyList) do
		matproxy.Add( {
			name = proxy,

			init = function( self, _, values )
				-- Store the name of the variable we want to set
				self.ResultTo = values.resultvar
			end,

			bind = function( self, mat, ent )
				if ( !IsValid( ent ) ) then return end

				-- If entity is a ragdoll try to convert it into the player
				-- ( this applies to their corpses )
				if ( ent:IsRagdoll() ) then
					local owner = ent:GetRagdollOwner()
					if ( IsValid( owner ) ) then ent = owner end
				end

                -- SHOULD return a Vector with the items stored-/character's stored hair colour.
				local clrFallback = Vector( 255 / 255, 255 / 255, 255 / 255 )

                local entColor = ent.GetProxyColors and ent:GetProxyColors() or false

                local ragdollNWVector = ent:GetNWVector(proxy, false)

                local character = ent.GetCharacter and ent:GetCharacter() or false
                local charProxyColors = character and character.GetProxyColors and character:GetProxyColors() or {}

				local color = entColor and entColor[proxy] or ragdollNWVector or charProxyColors[proxy] or clrFallback

				if istable(color) and color.r then
					color = Vector(color.r / 255, color.g / 255, color.b / 255)
				end

				mat:SetVector(self.ResultTo, color)
			end
		} )
	end
end
