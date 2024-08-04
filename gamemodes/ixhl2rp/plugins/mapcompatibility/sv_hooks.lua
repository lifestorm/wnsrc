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
				ix.chat.Send(nil, "broadcast", "Przypomnienie dla wszystkich mieszkańców Miasta Dwadzieścia Cztery: *Cywilizowane* społeczeństwo jest *bezpieczne* i *bogate*. Odegraj *swoją* rolę w wyniesieniu ludzkości do gwiazd, zgłaszając tych, którzy uważają, że droga ludzkości do sukcesu jest nie do przyjęcia.", false, nil, {speakerName = "Głos Miasta"})
			end)
		end,
		position = Vector(13125.000000, 3581.000000, 2160.000000)
	},
	["BOE_CitizenReminder2"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Przypomnienie dla wszystkich mieszkańców Miasta Dwadzieścia Cztery: Kontynuacja gatunku ludzkiego spoczywa w rękach Uniwersalnej Unii. Od nas zależy utrzymanie więzi, które trzymają nas razem.  Zrób *swoją* część w wyniesieniu naszego gatunku do gwiazd.", false, nil, {speakerName = "Głos Miasta"})
			end)
		end,
		position = Vector(13125.000000, 3581.000000, 2144.000000)
	},
	["BOE_CitizenReminder3"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Przypomnienie dla wszystkich mieszkańców Miasta Dwadzieścia Cztery: *Magiczne myślenie* jest narzędziem ekstremistów. Nie pozwólcie sobie na uleganie kłamstwom i niemożliwym do odrzucenia żądaniom skrajnych elementów.", false, nil, {speakerName = "Głos Miasta"})
			end)
		end,
		position = Vector(13125.000000, 3581.000000, 2128.000000)
	},
	["BOE_CitizenReminder4"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Przypomnienie dla wszystkich mieszkańców Miasta Dwadzieścia Cztery: Zjednoczenie Ziemi jest tylko częścią procesu, który wyniesie nasz gatunek. Bądź częścią tego procesu. Ty i twoja rodzina będziecie wdzięczni.", false, nil, {speakerName = "Głos Miasta"})
			end)
		end,
		position = Vector(13104.400391, 3536.360107, 2160.000000)
	},
	["BOE_CitizenReminder5"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Przypomnienie dla wszystkich mieszkańców Miasta Dwadzieścia Cztery: Uniwersalna Unia jest cywilizowanym organem, który działa w najlepszym interesie naszego społeczeństwa i gatunku, niezależnie od tego, kim są. Nie pozwól, aby elementy marginesu zerwały więź która jest między nimi.", false, nil, {speakerName = "Głos Miasta"})
			end)
		end,
		position = Vector(13104.400391, 3536.360107, 2144.000000)
	},
	["BOE_WorkerAnnouncement"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Uwaga wszyscy pracujący mieszkańcy Miasta Dwadzieścia Cztery: Zaplanowana sesja robocza jest gotowa. Prosimy o udanie się do odpowiedniego magazynu w celu przydzielenia zadań.", false, nil, {speakerName = "Głos Miasta"})
			end)
		end,
		position = Vector(13104.400391, 3536.360107, 2128.000000)
	},
	["BOE_SuspendedRations"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Uwaga wszyscy mieszkańcy Miasta Dwadzieścia Cztery: W związku z działaniami elementów pobocznych, pobór racji zostaje tymczasowo zawieszony.", false, nil, {speakerName = "Głos Miasta"})
			end)
		end,
		position = Vector(12952.000000, 4119.000000, 2169.000000)
	},
	["BOE_RationAnnouncement"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Uwaga wszyscy mieszkańcy Miasta Dwadzieścia Cztery: Wasze racje żywnościowe są już dostępne do odbioru. Prosimy o jak najszybsze udanie się do terminalu dystrybucji racji żywnościowych.", false, nil, {speakerName = "Głos Miasta"})
			end)
		end,
		position = Vector(12952.000000, 4119.000000, 2144.000000)
	},
	["CA_CitizenReminder1"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Przypomnienie dla wszystkich mieszkańców Miasta Dwadzieścia Cztery: *Cywilizowane* społeczeństwo jest *bezpieczne* i *bogate*. Odegraj *swoją* rolę w wyniesieniu ludzkości do gwiazd, zgłaszając tych, którzy uważają, że droga ludzkości do sukcesu jest nie do przyjęcia.", false, nil, {speakerName = "Głos Miasta"})
			end)
		end,
		position = Vector(14551.900391, 3651.979980, 2157.689941)
	},
	["CA_CitizenReminder2"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Przypomnienie dla wszystkich mieszkańców Miasta Dwadzieścia Cztery: Kontynuacja gatunku ludzkiego spoczywa w rękach Uniwersalnej Unii. Od nas zależy utrzymanie więzi, które trzymają nas razem.  Zrób *swoją* część w wyniesieniu naszego gatunku do gwiazd.", false, nil, {speakerName = "Głos Miasta"})
			end)
		end,
		position = Vector(14551.900391, 3651.979980, 2141.689941)
	},
	["CA_CitizenReminder3"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Przypomnienie dla wszystkich mieszkańców Miasta Dwadzieścia Cztery: *Magiczne myślenie* jest narzędziem ekstremistów. Nie pozwólcie sobie na uleganie kłamstwom i niemożliwym do odrzucenia żądaniom skrajnych elementów.", false, nil, {speakerName = "Głos Miasta"})
			end)
		end,
		position = Vector(14551.900391, 3651.979980, 2125.689941)
	},
	["CA_CitizenReminder4"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Przypomnienie dla wszystkich mieszkańców Miasta Dwadzieścia Cztery: Zjednoczenie Ziemi jest tylko częścią procesu, który wyniesie nasz gatunek. Bądź częścią tego procesu. Ty i twoja rodzina będziecie wdzięczni.", false, nil, {speakerName = "Głos Miasta"})
			end)
		end,
		position = Vector(14515.900391, 3623.800049, 2155.689941)
	},
	["CA_CitizenReminder5"] = {
		OnPressed = function(self, client)
			timer.Simple(2, function()
				ix.chat.Send(nil, "broadcast", "Przypomnienie dla wszystkich mieszkańców Miasta Dwadzieścia Cztery: Uniwersalna Unia jest cywilizowanym organem, który działa w najlepszym interesie naszego społeczeństwa i gatunku, niezależnie od tego, kim są. Nie pozwól, aby elementy marginesu zerwały więź która jest między nimi.", false, nil, {speakerName = "Głos Miasta"})
			end)
		end,
		position = Vector(14515.900391, 3623.800049, 2139.689941)
	},
	["CA_WorkerAnnouncement"] = {
		OnPressed = function(self, client)
			if (client:Team() == FACTION_WORKERS or client:Team() == FACTION_MEDICAL or client:IsCombine() or client:IsAdmin()) then
				timer.Simple(2, function()
					ix.chat.Send(nil, "broadcast", "Uwaga wszyscy pracujący mieszkańcy Miasta Dwadzieścia Cztery: Zaplanowana sesja robocza jest gotowa. Prosimy o udanie się do odpowiedniego magazynu w celu przydzielenia zadań.", false, nil, {speakerName = "Głos Miasta"})
				end)
			else
				return "Nie posiadasz pozwolenia do ogłoszenia workshiftu!"
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
							ix.chat.Send(Entity(0), "worlddispatch", "Uwaga jednostki naziemne. Wykryto działania inwazyjne pochodzenia antyobywatelskiego. Kod odpowiedzi: Engage. Quell. Inquire.")

							timer.Simple(16, function()
								ix.chat.Send(Entity(0), "worlddispatch", "Alarm, jednostki reagowania. Kod aktualizacji: FLUSH; ESCORT; CONTINUE.")

								timer.Simple(13, function()
									ix.chat.Send(nil, "broadcast", "Uwaga, Miasto Dwadzieścia Cztery: Judgement Waiver w toku.. Wszyscy mieszkańcy są zobowiązani do powrotu do swoich domów. Dyrektywy zostały wysłane do lokalnych zespołów Civil Protection. Współpracujcie, a wasze bezpieczeństwo będzie zapewnione.", false, nil, {speakerName = "Głos Miasta"})

									timer.Simple(20.5, function()
										ix.chat.Send(Entity(0), "worlddispatch", "Alarm: Odnowienie administracji w toku. Kod dostosowania alokacji aktywów: FLINT; INSPECT; EXTIRPATE. Priorytet: NATYCHMIAST.")

										timer.Simple(17, function()
											ix.chat.Send(Entity(0), "worlddispatch", "Alarm bezpieczeństwa. Krytyczny bunt antyobywatelski. Wysłano zespoły techniczne do bloków 49, 64, 77. Zachować priorytet.")

											timer.Simple(15.5, function()
												ix.chat.Send(Entity(0), "worlddispatch", "Uwaga, jednostki naziemne: Niepowodzenie misji będzie skutkować stałym przydziałem pozaziemskim. Przypomnienie kodu: SACRIFICE, COAGULATE, CLAMP.")

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
					client:Notify("Nie możesz zainicjować Judgement Waiver!")
				end
			else
				client:Notify("Poczekaj, zanim przełączysz Judgement Waiver!")
			end

			return true -- Stopping the button logic because it's broken.
		end,
		position = Vector(14547.500000, 3583.310059, 2152.510010)
	},
	["CA_SocialInfection"] = {
		OnPressed = function(self, client)
			if (client:Team() == FACTION_OTA or client:IsAdmin()) then
				timer.Simple(2, function()
					ix.chat.Send(Entity(0), "worlddispatch", "Uwaga Jednostki Naziemne! Inwazyjne działania pochodzenia Antyobywatelskiego w toku. Kod: ENGAGE; QUELL; INQUIRE.")

					timer.Simple(12, function()
						ix.chat.Send(nil, "broadcast", "Uwaga rezydenci Miasta Dwadzieścia Cztery! Wykryto dysfunkcje społeczną. Wdrożono procedury mające na celu zwalczenie niepokojów społecznych. Pamiętajcie - współpraca z Civil Protection jest kluczem do bezpieczeństwa.", false, nil, {speakerName = "Informator Miasta"})

						timer.Simple(16.5, function()
							ix.chat.Send(Entity(0), "worlddispatch", "Uwaga Jednostki Naziemne! Inwazyjne działania pochodzenia Antyobywatelskiego w toku. Kod: ENGAGE; QUELL; INQUIRE.")
						end)
					end)
				end)
			else
				return "Nie posiadasz wystarczających permisji, aby ogłosić Social Infection!"
			end
		end,
		position = Vector(14547.599609, 3583.320068, 2129.510010)
	},
	["CA_RationAnnouncement"] = {
		OnPressed = function(self, client)
			if (client:IsCombine() or client:IsAdmin()) then
				timer.Simple(2, function()
					ix.chat.Send(nil, "broadcast", "Uwaga rezydenci Miasta Dwudziestego Czwartego! Wasze godzinne racje żywnościowe są już dostępne do odebrania. Prosimy o udanie się do Terminala Dystrybucji Racji, kiedy bedzie to dla was najdogodniejsze.", false, nil, {speakerName = "Informator Miasta"})
				end)
			else
				return "Nie posiadasz wystarczających permisji, aby ogłosić dystrybucje racji!"
			end
		end,
		position = Vector(14600.299805, 3599.760010, 2152.510010)
	},
	["CA_SuspendedRations"] = {
		OnPressed = function(self, client)
			if (client:IsCombine() or client:IsAdmin()) then
				timer.Simple(2, function()
					ix.chat.Send(nil, "broadcast", "Uwaga rezydenci Miasta Dwudziestego Czwartego! Ze względu na działania skrajnych elementów, godzinny przydział racji żywnościowych został tymczasowo zawieszony.", false, nil, {speakerName = "Informator Miasta"})
				end)
			else
				return "Nie posiadasz wystarczających permisji, aby ogłosić zakończenie dystrybucji racji!"
			end
		end,
		position = Vector(14600.400391, 3599.860107, 2129.510010)
	},
	["RDC_SuspendedRations"] = {
		OnPressed = function(self, client)
			if (client:IsCombine() or client:IsAdmin()) then
				timer.Simple(2, function()
					ix.chat.Send(nil, "broadcast", "Uwaga rezydenci Miasta Dwudziestego Czwartego! Ze względu na działania skrajnych elementów, godzinny przydział racji żywnościowych został tymczasowo zawieszony.", false, nil, {speakerName = "Informator Miasta"})
				end)
			else
				return "Nie posiadasz wystarczających permisji, aby ogłosić zakończenie dystrybucji racji!"
			end
		end,
		position = Vector(7199.000000, 7970.990234, 186.000000)
	},
	["RDC_RationAnnouncement"] = {
		OnPressed = function(self, client)
			if (client:IsCombine() or client:IsAdmin()) then
				timer.Simple(2, function()
					ix.chat.Send(nil, "broadcast", "Uwaga rezydenci Miasta Dwudziestego Czwartego! Wasze godzinne racje żywnościowe są już dostępne do odebrania. Prosimy o udanie się do Terminala Dystrybucji Racji, kiedy bedzie to dla was najdogodniejsze.", false, nil, {speakerName = "Informator Miasta"})
				end)
			else
				return "Nie posiadasz wystarczających permisji, aby ogłosić dystrybucje racji!"
			end
		end,
		position = Vector(7161.000000, 7881.009766, 178.009995)
	},
	["CWU_WorkerAnnouncement"] = {
		OnPressed = function(self, client)
			if (client:Team() == FACTION_WORKERS or client:Team() == FACTION_MEDICAL or client:IsCombine() or client:IsAdmin()) then
				timer.Simple(2, function()
					ix.chat.Send(nil, "broadcast", "Uwaga wszyscy pracujący rezydenci Miasta Dwudziestego Czwartego! Wasza zaplanowana sesja robocza jest gotowa do realizacji. Proszę udać się do odpowiedniego bloku produkcyjnego w celu przydzielenia zadania.", false, nil, {speakerName = "Informator Miasta"})
				end)
			else
				return "Nie posiadasz wystarczających permisji, aby ogłosić cykl pracy!"
			end
		end,
		position = Vector(5778.000000, 8457.000000, 514.000000)
	},
	["VIC_CheckpointAlarm"] = {
		OnPressed = function(self, client)
			if (!client:IsCombine() and !client:IsAdmin()) then
				return "Nie posiadasz wystarczających permisji, aby aktywować alarm w punkcie kontrolnym!"
			end
		end,
		position = Vector(5691.950195, 6677.560059, 617.989990)
	},
	["VIC_CheckpointGate"] = {
		OnPressed = function(self, client)
			if (!client:IsCombine() and !client:IsAdmin()) then
				return "Nie posiadasz wystarczających permisji, aby sterować bramą punktu kontrolnego!"
			end
		end,
		position = Vector(5507.040039, 6572.029785, 631.940002)
	},
	["WIL_CheckpointAlarm"] = {
		OnPressed = function(self, client)
			if (!client:IsCombine() and !client:IsAdmin()) then
				return "Nie posiadasz wystarczających permisji, aby aktywować alarm w punkcie kontrolnym!"
			end
		end,
		position = Vector(9379.519531, 7912.979980, 673.630005)
	},
	["WIL_CheckpointGate"] = {
		OnPressed = function(self, client)
			if (!client:IsCombine() and !client:IsAdmin()) then
				return "Nie posiadasz wystarczających permisji, aby sterować bramą punktu kontrolnego!"
			end
		end,
		position = Vector(9538.040039, 7801.029785, 686.940002)
	},
	["SEW_Forcefields"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "Nie posiadasz wystarczających permisji, aby sterować polami siłowymi!"
			end
		end,
		position = Vector(8484.000000, 9752.000000, -1128.000000)
	},
	["ADM_Explosion1"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "Nie posiadasz wystarczających permisji, aby skorzystać z tego przycisku!"
			end
		end,
		position = Vector(11280.000000, 4544.500000, 1061.000000)
	},
	["ADM_Explosion2"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "Nie posiadasz wystarczających permisji, aby skorzystać z tego przycisku!"
			end
		end,
		position = Vector(11184.000000, 4544.500000, 1061.000000)
	},
	["ADM_Wind"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "Nie posiadasz wystarczających permisji, aby skorzystać z tego przycisku!"
			end
		end,
		position = Vector(11104.000000, 4544.500000, 1060.000000)
	},
	["ADM_Thunder"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "Nie posiadasz wystarczających permisji, aby skorzystać z tego przycisku!"
			end
		end,
		position = Vector(10952.500000, 4728.009766, 1060.000000)
	},
	["ADM_CloudsEnable"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "Nie posiadasz wystarczających permisji, aby skorzystać z tego przycisku!"
			end
		end,
		position = Vector(10952.500000, 4800.009766, 1060.000000)
	},
	["ADM_CloudsDisable"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "Nie posiadasz wystarczających permisji, aby skorzystać z tego przycisku!"
			end
		end,
		position = Vector(10952.500000, 4888.009766, 1060.000000)
	},
	["ADM_Alarm1"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "Nie posiadasz wystarczających permisji, aby skorzystać z tego przycisku!"
			end
		end,
		position = Vector(11112.000000, 5055.500000, 1060.000000)
	},
	["ADM_Alarm2"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "Nie posiadasz wystarczających permisji, aby skorzystać z tego przycisku!"
			end
		end,
		position = Vector(11208.000000, 5055.500000, 1060.000000)
	},
	["ADM_ManhackAlert"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "Nie posiadasz wystarczających permisji, aby skorzystać z tego przycisku!"
			end
		end,
		position = Vector(11288.000000, 5055.500000, 1060.000000)
	},
	["ADM_ScannerAlert"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "Nie posiadasz wystarczających permisji, aby skorzystać z tego przycisku!"
			end
		end,
		position = Vector(11463.500000, 4951.990234, 1060.000000)
	},
	["ADM_Battle1"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "Nie posiadasz wystarczających permisji, aby skorzystać z tego przycisku!"
			end
		end,
		position = Vector(11463.500000, 4871.990234, 1060.000000)
	},
	["ADM_Battle2"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "Nie posiadasz wystarczających permisji, aby skorzystać z tego przycisku!"
			end
		end,
		position = Vector(11463.500000, 4799.990234, 1060.000000)
	},
	["ADM_TrainHorn"] = {
		OnPressed = function(self, client)
			if (!client:IsAdmin()) then
				return "Nie posiadasz wystarczających permisji, aby skorzystać z tego przycisku!"
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
