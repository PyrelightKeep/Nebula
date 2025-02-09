/mob/living/simple_animal/trained_bird/hawk
	name = "hawk"
	icon = 'mods/pyrelight/icons/mobs/hawk.dmi'
	ai   = /datum/mob_controller/passive/hunter/hawk

/datum/mob_controller/passive/hunter/hawk
	emote_speech   = list("Skree!","SKREE!","Skree!?")
	emote_hear     = list("screeches", "screams")
	emote_see      = list("preens its feathers", "flicks its wings", "looks sharply around")

// Throw bird at target/afterattack on holder:
	// Pass husbandry check
		// Item: retrieves
		// Mob:  attacks
	// Fail husbandry check
		// Attacks you (for a short time, like goats)
