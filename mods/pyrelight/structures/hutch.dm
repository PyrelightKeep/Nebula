/datum/storage/hutch
	can_hold      = list(/obj/item/holder)
	max_w_class   = MOB_SIZE_SMALL
	storage_slots = 10

/datum/storage/hutch/open(mob/user)
	. = ..()
	var/atom/hutch = holder
	if(istype(hutch))
		hutch.queue_icon_update()

/datum/storage/hutch/close(mob/user)
	. = ..()
	var/atom/hutch = holder
	if(istype(hutch))
		hutch.queue_icon_update()

/obj/structure/hutch
	name                     = "hutch"
	icon                     = 'mods/pyrelight/icons/structures/hutch.dmi'
	desc                     = "A hutch for containing small animals like rabbits."
	icon_state               = ICON_STATE_WORLD
	material                 = /decl/material/solid/organic/wood
	storage                  = /datum/storage/hutch
	var/initial_animal_count = 5
	var/decl/material/door_material = /decl/material/solid/organic/plantmatter/grass/dry
	var/initial_animal_type

/obj/structure/hutch/Initialize(ml, _mat, _reinf_mat)
	. = ..()

	if(ispath(door_material))
		door_material = GET_DECL(door_material)

	if(initial_animal_type && initial_animal_count)
		for(var/i = 1 to initial_animal_count)
			var/obj/item/holder/bird/bird_item = new(src)
			var/bird_type = islist(initial_animal_type) ? pick(initial_animal_type) : initial_animal_type
			bird_item.sync(new bird_type(bird_item))
	else
		update_icon()

/obj/structure/hutch/on_update_icon()
	. = ..()
	if(door_material)
		add_overlay(overlay_image(icon, "[icon_state]-doors-[storage?.opened ? "open" : "closed"]", door_material.color, RESET_COLOR))

// Bird subtypes.
/obj/structure/hutch/aviary
	name = "aviary"
	desc = "A hutch for containing birds like hawks or crows."
	icon = 'mods/pyrelight/icons/structures/aviary.dmi'

/obj/structure/hutch/aviary/crow
	initial_animal_type = /mob/living/simple_animal/trained_bird/crow

/obj/structure/hutch/aviary/pigeon
	initial_animal_type = /mob/living/simple_animal/trained_bird/pigeon

/obj/structure/hutch/aviary/hawk
	initial_animal_type = /mob/living/simple_animal/trained_bird/hawk

// Rabbits are a kind of bird, right?
/obj/structure/hutch/rabbit
	initial_animal_type = list(
		/mob/living/simple_animal/passive/rabbit,
		/mob/living/simple_animal/passive/rabbit/black,
		/mob/living/simple_animal/passive/rabbit/brown
	)
