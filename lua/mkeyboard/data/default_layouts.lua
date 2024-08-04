--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Default layout from Playable Piano
MKeyboard:RegisterLayout( "compact", "musicalk.layout.compact", {
    -- button, note, is a black key
    { KEY_A, 60 },
    { KEY_W, 61, true },
    { KEY_S, 62 },
    { KEY_E, 63, true },
    { KEY_D, 64 },
    { KEY_F, 65 },
    { KEY_T, 66, true },
    { KEY_G, 67 },
    { KEY_Y, 68, true },
    { KEY_H, 69 },
    { KEY_U, 70, true },
    { KEY_J, 71 },
    { KEY_K, 72 },
    { KEY_O, 73, true },
    { KEY_L, 74 },
    { KEY_P, 75, true },
    { KEY_SEMICOLON, 76 },
    { KEY_APOSTROPHE, 77 }
} )

-- Expanded layout from Playable Piano
MKeyboard:RegisterLayout( "expanded", "musicalk.layout.expanded", {
    -- button, note, is a black key, requires shift
    { KEY_1, 36 },
    { KEY_1, 37, true, true },
    { KEY_2, 38 },
    { KEY_2, 39, true, true },
    { KEY_3, 40 },
    { KEY_4, 41 },
    { KEY_4, 42, true, true },
    { KEY_5, 43 },
    { KEY_5, 44, true, true },
    { KEY_6, 45 },
    { KEY_6, 46, true, true },
    { KEY_7, 47 },
    { KEY_8, 48 },
    { KEY_8, 49, true, true },
    { KEY_9, 50 },
    { KEY_9, 51, true, true },
    { KEY_0, 52 },

    { KEY_Q, 53 },
    { KEY_Q, 54, true, true },
    { KEY_W, 55 },
    { KEY_W, 56, true, true },
    { KEY_E, 57 },
    { KEY_E, 58, true, true },
    { KEY_R, 59 },
    { KEY_T, 60 },
    { KEY_T, 61, true, true },
    { KEY_Y, 62 },
    { KEY_Y, 63, true, true },
    { KEY_U, 64 },
    { KEY_I, 65 },
    { KEY_I, 66, true, true },
    { KEY_O, 67 },
    { KEY_O, 68, true, true },
    { KEY_P, 69 },
    { KEY_P, 70, true, true },

    { KEY_A, 71 },
    { KEY_S, 72 },
    { KEY_S, 73, true, true },
    { KEY_D, 74 },
    { KEY_D, 75, true, true },
    { KEY_F, 76 },
    { KEY_G, 77 },
    { KEY_G, 78, true, true },
    { KEY_H, 79 },
    { KEY_H, 80, true, true },
    { KEY_J, 81 },
    { KEY_J, 82, true, true },
    { KEY_K, 83 },
    { KEY_L, 84 },
    { KEY_L, 85, true, true },

    { KEY_Z, 86 },
    { KEY_Z, 87, true, true },
    { KEY_X, 88 },
    { KEY_C, 89 },
    { KEY_C, 90, true, true },
    { KEY_V, 91 },
    { KEY_V, 92, true, true },
    { KEY_B, 93 },
    { KEY_B, 94, true, true },
    { KEY_N, 95 },
    { KEY_M, 96 }
} )

-- Keyboard layout from FL Studio
MKeyboard:RegisterLayout( "fl_studio", "FL Studio", {
    -- button, note, is a black key, requires shift, alternative button
    { KEY_Z, 24 },
    { KEY_S, 25, true },
    { KEY_X, 26 },
    { KEY_D, 27, true },
    { KEY_C, 28 },
    { KEY_V, 29 },
    { KEY_G, 30, true },
    { KEY_B, 31 },
    { KEY_H, 32, true },
    { KEY_N, 33 },
    { KEY_J, 34, true },
    { KEY_M, 35 },

    { KEY_Q, 36, false, false, KEY_COMMA },
    { KEY_2, 37, true, false, KEY_L },
    { KEY_W, 38, false, false, KEY_PERIOD },
    { KEY_3, 39, true, false, KEY_SEMICOLON },
    { KEY_E, 40, false, false, KEY_SLASH },
    { KEY_R, 41 },
    { KEY_5, 42, true },
    { KEY_T, 43 },
    { KEY_6, 44, true },
    { KEY_Y, 45 },
    { KEY_7, 46, true },
    { KEY_U, 47 },
    { KEY_I, 48 },
    { KEY_9, 49, true },
    { KEY_O, 50 },
    { KEY_0, 51, true },
    { KEY_P, 52 },
    { KEY_LBRACKET, 53 },
    { KEY_EQUAL, 54, true },
    { KEY_RBRACKET, 55 }
} )
