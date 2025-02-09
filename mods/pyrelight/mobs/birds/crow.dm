/datum/mob_controller/passive/crow
	emote_speech   = list("Caw.","Caw!","Caw...")
	emote_hear     = list("croaks", "caws")
	emote_see      = list("preens its feathers", "hops around")

/mob/living/simple_animal/trained_bird/crow
	name = "crow"
	icon = 'mods/pyrelight/icons/mobs/crow.dmi'
	ai = /datum/mob_controller/passive/crow
