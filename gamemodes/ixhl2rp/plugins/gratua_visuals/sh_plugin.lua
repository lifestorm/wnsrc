--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

PLUGIN.name = "Gra'tua Visuals"
PLUGIN.author = "Multiple Authors"
PLUGIN.description = "Combines a bunch of post-processing effects that i've found on github/workshop."

ix.lang.AddTable("english", {
	optEnableADOF = "Enable ADOF",
	optdEnableADOF = "Enables advanced Depth of Field. Your camera will focus on objects.",

	optEnableLensFlare = "Enable Lens Flare",
	optdEnableLensFlare = "Enables advanced lens flares.",

	optEnableDirtyLens = "Enable Dirty Lens",
	optdEnableDirtyLens = "Enables dirty lens post-processing effect.",

	optEnableChromaticAberration = "Enable Chromatic Aberration",
	optdEnableChromaticAberration = "Enables chromatic aberration post-processing effect, making colors more intense.",

	optEnableFilmGrain = "Enable Film Grain",
	optdEnableFilmGrain = "Enables film grain post-processing effect.",
})

ix.option.Add("enableADOF", ix.type.bool, false, {
	category = "Visual Enhancements",
})

ix.option.Add("enableLensFlare", ix.type.bool, false, {
	category = "Visual Enhancements",
})

ix.option.Add("enableDirtyLens", ix.type.bool, false, {
	category = "Visual Enhancements",
})

ix.option.Add("enableChromaticAberration", ix.type.bool, false, {
	category = "Visual Enhancements",
})

ix.option.Add("enableFilmGrain", ix.type.bool, false, {
	category = "Visual Enhancements",
})

ix.util.IncludeDir(PLUGIN.folder .. "/modules", true)