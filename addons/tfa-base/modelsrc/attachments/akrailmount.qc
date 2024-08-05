// Created by Crowbar 0.34.0.0

$ModelName "wystan\attachments_tfa\akrailmount.mdl"

$BodyGroup "studio"
{
	studio "akrailmount_reference.smd"
}


$SurfaceProp "weapon"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\wystan\attachment2\akrail\"

$CBox 0 0 0 0 0 0

$BBox -0.33 -3.948 -4.868 1.55 5.28 2.077

// $HBoxSet "default"


$Sequence "idle" {
	"akrailmount_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "akrailmount_reference.smd"
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
