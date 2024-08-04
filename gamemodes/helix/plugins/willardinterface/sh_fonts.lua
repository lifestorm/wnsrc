--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

resource.AddFile( "resource/fonts/opensans_extrabold.ttf" )
resource.AddFile( "resource/fonts/opensans_bold.ttf" )
resource.AddFile( "resource/fonts/opensans_bolditalic.ttf" )
resource.AddFile( "resource/fonts/opensans_extrabolditalic.ttf" )
resource.AddFile( "resource/fonts/opensans_italic.ttf" )
resource.AddFile( "resource/fonts/opensans_light.ttf" )
resource.AddFile( "resource/fonts/opensans_lightitalic.ttf" )
resource.AddFile( "resource/fonts/opensans_regular.ttf" )
resource.AddFile( "resource/fonts/opensans_semibold.ttf" )
resource.AddFile( "resource/fonts/opensans_semibolditalic.ttf" )
resource.AddFile( "resource/fonts/sourcesanspro-bold.ttf" )

if (CLIENT) then
	function PLUGIN:LoadFonts(font, genericFont)

		surface.CreateFont( "CharCreationBoldTitle", {
			font = "Open Sans Extrabold",
			extended = false,
			size = math.Clamp(SScaleMin(12), 26, 36),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "CharCreationBoldTitleNoClamp", {
			font = "Open Sans Extrabold",
			extended = false,
			size = SScaleMin(36 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "CombineMonitor", {
			font = "Courier New",
			extended = false,
			size = SScaleMin(20 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "CombineMonitorLarge", {
			font = "Open Sans Extrabold",
			extended = true,
			size = SScaleMin(30 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WNMenuTitle", {
			font = "Open Sans Extrabold",
			extended = false,
			size = math.Clamp(SScaleMin(23.333333333333), 0, 70),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WNMenuTitleNoClamp", {
			font = "Open Sans Extrabold",
			extended = false,
			size = SScaleMin(70 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WNBleedingTitle", {
			font = "Open Sans Extrabold",
			extended = false,
			size = math.Clamp(SScaleMin(24.333333333333), 0, 73),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WNBleedingTitleNoClamp", {
			font = "Open Sans Extrabold",
			extended = false,
			size = SScaleMin(73 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WNBleedingMinutesBold", {
			font = "Open Sans Bold",
			extended = false,
			size = math.Clamp(SScaleMin(8), 0, 24),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WNBleedingMinutesBoldNoClamp", {
			font = "Open Sans Bold",
			extended = false,
			size = SScaleMin(24 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WNBleedingText", {
			font = "Open Sans",
			extended = false,
			size = math.Clamp(SScaleMin(8.6666666666667), 0, 26),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WNBleedingTextNoClamp", {
			font = "Open Sans",
			extended = false,
			size = SScaleMin(26 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WNBleedingTextBold", {
			font = "Open Sans",
			extended = false,
			size = SScaleMin(26 / 3),
			weight = 700,
			antialias = true,
		} )

		surface.CreateFont( "WNSmallerMenuTitle", {
			font = "Open Sans Extrabold",
			extended = false,
			size = math.Clamp(SScaleMin(14), 0, 42),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WNSmallerMenuTitleNoClamp", {
			font = "Open Sans Extrabold",
			extended = false,
			size = SScaleMin(14),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "SkillsTitle", {
			font = "Open Sans Extrabold",
			extended = false,
			size = SScaleMin(60 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "DebugFixedRadio", {
			font = "Courier New",
			extended = false,
			size = SScaleMin(14 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "SkillsDesc", {
			font = "Open Sans Bold",
			extended = false,
			size = SScaleMin(36 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WNSmallerMenuTitleNoBold", {
			font = "Open Sans",
			extended = false,
			size = math.Clamp(SScaleMin(14), 0, 42),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WNSmallerMenuTitleNoBoldNoClamp", {
			font = "Open Sans",
			extended = false,
			size = SScaleMin(14),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WNMenuSubtitle", {
			font = "Yellowtail",
			size = math.Clamp(SScaleMin(11.333333333333), 0, 34),
			weight = 500,
			antialias = true,
		} )

		surface.CreateFont( "WNMenuSubtitleNoClamp", {
			font = "Yellowtail",
			size = SScaleMin(34 / 3),
			weight = 500,
			antialias = true,
		} )

		surface.CreateFont( "WNMenuFont", {
			font = "Open Sans",
			extended = false,
			size = math.Clamp(SScaleMin(6.6666666666667), 18, 20),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WNMenuFontNoClamp", {
			font = "Open Sans",
			extended = false,
			size = SScaleMin(20 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WNBackFont", {
			font = "Open Sans",
			extended = false,
			size = math.Clamp(SScaleMin(5.3333333333333), 16, 16),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WNBackFontNoClamp", {
			font = "Open Sans",
			extended = false,
			size = SScaleMin(5.3333333333333),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WNBackFontBold", {
			font = "Open Sans Bold",
			extended = false,
			size = math.Clamp(SScaleMin(5.3333333333333), 16, 16),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WNBackFontBoldNoClamp", {
			font = "Open Sans Bold",
			extended = false,
			size = SScaleMin(5.3333333333333),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "MenuFont", {
			font = "Open Sans",
			extended = false,
			size = math.Clamp(SScaleMin(6), 14, 18),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "MenuFontNoClamp", {
			font = "Open Sans",
			extended = false,
			size = SScaleMin(18 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "MenuFontFixed", {
			font = "Open Sans",
			extended = false,
			size = 18,
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "MenuFontOutlined", {
			font = "Open Sans",
			extended = false,
			size = math.Clamp(SScaleMin(6), 14, 18),
			weight = 550,
			additive = true,
			shadow = true,
			outline = true,
			antialias = true,
		} )

		surface.CreateFont( "MenuFontOutlinedNoClamp", {
			font = "Open Sans",
			extended = false,
			size = SScaleMin(18 / 3),
			weight = 550,
			additive = true,
			shadow = true,
			outline = true,
			antialias = true,
		} )

		surface.CreateFont( "MenuFontLarger", {
			font = "Open Sans",
			extended = false,
			size = math.Clamp(SScaleMin(6.3333333333333), 15, 19),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "MenuFontLargerNoClamp", {
			font = "Open Sans",
			extended = false,
			size = SScaleMin(19 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "MenuFontLargerBold", {
			font = "Open Sans Bold",
			extended = false,
			size = math.Clamp(SScaleMin(6.3333333333333), 15, 19),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "MenuFontLargerBoldNoFix", {
			font = "Open Sans Bold",
			extended = false,
			size = SScaleMin(19 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "MenuFontBold", {
			font = "Open Sans Bold",
			extended = false,
			size = math.Clamp(SScaleMin(6), 14, 18),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "MenuFontBoldNoClamp", {
			font = "Open Sans Bold",
			extended = false,
			size = SScaleMin(18 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "SubtitleFont", {
			font = "Open Sans",
			extended = false,
			size = math.Clamp(SScaleMin(4.6666666666667), 0, 14),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "TitlesFont", {
			font = "Open Sans Bold",
			extended = false,
			size = math.Clamp(SScaleMin(8), 20, 24),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "TitlesFontNoClamp", {
			font = "Open Sans Bold",
			extended = false,
			size = SScaleMin(24 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "TitlesFontFixed", {
			font = "Open Sans Bold",
			extended = false,
			size = 24,
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "LargerTitlesFont", {
			font = "Open Sans Bold",
			extended = false,
			size = math.Clamp(SScaleMin(9.3333333333333), 0, 28),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "LargerTitlesFontNoClamp", {
			font = "Open Sans Bold",
			extended = false,
			size = SScaleMin(28 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "EvenLargerTitlesFontNoClamp", {
			font = "Open Sans Bold",
			extended = false,
			size = SScaleMin(30 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "LargerTitlesFontFixed", {
			font = "Open Sans Bold",
			extended = false,
			size = 28,
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WN3D2DLargeText", {
			font = "Open Sans",
			extended = false,
			size = 36,
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "WN3D2DMediumText", {
			font = "Open Sans",
			extended = false,
			size = 28,
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "TitlesFontNoBold", {
			font = "Open Sans",
			extended = false,
			size = math.Clamp(SScaleMin(7.3333333333333), 20, 22),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "TitlesFontNoBoldNoClamp", {
			font = "Open Sans",
			extended = false,
			size = SScaleMin(22 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "SmallerTitleFont", {
			font = "Open Sans Bold",
			extended = false,
			size = math.Clamp(SScaleMin(6.6666666666667), 18, 20),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "SmallerTitleFontNoClamp", {
			font = "Open Sans Bold",
			extended = false,
			size = SScaleMin(20 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "SmallerTitleFontNoBold", {
			font = "Open Sans",
			extended = false,
			size = math.Clamp(SScaleMin(6.6666666666667), 16, 20),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "SmallerTitleFontNoBoldNoClamp", {
			font = "Open Sans",
			extended = false,
			size = SScaleMin(20 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "SmallerTitleFontNoBoldNoClampLessWeight", {
			font = "Open Sans",
			extended = false,
			size = SScaleMin(20 / 3),
			weight = 400,
			antialias = true,
		} )

		surface.CreateFont( "HUDFontLarge", {
			font = "Open Sans Bold",
			extended = false,
			size = math.Clamp(SScaleMin(18.666666666667), 0, 56),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "HUDFontLargeNoClamp", {
			font = "Open Sans Bold",
			extended = false,
			size = SScaleMin(56 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "HUDFontExtraLarge", {
			font = "Open Sans Bold",
			extended = false,
			size = math.Clamp(SScaleMin(24), 0, 72),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "HUDFontExtraLargeNoClamp", {
			font = "Open Sans Bold",
			extended = false,
			size = SScaleMin(72 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "MainMenuNewTitleFont", {
			font = "Source Sans Pro",
			extended = false,
			size = SScaleMin(70 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "MainMenuNewTitleFont", {
			font = "Open Sans Extrabold",
			extended = false,
			size = SScaleMin(90 / 3),
			weight = 550,
			antialias = true,
		} )

		surface.CreateFont( "MainMenuNewButtonFont", {
			font = "Open Sans Bold",
			extended = false,
			size = SScaleMin(20 / 3),
			weight = 550,
			antialias = true,
		} )
	end
end