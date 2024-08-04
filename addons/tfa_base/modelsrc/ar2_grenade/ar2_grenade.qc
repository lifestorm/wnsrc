$modelname "items\tfa\ar2_grenade.mdl"

$staticprop

$model "body" "ar2_grenade_hd.smd"

$LOD 10
{
	replacemodel "ar2_grenade_hd.smd" "ar2_grenade_reference.smd"
}

$surfaceprop "item"

$contents "solid"

$illumposition 0 -0.258 1.082

$cdmaterials "models\items\tfa\"
$cdmaterials "models\items\"

// $include "ar2_grenade_box.qci"

$include "ar2_grenade_bone.qci"

$include "ar2_grenade_animation.qci"

$include "ar2_grenade_collision.qci"

$keyvalues
{
	prop_data 
	{
		"base"		"Item.Small"
	}
}
