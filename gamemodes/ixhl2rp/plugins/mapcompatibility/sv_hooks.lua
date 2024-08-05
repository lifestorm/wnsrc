--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local mapButtonIndex = {
	["BOE_CitizenReminder1"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Reminder to all residents of City Twenty-Four: A *civil* society is a *safe* and *prosperous* one. Do *your* part in taking humanity to the stars, by reporting those who deem humanity's path to success unacceptable.", false, nil, {speakerName = "City Announcer"})
			end)
		end,
		position = Vector(13125.000000, 3581.000000, 2160.000000)
	},
	["BOE_CitizenReminder2"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Reminder to all residents of City Twenty-Four: The continuation of the human species rests in the hands of the Universal Union. It is up to us to maintain the bonds that hold us together. Do *your* part in taking our species to the stars.", false, nil, {speakerName = "City Announcer"})
			end)
		end,
		position = Vector(13125.000000, 3581.000000, 2144.000000)
	},
	["BOE_CitizenReminder3"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Reminder to all residents of City Twenty-Four: *Magical-Thinking* is a tool of extremists. Do not allow yourself to be subjected to falsehoods, and irredeemable demands by fringe elements.", false, nil, {speakerName = "City Announcer"})
			end)
		end,
		position = Vector(13125.000000, 3581.000000, 2128.000000)
	},
	["BOE_CitizenReminder4"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Reminder to all residents of City Twenty-Four: The unification of Earth is but one part of the process that will transcend our species. Be a part of that process. You and your family will be thankful.", false, nil, {speakerName = "City Announcer"})
			end)
		end,
		position = Vector(13104.400391, 3536.360107, 2160.000000)
	},
	["BOE_CitizenReminder5"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Reminder to all residents of City Twenty-Four: The Universal Union is a civilized authority that works in the best interests of our society and species, regardless of who they are. Do not allow fringe elements to break the bond between the two.", false, nil, {speakerName = "City Announcer"})
			end)
		end,
		position = Vector(13104.400391, 3536.360107, 2144.000000)
	},
	["BOE_WorkerAnnouncement"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Attention all working residents of City Twenty-Four: Your scheduled work-session is ready for completion. Please proceed to the respective warehouse for task assignment.", false, nil, {speakerName = "City Announcer"})
			end)
		end,
		position = Vector(13104.400391, 3536.360107, 2128.000000)
	},
	["BOE_SuspendedRations"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Attention all residents of City Twenty-Four: Due to the actions of fringe elements, hourly intake of rationing has been temporarily suspended.", false, nil, {speakerName = "City Announcer"})
			end)
		end,
		position = Vector(12952.000000, 4119.000000, 2169.000000)
	},
	["BOE_RationAnnouncement"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Attention all residents of City Twenty-Four: Your hourly intake of rations are now available for retrieval. Please proceed to the Ration Distribution Terminal at your earliest convenience.", false, nil, {speakerName = "City Announcer"})
			end)
		end,
		position = Vector(12952.000000, 4119.000000, 2144.000000)
	},
	["CA_CitizenReminder1"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Reminder to all residents of City Twenty-Four: A *civil* society is a *safe* and *prosperous* one. Do *your* part in taking humanity to the stars, by reporting those who deem humanity's path to success unacceptable.", false, nil, {speakerName = "City Announcer"})
			end)
		end,
		position = Vector(14551.900391, 3651.979980, 2157.689941)
	},
	["CA_CitizenReminder2"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Reminder to all residents of City Twenty-Four: The continuation of the human species rests in the hands of the Universal Union. It is up to us to maintain the bonds that hold us together. Do *your* part in taking our species to the stars.", false, nil, {speakerName = "City Announcer"})
			end)
		end,
		position = Vector(14551.900391, 3651.979980, 2141.689941)
	},
	["CA_CitizenReminder3"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Reminder to all residents of City Twenty-Four: *Magical-Thinking* is a tool of extremists. Do not allow yourself to be subjected to falsehoods, and irredeemable demands by fringe elements.", false, nil, {speakerName = "City Announcer"})
			end)
		end,
		position = Vector(14551.900391, 3651.979980, 2125.689941)
	},
	["CA_CitizenReminder4"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Reminder to all residents of City Twenty-Four: The unification of Earth is but one part of the process that will transcend our species. Be a part of that process. You and your family will be thankful.", false, nil, {speakerName = "City Announcer"})
			end)
		end,
		position = Vector(14515.900391, 3623.800049, 2155.689941)
	},
	["CA_CitizenReminder5"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Reminder to all residents of City Twenty-Four: The Universal Union is a civilized authority that works in the best interests of our society and species, regardless of who they are. Do not allow fringe elements to break the bond between the two.", false, nil, {speakerName = "City Announcer"})
			end)
		end,
		position = Vector(14515.900391, 3623.800049, 2139.689941)
	},
	["CA_WorkerAnnouncement"] = {
		OnPressed = function(self, client)
			if (client:Team() == FACTION_WORKERS or client:Team() == FACTION_MEDICAL or client:IsCombine() or client:IsAdmin()) then
				timer.Simple(2, function()
					ix.chat.Send(nil, "broadcast", "Attention all working residents of City Twenty-Four: Your scheduled work-session is ready for completion. Please proceed to the respective warehouse for task assignment.", false, nil, {speakerName = "City Announcer"})
				end)
			else
				return "You are not allowed to announce a workshift!"
			end
		end,
		position = Vector(14515.900391, 3623.800049, 2123.689941)
	},
	["CA_JudgementWaiver"] = {
		OnPressed = function(self, client)
			if (!ix.JwLocked) then
				local steamIDs = string.Explode(",", ix.config.Get("judgementWaiverPermission", ""), false)

				if (table.HasValue(steamIDs, client:SteamID())) then
					if (!ix.JudgementWaiverEnabled) then
						ix.JudgementWaiverEnabled = true
						ix.JwLocked = true

						local jwRelay = ents.FindByName("jw_on_logic")
						jwRelay[1]:Fire("Trigger")

						for _, alarm in ipairs(ents.FindByClass("ambient_generic")) do
							if (alarm:GetName() == "tower_alarm" or alarm:GetName() == "tower_alarm1") then
								alarm:Fire("PlaySound")
							end
						end

						timer.Simple(19, function()
							ix.chat.Send(Entity(0), "worlddispatch", "Attention, please. Alert, Ground Units: Invasive operation of Anti-Citizen origin. Response Code: ENGAGE; QUELL; INQUIRE.")

							timer.Simple(16, function()
								ix.chat.Send(Entity(0), "worlddispatch", "Alert, Response Units. Update Code: FLUSH; ESCORT; CONTINUE.")

								timer.Simple(13, function()
									ix.chat.Send(nil, "broadcast", "Attention, City Twenty-Four: Judgement Waiver is now in immediate effect. All residents are now obligated to return to their homes. Directives have been dispatched to local Protection Teams. Co-operate and your safety is assured.", false, nil, {speakerName = "City Announcer"})

									timer.Simple(20.5, function()
										ix.chat.Send(Entity(0), "worlddispatch", "Security Alert: Re-Administration in-progress. Asset allocation Adjustment Code: FLINT; INSPECT; EXTIRPATE. Priority: IMMEDIATE.")

										timer.Simple(17, function()
											ix.chat.Send(Entity(0), "worlddispatch", "Security Alert: Critical civil insurrection. Deploy Technician Teams to Blocks 49, 64, 77. Maintain priority.")

											timer.Simple(15.5, function()
												ix.chat.Send(Entity(0), "worlddispatch", "Security Alert: Reminder, Ground Teams: Mission failure will result in Permanent Relocation. Response Code: BREACH; MANEUVER; INOCULATE.")

												ix.JwLocked = false
											end)
										end)
									end)
								end)
							end)
						end)
					else
						ix.JudgementWaiverEnabled = false
						ix.JwLocked = true

						local jwRelay = ents.FindByName("jw_stop_logic")
						jwRelay[1]:Fire("Trigger")

						for _, alarm in ipairs(ents.FindByClass("ambient_generic")) do
							if (alarm:GetName() == "tower_alarm" or alarm:GetName() == "tower_alarm1") then
								alarm:Fire("StopSound")
							end
						end

						timer.Simple(20, function()
							ix.JwLocked = false
						end)
					end
				else
					client:Notify("You are not allowed to initiate a Judgement Waiver!")
				end
			else
				client:Notify("Please wait before toggling the Judgement Waiver!")
			end

			return true -- Stopping the button logic because it's broken.
		end,
		position = Vector(14547.500000, 3583.310059, 2152.510010)
	},
	["CA_SocialInfection"] = {
		OnPressed = function(self, client)
			if (client:Team() == FACTION_OTA or client:IsAdmin()) then
				timer.Simple(2, function()
					ix.chat.Send(Entity(0), "worlddispatch", "Alert, Ground Units: Invasive operation of Anti-Citizen origin. Response Code: ENGAGE; QUELL; INQUIRE.")

					timer.Simple(12, function()
						ix.chat.Send(nil, "broadcast", "Attention, City Twenty-Four: Societal infection has been detected. Practices to combat unrest procedures are being enacted. Remember - co-operation with Civil Protection is the *key* to safety.", false, nil, {speakerName = "City Announcer"})

						timer.Simple(16.5, function()
							ix.chat.Send(Entity(0), "worlddispatch", "Alert, Ground Units: Invasive operation of Anti-Citizen origin. Response Code: ENGAGE; QUELL; INQUIRE.")
						end)
					end)
				end)
			else
				return "You are not allowed to call a Social Infection!"
			end
		end,
		position = Vector(14547.599609, 3583.320068, 2129.510010)
	},
	["CA_RationAnnouncement"] = {
		OnPressed = function(self, client)
			if (client:IsCombine() or client:IsAdmin()) then
				timer.Simple(2, function()
					ix.chat.Send(nil, "broadcast", "Attention all residents of City Twenty-Four: Your hourly intake of rations are now available for retrieval. Please proceed to the Ration Distribution Terminal at your earliest convenience.", false, nil, {speakerName = "City Announcer"})
				end)
			else
				return "You are not allowed to enable ration distribution!"
			end
		end,
		position = Vector(14600.299805, 3599.760010, 2152.510010)
	},
	["CA_SuspendedRations"] = {
		OnPressed = function(self, client)
			if (client:IsCombine() or client:IsAdmin()) then
				timer.Simple(2, function()
					ix.chat.Send(nil, "broadcast", "Attention all residents of City Twenty-Four: Due to the actions of fringe elements, hourly intake of rationing has been temporarily suspended.", false, nil, {speakerName = "City Announcer"})
				end)
			else
				return "You are not allowed to disable ration distribution!"
			end
		end,
		position = Vector(14600.400391, 3599.860107, 2129.510010)
	},
	["RDC_SuspendedRations"] = {
		OnPressed = function(self, client)
			if (client:IsCombine() or client:IsAdmin()) then
				timer.Simple(2, function()
					ix.chat.Send(nil, "broadcast", "Attention all residents of City Twenty-Four: Due to the actions of fringe elements, hourly intake of rationing has been temporarily suspended.", false, nil, {speakerName = "City Announcer"})
				end)
			else
				return "You are not allowed to disable ration distribution!"
			end
		end,
		position = Vector(7199.000000, 7970.990234, 186.000000)
	},
	["RDC_RationAnnouncement"] = {
		OnPressed = function(self, client)
			if (client:IsCombine() or client:IsAdmin()) then
				timer.Simple(2, function()
					ix.chat.Send(nil, "broadcast", "Attention all residents of City Twenty-Four: Your hourly intake of rations are now available for retrieval. Please proceed to the Ration Distribution Terminal at your earliest convenience.", false, nil, {speakerName = "City Announcer"})
				end)
			else
				return "You are not allowed to enable ration distribution!"
			end
		end,
		position = Vector(7161.000000, 7881.009766, 178.009995)
	},
	["CWU_WorkerAnnouncement"] = {
		OnPressed = function(self, client)
			if (client:Team() == FACTION_WORKERS or client:Team() == FACTION_MEDICAL or client:IsCombine() or client:IsAdmin()) then
				timer.Simple(2, function()
					ix.chat.Send(nil, "broadcast", "Attention all working residents of City Twenty-Four: Your scheduled work-session is ready for completion. Please proceed to the respective warehouse for task assignment.", false, nil, {speakerName = "City Announcer"})
				end)
			else
				return "You are not allowed to announce a workshift!"
			end
		end,
		position = Vector(5778.000000, 8457.000000, 514.000000)
	},
	["VIC_CheckpointAlarm"] = {
		OnPressed = function(self, client)
			if (!client:IsCombine() and !client:IsAdmin()) then
				return "You are not allowed to activate the checkpoint alarm!"
			end
		end,
		position = Vector(5691.950195, 6677.560059, 617.989990)
	},
	["VIC_CheckpointGate"] = {
		OnPressed = function(self, client)
			if (!client:IsCombine() and !client:IsAdmin()) then
				return "You are not allowed to control the checkpoint gate!"
			end
		end,
		position = Vector(5507.040039, 6572.029785, 631.940002)
	},
	["WIL_CheckpointAlarm"] = {
		OnPressed = function(self, client)
			if (!client:IsCombine() and !client:IsAdmin()) then
				return "You are not allowed to activate the checkpoint alarm!"
			end
		end,
		position = Vector(9379.519531, 7912.979980, 673.630005)
	},
	["WIL_CheckpointGate"] = {
		OnPressed = function(self, client)
			if (!client:IsCombine() and !client:IsAdmin()) then
				return "You are not allowed to control the checkpoint gate!"
			end
		end,
		position = Vector(9538.040039, 7801.029785, 686.940002)
	},
	["SEW_Forcefields"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "You are not allowed to control the forcefields!"
			end
		end,
		position = Vector(8484.000000, 9752.000000, -1128.000000)
	},
	["ADM_Explosion1"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "You are not allowed to use this button!"
			end
		end,
		position = Vector(11280.000000, 4544.500000, 1061.000000)
	},
	["ADM_Explosion2"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "You are not allowed to use this button!"
			end
		end,
		position = Vector(11184.000000, 4544.500000, 1061.000000)
	},
	["ADM_Wind"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "You are not allowed to use this button!"
			end
		end,
		position = Vector(11104.000000, 4544.500000, 1060.000000)
	},
	["ADM_Thunder"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "You are not allowed to use this button!"
			end
		end,
		position = Vector(10952.500000, 4728.009766, 1060.000000)
	},
	["ADM_CloudsEnable"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "You are not allowed to use this button!"
			end
		end,
		position = Vector(10952.500000, 4800.009766, 1060.000000)
	},
	["ADM_CloudsDisable"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "You are not allowed to use this button!"
			end
		end,
		position = Vector(10952.500000, 4888.009766, 1060.000000)
	},
	["ADM_Alarm1"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "You are not allowed to use this button!"
			end
		end,
		position = Vector(11112.000000, 5055.500000, 1060.000000)
	},
	["ADM_Alarm2"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "You are not allowed to use this button!"
			end
		end,
		position = Vector(11208.000000, 5055.500000, 1060.000000)
	},
	["ADM_ManhackAlert"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "You are not allowed to use this button!"
			end
		end,
		position = Vector(11288.000000, 5055.500000, 1060.000000)
	},
	["ADM_ScannerAlert"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "You are not allowed to use this button!"
			end
		end,
		position = Vector(11463.500000, 4951.990234, 1060.000000)
	},
	["ADM_Battle1"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "You are not allowed to use this button!"
			end
		end,
		position = Vector(11463.500000, 4871.990234, 1060.000000)
	},
	["ADM_Battle2"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "You are not allowed to use this button!"
			end
		end,
		position = Vector(11463.500000, 4799.990234, 1060.000000)
	},
	["ADM_TrainHorn"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "You are not allowed to use this button!"
			end
		end,
		position = Vector(11463.500000, 4719.990234, 1060.000000)
	},
	["BOE_Anthem"] = {
		position = Vector(11878.599609, 3844.679932, 2111.100098)
	},
	["BOE_Intro"] = {
		position = Vector(12253.500000, 4019.989990, 2109.350098)
	},
	["BOE_Outro"] = {
		position = Vector(12350.000000, 4019.989990, 2109.350098)
	},
	["BOE_NewsIntro"] = {
		position = Vector(12444.000000, 4019.989990, 2109.350098)
	},
	["BOE_CloseupCamera"] = {
		position = Vector(12542.000000, 3981.500000, 2108.000000)
	},
	["BOE_SpeechIntro"] = {
		position = Vector(12561.000000, 3919.000000, 2095.010010)
	},
	["BOE_Applause"] = {
		position = Vector(12765.500000, 3783.010010, 2111.350098)
	},
	["BOE_Laugher"] = {
		position = Vector(12685.500000, 3783.010010, 2111.350098)
	},
	["BOE_Set1Camera"] = {
		position = Vector(12602.000000, 3782.330078, 2111.350098)
	},
	["BOE_CamerasOff"] = {
		position = Vector(12329.000000, 3783.000000, 2111.350098)
	},
	["BOE_Intermission"] = {
		position = Vector(12263.000000, 3783.000000, 2111.350098)
	},
	["BOE_TechnicalIssues"] = {
		position = Vector(12191.000000, 3783.000000, 2111.350098)
	},
	["BOE_Set2Camera"] = {
		position = Vector(12107.000000, 3782.330078, 2111.350098)
	}
}

local mapDoorIndex = {
	["BrokenNexusDoor1"] = {
		position = Vector(13319.000000, 9391.000000, 530.000000),
		autoclose = 6
	},
	["BrokenNexusDoor2"] = {
		position = Vector(13607.000000, 9391.000000, 530.000000),
		autoclose = 6
	},
	["BrokenCheckpointDoor"] = {
		position = Vector(8900.000000, 5992.000000, 338.000000),
		autoclose = 6
	},
	["cmu_door"] = {
		locked = true
	},
	["cmu_door1"] = {
		locked = true
	},
	["rationshutter"] = {
		locked = true
	},
	["d2_slumsdoor"] = {
		locked = true
	},
	["depot_gate"] = {
		locked = true
	},
	["depot_gate1"] = {
		locked = true
	},
	["nexus_gate"] = {
		locked = true
	},
	["nexus_gate1"] = {
		locked = true
	}
}

function PLUGIN:InitPostEntity()
	if (game.GetMap() == "rp_city24_v3") then
		for _, button in ipairs(ents.FindByClass("func_button")) do
			if (button:GetName() == "jw_off") then button:Remove() continue end -- Remove the button since we're handling JW toggle logic.

			for buttonName, buttonData in pairs(mapButtonIndex) do
				if (button:GetPos() == buttonData.position) then
					button:SetName(buttonName)
				end
			end
		end

		for _, door in ipairs(ents.FindByClass("func_door")) do
			for doorName, doorData in pairs(mapDoorIndex) do
				if (doorData.position and door:GetPos() == doorData.position) then
					door:SetName(doorName)
				end
			end
		end
	end
end

function PLUGIN:PlayerUse(client, entity)
	if (game.GetMap() == "rp_city24_v3") then
		if (entity:GetClass() == "func_button") then
			local curTime = CurTime()

			if (!client.nextUse or client.nextUse <= curTime) then
				local buttonData = mapButtonIndex[entity:GetName()]

				client.nextUse = curTime + 1

				if (buttonData) then
					if (buttonData.OnPressed and type(buttonData.OnPressed) == "function") then
						local noPress = buttonData:OnPressed(client)

						if (!noPress) then
							entity:Fire("Use")
						elseif (type(noPress) == "string") then
							client:Notify(noPress)
						end
					else
						entity:Fire("Use")
					end

					ix.log.Add(client, "mapButtonPressed", entity:GetName())
				else
					entity:Fire("Use")
				end
			end

			return false
		elseif (entity:GetClass() == "func_door" or entity:GetClass() == "func_door_rotating") then
			local doorData = mapDoorIndex[entity:GetName()]

			if (doorData) then
				if (doorData.locked) then
					return false
				elseif (doorData.autoclose) then
					timer.Simple(doorData.autoclose, function()
						entity:Fire("Close")
					end)
				end
			end
		end
	end
end
