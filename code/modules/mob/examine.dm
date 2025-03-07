/mob/proc/get_visible_pronouns(hideflags)
	//suits/masks/helmets make it hard to tell their gender
	if((hideflags & HIDEJUMPSUIT) && (hideflags & HIDEFACE))
		return GET_DECL(/decl/pronouns)
	return get_pronouns()

/mob/proc/get_equipment_visibility()
	. = 0
	for(var/obj/item/thing in get_equipped_items(include_carried = FALSE))
		. |= thing.flags_inv
	return . & EQUIPMENT_VISIBILITY_FLAGS

/mob/proc/get_examined_short_description(mob/user, distance, infix, suffix, hideflags, decl/pronouns/pronouns)
	. = list()
	. += "[html_icon(src)] That's \a [src][infix]. [suffix]"
	if(desc)
		. += desc

/mob/proc/get_examined_worn_held_items(mob/user, distance, infix, suffix, hideflags, decl/pronouns/pronouns)
	. = list()
	var/slot_datums = get_inventory_slots()
	if(length(slot_datums))
		for(var/slot in slot_datums)
			var/datum/inventory_slot/inv_slot = slot_datums[slot]
			if(!inv_slot || inv_slot.skip_on_inventory_display)
				continue
			var/slot_desc = inv_slot.get_examined_string(src, user, distance, hideflags, pronouns)
			if(slot_desc)
				. += slot_desc
	if(buckled)
		if(user == src)
			. += SPAN_WARNING("You are [html_icon(buckled)] buckled to [buckled]!")
		else
			. += SPAN_WARNING("[pronouns.He] [pronouns.is] [html_icon(buckled)] buckled to [buckled]!")

/mob/proc/get_other_examine_strings(mob/user, distance, infix, suffix, hideflags, decl/pronouns/pronouns)
	return

/mob/get_examine_strings(mob/user, distance, infix, suffix)

	SHOULD_CALL_PARENT(FALSE)
	. = list()

	// Collect equipment visibility flags.
	var/hideflags = get_equipment_visibility()
	//no accuately spotting headsets from across the room.
	if(distance > 3)
		hideflags |= HIDEEARS

	// Show our equipment, held items, desc, etc.
	var/decl/pronouns/pronouns = get_visible_pronouns(hideflags)
	// to_chat(user, "<blockquote>") // these don't work in BYOND's native output panel. If we switch to browser output instead, you can readd this
	. += get_examined_short_description(user, distance, infix, suffix, hideflags, pronouns)
	. += get_examined_worn_held_items(user, distance, infix, suffix, hideflags, pronouns)
	. += get_other_examine_strings(user, distance, infix, suffix, hideflags, pronouns)
	// to_chat(user, "</blockquote>") // see above
