/obj/item/grenade/flashbang
	name = "flashbang"
	desc = "A grenade designed to blind, stun and disorient by means of an extremely bright flash and loud explosion."
	icon = 'icons/obj/items/grenades/flashbang.dmi'
	origin_tech = @'{"materials":2,"combat":1}'
	var/banglet = 0

/obj/item/grenade/flashbang/detonate()
	..()
	var/list/victims = list()
	var/list/objs = list()
	var/turf/T = get_turf(src)
	get_listeners_in_range(T, 7, victims, objs)
	for(var/mob/living/M in victims)
		bang(T, M)

	FOR_DVIEW(var/obj/effect/blob/B, 7, T, INVISIBILITY_MAXIMUM) //Blob damage here
		var/damage = round(30/(get_dist(B,T)+1))
		B.take_damage(damage, BURN)
	END_FOR_DVIEW

	new /obj/effect/sparks(loc)
	new /obj/effect/effect/smoke/illumination(loc, 5, 30, 1, "#ffffff")
	qdel(src)

// Added a new proc called 'bang' that takes a location and a person to be banged.
// Called during the loop that bangs people in lockers/containers and when banging
// people in normal view.  Could theroetically be called during other explosions.
// -- Polymorph
/obj/item/grenade/flashbang/proc/bang(var/turf/T , var/mob/living/M)
	to_chat(M, SPAN_DANGER("BANG"))
	playsound(src, 'sound/weapons/flashbang.ogg', 100)

	//Checking for protections
	var/eye_safety = 0
	var/ear_safety = 0
	if(istype(M))
		eye_safety = M.eyecheck()
		if(M.get_sound_volume_multiplier() < 0.2)
			ear_safety += 2
		if(istype(M.get_equipped_item(slot_head_str), /obj/item/clothing/head/helmet))
			ear_safety += 1

	//Flashing everyone
	M.flash_eyes(FLASH_PROTECTION_MODERATE)
	if(eye_safety < FLASH_PROTECTION_MODERATE)
		SET_STATUS_MAX(M, STAT_STUN, 2)
		SET_STATUS_MAX(M, STAT_CONFUSE, 5)

	//Now applying sound
	if(ear_safety)
		if(ear_safety < 2 && get_dist(M, T) <= 2)
			SET_STATUS_MAX(M, STAT_STUN, 1)
			SET_STATUS_MAX(M, STAT_CONFUSE, 3)

	else if(get_dist(M, T) <= 2)
		SET_STATUS_MAX(M, STAT_STUN, 3)
		SET_STATUS_MAX(M, STAT_CONFUSE, 8)
		SET_STATUS_MAX(M, STAT_TINNITUS, rand(0, 5))
		SET_STATUS_MAX(M, STAT_DEAF, 15)

	else if(get_dist(M, T) <= 5)
		SET_STATUS_MAX(M, STAT_STUN, 2)
		SET_STATUS_MAX(M, STAT_CONFUSE, 5)
		SET_STATUS_MAX(M, STAT_TINNITUS, rand(0, 3))
		SET_STATUS_MAX(M, STAT_DEAF, 10)

	else
		SET_STATUS_MAX(M, STAT_STUN, 1)
		SET_STATUS_MAX(M, STAT_CONFUSE, 3)
		SET_STATUS_MAX(M, STAT_TINNITUS, rand(0, 1))
		SET_STATUS_MAX(M, STAT_DEAF, 5)

	//This really should be in mob not every check
	switch(GET_STATUS(M, STAT_TINNITUS))
		if(1 to 14)
			to_chat(M, "<span class='danger'>Your ears start to ring!</span>")
		if(15 to INFINITY)
			to_chat(M, "<span class='danger'>Your ears start to ring badly!</span>")

	if(!ear_safety)
		sound_to(M, 'sound/weapons/flash_ring.ogg')

/obj/item/grenade/flashbang/instant
	invisibility = INVISIBILITY_MAXIMUM
	is_spawnable_type = FALSE // Do not manually spawn this, it will runtime/break.

/obj/item/grenade/flashbang/instant/Initialize()
	. = ..()
	name = "arcane energy"
	detonate()

/obj/item/grenade/flashbang/clusterbang//Created by Polymorph, fixed by Sieve
	desc = "Use of this weapon may constitute a war crime in your area, consult your local captain."
	name = "clusterbang"
	icon = 'icons/obj/items/grenades/clusterbang.dmi'

/obj/item/grenade/flashbang/clusterbang/detonate()
	var/numspawned = rand(4,8)
	var/again = 0
	for(var/more = numspawned,more > 0,more--)
		if(prob(35))
			again++
			numspawned --
	for(,numspawned > 0, numspawned--)
		new /obj/item/grenade/flashbang/cluster(src.loc)//Launches flashbangs
		playsound(src.loc, 'sound/weapons/armbomb.ogg', 75, 1, -3)

	for(,again > 0, again--)
		new /obj/item/grenade/flashbang/clusterbang/segment(src.loc)//Creates a 'segment' that launches a few more flashbangs
		playsound(src.loc, 'sound/weapons/armbomb.ogg', 75, 1, -3)
	qdel(src)

/obj/item/grenade/flashbang/clusterbang/segment
	desc = "A smaller segment of a clusterbang. Better run."
	name = "clusterbang segment"
	icon = 'icons/obj/items/grenades/clusterbang_segment.dmi'

/obj/item/grenade/flashbang/clusterbang/segment/Initialize()
	. = ..() //Segments should never exist except part of the clusterbang, since these immediately 'do their thing' and asplode
	banglet = 1
	activate()
	//I must go, my people need me
	addtimer(CALLBACK(src, PROC_REF(detonate)), rand(15,60))
	if(isturf(loc)) // Don't hurl yourself around if you're not on a turf.
		throw_at(get_edge_target_turf(loc, pick(global.cardinal)), rand(1, 4), 5, null, TRUE)

/obj/item/grenade/flashbang/clusterbang/segment/detonate()
	var/numspawned = rand(4,8)
	for(var/more = numspawned,more > 0,more--)
		if(prob(35))
			numspawned --
	for(,numspawned > 0, numspawned--)
		new /obj/item/grenade/flashbang/cluster(src.loc)
		playsound(src.loc, 'sound/weapons/armbomb.ogg', 75, 1, -3)
	qdel(src)

/obj/item/grenade/flashbang/cluster/Initialize()
	. = ..() //Same concept as the segments, so that all of the parts don't become reliant on the clusterbang
	banglet = 1
	activate()
	addtimer(CALLBACK(src, PROC_REF(detonate)), rand(15,60))
	if(isturf(loc)) // See Initialize() for above.
		throw_at(get_edge_target_turf(loc, pick(global.cardinal)), rand(1, 3), 5, null, TRUE)
