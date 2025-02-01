/obj/structure/bed/chair/bench/pew
	name = "pew"
	desc = "A long bench with a backboard, commonly found in places of worship, courtrooms and so on. Not known for being particularly comfortable."
	icon = 'icons/obj/structures/pews.dmi'
	icon_state = "pew_standing"
	base_icon = "pew"

/obj/structure/bed/chair/bench/pew/get_material_icon()
	return material?.pew_icon

/obj/structure/bed/chair/bench/pew/single
	name = "backed chair"
	desc = "A tall chair with a sturdy back. Not very comfortable."
	base_icon = "pew_standing"
	connect_neighbors = FALSE

/obj/structure/bed/chair/bench/pew/mahogany
	color    = /decl/material/solid/organic/wood/mahogany::color
	material = /decl/material/solid/organic/wood/mahogany

/obj/structure/bed/chair/bench/pew/ebony
	color    = /decl/material/solid/organic/wood/ebony::color
	material = /decl/material/solid/organic/wood/ebony
