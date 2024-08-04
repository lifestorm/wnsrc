--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


	local function CombineSuitsOS()  
	  
	  
 for k, v in pairs( player.GetAll() ) do

		

	if v:IsPlayer() then

					v.friclass = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
					v.SquadName = "vj_neutral"
					v.Class = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
					v.Classify = "CLASS_NEUTRAL" and "CLASS_NEUTRALS" 
					v.VJ_NPC_Class = {"CLASS_HERO_NEUTRAL","CLASS_HERO_BANDIT","CLASS_HERO_FREEDOM","CLASS_HERO_DUTY","CLASS_HERO_CS","CLASS_HERO_HUNTER","CLASS_HERO_SKIT","CLASS_HERO_UCHENIY","CLASS_HERO_KILLER","CLASS_HERO_GREH"}
					v.GetClass = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
					v.SetClass = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
		  	   
	

			end

		end
		end

if SERVER then

	local function CombineSuitsOS()  
	  
	  
 for k, v in pairs( player.GetAll() ) do

		

	if v:IsPlayer() then

					v.friclass = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
					v.SquadName = "vj_neutral"
					v.Class = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
					v.Classify = "CLASS_NEUTRAL" and "CLASS_NEUTRALS" 
					v.VJ_NPC_Class = {"CLASS_HERO_NEUTRAL","CLASS_HERO_BANDIT","CLASS_HERO_FREEDOM","CLASS_HERO_DUTY","CLASS_HERO_CS","CLASS_HERO_HUNTER","CLASS_HERO_SKIT","CLASS_HERO_UCHENIY","CLASS_HERO_KILLER","CLASS_HERO_GREH"}
					v.GetClass = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
					v.SetClass = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
		  	   
	

			end

		end
		end

end




if CLIENT then
	local function CombineSuitsOS()  
	  
	  
 for k, v in pairs( player.GetAll() ) do

		

	if v:IsPlayer() then

					v.friclass = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
					v.SquadName = "vj_neutral"
					v.Class = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
					v.Classify = "CLASS_NEUTRAL" and "CLASS_NEUTRALS" 
					v.VJ_NPC_Class = {"CLASS_HERO_NEUTRAL","CLASS_HERO_BANDIT","CLASS_HERO_FREEDOM","CLASS_HERO_DUTY","CLASS_HERO_CS","CLASS_HERO_HUNTER","CLASS_HERO_SKIT","CLASS_HERO_UCHENIY","CLASS_HERO_KILLER","CLASS_HERO_GREH"}
					v.GetClass = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
					v.SetClass = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
		  	   
	

			end

		end
		end

	end
	

