--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local cvar = CreateConVar("rpprops_hide", -1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Show Roleplay Props in the spawnmenu")

if SERVER then

	if (cvar:GetInt() == -1) then -- Default convars don't seem to be sent to clients
		cvar:SetInt(0)
	end

else

	local models = {
		["Living Room"] = {
			"models/U4Lab/tv_monitor_plasma.mdl",
			"models/gmod_tower/suitetv.mdl",
			"models/scenery/furniture/coffeetable1/vestbl.mdl",
			"models/props_interiors/chairlobby01.mdl",
			"models/props_warehouse/office_furniture_couch.mdl",
			"models/props_vtmb/armchair.mdl",
			"models/props_vtmb/sofa.mdl",
			"models/props_interiors/sofa01.mdl",
			"models/props_interiors/sofa02.mdl",
			"models/props_interiors/sofa_chair02.mdl",
			"models/props_interiors/ottoman01.mdl",
			"models/env/furniture/decosofa_wood/decosofa_wood_dou.mdl",
			"models/Highrise/lobby_chair_01.mdl",
			"models/Highrise/lobby_chair_02.mdl",
			"models/props_interiors/desk_motel.mdl",
			"models/props_furniture/piano.mdl",
			"models/props_furniture/piano_bench.mdl",
			"models/props_interiors/painting_landscape01.mdl",
			"models/props_interiors/painting_portrait01.mdl",
			"models/props_furniture/picture_frame8.mdl",
			"models/props_urban/hotel_curtain001.mdl",
			"models/props_plants/plantairport01.mdl",
			"models/Highrise/potted_plant_05.mdl",
			"models/env/decor/tall_plant_b/tall_plant_b.mdl",
			"models/env/decor/plant_decofern/plant_decofern.mdl",
			},
		["Kitchen"] = {
			"models/props_interiors/refrigerator03.mdl",
			"models/sickness/fridge_01.mdl",
			"models/sickness/stove_01.mdl",
			"models/props_interiors/sink_kitchen.mdl",
			"models/props_interiors/coffee_maker.mdl",
			"models/props_interiors/chair01.mdl",
			"models/props_interiors/chair_cafeteria.mdl",
			"models/props_interiors/dining_table_round.mdl",
			"models/props_interiors/dinning_table_oval.mdl",
			"models/props_interiors/trashcankitchen01.mdl",
			
			},
		["Bathroom"] = {
			"models/env/furniture/wc_double_cupboard/wc_double_cupboard.mdl",
			"models/env/furniture/square_sink/sink_double.mdl",
			"models/env/furniture/square_sink/sink_merged_b.mdl",
			"models/env/furniture/showerbase/showerbase.mdl",
			"models/env/furniture/shower/shower.mdl",
			"models/props_interiors/bathtub01.mdl",
			"models/env/furniture/ensuite1_toilet/ensuite1_toilet.mdl",
			"models/env/furniture/ensuite1_toilet/ensuite1_toilet_b.mdl",
			"models/env/furniture/ensuite1_sink/ensuite1_sink.mdl",
			"models/props_interiors/soap_dispenser.mdl",
			"models/props_interiors/toiletpaperdispenser_residential.mdl",
			"models/props_interiors/toiletpaperroll.mdl",		
			},
		["Bedroom"] = {
			"models/props_interiors/bed_motel.mdl",
			"models/props_downtown/bed_motel01.mdl",
			"models/env/furniture/bed_secondclass/beddouble_group.mdl",
			"models/env/furniture/bed_andrea/bed_andrea_1st.mdl",
			"models/props_interiors/side_table_square.mdl",		
			},
		["Office"] = {
			"models/U4Lab/chair_office_a.mdl",
			"models/U4Lab/desk_office_a.mdl",
			"models/props_warehouse/office_furniture_coffee_table.mdl",
			"models/props_warehouse/office_furniture_desk.mdl",
			"models/props_warehouse/office_furniture_desk_corner.mdl",
			"models/props_office/desk_01.mdl",
			"models/props_interiors/desk_executive.mdl",
			"models/env/furniture/largedesk/largedesk.mdl",
			"models/props_office/file_cabinet_03.mdl",
			"models/Highrise/cubicle_monitor_01.mdl",
			"models/props_interiors/copymachine01.mdl",
			"models/props_interiors/printer.mdl",
			"models/props_interiors/paper_tray.mdl",
			"models/props_interiors/water_cooler.mdl",
			"models/props_interiors/corkboardverticle01.mdl",		
			},
		["Outdoors"] = {
			"models/props_unique/spawn_apartment/coffeeammo.mdl",
			"models/props_downtown/sign_donotenter.mdl",
			"models/props_waterfront/awning01.mdl",
			"models/props_street/awning_department_store.mdl",
			"models/props/de_tides/planter.mdl",
			"models/props_urban/bench001.mdl",
			"models/props_interiors/table_picnic.mdl",
			"models/props_urban/plastic_chair001.mdl",
			"models/props_interiors/patio_chair2_white.mdl",
			"models/props/de_tides/patio_chair2.mdl",
			"models/props/de_tides/patio_table2.mdl",
			"models/env/furniture/pool_recliner/pool_recliner.mdl",
			"models/props/de_piranesi/pi_bench.mdl",
			"models/props/de_piranesi/pi_sundial.mdl",
			"models/props/de_inferno/bench_concrete.mdl",
			"models/props/de_inferno/fountain.mdl",
			"models/props/de_inferno/lattice.mdl",
			"models/props_unique/firepit_campground.mdl",
			"models/props_equipment/sleeping_bag1.mdl",
			"models/props_equipment/sleeping_bag2.mdl",
			"models/props_urban/outhouse001.mdl",
			"models/props_junk/trashcluster01a_corner.mdl",
			"models/trees/pi_tree1.mdl",
			"models/trees/pi_tree3.mdl",
			"models/trees/pi_tree4.mdl",
			"models/trees/pi_tree5.mdl",
			},
		["Commercial"] = {
			"models/props_equipment/phone_booth.mdl",
			"models/Highrise/trashcanashtray_01.mdl",
			"models/Highrise/trash_can_03.mdl",
			"models/props_interiors/trashcan01.mdl",
			"models/props_interiors/cashregister01.mdl",
			"models/props_interiors/magazine_rack.mdl",
			"models/props_interiors/shelvinggrocery01.mdl",
			"models/props_interiors/shelvingstore01.mdl",
			"models/props_equipment/fountain_drinks.mdl",
			"models/props_downtown/bar_long.mdl",
			"models/props_downtown/bar_long_endcorner.mdl",
			"models/scenery/structural/vesuvius/bartap.mdl",
			"models/env/furniture/bstoolred/bstoolred.mdl",
			"models/props_furniture/cafe_barstool1.mdl",
			"models/props_downtown/pooltable.mdl",
			"models/de_vegas/card_table.mdl",
			"models/props_equipment/security_desk1.mdl",
			"models/sickness/bk_booth2.mdl",
			"models/props_downtown/booth01.mdl",
			"models/props_downtown/booth02.mdl",
			"models/props_downtown/booth_table.mdl",
			"models/props_interiors/table_cafeteria.mdl",
			"models/props_warehouse/table_01.mdl",
			"models/props_interiors/chairs_airport.mdl",
			"models/props_warehouse/toolbox.mdl",
			"models/props_vtmb/turntable.mdl",
			"models/props_vehicles/ambulance.mdl",
			"models/props_unique/wheelchair01.mdl",
			"models/props_unique/hospital/exam_table.mdl",
			"models/props_unique/hospital/gurney.mdl",
			"models/props_equipment/surgicaltray_01.mdl",
			"models/props_unique/hospital/hospital_bed.mdl",
			"models/props_unique/hospital/iv_pole.mdl",
			"models/props_unique/hospital/surgery_lamp.mdl",
			"models/props_interiors/medicalcabinet02.mdl",		
			},
		["Lighting"] = {
			"models/props_unique/spawn_apartment/lantern.mdl",	
			"models/env/lighting/lamp_trumpet/lamp_trumpet_tall.mdl",
			"models/env/lighting/jelly_lamp/jellylamp.mdl",
			"models/env/lighting/corridor_ceil_lamp/corridor_ceil_lamp.mdl",
			"models/env/lighting/corridorlamp/corridorlamp.mdl",
			"models/props_urban/light_fixture01.mdl",
			"models/Highrise/tall_lamp_01.mdl",
			"models/U4Lab/track_lighting_a.mdl",
			"models/Highrise/sconce_01.mdl",
			"models/wilderness/lamp6.mdl",
			"models/props_interiors/lamp_table02.mdl",			
			}
	}


	hook.Add("PopulateContent", "RoleplayProps", function(pnlContent, tree)
	
		local cvar = GetConVar("rpprops_hide")
		if cvar and (cvar:GetInt() == 1) then return end -- The server doesn't want it in the client spawn menu

		local RootNode = tree:AddNode("Roleplay Props", "icon16/rpprops.png")

		local ViewPanel = vgui.Create("ContentContainer", pnlContent)
		ViewPanel:SetVisible(false)
		
		RootNode.DoClick = function()
		
			ViewPanel:Clear(true)
			
			for name, tbl in SortedPairs(models) do
			
				local label = vgui.Create("ContentHeader", container)
				label:SetText(name)

				ViewPanel:Add(label)
			
				for _, v in ipairs(tbl) do
				
					local mdlicon = spawnmenu.GetContentType("model")
					if mdlicon then
						mdlicon(ViewPanel, {model = v})
					end

				end
				
			end
			
			pnlContent:SwitchPanel(ViewPanel)
			
		end

	end)
	
end
