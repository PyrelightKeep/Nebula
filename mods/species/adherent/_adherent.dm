#define LANGUAGE_ADHERENT "Protocol"
#define BP_FLOAT        "floatation disc"
#define BP_JETS         "maneuvering jets"
#define BP_COOLING_FINS "cooling fins"

#define SPECIES_ADHERENT  "Adherent"
#define BODYTYPE_ADHERENT "adherent body"

/decl/modpack/adherent
	name = "Adherent Species"

/decl/modpack/adherent/pre_initialize()
	..()
	SSmodpacks.default_submap_whitelisted_species |= SPECIES_ADHERENT

/mob/living/human/Process_Spacemove(allow_movement)
	. = ..()
	if(.)
		return
	// This is horrible but short of spawning a jetpack inside the organ than locating
	// it, I don't really see another viable approach short of a total jetpack refactor.
	for(var/obj/item/organ/internal/powered/jets/jet in get_internal_organs())
		if(!jet.is_broken() && jet.active)
			// Unlike Bay, we don't check or unset inertia_dir here
			// because the spacedrift subsystem checks the return value of this proc
			// and unsets inertia_dir if it returns nonzero.
			return 1

/mob/living/human/adherent/Initialize(mapload, species_name, datum/mob_snapshot/supplied_appearance)
	species_name = SPECIES_ADHERENT
	. = ..()