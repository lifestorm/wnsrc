--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()

local model = "models/ctvehicles/hla/prisoner_transport.mdl"

local light_table = {
	ems_sounds = {"vehicles/ctvehicles/apc/apc_alarm_loop1.wav"},
}
list.Set( "simfphys_lights", "ctv_prisontrans", light_table) -- здесь тебе нужно изменить "test" на любое другое название, например "myfirstsimfcar"


local V = {
	Name = "Combine Prisoner Transporter", -- название машины в меню
	Model = model, -- модель машины (в вкладке дополнения и проп авто)
	Category = "Willi302's Cars", -- категория в которой будет машина

	Members = {
		Mass = 4000, -- масса авто
		
		SpeedoMax = -1, -- какая максималка на спидометре(может работать криво)

		LightsTable = "ctv_prisontrans", -- название light_table

		AirFriction = 0,

		FrontWheelRadius = 26,--радиус переднего колеса
		RearWheelRadius = 26,--радиус заднего колеса

		CustomMassCenter = Vector(0,0,-1), 

		SeatOffset = Vector(-2,0,-4), -- положение водительского сидения
		SeatPitch = 0,

		PassengerSeats = { -- пассажирские места
			{
				pos = Vector(17,44,58),
				ang = Angle(0,0,0) -- Vector(ширина, длина, высота),
			},
			
			{
				pos = Vector(36,-22,55),
				ang = Angle(0,90,0) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(36,-51,55),
				ang = Angle(0,90,0) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(36,-80,55),
				ang = Angle(0,90,0) -- Vector(ширина, длина, высота),
			},
			
			{
				pos = Vector(-36,-22,55),
				ang = Angle(0,90,0) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(-36,-51,55),
				ang = Angle(0,90,0) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(-36,-80,55),
				ang = Angle(0,90,0) -- Vector(ширина, длина, высота),
			},
		},

		--[[ExhaustPositions = { -- позиция выхлопа
        	{
                pos = Vector(25,-118,12),
                ang = Angle(90,-90,0),
        	},
        },]]

		StrengthenSuspension = true, -- жесткая подвеска.

		FrontHeight = 11, -- высота передней подвески
		FrontConstant = 80000,
		FrontDamping = 6000,
		FrontRelativeDamping = 5000,

		RearHeight = 11, -- высота задней подвески
		RearConstant = 80000,
		RearDamping = 6000,
		RearRelativeDamping = 5000,

		FastSteeringAngle = 15,
		SteeringFadeFastSpeed = 750,

		TurnSpeed = 3,

		MaxGrip = 70,
		Efficiency = 1.3,
		GripOffset = -3,
		BrakePower = 50, -- сила торможения

		IdleRPM = 100, -- мин. кол-во оборотов
		LimitRPM = 8000, -- макс. кол-во оборотов
		Revlimiter = false, -- Если true - Когда стрелка спидометра доходит до красного обозначения, она не проходит дальше, если false - это игнорируется
		PeakTorque = 120, -- крутящий момент
		PowerbandStart = 100, -- какие обороты на нейтральной передаче
		PowerbandEnd = 8000, -- ограничение по оборотам
		Turbocharged = false, -- турбо false = нет, true = да
		Supercharged = false, -- супер заряд
		Backfire = false, -- стреляющий выхлоп

		FuelFillPos = Vector(-45,60,35), -- положение заправки
		FuelType = FUELTYPE_ELECTRIC, -- тип топлива
		FuelTankSize = 200, -- размер бака

		PowerBias = 0.8, -- привод. 1 - задний, 0 - полный, -1 - передний

		EngineSoundPreset = -1,
--
		snd_pitch = 1.5,
		snd_idle = "simulated_vehicles/c_apc/apc_idle.wav",

		snd_low = "vehicles/ctvehicles/apc/apc_cruise_loop3.wav",
		snd_low_revdown = "vehicles/ctvehicles/apc/apc_slowdown_fast_loop5.wav", -- это всё звук
		snd_low_pitch = 0.49,

		snd_mid = "simulated_vehicles/c_apc/apc_mid.wav",
		--snd_mid_gearup = "vehicles/second.wav",
		--snd_mid_geardown = "vehicles/second.wav",
		snd_mid_pitch = 0.49,

		snd_horn = "simulated_vehicles/horn_2.wav",
	ForceTransmission 		= 		0,
--              
		DifferentialGear = 0.40,
		Gears = {-0.08,0,0.13} -- кол-во передач и "мощность"
	}
}
list.Set( "simfphys_vehicles", "ctv_hla_prisoner_transport", V )