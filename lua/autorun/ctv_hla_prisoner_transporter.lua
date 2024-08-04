--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local V = {
	-- Required information
	Name = "Combine Prisoner Transporter",
	Model = "models/ctvehicles/hla/prisoner_transport.mdl",
	Class = "prop_vehicle_jeep",
	Category = "CTVehicles",

	-- Optional information
	Author = "CTV",
	Information = "HLA",

	KeyValues = {
		vehiclescript = "scripts/vehicles/ctvehicles/ctv_hla_prisoner_transport.txt"
	}
}
list.Set( "Vehicles", "ctv_hla_prisoner_transport", V )