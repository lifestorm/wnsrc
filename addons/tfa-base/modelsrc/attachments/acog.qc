// Created by Crowbar 0.34.0.0

$ModelName "wystan\attachments_tfa\acog.mdl"

$BodyGroup "studio"
{
	studio "acog_reference.smd"
}


$SurfaceProp "weapon"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\wystan\attachment2\acog\"

$CBox 0 0 0 0 0 0

$BBox -0.892 -8.373 0 1.736 0 8.42

// $HBoxSet "default"


$Sequence "idle" {
	"acog_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "acog_physics.smd"
{
	$mass 5
	$inertia 1
	$damping 0
	$rotdamping 0

}

$KeyValues
{
	prop_data 
	{
		"base" "Metal.Small"
	}
}
