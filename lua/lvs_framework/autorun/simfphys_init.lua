--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


FUELTYPE_NONE = -1
FUELTYPE_PETROL = 0
FUELTYPE_DIESEL = 1
FUELTYPE_ELECTRIC = 2

hook.Add( "LVS:Initialize", "[LVS] - Car [Fake Physics] - Keys", function()
	local KEYS = {
		{
			name_menu = "Forward",
			default = KEY_W,
			cmd = "cl_simfphys_keyforward"
		},
		{
			name_menu = "Reverse",
			default = KEY_S,
			cmd = "cl_simfphys_keyreverse"
		},
		{
			name_menu = "Steer Left",
			default = KEY_A,
			cmd = "cl_simfphys_keyleft",
		},
		{
			name_menu = "Steer Right",
			default = KEY_D,
			cmd = "cl_simfphys_keyright",
		},
		{
			name_menu = "Throttle Modifier",
			default = KEY_LSHIFT,
			cmd = "cl_simfphys_keywot",
		},
		{
			name_menu = "Clutch",
			default = KEY_LALT,
			cmd = "cl_simfphys_keyclutch",
		},
		{
			name_menu = "Gear Up",
			default = MOUSE_LEFT,
			cmd = "cl_simfphys_keygearup",
		},
		{
			name_menu = "Gear Down",
			default = MOUSE_RIGHT,
			cmd = "cl_simfphys_keygeardown",
		},
		{
			name_menu = "Handbrake",
			default = KEY_SPACE,
			cmd = "cl_simfphys_keyhandbrake",
		},
		{
			name_menu = "Cruise Control",
			default = KEY_R,
			cmd = "cl_simfphys_cruisecontrol",
		},
		{
			name_menu = "Lights",
			default = KEY_F,
			cmd = "cl_simfphys_lights",
		},
		{
			name_menu = "Foglights",
			default = KEY_V,
			cmd = "cl_simfphys_foglights",
		},
		{
			name_menu = "Horn / Siren",
			default = KEY_H,
			cmd = "cl_simfphys_keyhorn",
		},
		{
			name_menu = "Start/Stop Engine",
			default = KEY_I,
			cmd = "cl_simfphys_keyengine",
		},
		{
			name_menu = "Tilt Backward",
			default = KEY_PAD_8,
			cmd = "cl_simfphys_key_air_forward",
		},
		{
			name_menu = "Tilt Forward",
			default = KEY_PAD_2,
			cmd = "cl_simfphys_key_air_reverse",
		},
		{
			name_menu = "Tilt Left",
			default = KEY_A,
			cmd = "cl_simfphys_key_air_left",
		},
		{
			name_menu = "Tilt Right",
			default = KEY_D,
			cmd = "cl_simfphys_key_air_right",
		},
		{
			name_menu = "Turnsignals",
			default = KEY_COMMA,
			cmd = "cl_simfphys_key_turnmenu",
		},
	}

	for _, v in pairs( KEYS ) do
		LVS:AddKey( "~SKIP~", "LVS-Cars [Fake Physics]", v.name_menu, v.cmd, v.default )
	end
end )
