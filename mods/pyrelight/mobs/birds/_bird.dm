/mob/living/simple_animal/trained_bird
	mob_size = MOB_SIZE_SMALL
	abstract_type = /mob/living/simple_animal/trained_bird
	holder_type = /obj/item/holder/bird

/mob/living/simple_animal/trained_bird/proc/handle_holder_interaction(mob/user)
	return FALSE

/mob/living/simple_animal/trained_bird/proc/process_target(mob/thrower, atom/target)
	visible_message("\The [src] follows [thrower]'s directions and attacks [target]!")
	return FALSE

/mob/living/simple_animal/trained_bird/proc/process_handler_failure(mob/thrower, atom/target)
	visible_message("\The [src] ignores [target] in favour of attacking [thrower]!")
	return FALSE

/obj/item/holder/bird
	w_class = MOB_SIZE_SMALL

/obj/item/holder/bird/attack_self(mob/user)
	var/mob/living/simple_animal/trained_bird/bird = locate() in contents
	if(bird?.handle_holder_interaction(user))
		return TRUE
	return ..()

/obj/item/holder/bird/end_throw(datum/thrownthing/TT)
	var/mob/living/simple_animal/trained_bird/bird = locate() in contents
	. = ..()
	if(!TT.thrower || !bird || QDELETED(src) || bird.loc != src)
		return
	bird.dropInto(loc)
	qdel(src) // This will happen shortly regardless, but might as well skip the 1ds delay.
	bird.visible_message("\The [bird] was thrown by \the [TT.thrower] at \the [TT.target].")
	if(bird.ai)
		if(bird.ai.is_friend(TT.thrower))
			bird.process_target(TT.thrower, TT.target)
		else
			bird.process_handler_failure(TT.thrower, TT.target)
