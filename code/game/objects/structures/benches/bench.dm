// These are benches with backs. For backless benches that can't be buckled to, check for /obj/structure/table/bench.
/obj/structure/bed/chair/bench
	name = "bench"
	desc = "A simple slatted bench."
	icon = 'icons/obj/structures/benches.dmi'
	icon_state = "bench_standing"
	base_icon = "bench"
	color = WOOD_COLOR_GENERIC
	reinf_material = null
	material = /decl/material/solid/organic/wood/oak
	obj_flags = 0
	anchored = TRUE
	var/connect_neighbors = TRUE

/obj/structure/bed/chair/bench/should_have_alpha_mask()
	return simulated && isturf(loc) && connect_neighbors && !(locate(/obj/structure/bed/chair/bench) in get_step(loc, SOUTH))

/obj/structure/bed/chair/bench/single
	name = "slatted seat"
	base_icon = "bench_standing"
	anchored = FALSE
	connect_neighbors = FALSE

/obj/structure/bed/chair/bench/Initialize(mapload)
	. = ..()
	if(connect_neighbors)
		. = INITIALIZE_HINT_LATELOAD

/obj/structure/bed/chair/bench/LateInitialize(mapload)
	..()
	if(connect_neighbors)
		if(mapload)
			update_base_icon()
		else
			update_neighbors()

/obj/structure/bed/chair/bench/Destroy()
	var/oldloc = loc
	. = ..()
	if(connect_neighbors)
		update_neighbors(oldloc)

/obj/structure/bed/chair/bench/set_dir()
	var/olddir = dir
	. = ..()
	if(. && connect_neighbors)
		update_neighbors(update_dir = olddir, skip_icon_update = TRUE)
		update_neighbors(update_dir = dir)

/obj/structure/bed/chair/bench/Move()
	var/oldloc = loc
	. = ..()
	if(. && connect_neighbors)
		update_neighbors(oldloc, skip_icon_update = TRUE)
		update_neighbors(loc)

/obj/structure/bed/chair/bench/proc/update_neighbors(update_loc = loc, update_dir = dir, skip_icon_update)
	if(!connect_neighbors)
		return
	if(!skip_icon_update)
		update_base_icon()
	if(!isturf(update_loc))
		return
	for(var/stepdir in list(turn(update_dir, -90), turn(update_dir, 90)))
		for(var/obj/structure/bed/chair/bench/other in get_step(update_loc, stepdir))
			other.update_base_icon()

/obj/structure/bed/chair/bench/proc/update_base_icon()

	if(!connect_neighbors)
		return

	base_icon = initial(base_icon)

	if(!isturf(loc))
		base_icon = "[base_icon]_standing"
	else
		var/neighbors = 0
		var/left_dir  = turn(dir, -90)
		var/right_dir = turn(dir,  90)
		for(var/checkdir in list(left_dir, right_dir))
			var/turf/check_turf = get_step(loc, checkdir)
			for(var/obj/structure/bed/chair/bench/other in check_turf)
				if(other.connect_neighbors && other.dir == dir && initial(other.base_icon) == base_icon && other.material == material)
					neighbors |= checkdir
					break

		if(neighbors & left_dir)
			if(neighbors & right_dir)
				base_icon = "[base_icon]_middle"
			else
				base_icon = "[base_icon]_right"
		else if(neighbors & right_dir)
			base_icon = "[base_icon]_left"
		else
			base_icon = "[base_icon]_standing"

	update_icon()

/obj/structure/bed/chair/bench/proc/get_material_icon()
	return material?.bench_icon

/obj/structure/bed/chair/bench/update_materials()
	. = ..()
	var/icon/material_icon = get_material_icon()
	if(material_icon)
		icon = material_icon

/obj/structure/bed/chair/bench/mahogany
	color = WOOD_COLOR_RICH
	material = /decl/material/solid/organic/wood/mahogany

/obj/structure/bed/chair/bench/ebony
	color = WOOD_COLOR_BLACK
	material = /decl/material/solid/organic/wood/ebony
