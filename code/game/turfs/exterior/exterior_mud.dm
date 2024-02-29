/turf/exterior/clay
	name = "clay"
	desc = "Thick, claggy clay."
	icon = 'icons/turf/exterior/mud_light.dmi'
	icon_edge_layer = EXT_EDGE_CLAY
	footstep_type = /decl/footsteps/mud
	is_fundament_turf = TRUE

/turf/exterior/clay/get_diggable_resources()
	return dug ? null : list(/obj/item/stack/material/ore/clay = list(3, 2))

/turf/exterior/clay/drop_diggable_resources()
	if(!dug && prob(15))
		new /obj/item/rock(src, /decl/material/solid/stone/flint)
	return ..()

/turf/exterior/clay/flooded
	flooded = /decl/material/liquid/water

/turf/exterior/mud
	name = "mud"
	desc = "Thick, waterlogged mud."
	icon = 'icons/turf/exterior/mud_dark.dmi'
	icon_edge_layer = EXT_EDGE_MUD
	footstep_type = /decl/footsteps/mud
	is_fundament_turf = TRUE

/turf/exterior/mud/water
	color = COLOR_SKY_BLUE
	reagent_type = /decl/material/liquid/water
	height = -(FLUID_SHALLOW)

/turf/exterior/mud/water/deep
	color = COLOR_BLUE
	height = -(FLUID_DEEP)

/turf/exterior/mud/flooded
	flooded = /decl/material/liquid/water

/turf/exterior/dry
	name = "dry mud"
	desc = "Should have stayed hydrated."
	dirt_color = "#ae9e66"
	icon = 'icons/turf/exterior/seafloor.dmi'
	is_fundament_turf = TRUE
