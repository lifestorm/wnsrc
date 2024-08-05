// Created by Crowbar 0.34.0.0

$ModelName "wystan\attachments_tfa\eotech557sight.mdl"

$StaticProp

$BodyGroup "mybody"
{
	studio "eotech557sight_reference.smd"
}


$SurfaceProp "weapon"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\wystan\attachment2\eotech\"
$CDMaterials "models\wystan\attachment2\aimpoint\"

$CBox 0 0 0 0 0 0

$BBox 0 -1.12 0 13.782 0.848 12.648


$Sequence "idle" {
	"eotech557sight_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$IncludeModel "weapons/v_models/eotech557sightref.mdl"

$CollisionModel "eotech557sight_physics.smd"
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
