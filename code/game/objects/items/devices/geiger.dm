//Geiger counter
//Rewritten version of TG's geiger counter
//I opted to show exact radiation levels

// Sound obtained then edited from here : https://freesound.org/people/leonelmail/sounds/328381/ -- Under creative commons 0

/obj/item/geiger
	name = "geiger counter"
	desc = "A handheld device used for detecting and measuring radiation in an area."
	icon = 'icons/obj/items/device/geiger.dmi'
	icon_state = "geiger_off"
	item_state = "multitool"
	w_class = ITEM_SIZE_SMALL
	action_button_name = "Toggle geiger counter"
	material = /decl/material/solid/organic/plastic
	matter = list(
		/decl/material/solid/metal/copper    = MATTER_AMOUNT_REINFORCEMENT,
		/decl/material/solid/silicon         = MATTER_AMOUNT_REINFORCEMENT,
		/decl/material/solid/metal/aluminium = MATTER_AMOUNT_REINFORCEMENT,
		/decl/material/solid/glass           = MATTER_AMOUNT_TRACE,
	)
	var/scanning = 0
	var/radiation_count = 0
	var/datum/sound_token/sound_token
	var/geiger_volume = 0
	var/sound_id

/obj/item/geiger/Initialize()
	. = ..()
	sound_id = "[type]_[sequential_id(type)]"

/obj/item/geiger/proc/update_sound(var/playing)
	if(playing && !sound_token)
		sound_token = play_looping_sound(src, sound_id, "sound/items/geiger.ogg", volume = geiger_volume, range = 4, falloff = 3, prefer_mute = TRUE)
	else if(!playing && sound_token)
		QDEL_NULL(sound_token)

/obj/item/geiger/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)
	update_sound(0)

/obj/item/geiger/Process()
	if(!scanning)
		return
	radiation_count = SSradiation.get_rads_at_turf(get_turf(src))
	update_icon()

/obj/item/geiger/get_examine_strings(mob/user, distance, infix, suffix)
	. = ..()
	var/msg = "[scanning ? "ambient" : "stored"] Radiation level: [radiation_count ? radiation_count : "0"] Roentgen."
	if(radiation_count > RAD_LEVEL_LOW)
		. += SPAN_DANGER("[msg]")
	else
		. += SPAN_NOTICE("[msg]")

/obj/item/geiger/attack_self(var/mob/user)
	scanning = !scanning
	if(scanning)
		START_PROCESSING(SSobj, src)
	else
		STOP_PROCESSING(SSobj, src)
	update_icon()
	to_chat(user, "<span class='notice'>[html_icon(src)] You switch [scanning ? "on" : "off"] [src].</span>")

/obj/item/geiger/on_update_icon()
	. = ..()
	if(!scanning)
		icon_state = "geiger_off"
		update_sound(0)
		return 1

	if(!sound_token) update_sound(1)

	switch(radiation_count)
		if(null) icon_state = "geiger_on_1"
		if(-INFINITY to RAD_LEVEL_LOW)
			icon_state = "geiger_on_1"
			geiger_volume = 0
			sound_token.SetVolume(geiger_volume)
		if(RAD_LEVEL_LOW + 0.01 to RAD_LEVEL_MODERATE)
			icon_state = "geiger_on_2"
			geiger_volume = 10
			sound_token.SetVolume(geiger_volume)
		if(RAD_LEVEL_MODERATE + 0.1 to RAD_LEVEL_HIGH)
			icon_state = "geiger_on_3"
			geiger_volume = 25
			sound_token.SetVolume(geiger_volume)
		if(RAD_LEVEL_HIGH + 1 to RAD_LEVEL_VERY_HIGH)
			icon_state = "geiger_on_4"
			geiger_volume = 40
			sound_token.SetVolume(geiger_volume)
		if(RAD_LEVEL_VERY_HIGH + 1 to INFINITY)
			icon_state = "geiger_on_5"
			geiger_volume = 60
			sound_token.SetVolume(geiger_volume)


