// Created by Crowbar 0.34.0.0

$ModelName "wystan\attachments_tfa\Rail.mdl"

$BodyGroup "studio"
{
	studio "rail_reference.smd"
}


$SurfaceProp "weapon"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\wystan\attachment2\AKRail\"

$CBox 0 0 0 0 0 0

$BBox -2.228 -0.33 0 3.948 0.802 1.982

// $HBoxSet "default"


$Sequence "idle" {
	"rail_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "rail_physics.smd"
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
