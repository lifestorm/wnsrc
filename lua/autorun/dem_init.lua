--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if CLIENT then
	local math_Clamp = math.Clamp
	local render_GetLightColor = render.GetLightColor
	local default0 = Vector(0,0,0)
	local defaultTint = Vector()

    matproxy.Add({
        name = "DynamicEnvMap",
        init = function(self,mat,values)
            self.Result = values.resultvar

			self.TintScale = mat:GetVector("$DEM_TintScale") or defaultTint
			self.Multiplier = mat:GetFloat("$DEM_Multiplier") or 1
			self.ClampMin = mat:GetVector("$DEM_ClampMin") or default0
			self.ClampMax = mat:GetVector("$DEM_ClampMax")
			self.Color = (mat:GetVector("$DEM_Color") or mat:GetVector("$color")) or defaultTint
        end,
        bind = function(self,mat,ent)
            if (!IsValid(ent)) then return end

			local finalResult = defaultTint
			local mult = self.Multiplier
			local clampMin = self.ClampMin
			local clampMax = self.ClampMax
			local tint = self.TintScale *self.Color
			local luminance = render_GetLightColor(ent:GetPos() +ent:OBBCenter()) *mult
			finalResult = (tint *luminance) *mult
			if clampMax then
				finalResult.x = math_Clamp(finalResult.x,clampMin.x,clampMax.x)
				finalResult.y = math_Clamp(finalResult.y,clampMin.y,clampMax.y)
				finalResult.z = math_Clamp(finalResult.z,clampMin.z,clampMax.z)
			end

			-- print(tint,self.Color,finalResult)
			mat:SetVector(self.Result,finalResult)
        end
    })

    print("DynamicEnvMap proxy successfully loaded!")
end

/*
    Add this to your VMT to initialize the proxy:

	"$DEM_TintScale" 			"[1 1 1]" // Color scaling essentially, if you want default envmap tint, leave this as is
	"$DEM_Multiplier" 			"1" // Multiplies the output, should change this based on other $envmap settings that alter the strength/color
	"$DEM_ClampMin" 			"[0 0 0]" // Optional, clamps the output to a minimum value
	"$DEM_ClampMax" 			"[1 1 1]" // Optional, clamps the output to a maximum value
	"$DEM_Color" 				"[1 1 1]" // Optional, changes the envmaptint, otherwise it will use $color (or white) by default

	"Proxies" 
	{
		"DynamicEnvMap"
		{
			resultVar	"$envmaptint"
		}
    }
*/