// ZOMBIES
// Dead and rotting, but still mobile and aggressive.
/mob/living/human/proc/make_zombie()
	set_trait(/decl/trait/metabolically_inert, TRAIT_LEVEL_EXISTS)
	set_trait(/decl/trait/undead, TRAIT_LEVEL_MINOR)

	for(var/obj/item/organ/organ in get_organs())
		organ.die()
		organ.damage = 0 // die() sets to max damage
		organ.germ_level = INFECTION_LEVEL_THREE

	// Set this so nonhumans look appropriately gross.
	reset_hair()
	if(get_bodytype()?.appearance_flags & HAS_SKIN_COLOR)
		_skin_colour = pick(COLOR_GRAY, COLOR_GRAY15, COLOR_GRAY20, COLOR_GRAY40, COLOR_GRAY80, COLOR_WHITE)
		SET_HAIR_COLOUR(src, _skin_colour, TRUE)
		SET_FACIAL_HAIR_COLOUR(src, _skin_colour, TRUE)

	for(var/obj/item/organ/external/limb in get_external_organs())
		if(!BP_IS_PROSTHETIC(limb))
			limb.sync_colour_to_human(src)
			if(prob(10))
				limb.skeletonize()
			else if(prob(15))
				if(prob(75))
					limb.createwound(CUT, rand(limb.max_damage * 0.25, limb.max_damage * 0.5))
				else
					limb.createwound(BURN, rand(limb.max_damage * 0.25, limb.max_damage * 0.5))

	vessel.remove_any(vessel.total_volume * rand(0.2, 0.5))
	update_body()

/mob/living/human/zombie/post_setup(species_name, datum/mob_snapshot/supplied_appearance)
	. = ..()
	make_zombie()

/mob/living/human/zombie/Initialize(mapload, species_name, datum/mob_snapshot/supplied_appearance)
	if(!species_name)
		species_name = SPECIES_HUMAN
	. = ..()

/mob/living/human/zombie/hnoll/Initialize(mapload, species_name, datum/mob_snapshot/supplied_appearance)
	if(!species_name)
		species_name = SPECIES_HNOLL
	. = ..()

/mob/living/human/zombie/kobaloi/Initialize(mapload, species_name, datum/mob_snapshot/supplied_appearance)
	if(!species_name)
		species_name = SPECIES_KOBALOI
	. = ..()

/mob/living/human/zombie/meredrake/Initialize(mapload, species_name, datum/mob_snapshot/supplied_appearance)
	if(!species_name)
		var/decl/species/grafadreka/drakes = GET_DECL(/decl/species/grafadreka)
		species_name = drakes.name
	. = ..()
