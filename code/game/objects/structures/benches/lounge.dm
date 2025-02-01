/obj/structure/bed/chair/bench/lounge
	name       = "lounge"
	desc       = "An elegant lounge, perfect for reclining on."
	icon       = 'icons/obj/structures/lounge.dmi'
	icon_state = "lounge_standing"
	base_icon  = "lounge"

/obj/structure/bed/chair/bench/lounge/get_material_icon()
	return icon

/obj/structure/bed/chair/bench/lounge/mapped
	color          = /decl/material/solid/organic/wood/mahogany::color
	material       = /decl/material/solid/organic/wood/mahogany
	reinf_material = /decl/material/solid/organic/cloth
	padding_color  = COLOR_RED_GRAY
