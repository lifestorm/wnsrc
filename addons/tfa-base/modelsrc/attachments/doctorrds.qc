// Created by Crowbar 0.34.0.0

$ModelName "wystan\attachments_tfa\doctorrds.mdl"

$BodyGroup "studio"
{
	studio "doctorrds_reference.smd"
}


$SurfaceProp "weapon"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\wystan\attachment2\doctor\"
$CDMaterials "models\wystan\attachment2\aimpoint\"

$CBox 0 0 0 0 0 0

$BBox -0.414 -1.103 -6.659 1.101 4.706 1.154

// $HBoxSet "default"


$Sequence "idle" {
	"anims\doc_idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "doctorrds_physics.smd"
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
