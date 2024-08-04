$modelname "items\tfa\boxar2grenades.mdl"

$staticprop

$body "holder" "boxflares_emptyedit.smd"
$body "grenades" "ar2_grenade5_hd.smd"

$LOD 35
{
	replacemodel "ar2_grenade5_hd.smd" "ar2_grenade5_orig.smd"
}

$surfaceprop "default"

$contents "solid"

$renamematerial "boxflares" "boxflares_empty"

$cdmaterials "models\items\tfa\"
$cdmaterials "models\items\"

$sequence "idle" "ar2_grenade5_hd.smd"

$collisionmodel "boxar2grenades_phys.smd"
{
	$mass 15
	$inertia 1
	$damping 0
	$rotdamping 0
}

$keyvalues
{
	prop_data 
	{
		"base"		"Item.Small"
	}
}
