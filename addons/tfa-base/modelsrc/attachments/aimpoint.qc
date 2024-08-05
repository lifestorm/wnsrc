// Created by Crowbar 0.34.0.0

$ModelName "wystan\attachments_tfa\aimpoint.mdl"

$BodyGroup "studio"
{
	studio "aimpoint_reference.smd"
}


$SurfaceProp "weapon"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\wystan\attachment2\aimpoint\"

$CBox 0 0 0 0 0 0

$BBox -0.962 -8.944 0 1.402 0 8.455

// $HBoxSet "default"


$Sequence "idle" {
	"aimpoint_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "aimpoint_physics.smd"
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
